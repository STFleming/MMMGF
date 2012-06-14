--
-- plxdmsm.vhd - Local bus direct master state machine
--
-- Modules defined:
--
--    plxdmsm              Local bus direct master state machine
--
-- This state machine is designed to initiate direct master transfers on
-- the local bus.
--

library ieee;
use ieee.std_logic_1164.all;

entity plxdmsm is
    port(
        clk              : in    std_logic;  -- Local bus clock
        rst              : in    std_logic;  -- Asynchronous reset, should reduce to global reset
        sr               : in    std_logic;  -- Synchronous reset, must be asserted when bus idle
        request          : in    std_logic;  -- Pulse to request a direct-master cycle
        write            : in    std_logic;  -- Assert coincident with 'request' for a write cycle
        stop             : in    std_logic;  -- Pulse to terminate burst
        lready           : in    std_logic;  -- Local bus LREADY# (PCI9656) or LREADYO# (PCI9080) signal, active high
        lbterm           : in    std_logic;  -- Local bus LBTERM# (PCI9656) or LBTERMO# (PCI9080) signal, active high
        fholda           : in    std_logic;  -- From local bus arbiter, FPGA's bus grant signal
        fhold            : out   std_logic;  -- To local bus arbiter, FPGA's bus request signal
        la_oe_l          : out   std_logic;  -- Enable for local bus LA signal, active low
        lads_o_l         : out   std_logic;  -- To local bus LADS# signal, active low
        lads_oe_l        : out   std_logic;  -- Enable for local bus LADS# signal, active low
        lbe_oe_l         : out   std_logic;  -- Enable for local bus LBE# signal, active low
        lblast_o_l       : out   std_logic;  -- To local bus LBLAST# signal, active low
        lblast_oe_l      : out   std_logic;  -- Enable for local bus LBLAST# signal, active low
        eld_oe           : out   std_logic;  -- Early enable for local bus LD signal, active high
        ld_oe_l          : out   std_logic;  -- Enable for local bus LD/LAD signal, active low
        lwrite           : out   std_logic;  -- To local bus LWRITE signal, active high
        lwrite_oe_l      : out   std_logic;  -- Enable for local bus LWRITE signal, active low
        transfer         : out   std_logic;  -- Asserted 1 clock after data transfer takes place
        done             : out   std_logic); -- Asserted when machine is idle
end plxdmsm;

architecture rtl of plxdmsm is

    type state_type is (s_idle, s_arb, s_addr, s_xfer);
    signal state, n_state : state_type;
    signal i_la_oe_l, n_la_oe_l : std_logic;
    signal i_lads_o_l, n_lads_o_l : std_logic;
    signal i_lads_oe_l, n_lads_oe_l : std_logic;
    signal i_lbe_oe_l, n_lbe_oe_l : std_logic;
    signal lblast, n_lblast : std_logic;
    signal i_lblast_o_l, n_lblast_o_l : std_logic;
    signal i_lblast_oe_l, n_lblast_oe_l : std_logic;
    signal ld_oe, n_ld_oe : std_logic;
    signal i_ld_oe_l, n_ld_oe_l : std_logic;
    signal i_lwrite, n_lwrite : std_logic;
    signal i_lwrite_oe_l, n_lwrite_oe_l : std_logic;
    signal i_done, n_done : std_logic;
    signal i_fhold, n_fhold : std_logic;
    signal i_transfer, n_transfer : std_logic;
    
    signal stopping, n_stopping : std_logic;
    signal write_q, n_write_q : std_logic;
    
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of i_lads_oe_l : signal is "no";
    attribute equivalent_register_removal of i_lads_o_l : signal is "no";
    attribute equivalent_register_removal of i_lblast_oe_l : signal is "no";
    attribute equivalent_register_removal of i_lblast_o_l : signal is "no";
    attribute equivalent_register_removal of lblast : signal is "no";
    attribute equivalent_register_removal of ld_oe : signal is "no";
    attribute equivalent_register_removal of i_ld_oe_l : signal is "no";
    attribute iob : string;
    attribute iob of i_ld_oe_l : signal is "true";
    attribute iob of i_lads_o_l : signal is "true";
    attribute iob of i_lads_oe_l : signal is "true";
    attribute iob of i_lblast_o_l : signal is "true";
    attribute iob of i_lblast_oe_l : signal is "true";

begin
    
    --
    -- Generate outputs.
    --
    la_oe_l <= i_la_oe_l;
    lads_o_l <= i_lads_o_l;
    lads_oe_l <= i_lads_oe_l;
    lbe_oe_l <= i_lbe_oe_l;
    lblast_o_l <= i_lblast_o_l;
    lblast_oe_l <= i_lblast_oe_l;
    eld_oe <= n_ld_oe;
    ld_oe_l <= i_ld_oe_l;
    lwrite <= i_lwrite;
    lwrite_oe_l <= i_lwrite_oe_l;
    done <= i_done;
    fhold <= i_fhold;
    transfer <= i_transfer;

    --
    -- Generate the current state.
    --
    state_transition : process(clk, rst)
    begin
        if rst = '1' then
            state <= s_idle;
            i_la_oe_l <= '1';
            i_lads_o_l <= '1';
            i_lads_oe_l <= '1';
            i_lbe_oe_l <= '1';
            lblast <= '0';
            i_lblast_o_l <= '1';
            i_lblast_oe_l<= '1';
            ld_oe <= '0';
            i_ld_oe_l <= '1';
            i_lwrite <= '0';
            i_lwrite_oe_l <= '1';
            i_fhold <= '0';
            i_done <= '1';
            i_transfer <= '0';
            stopping <= '0';
            write_q <= '0';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                state <= s_idle;
                i_la_oe_l <= '1';
                i_lads_o_l <= '1';
                i_lads_oe_l <= '1';
                i_lbe_oe_l <= '1';
                lblast <= '0';
                i_lblast_o_l <= '1';
                i_lblast_oe_l <= '1';
                ld_oe <= '0';
                i_ld_oe_l <= '1';
                i_lwrite <= '0';
                i_lwrite_oe_l <= '1';
                i_fhold <= '0';
                i_done <= '1';
                i_transfer <= '0';
                stopping <= '0';
                write_q <= '0';
            else
                state <= n_state;
                i_la_oe_l <= n_la_oe_l;
                i_lads_o_l <= n_lads_o_l;
                i_lads_oe_l <= n_lads_oe_l;
                i_lbe_oe_l <= n_lbe_oe_l;
                lblast <= n_lblast;
                i_lblast_o_l <= n_lblast_o_l;
                i_lblast_oe_l <= n_lblast_oe_l;
                ld_oe <= n_ld_oe;
                i_ld_oe_l <= n_ld_oe_l;
                i_lwrite <= n_lwrite;
                i_lwrite_oe_l <= n_lwrite_oe_l;
                i_fhold <= n_fhold;
                i_done <= n_done;
                i_transfer <= n_transfer;
                stopping <= n_stopping;
                write_q <= n_write_q;
            end if;
        end if;
    end process;
    
    --
    -- Determine next state.
    --
    next_state : process(
        state, 
        request,
        stop,
        write,
        write_q,
        stopping,
        fholda,
        lready,
        lbterm,
        lblast)
    begin
        case state is
            when s_idle =>
                if request = '1' then
                    n_state <= s_arb;
                    n_done <= '0';
                    n_fhold <= '1';
                    n_lads_o_l <= '-';
                    n_lads_oe_l <= '1';
                    n_la_oe_l <= '1';
                    n_lbe_oe_l <= '1';
                    n_lblast <= '0';
                    n_lblast_o_l <= '-';
                    n_lblast_oe_l <= '1';
                    n_ld_oe <= '0';
                    n_ld_oe_l <= '1';
                    n_lwrite <= '-';
                    n_lwrite_oe_l <= '1';
                    n_stopping <= stop;
                    n_transfer <= '0';
                    n_write_q <= write;                  
                else
                    n_state <= s_idle;
                    n_done <= '1';
                    n_fhold <= '0';
                    n_lads_o_l <= '-';
                    n_lads_oe_l <= '1';
                    n_la_oe_l <= '1';
                    n_lbe_oe_l <= '1';
                    n_lblast <= '0';
                    n_lblast_o_l <= '-';
                    n_lblast_oe_l <= '1';
                    n_ld_oe <= '0';
                    n_ld_oe_l <= '1';
                    n_lwrite <= '-';
                    n_lwrite_oe_l <= '1';
                    n_stopping <= '0';
                    n_transfer <= '0';
                    n_write_q <= write_q;               
                end if;
                
            when s_arb =>
                if fholda = '1' then
                    n_state <= s_addr;
                    n_done <= '0';
                    n_lads_o_l <= '0';
                    n_lads_oe_l <= '0';
                    n_la_oe_l <= '0';
                    n_lbe_oe_l <= '0';
                    n_lblast <= stop or stopping;
                    n_lblast_o_l <= not (stop or stopping);
                    n_lblast_oe_l <= '0';
                    n_lwrite <= write_q;
                    n_lwrite_oe_l <= '0';
                    n_ld_oe <= write_q;
                    n_ld_oe_l <= not write_q;
                    n_fhold <= '1';
                    n_stopping <= stop or stopping;
                    n_transfer <= '0';
                    n_write_q <= write_q;
                else
                    n_state <= s_arb;
                    n_done <= '0';
                    n_lads_o_l <= '-';
                    n_lads_oe_l <= '1';
                    n_la_oe_l <= '1';
                    n_lbe_oe_l <= '1';
                    n_lblast <= '-';
                    n_lblast_o_l <= '-';
                    n_lblast_oe_l <= '1';
                    n_lwrite <= '-';
                    n_lwrite_oe_l <= '1';
                    n_ld_oe <= '0';
                    n_ld_oe_l <= '1';
                    n_fhold <= '1';
                    n_stopping <= stop or stopping;
                    n_transfer <= '0';
                    n_write_q <= write_q;
                end if;

            when s_addr =>
                n_state <= s_xfer;
                n_done <= '0';
                n_fhold <= '1';
                n_lads_o_l <= '1';
                n_lads_oe_l <= '0';
                n_la_oe_l <= '0';
                n_lbe_oe_l <= '0';
                n_lblast <= stop or stopping;
                n_lblast_o_l <= not (stop or stopping);
                n_lblast_oe_l <= '0';
                n_ld_oe <= write_q;
                n_ld_oe_l <= not write_q;
                n_lwrite <= write_q;
                n_lwrite_oe_l <= '0';
                n_stopping <= stop or stopping;
		n_transfer <= '0';
                n_write_q <= write_q;
                
            when s_xfer =>
                if (lblast = '1' and lready = '1') or lbterm = '1' then
                    n_state <= s_idle;
                    n_done <= '1';
                    n_fhold <= '1';
                    n_lads_o_l <= '-';
                    n_lads_oe_l <= '1';
                    n_la_oe_l <= '1';
                    n_lbe_oe_l <= '1';
                    n_lblast <= '-';
                    n_lblast_o_l <= '-';
                    n_lblast_oe_l <= '1';
                    n_ld_oe <= '0';
                    n_ld_oe_l <= '1';
                    n_lwrite <= '0';
                    n_lwrite_oe_l <= '0';
                    n_transfer <= '1';
                    n_stopping <= stop or stopping;
                    n_write_q <= write_q;
                else
                    n_state <= s_xfer;
                    n_done <= '0';
                    n_fhold <= '1';
                    n_lads_o_l <= '-';
                    n_lads_oe_l <= '1';
                    n_la_oe_l <= '0';
                    n_lbe_oe_l <= '0';
                    n_lblast <= stop or stopping;
                    n_lblast_o_l <= not (stop or stopping);
                    n_lblast_oe_l <= '0';
                    n_ld_oe <= write_q;
                    n_ld_oe_l <= not write_q;
                    n_lwrite <= write_q;
                    n_lwrite_oe_l <= '0';
                    n_transfer <= lready;
                    n_stopping <= stop or stopping;
                    n_write_q <= write_q;
                end if;
        end case;
    end process;
    
end rtl;

