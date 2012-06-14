--
-- plxddsm.vhd - Local bus demand mode DMA state machine
--
-- Modules defined:
--
--    plxddsm             Local bus demand mode DMA state machine
--
-- The plxddsm module defines the state machine and associated logic that
-- controls a single DMA channel in demand mode. It cooperates with an
-- instance of the 'plxdssm' module.
--
-- One cycle of address decoding is permitted.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

entity plxddsm is
    port(
        clk:           in       std_logic;  -- Local bus clock
        rst:           in       std_logic;  -- Should reduce during synthesis to global reset
        sr:            in       std_logic;  -- Synchronous reset (do not assert unless bus is idle)
        qlads:         in       std_logic;  -- LADS# from local bus, qualified by address decoding and LDACK#
        lblast:        in       std_logic;  -- LBLAST# signal from local bus, active high
        lbterm:        in       std_logic;  -- LBTERM# signal from local bus, active high
        request:       in       std_logic;  -- Pulse to request demand-mode DMA cycle
        ready:         in       std_logic;  -- Must be same signal as fed to 'plxdssm' instance
        stop:          in       std_logic;  -- Must be same signal as fed to 'plxdssm' instance
        idle:          out      std_logic;  -- 
        ldreq_o_l:     out      std_logic); -- To LDREQ# local bus signal
end;

architecture rtl of plxddsm is
    
    type state_type is (s_idle, s_decode_wait, s_xfer);
    signal state, n_state : state_type;
    signal i_idle, n_idle : std_logic;
    signal i_ldreq_o_l, n_ldreq_o_l : std_logic;
    signal stopping, n_stopping : std_logic;

    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of stopping : signal is "no";
    attribute equivalent_register_removal of i_ldreq_o_l : signal is "no";

begin
    
    idle <= i_idle;
    ldreq_o_l <= i_ldreq_o_l;

    --
    -- Generate the current state.
    --
    current_state : process(clk, rst)
    begin
        if rst = '1' then
            state <= s_idle;
            i_idle <= '1';
            i_ldreq_o_l <= '1';
            stopping <= '0';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                state <= s_idle;
                i_idle <= '1';
                i_ldreq_o_l <= '1';
                stopping <= '0';
            else
                state <= n_state;
                i_idle <= n_idle;
                i_ldreq_o_l <= n_ldreq_o_l;
                stopping <= n_stopping;
            end if;
        end if;
    end process;
    
    --
    -- Determine next state.
    --
    next_state : process(
        state,
        qlads,
        request,
        ready,
        stop,
        stopping,
        lblast,
        lbterm)
    begin
        case state is 
            when s_idle =>
                if qlads = '1' then
                    n_state <= s_decode_wait;
                    n_idle <= '0';
                    n_ldreq_o_l <= '0';
                    n_stopping <= '0';
                else
                    n_state <= s_idle;
                    n_idle <= '1';
                    n_ldreq_o_l <= not request;
                    n_stopping <= '-';
                end if;

            when s_decode_wait =>
                if ready = '1' then
                    n_state <= s_xfer;
                    n_idle <= '0';
                    n_ldreq_o_l <= stop or stopping;
                    n_stopping <= stop or stopping;
                else
                    n_state <= s_decode_wait;
                    n_idle <= '0';
                    n_ldreq_o_l <= stop or stopping;
                    n_stopping <= stop or stopping;
                end if;
                    
            when s_xfer =>
                if lblast = '1' or lbterm = '1' then
                    n_state <= s_idle;
                    n_idle <= '1';
                    n_ldreq_o_l <= not request;
                    n_stopping <= '-';
                else
                    n_state <= s_xfer;
                    n_idle <= '0';
                    n_ldreq_o_l <= stop or stopping;
                    n_stopping <= stop or stopping;
                end if;
        end case;
    end process;
    
end rtl;
