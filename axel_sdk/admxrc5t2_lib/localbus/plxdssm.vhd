--
-- plxdssm.vhd - Local bus direct slave state machine
--
-- Modules defined:
--
--     plxdssm          Local bus direct slave state machine
--
-- This state machine is designed to respond to direct slave transfers or
-- programmed DMA transfers, NOT demand mode DMA transfers.
--
-- One cycle of address decoding is permitted.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

entity plxdssm is
    port(
        clk              : in    std_logic;
        rst              : in    std_logic;
        sr               : in    std_logic;
        qlads            : in    std_logic;
        lblast           : in    std_logic;
        lbterm           : in    std_logic;
        lwrite           : in    std_logic;
        eld_oe           : out   std_logic;
        ld_oe_l          : out   std_logic;
        lready_o_l       : out   std_logic;
        lready_oe_l      : out   std_logic;
        lbterm_o_l       : out   std_logic;
        lbterm_oe_l      : out   std_logic;
        idle             : out   std_logic;
        transfer         : out   std_logic;
        decode           : out   std_logic;
        write            : out   std_logic;
        ready            : in    std_logic;
        stop             : in    std_logic);
end entity;

architecture rtl of plxdssm is
    
    type state_type is (s_idle, s_decode, s_wait, s_xfer);
    signal state, n_state : state_type;
    signal i_idle, n_idle : std_logic;
    signal i_transfer, n_transfer : std_logic;
    signal n_lready_o_l : std_logic;
    signal n_lready_oe_l : std_logic;
    signal n_lbterm_o_l : std_logic;
    signal n_lbterm_oe_l : std_logic;
    signal i_decode, n_decode : std_logic;
    signal i_ld_oe_l, n_ld_oe_l : std_logic;
    signal ld_oe, n_ld_oe : std_logic;
    signal i_write, n_write : std_logic;
    signal stopping, n_stopping : std_logic;
    
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of lready_oe_l : signal is "no";
    attribute equivalent_register_removal of lready_o_l : signal is "no";
    attribute equivalent_register_removal of lbterm_oe_l : signal is "no";
    attribute equivalent_register_removal of lbterm_o_l : signal is "no";
    attribute equivalent_register_removal of ld_oe : signal is "no";
    attribute equivalent_register_removal of i_ld_oe_l : signal is "no";
    attribute iob : string;
    attribute iob of ld_oe_l : signal is "true";
    attribute iob of lready_o_l : signal is "true";
    attribute iob of lready_oe_l : signal is "true";
    attribute iob of lbterm_o_l : signal is "true";
    attribute iob of lbterm_oe_l : signal is "true";

begin

    idle <= i_idle;
    transfer <= i_transfer;
    decode <= i_decode;
    eld_oe <= n_ld_oe;
    ld_oe_l <= i_ld_oe_l;
    write <= i_write;

    state_transition : process(clk, rst)
    begin
        if rst = '1' then
            state <= s_idle;
            i_idle <= '1';
            i_transfer <= '0';
            lready_o_l <= '1';
            lready_oe_l <= '1';
            lbterm_o_l <= '1';
            lbterm_oe_l <= '1';
            i_decode <= '0';
            ld_oe <= '0';
            i_ld_oe_l <= '1';
            i_write <= '0';
            stopping <= '0';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                state <= s_idle;
                i_idle <= '1';
                i_transfer <= '0';
                lready_o_l <= '1';
                lready_oe_l <= '1';
                lbterm_o_l <= '1';
                lbterm_oe_l <= '1';
                i_decode <= '0';
                ld_oe <= '0';
                i_ld_oe_l <= '1';
                i_write <= '0';
                stopping <= '0';
            else
                state <= n_state;
                i_idle <= n_idle;
                i_transfer <= n_transfer;
                lready_o_l <= n_lready_o_l;
                lready_oe_l <= n_lready_oe_l;
                lbterm_o_l <= n_lbterm_o_l;
                lbterm_oe_l <= n_lbterm_oe_l;
                i_decode <= n_decode;
                ld_oe <= n_ld_oe;
                i_ld_oe_l <= n_ld_oe_l;
                i_write <= n_write;
                stopping <= n_stopping;
            end if;
        end if;
    end process state_transition;
	
    next_state : process(
        state, 
        lblast, 
        qlads, 
        lbterm, 
        lwrite, 
        ready,
        stop,
        stopping,
        i_write)
    begin
        case state is
            when s_idle =>
                n_transfer <= '0';
                n_lready_o_l <= '1';
                n_lready_oe_l <= '1';
                n_lbterm_o_l <= '1';
                n_lbterm_oe_l <= '1';
                n_ld_oe <= '0';
                n_ld_oe_l <= '1';
                n_stopping <= '0';
                if qlads = '1' then
                    n_state <= s_decode;
                    n_idle <= '0';
                    n_decode <= '1';
                    n_write <= lwrite;
                else
                    n_state <= s_idle;
                    n_idle <= '1';
                    n_decode <= '0';
                    n_write <= i_write;
                end if;
                
            when s_decode =>
                n_decode <= '0';
                n_ld_oe <= not i_write;
                n_ld_oe_l <= i_write;
                n_lready_oe_l <= '0';
                n_lbterm_oe_l <= '0';
                n_write <= i_write;
                if ready = '1' then
                    n_state <= s_xfer;
                    n_idle <= '0';
                    n_lready_o_l <= '0';
                    n_lbterm_o_l <= not (stop or stopping);
                    n_transfer <= '1';
                    n_stopping <= '0';
                else
                    n_state <= s_wait;
                    n_idle <= '0';
                    n_lready_o_l <= '1';
                    n_lbterm_o_l <= '1';
                    n_transfer <= '0';
                    n_stopping <= stop or stopping;
                end if;

            when s_wait =>
                n_decode <= '0';
                n_ld_oe <= not i_write;
                n_ld_oe_l <= i_write;
                n_lready_oe_l <= '0';
                n_lbterm_oe_l <= '0';
                n_write <= i_write;
                if ready = '1' then
                    n_state <= s_xfer;
                    n_idle <= '0';
                    n_lready_o_l <= '0';
                    n_lbterm_o_l <= not (stop or stopping);
                    n_transfer <= '1';
                    n_stopping <= stop or stopping;
                else
                    n_state <= s_wait;
                    n_idle <= '0';
                    n_lready_o_l <= '1';
                    n_lbterm_o_l <= '1';
                    n_transfer <= '0';
                    n_stopping <= stop or stopping;
                end if;
                
            when s_xfer =>
                n_decode <= '0';
                n_lready_oe_l <= '0';
                n_lbterm_oe_l <= '0';
                n_write <= i_write;
                if lblast = '1' or lbterm = '1' then
                    n_state <= s_idle;
                    n_idle <= '1';
                    n_lready_o_l <= '1';
                    n_lbterm_o_l <= '1';
                    n_stopping <= '-';
                    n_transfer <= '0';
                    n_ld_oe <= '0';
                    n_ld_oe_l <= '1';
                else
                    n_state <= s_xfer;
                    n_idle <= '0';
                    n_lready_o_l <= '0';
                    n_stopping <= stop or stopping;
                    n_lbterm_o_l <= not (stop or stopping);
                    n_transfer <= '1';
                    n_ld_oe <= not i_write;
                    n_ld_oe_l <= i_write;
                end if;
                
        end case;
    end process next_state;

end architecture;
