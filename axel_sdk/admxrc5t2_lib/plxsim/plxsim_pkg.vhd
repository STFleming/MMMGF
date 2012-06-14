--
-- plxsim_pkg.vhd - package "plxsim"
--
-- (C) Copyright Alpha Data Ltd. 2004-2005
--
-- NOT SYNTHESIZABLE
--
-- Package of components, procedures and functions for applying stimulus
-- to the FPGA on an ADM-XRC series card.
--
-- Exported data types:
--
--   byte_enable_t
--   byte_t
--   byte_vector_t
--   integer_vector_t
--   locbus_ddma_in_t
--   locbus_ddma_out_t
--   locbus_in_t
--   locbus_out_t
--
-- Exported constants:
--
--   init_locbus_ddma_out
--   init_locbus_out
--
-- Exported routines (parenthesis indicated number of overloads):
--
--   conv_byte_vector
--   conv_integer
--   conv_integer_signed
--   conv_integer_unsigned
--   conv_std_logic_vector
--   conv_string (4)
--   conv_string_hex (3)
--   plxsim_read
--   plxsim_read_const
--   plxsim_read_const_demand
--   plxsim_read_demand
--   plxsim_request_bus
--   plxsim_wait_cycles
--   plxsim_wait_demand
--   plxsim_write
--   plxsim_write_const
--   plxsim_write_const_demand
--   plxsim_write_demand
--
-- Exported components:
--
--   lbpcheck
--   locbus_agent_ddma
--   locbus_agent_mux32
--   locbus_agent_mux64
--   locbus_agent_nonmux
--   locbus_arb
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library std;
use std.textio.all;

package plxsim is

    --
    -- A byte datatype
    --
    subtype byte_t is std_logic_vector(7 downto 0);

    --
    -- An array of std_logic, intended to hold byte enables in ACTIVE HIGH
    -- representation
    --
    type byte_enable_t is array(natural range <>) of std_logic;

    --
    -- An array of bytes, intended to hold data to be written to the
    -- local bus or read from the local bus.
    --
    type byte_vector_t is array(natural range <>) of byte_t;

    --
    -- An array of integers
    --
    type integer_vector_t is array(natural range <>) of integer;

    --
    -- Utility functions for converting between std_logic_vector, byte_vector
    -- and integer datatypes.
    --

    function conv_byte_vector(
        constant x : in std_logic_vector)
    return byte_vector_t;

    function conv_integer(
        constant x : in byte_vector_t)
    return natural;

    function conv_integer_signed(
        constant val : in std_logic_vector)
    return integer;
    
    function conv_integer_unsigned(
        constant val : in std_logic_vector)
    return natural;

    function conv_std_logic_vector(
        constant x : in byte_vector_t)
    return std_logic_vector;

    function conv_string(
        constant val : in time)
    return string;

    function conv_string(
        constant val : in integer)
    return string;

    function conv_string(
        constant val : in real)
    return string;

    function conv_string(
        constant val : in boolean)
    return string;

    function conv_string_hex(
        constant val : in std_logic_vector)
    return string;

    function conv_string_hex(
        constant val : in byte_vector_t)
    return string;

    function conv_string_hex(
        constant val : in integer)
    return string;

    --
    -- Bus stimulus datatypes for local bus
    --

    type locbus_in_t is record
        lreset_l  : std_logic;
        lclk      : std_logic;
        la        : std_logic_vector(31 downto 0);
        ld        : std_logic_vector(63 downto 0);
        lbe_l     : std_logic_vector(7 downto 0);
        lads_l    : std_logic;
        l64_l     : std_logic;
        lblast_l  : std_logic;
        lwrite    : std_logic;
        lready_l  : std_logic;
        lbterm_l  : std_logic;
        lholda    : std_logic;
    end record;

    type locbus_out_t is record
        la        : std_logic_vector(31 downto 0);
        oe_la     : std_logic;
        ld        : std_logic_vector(63 downto 0);
        oe_ld     : std_logic;
        lbe_l     : std_logic_vector(7 downto 0);
        oe_lbe    : std_logic;
        lads_l    : std_logic;
        oe_lads   : std_logic;
        l64_l     : std_logic;
        oe_l64    : std_logic;
        lblast_l  : std_logic;
        oe_lblast : std_logic;
        lwrite    : std_logic;
        oe_lwrite : std_logic;
        lready_l  : std_logic;
        oe_lready : std_logic;
        lbterm_l  : std_logic;
        oe_lbterm : std_logic;
        lhold     : std_logic;
    end record;

    --
    -- A value that may be used to initialise a locbus_out_t object
    --
    constant init_locbus_out : locbus_out_t := (
        la => (others => '-'),
        oe_la => '0',
        lbe_l => (others => '-'),
        oe_lbe => '0',
        lads_l => '-',
        oe_lads => '0',
        l64_l => '-',
        oe_l64 => '0',
        lblast_l => '-',
        oe_lblast => '0',
        ld => (others => '-'),
        oe_ld => '0',
        lwrite => '-',
        oe_lwrite => '0',
        lready_l => '-',
        oe_lready => '0',
        lbterm_l => '-',
        oe_lbterm => '0',
        lhold => '0');

    component locbus_arb
        generic(
            tco_p2p  : in    time := 5 ns;
            n_arb    : in    natural;
            priority : in    integer_vector_t);
        port(
            lreset_l : in    std_logic;
            lclk     : in    std_logic;
            lhold    : in    std_logic_vector(n_arb - 1 downto 0);
            lholda   : out   std_logic_vector(n_arb - 1 downto 0));
    end component;

    component locbus_agent_nonmux
        generic(
            tco_bussed : in    time := 5 ns;
            tco_p2p    : in    time := 5 ns);
        port(
            -- These ports should be connected to the local bus
            lreset_l   : in    std_logic;
            lclk       : in    std_logic;
            la         : inout std_logic_vector(31 downto 2);
            lads_l     : inout std_logic;
            lbe_l      : inout std_logic_vector(3 downto 0);
            lblast_l   : inout std_logic;
            lbterm_l   : inout std_logic;
            ld         : inout std_logic_vector(31 downto 0);
            lready_l   : inout std_logic;
            lwrite     : inout std_logic;
            -- These ports should be connected to the local bus arbiter
            lhold      : out   std_logic;
            lholda     : in    std_logic;
            -- These ports are used by the stimulus process
            bus_in     : out   locbus_in_t;
            bus_out    : in    locbus_out_t);
    end component;

    component locbus_agent_mux32
        generic(
            tco_bussed : in    time := 5 ns;
            tco_p2p    : in    time := 5 ns);
        port(
            -- These ports should be connected to the local bus
            lreset_l   : in    std_logic;
            lclk       : in    std_logic;
            lad        : inout std_logic_vector(31 downto 0);
            lads_l     : inout std_logic;
            lbe_l      : inout std_logic_vector(3 downto 0);
            lblast_l   : inout std_logic;
            lbterm_l   : inout std_logic;
            lready_l   : inout std_logic;
            lwrite     : inout std_logic;
            -- These ports should be connected to the local bus arbiter
            lhold      : out   std_logic;
            lholda     : in    std_logic;
            -- These ports are used by the stimulus process
            bus_in     : out   locbus_in_t;
            bus_out    : in    locbus_out_t);
    end component;

    component locbus_agent_mux64
        generic(
            tco_bussed : in    time := 5 ns;
            tco_p2p    : in    time := 5 ns);
        port(
            -- These ports should be connected to the local bus
            lreset_l   : in    std_logic;
            lclk       : in    std_logic;
            lad        : inout std_logic_vector(63 downto 0);
            lads_l     : inout std_logic;
            lbe_l      : inout std_logic_vector(7 downto 0);
            l64_l      : inout std_logic;
            lblast_l   : inout std_logic;
            lbterm_l   : inout std_logic;
            lready_l   : inout std_logic;
            lwrite     : inout std_logic;
            -- These ports should be connected to the local bus arbiter
            lhold      : out   std_logic;
            lholda     : in    std_logic;
            -- These ports are used by the stimulus process
            bus_in     : out   locbus_in_t;
            bus_out    : in    locbus_out_t);
    end component;

    --
    -- Demand-DMA stimulus datatypes
    --

    type locbus_ddma_in_t is record
        ldreq_l : std_logic;
    end record;
    
    type locbus_ddma_out_t is record
        ldack_l : std_logic;
    end record;
    
    --
    -- A value that may be used to initialise a locbus_ddma_out_t object
    --
    constant init_locbus_ddma_out : locbus_ddma_out_t := (ldack_l => '1');

    component locbus_agent_ddma
        generic(
            tco_p2p    : in    time := 5 ns);
        port(
            -- These ports should be connected to one set of the sideband demand-mode DMA signals
            ldreq_l    : in    std_logic;
            ldack_l    : out   std_logic;
            -- These ports are used by the stimulus process
            dd_in      : out   locbus_ddma_in_t;
            dd_out     : in    locbus_ddma_out_t);
    end component;

    -- ------------------------------------------------------------
    -- Local bus protocol checker component
    -- ------------------------------------------------------------

    component lbpcheck
        generic(
            multiplexed   : in    boolean;
            wide          : in    boolean);
        port(
            lclk          : in    std_logic;
            lreset_l      : in    std_logic;
            lads_l        : in    std_logic;
            l64_l         : in    std_logic;                      -- ignored if not wide
            la            : in    std_logic_vector(31 downto 2);  -- ignored if multiplexed
            lad_lo        : in    std_logic_vector(31 downto 0);
            lad_hi        : in    std_logic_vector(63 downto 32); -- ignored if not wide
            lbe_lo_l      : in    std_logic_vector(3 downto 0);
            lbe_hi_l      : in    std_logic_vector(7 downto 4);   -- ignored if not wide
            lwrite        : in    std_logic;
            lblast_l      : in    std_logic;
            lready_l      : in    std_logic;
            lbterm_l      : in    std_logic);
    end component;

    -- ------------------------------------------------------------
    -- Public routines for performing local bus transfers
    -- ------------------------------------------------------------

    --
    -- Perform a direct slave read, with incrementing local bus address.
    --
    --     order       Width of local data bus. 2 => 32 bits, 3 => 64 bits
    --
    --     multiburst  TRUE implies perform multiple bursts in order to transfer all
    --                 data, in the event that LBTERM# is asserted.
    --
    --     address     Local bus byte address.
    --
    --     be          Local bus byte enables. be'length must be the same as
    --                 data'length.
    --
    --     data        Data read from local bus. data'length indicates
    --                 desired number of bytes to read.
    --
    --     nxfered     Returns the actual number of bytes read on the local bus.
    --                 This may be less than data'length if the slave terminates the
    --                 transfer by asserting LBTERM#.
    --
    procedure plxsim_read(
               order      : in    natural;
               multiburst : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t);

    --
    -- Perform a direct slave write, with incrementing local bus address.
    --
    --     order       Width of local data bus. 2 => 32 bits, 3 => 64 bits
    --
    --     multiburst  TRUE implies perform multiple bursts in order to transfer all
    --                 data, in the event that LBTERM# is asserted.
    --
    --     address     Local bus byte address.
    --
    --     be          Local bus byte enables. be'length must be the same as
    --                 data'length.
    --
    --     data        Data to write to local bus. data'length indicates
    --                 desired number of bytes to write.
    --
    --     nxfered     Returns the actual number of bytes read on the local bus.
    --                 This may be less than data'length if the slave terminates the
    --                 transfer by asserting LBTERM#.
    --
    procedure plxsim_write(
               order      : in    natural;
               multiburst : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t);

    --
    -- Perform a direct slave read, with constant local bus address.
    --
    --     multiburst  TRUE implies perform multiple bursts in order to transfer all
    --                 data, in the event that LBTERM# is asserted.
    --
    --     address     Local bus byte address.
    --
    --     be          Local bus byte enables. be'length must be the same as
    --                 data'length.
    --
    --     data        Data read from local bus. Data'length indicates
    --                 desired number of words to read.
    --
    --     nxfered     Returns the actual number of bytes read on the local bus.
    --                 This may be less than data'length if the slave terminates the
    --                 transfer by asserting LBTERM#.
    --
    procedure plxsim_read_const(
               order      : in    natural;
               multiburst : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t);

    --
    -- Perform a direct slave write, with constant local bus address.
    --
    --     order       Width of local data bus. 2 => 32 bits, 3 => 64 bits
    --
    --     multiburst  TRUE implies perform multiple bursts in order to transfer all
    --                 data, in the event that LBTERM# is asserted.
    --
    --     address     Local bus byte address.
    --
    --     be          Local bus byte enables. be'length must be the same as
    --                 data'length.
    --
    --     data        Data to write to local bus. data'length indicates
    --                 desired number of bytes to write.
    --
    --     nxfered     Returns the actual number of bytes read on the local bus.
    --                 This may be less than data'length if the slave terminates the
    --                 transfer by asserting LBTERM#.
    --
    procedure plxsim_write_const(
               order      : in    natural;
               multiburst : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t);

    --
    -- Perform a demand-mode direct slave read, with incrementing local bus address
    --
    --     order       Width of local data bus. 2 => 32 bits, 3 => 64 bits
    --
    --     address     Local bus byte address.
    --
    --     be          Local bus byte enables. be'length must be the same as
    --                 data'length.
    --
    --     data        Data read from local bus. data'length indicates
    --                 desired number of words to read.
    --
    --     n           Returns the actual number of bytes read on the local bus.
    --                 This may be less than data'length if the slave pauses the
    --                 transfer by deasserting LDREQ#.
    --
    procedure plxsim_read_demand(
               order      : in    natural;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t);

    --
    -- Assert or deassert the LHOLD signal
    --
    --     request      TRUE => assert LHOLD signal
    --                  FALSE => deassert LHOLD signal
    --
    procedure plxsim_request_bus(
               request    : in    boolean;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t);

    --
    -- Delay for a specified number of clock cycles
    --
    --     n           Number of clock cycles of delay.
    --
    procedure plxsim_wait_cycles(
               n          : in    natural;
        signal bus_in     : in    locbus_in_t);

    --
    -- Wait until the specified demand-mode DMA request signal is asserted
    --
    procedure plxsim_wait_demand(
        signal bus_in     : in    locbus_in_t;
        signal dd_in      : in    locbus_ddma_in_t);

    --
    -- Perform a demand-mode direct slave write, with incrementing local bus address
    --
    --     order       Width of local data bus. 2 => 32 bits, 3 => 64 bits
    --
    --     address     Local bus byte address.
    --
    --     be          Local bus byte enables. be'length must be the same as
    --                 data'length.
    --
    --     data        Data to write to local bus. data'length indicates
    --                 desired number of bytes to write.
    --
    --     n           Returns the actual number of words written on the local bus.
    --                 This may be less than data'length if the slave pauses the
    --                 transfer by deasserting LDREQ#.
    --
    procedure plxsim_write_demand(
               order      : in    natural;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t);

    --
    -- Perform a demand-mode direct slave read, with constant local bus address
    --
    --     order       Width of local data bus. 2 => 32 bits, 3 => 64 bits
    --
    --     address     Local bus byte address.
    --
    --     be          Local bus byte enables. be'length must be the same as
    --                 data'length.
    --
    --     data        Data read from local bus. data'length indicates
    --                 desired number of words to read.
    --
    --     n           Returns the actual number of words read on the local bus.
    --                 This may be less than data'length if the slave pauses the
    --                 transfer by deasserting LDREQ#.
    --
    procedure plxsim_read_const_demand(
               order      : in    natural;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t);

    --
    -- Perform a demand-mode direct slave write, with constant local bus address
    --
    --     order       Width of local data bus. 2 => 32 bits, 3 => 64 bits
    --
    --     address     Local bus byte address.
    --
    --     be          Local bus byte enables. be'length must be the same as
    --                 data'length.
    --
    --     data        Data to write to local bus. data'length indicates
    --                 desired number of bytes to write.
    --
    --     n           Returns the actual number of words written on the local bus.
    --                 This may be less than data'length if the slave pauses the
    --                 transfer by deasserting LDREQ#.
    --
    procedure plxsim_write_const_demand(
               order      : in    natural;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t);

end;

package body plxsim is
    
    -- ---------------------------------------------------------------
    -- Private
    -- ---------------------------------------------------------------

    function conv_string_hexdigit(
        constant val : in std_logic_vector)
    return character is
        variable tmp : std_logic_vector(3 downto 0);
    begin
	assert val'length = 4
            report "conv_string_hex_digit: std_logic_vector passed has invalid length (must be 4)"
            severity failure;

        tmp := val;
        case tmp is
            when "0000" =>
                return '0';
            when "0001" =>
                return '1';
            when "0010" =>
                return '2';
            when "0011" =>
                return '3';
            when "0100" =>
                return '4';
            when "0101" =>
                return '5';
            when "0110" =>
                return '6';
            when "0111" =>
                return '7';
            when "1000" =>
                return '8';
            when "1001" =>
                return '9';
            when "1010" =>
                return 'A';
            when "1011" =>
                return 'B';
            when "1100" =>
                return 'C';
            when "1101" =>
                return 'D';
            when "1110" =>
                return 'E';
            when "1111" =>
                return 'F';
            when others =>
                return 'X';
        end case;
    end;

    -- -----------------------------------------------------------------------
    -- Private local bus routines
    -- -----------------------------------------------------------------------

    procedure plxsim_burst_write(
               order      : in    natural;
               multiburst : in    boolean;
               const_addr : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t)
    is
        variable addr : std_logic_vector(31 downto 0);
        variable addr_lo : natural;
        variable term, ready : boolean;
        variable data_offset, be_offset : natural;
        variable m, remaining : natural;
        variable next_be : boolean;
        variable width : natural;

        type burst_state_type is (
            bs_arb,
            bs_addr,
            bs_data,
            bs_finished);
        variable state, n_state : burst_state_type;
        variable n_la : std_logic_vector(31 downto 0);
        variable n_la_oe : std_logic;
        variable n_lads : std_logic;
        variable n_lads_oe : std_logic;
        variable n_lbe_oe : std_logic;
        variable n_lbe : std_logic_vector(7 downto 0);
        variable n_l64_oe : std_logic;
        variable n_lblast : std_logic;
        variable n_lblast_oe : std_logic;
        variable n_ld_oe : std_logic;
        variable n_ld : std_logic_vector(63 downto 0);
        variable n_lwrite_oe : std_logic;

    begin
        assert be'length = data'length
            report "*** plxsim_burst_write: byte enable length (" & conv_string(be'length) &
                   ") does not match data length (" & conv_string(be'length) & ")"
            severity failure;

        assert address'length >= 3
            report "*** plxsim_burst_write: address length (" & conv_string(address'length) &
                   ") is less than 3"
            severity failure;

        width := 2**order;
        addr := EXT(address, 32);
        addr_lo := conv_integer_unsigned(addr(order - 1 downto 0));

        state := bs_arb;
        data_offset := data'low;
        be_offset := be'low;
        remaining := be'length;

        bus_out.lwrite <= '1';
        n_lblast := '0';
        if order = 3 then
            bus_out.l64_l <= '0';
        else
            bus_out.l64_l <= '1';
        end if;

        while state /= bs_finished loop
            wait until bus_in.lclk'event and bus_in.lclk = '1';

            next_be := false;

            case state is
                when bs_arb =>
                    if bus_in.lholda = '1' then
                        n_state := bs_addr;
                        n_la_oe := '1';
                        n_lbe_oe := '1';
                        n_lads := '1';
                        n_lads_oe := '1';
                        n_l64_oe := '1';
                        n_lblast_oe := '1';
                        n_lwrite_oe := '1';
                        next_be := true;
                    else
                        n_state := bs_arb;
                    end if;

                when bs_addr =>
                    n_lads := '0';
                    n_ld_oe := '1';
                    n_state := bs_data;

                when bs_data =>
                    n_lads_oe := '0';

                    term := bus_in.lbterm_l = '0' or (bus_in.lblast_l = '0' and bus_in.lready_l = '0');
                    ready := bus_in.lbterm_l = '0' or bus_in.lready_l = '0';

                    if term then
                        if remaining /= 0 and multiburst then
                            n_state := bs_arb;
                        else
                            n_state := bs_finished;
                        end if;
                        n_la_oe := '0';
                        n_lbe_oe := '0';
                        n_ld_oe := '0';
                        n_l64_oe := '0';
                        n_lblast_oe := '0';
                        n_lwrite_oe := '0';
                    else
                        if ready then
                            next_be := true;
                        end if;
                    end if;

                when bs_finished =>
                    null;
            end case;

            state := n_state;

            if next_be then
                m := width - addr_lo;
                if m > remaining then
                    m := remaining;
                end if;

                for i in 0 to width - 1 loop
                    if i < addr_lo or m = 0 then
                        n_lbe(i) := '0';
                        n_ld(8 * (i + 1) - 1 downto 8 * i) := (others => '0');
                    else
                        n_lbe(i) := be(be_offset);
                        be_offset := be_offset + 1;
                        n_ld(8 * (i + 1) - 1 downto 8 * i) := data(data_offset);
                        data_offset := data_offset + 1;
                        remaining := remaining - 1;
                        if remaining = 0 then
                            n_lblast := '1';
                        end if;
                        m := m - 1;
                    end if;
                end loop;
                n_lbe(7 downto width) := (others => '0');
                n_ld(63 downto 8 * width) := (others => '0');
                n_la(31 downto order) := addr(31 downto order);
                n_la(order - 1 downto 0) := (others => '0');
                if not const_addr then
                    addr(addr'high downto order) := addr(addr'high downto order) + 1;
                end if;
                addr_lo := 0;

                bus_out.la <= n_la;
                bus_out.lbe_l <= not n_lbe;
                bus_out.ld <= n_ld;
            end if;

            bus_out.oe_la <= n_la_oe;
            bus_out.oe_lads <= n_lads_oe;
            bus_out.lads_l <= not n_lads;
            bus_out.oe_lbe <= n_lbe_oe;
            bus_out.lblast_l <= not n_lblast;
            bus_out.oe_l64 <= n_l64_oe;
            bus_out.oe_lblast <= n_lblast_oe;
            bus_out.oe_ld <= n_ld_oe;
            bus_out.oe_lwrite <= n_lwrite_oe;
        end loop;

        nxfered := be'length - remaining;
    end;

    procedure plxsim_burst_write_demand(
               order      : in    natural;
               const_addr : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t)
    is
        constant wide : boolean := false;
        variable addr : std_logic_vector(31 downto 0);
        variable addr_lo : natural;
        variable term, ready : boolean;
        variable data_offset, be_offset : natural;
        variable m, remaining : natural;
        variable next_be : boolean;
        variable width : natural;

        type burst_state_type is (
            bs_arb,
            bs_addr,
            bs_data,
            bs_finished);
        variable state, n_state : burst_state_type;
        variable n_la : std_logic_vector(31 downto 0);
        variable n_la_oe : std_logic;
        variable n_lads : std_logic;
        variable n_lads_oe : std_logic;
        variable n_lbe_oe : std_logic;
        variable n_lbe : std_logic_vector(7 downto 0);
        variable n_l64_oe : std_logic;
        variable n_lblast : std_logic;
        variable n_lblast_oe : std_logic;
        variable n_ld_oe : std_logic;
        variable n_ld : std_logic_vector(63 downto 0);
        variable n_lwrite_oe : std_logic;
        variable n_ldack : std_logic;

    begin
        assert be'length = data'length
            report "*** plxsim_burst_write: byte enable length (" & conv_string(be'length) &
                   ") does not match data length (" & conv_string(be'length) & ")"
            severity failure;

        assert address'length >= 3
            report "*** plxsim_burst_write: address length (" & conv_string(address'length) &
                   ") is less than 3"
            severity failure;

        width := 2**order;
        addr := EXT(address, 32);
        addr_lo := conv_integer_unsigned(addr(order - 1 downto 0));

        state := bs_arb;
        data_offset := data'low;
        be_offset := be'low;
        remaining := be'length;

        bus_out.lwrite <= '1';
        n_ldack := '0';
        n_lblast := '0';
        if order = 3 then
            bus_out.l64_l <= '0';
        else
            bus_out.l64_l <= '1';
        end if;

        while state /= bs_finished loop
            wait until bus_in.lclk'event and bus_in.lclk = '1';

            next_be := false;

            case state is
                when bs_arb =>
                    if bus_in.lholda = '1' then
                        n_state := bs_addr;
                        n_ldack := '1';
                        n_la_oe := '1';
                        n_lbe_oe := '1';
                        n_lads := '1';
                        n_lads_oe := '1';
                        n_l64_oe := '1';
                        n_lblast_oe := '1';
                        n_lwrite_oe := '1';
                        next_be := true;
                    else
                        n_state := bs_arb;
                    end if;

                when bs_addr =>
                    n_lads := '0';
                    n_ld_oe := '1';
                    if dd_in.ldreq_l = '1' then
                        n_lblast := '1';
                    end if;
                    n_state := bs_data;

                when bs_data =>
                    n_lads_oe := '0';

                    term := bus_in.lbterm_l = '0' or (bus_in.lblast_l = '0' and bus_in.lready_l = '0');
                    ready := bus_in.lbterm_l = '0' or bus_in.lready_l = '0';

                    if term then
                        if remaining /= 0 and dd_in.ldreq_l = '0' then
                            n_state := bs_arb;
                        else
                            n_state := bs_finished;
                        end if;
                        n_ldack := '0';
                        n_la_oe := '0';
                        n_lbe_oe := '0';
                        n_ld_oe := '0';
                        n_lblast_oe := '0';
                        n_lwrite_oe := '0';
                        n_l64_oe := '0';
                    else
                        if ready then
                            next_be := true;
                        end if;
                    end if;

                when bs_finished =>
                    null;
            end case;

            state := n_state;

            if next_be then
                m := width - addr_lo;
                if m > remaining then
                    m := remaining;
                end if;

                for i in 0 to width - 1 loop
                    if i < addr_lo or m = 0 then
                        n_lbe(i) := '0';
                        n_ld(8 * (i + 1) - 1 downto 8 * i) := (others => '0');
                    else
                        n_lbe(i) := be(be_offset);
                        be_offset := be_offset + 1;
                        n_ld(8 * (i + 1) - 1 downto 8 * i) := data(data_offset);
                        data_offset := data_offset + 1;
                        remaining := remaining - 1;
                        if remaining = 0 or dd_in.ldreq_l = '1' then
                            n_lblast := '1';
                        end if;
                        m := m - 1;
                    end if;
                end loop;
                n_lbe(7 downto width) := (others => '0');
                n_ld(63 downto 8 * width) := (others => '0');
                n_la(31 downto order) := addr(31 downto order);
                n_la(order - 1 downto 0) := (others => '0');
                if not const_addr then
                    addr(addr'high downto order) := addr(addr'high downto order) + 1;
                end if;
                addr_lo := 0;

                bus_out.la <= n_la;
                bus_out.lbe_l <= not n_lbe;
                bus_out.ld <= n_ld;
            end if;

            bus_out.oe_la <= n_la_oe;
            bus_out.oe_lads <= n_lads_oe;
            bus_out.lads_l <= not n_lads;
            bus_out.oe_lbe <= n_lbe_oe;
            bus_out.lblast_l <= not n_lblast;
            bus_out.oe_l64 <= n_l64_oe;
            bus_out.oe_lblast <= n_lblast_oe;
            bus_out.oe_ld <= n_ld_oe;
            bus_out.oe_lwrite <= n_lwrite_oe;
            dd_out.ldack_l <= not n_ldack;
        end loop;

        nxfered := be'length - remaining;
    end;

    procedure plxsim_burst_read(
               order      : in    natural;
               multiburst : in    boolean;
               const_addr : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t)
    is
        constant wide : boolean := false;
        variable addr : std_logic_vector(31 downto 0);
        variable addr_lo, data_addr_lo : natural;
        variable term, ready : boolean;
        variable be_offset, data_offset : natural;
        variable m, remaining, data_remaining : natural;
        variable next_be : boolean;
        variable width : natural;

        type burst_state_type is (
            bs_arb,
            bs_addr,
            bs_data,
            bs_finished);
        variable state, n_state : burst_state_type;
        variable n_la : std_logic_vector(31 downto 0);
        variable n_la_oe : std_logic;
        variable n_lads : std_logic;
        variable n_lads_oe : std_logic;
        variable n_lbe_oe : std_logic;
        variable n_lbe : std_logic_vector(7 downto 0);
        variable n_l64_oe : std_logic;
        variable n_lblast : std_logic;
        variable n_lblast_oe : std_logic;
        variable n_lwrite_oe : std_logic;

    begin
        assert be'length = data'length
            report "*** plxsim_burst_read: byte enable length (" & conv_string(be'length) &
                   ") does not match data length (" & conv_string(be'length) & ")"
            severity failure;

        assert address'length >= 3
            report "*** plxsim_burst_read: address length (" & conv_string(address'length) &
                   ") is less than 3"
            severity failure;

        width := 2**order;
        addr := EXT(address, 32);
        addr_lo := conv_integer_unsigned(addr(order - 1 downto 0));
        data_addr_lo := addr_lo;

        state := bs_arb;
        be_offset := be'low;
        data_offset := data'low;
        remaining := be'length;
        data_remaining := remaining;

        bus_out.lwrite <= '0';
        n_lblast := '0';
        if order = 3 then
            bus_out.l64_l <= '0';
        else
            bus_out.l64_l <= '1';
        end if;

        while state /= bs_finished loop
            wait until bus_in.lclk'event and bus_in.lclk = '1';

            next_be := false;

            case state is
                when bs_arb =>
                    if bus_in.lholda = '1' then
                        n_state := bs_addr;
                        n_la_oe := '1';
                        n_lbe_oe := '1';
                        n_lads := '1';
                        n_lads_oe := '1';
                        n_l64_oe := '1';
                        n_lblast_oe := '1';
                        n_lwrite_oe := '1';
                        next_be := true;
                        bus_out.lads_l <= '0';
                    else
                        n_state := bs_arb;
                    end if;

                when bs_addr =>
                    n_lads := '0';
                    n_state := bs_data;

                when bs_data =>
                    n_lads_oe := '0';

                    term := bus_in.lbterm_l = '0' or (bus_in.lblast_l = '0' and bus_in.lready_l = '0');
                    ready := bus_in.lbterm_l = '0' or bus_in.lready_l = '0';

                    if ready then
                        m := width - data_addr_lo;
                        if m > data_remaining then
                            m := data_remaining;
                        end if;
                        for i in 0 to width - 1 loop
                            if i >= data_addr_lo and m > 0 then
                                data(data_offset) := bus_in.ld(8 * (i + 1) - 1 downto 8 * i);
                                data_offset := data_offset + 1;
                                data_remaining := data_remaining - 1;
                                m := m - 1;
                            end if;
                        end loop;
                        data_addr_lo := 0;
                    end if;

                    if term then
                        if remaining /= 0 and multiburst then
                            n_state := bs_arb;
                        else
                            n_state := bs_finished;
                        end if;
                        n_la_oe := '0';
                        n_lbe_oe := '0';
                        n_l64_oe := '0';
                        n_lblast_oe := '0';
                        n_lwrite_oe := '0';
                    else
                        if ready then
                            next_be := true;
                        end if;
                    end if;

                when bs_finished =>
                    null;
            end case;

            state := n_state;

            if next_be then
                m := width - addr_lo;
                if m > remaining then
                    m := remaining;
                end if;

                for i in 0 to width - 1 loop
                    if i < addr_lo or m = 0 then
                        n_lbe(i) := '0';
                    else
                        n_lbe(i) := be(be_offset);
                        be_offset := be_offset + 1;
                        remaining := remaining - 1;
                        if remaining = 0 then
                            n_lblast := '1';
                        end if;
                        m := m - 1;
                    end if;
                end loop;
                n_lbe(7 downto width) := (others => '0');
                n_la(31 downto order) := addr(31 downto order);
                n_la(order - 1 downto 0) := (others => '0');
                if not const_addr then
                    addr(addr'high downto order) := addr(addr'high downto order) + 1;
                end if;
                addr_lo := 0;

                bus_out.la <= n_la;
                bus_out.lbe_l <= not n_lbe;
            end if;

            bus_out.oe_la <= n_la_oe;
            bus_out.lads_l <= not n_lads;
            bus_out.oe_lads <= n_lads_oe;
            bus_out.oe_lbe <= n_lbe_oe;
            bus_out.lblast_l <= not n_lblast;
            bus_out.oe_l64 <= n_l64_oe;
            bus_out.oe_lblast <= n_lblast_oe;
            bus_out.oe_lwrite <= n_lwrite_oe;
        end loop;

        nxfered := be'length - remaining;
    end;

    procedure plxsim_burst_read_demand(
               order      : in    natural;
               const_addr : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t)
    is
        constant wide : boolean := false;
        variable addr : std_logic_vector(31 downto 0);
        variable addr_lo, data_addr_lo : natural;
        variable term, ready : boolean;
        variable be_offset, data_offset : natural;
        variable m, remaining, data_remaining : natural;
        variable next_be : boolean;
        variable width : natural;

        type burst_state_type is (
            bs_arb,
            bs_addr,
            bs_data,
            bs_finished);
        variable state, n_state : burst_state_type;
        variable n_la : std_logic_vector(31 downto 0);
        variable n_la_oe : std_logic;
        variable n_lads : std_logic;
        variable n_lads_oe : std_logic;
        variable n_lbe_oe : std_logic;
        variable n_lbe : std_logic_vector(7 downto 0);
        variable n_l64_oe : std_logic;
        variable n_lblast : std_logic;
        variable n_lblast_oe : std_logic;
        variable n_lwrite_oe : std_logic;
        variable n_ldack : std_logic;

    begin
        assert be'length = data'length
            report "*** plxsim_burst_read: byte enable length (" & conv_string(be'length) &
                   ") does not match data length (" & conv_string(be'length) & ")"
            severity failure;

        assert address'length >= 3
            report "*** plxsim_burst_read: address length (" & conv_string(address'length) &
                   ") is less than 3"
            severity failure;

        width := 2**order;
        addr := EXT(address, 32);
        addr_lo := conv_integer_unsigned(addr(order - 1 downto 0));
        data_addr_lo := addr_lo;

        state := bs_arb;
        be_offset := be'low;
        data_offset := data'low;
        remaining := be'length;
        data_remaining := remaining;

        bus_out.lwrite <= '0';
        n_ldack := '0';
        n_lblast := '0';
        if order = 3 then
            bus_out.l64_l <= '0';
        else
            bus_out.l64_l <= '1';
        end if;

        while state /= bs_finished loop
            wait until bus_in.lclk'event and bus_in.lclk = '1';

            next_be := false;

            case state is
                when bs_arb =>
                    if bus_in.lholda = '1' then
                        n_state := bs_addr;
                        n_ldack := '1';
                        n_la_oe := '1';
                        n_lbe_oe := '1';
                        n_lads := '1';
                        n_lads_oe := '1';
                        n_l64_oe := '1';
                        n_lblast_oe := '1';
                        n_lwrite_oe := '1';
                        next_be := true;
                        bus_out.lads_l <= '0';
                    else
                        n_state := bs_arb;
                    end if;

                when bs_addr =>
                    n_lads := '0';
                    if dd_in.ldreq_l = '1' then
                        n_lblast := '1';
                    end if;
                    n_state := bs_data;

                when bs_data =>
                    n_lads_oe := '0';

                    term := bus_in.lbterm_l = '0' or (bus_in.lblast_l = '0' and bus_in.lready_l = '0');
                    ready := bus_in.lbterm_l = '0' or bus_in.lready_l = '0';

                    if ready then
                        m := width - data_addr_lo;
                        if m > data_remaining then
                            m := data_remaining;
                        end if;
                        for i in 0 to width - 1 loop
                            if i >= data_addr_lo and m > 0 then
                                data(data_offset) := bus_in.ld(8 * (i + 1) - 1 downto 8 * i);
                                data_offset := data_offset + 1;
                                data_remaining := data_remaining - 1;
                                m := m - 1;
                            end if;
                        end loop;
                        data_addr_lo := 0;
                    end if;

                    if term then
                        if remaining /= 0 and dd_in.ldreq_l = '0' then
                            n_state := bs_arb;
                        else
                            n_state := bs_finished;
                        end if;
                        n_la_oe := '0';
                        n_lbe_oe := '0';
                        n_l64_oe := '0';
                        n_lblast_oe := '0';
                        n_lwrite_oe := '0';
                        n_ldack := '0';
                    else
                        if ready then
                            next_be := true;
                        end if;
                    end if;

                when bs_finished =>
                    null;
            end case;

            state := n_state;

            if next_be then
                m := width - addr_lo;
                if m > remaining then
                    m := remaining;
                end if;

                for i in 0 to width - 1 loop
                    if i < addr_lo or m = 0 then
                        n_lbe(i) := '0';
                    else
                        n_lbe(i) := be(be_offset);
                        be_offset := be_offset + 1;
                        remaining := remaining - 1;
                        if remaining = 0 or dd_in.ldreq_l = '1' then
                            n_lblast := '1';
                        end if;
                        m := m - 1;
                    end if;
                end loop;
                n_lbe(7 downto width) := (others => '0');
                n_la(31 downto order) := addr(31 downto order);
                n_la(order - 1 downto 0) := (others => '0');
                if not const_addr then
                    addr(addr'high downto 3) := addr(addr'high downto 3) + 1;
                end if;
                addr_lo := 0;

                bus_out.la <= n_la;
                bus_out.lbe_l <= not n_lbe;
            end if;

            bus_out.oe_la <= n_la_oe;
            bus_out.lads_l <= not n_lads;
            bus_out.oe_lads <= n_lads_oe;
            bus_out.oe_lbe <= n_lbe_oe;
            bus_out.lblast_l <= not n_lblast;
            bus_out.oe_l64 <= n_l64_oe;
            bus_out.oe_lblast <= n_lblast_oe;
            bus_out.oe_lwrite <= n_lwrite_oe;
            dd_out.ldack_l <= not n_ldack;
        end loop;

        nxfered := be'length - remaining;
    end;

    -- ---------------------------------------------------------------
    -- Public
    -- ---------------------------------------------------------------

    function conv_integer_signed(
        constant val : in std_logic_vector)
    return integer is
        variable x : std_logic_vector(val'length - 2 downto 0);
    begin
        if val'length = 1 then
            if val = "0" then
                return 0;
            else
                return -1;
            end if;
        else
            x := val(val'high - 1 downto val'low);
            if val(val'high) = '1' then
                return -ieee.std_logic_unsigned.CONV_INTEGER("0" & (not x + 1));
            else
                return ieee.std_logic_unsigned.CONV_INTEGER("0" & x);
            end if;
        end if;
    end;
    
    function conv_integer_unsigned(
        constant val : in std_logic_vector)
    return natural is begin
        return CONV_INTEGER(val);
    end;

    function conv_string(
        val : in time)
    return string is
        variable l : line;
        variable len : integer;
        variable s : string(1 to 64);
    begin
        write(l, val);
        len := l'length;
        read(l, s(1 to len));
        return s(1 to len);
    end;

    function conv_integer(
        constant x : in byte_vector_t)
    return natural is
        variable t : natural;
    begin
        t := 0;
	for i in x'range loop
            t := t + 2**(i * 8) * conv_integer(x(i));
        end loop;

        return t;
    end;

    function conv_string(
        constant val : in integer)
    return string is
        variable l : line;
        variable len : integer;
        variable s : string(1 to 64);
    begin
        write(l, val);
        len := l'length;
        read(l, s(1 to len));
        return s(1 to len);
    end;

    function conv_string(
        constant val : in real)
    return string is
        variable l : line;
        variable len : integer;
        variable s : string(1 to 64);
    begin
        write(l, val);
        len := l'length;
        read(l, s(1 to len));
        return s(1 to len);
    end;

    function conv_string(
        constant val : in boolean)
    return string is
        variable l : line;
        variable len : integer;
        variable s : string(1 to 64);
    begin
        if val then
            return "true";
        else
            return "false";
        end if;
    end;

    function conv_string_hex(
        constant val : in std_logic_vector)
    return string is
        variable u, l : integer;
        variable digit : std_logic_vector(3 downto 0);
        variable s, t : string(1 to 64);
        variable i : natural;
        variable tmp : std_logic_vector(val'length - 1 downto 0);
    begin
        tmp := val;
        i := 1;
        l := tmp'low;
        u := tmp'high;

        while l <= u loop
            if (u + 1 - l) < 4 then
                digit := EXT(tmp(u downto l), 4);
            else
                digit := tmp(l + 3 downto l);
            end if;
            s(i) := conv_string_hexdigit(digit);
            i := i + 1;
            l := l + 4;
        end loop;

        for j in 1 to i loop
            t(j) := s(i - j + 1);
        end loop;

        return t;
    end;

    function conv_string_hex(
        constant val : in byte_vector_t)
    return string is
        variable j : integer;
        variable digit : std_logic_vector(3 downto 0);
        variable s : string(1 to 2 * val'length);
	variable byte : byte_t;
    begin
        j := 2 * val'length;

        for i in val'range loop
            byte := val(i);
            s(j) := conv_string_hexdigit(byte(3 downto 0));
            s(j - 1) := conv_string_hexdigit(byte(7 downto 4));
            j := j - 2;
        end loop;

        return s;
    end;

    function conv_string_hex(
        constant val : in integer)
    return string is
    begin
        return conv_string_hex(CONV_STD_LOGIC_VECTOR(val, 64));
    end;

    function conv_byte_vector(
        constant x : in std_logic_vector)
    return byte_vector_t is
        variable n : natural := (x'length + 7) / 8;
        variable m : std_logic_vector(8 * n - 1 downto 0);
        variable t : byte_vector_t(0 to n - 1);
    begin
        m := ext(x, 8 * n);
        for i in 0 to n - 1 loop
            t(i) := m(8 * (i + 1) - 1 downto 8 * i);
        end loop;

        return t;
    end;

    function conv_std_logic_vector(
        constant x : in byte_vector_t)
    return std_logic_vector is
        variable t : std_logic_vector(x'length * 8 - 1 downto 0);
    begin
        for i in 0 to x'length - 1 loop
            t(8 * (i + 1) - 1 downto 8 * i) := x(x'low + i);
        end loop;

        return t;
    end;

    -- ---------------------------------------------------------------
    -- Public local bus routines
    -- ---------------------------------------------------------------

    procedure plxsim_read(
               order      : in    natural;
               multiburst : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t)
    is
    begin
        plxsim_burst_read(order, multiburst, false, address, be, data, nxfered, bus_in, bus_out);
    end;

    procedure plxsim_write(
               order      : in    natural;
               multiburst : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t)
    is
    begin
        plxsim_burst_write(order, multiburst, false, address, be, data, nxfered, bus_in, bus_out);
    end;

    procedure plxsim_read_const(
               order      : in    natural;
               multiburst : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t)
    is
    begin
        plxsim_burst_read(order, multiburst, true, address, be, data, nxfered, bus_in, bus_out);
    end;

    procedure plxsim_write_const(
               order      : in    natural;
               multiburst : in    boolean;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t)
    is begin
        plxsim_burst_write(order, multiburst, true, address, be, data, nxfered, bus_in, bus_out);
    end;

    procedure plxsim_read_demand(
               order      : in    natural;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t)
    is
    begin
        plxsim_burst_read_demand(order, false, address, be, data, nxfered, bus_in, bus_out, dd_in, dd_out);
    end;

    procedure plxsim_request_bus(
               request    : in    boolean;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t)
    is
    begin
        if request then
            loop
                exit when bus_in.lholda = '0';
                wait until bus_in.lclk'event and bus_in.lclk = '1';
            end loop;
            bus_out.lhold <= '1';
        else
            wait until bus_in.lclk'event and bus_in.lclk = '1';
            loop
                exit when bus_in.lholda = '1';
                wait until bus_in.lclk'event and bus_in.lclk = '1';
            end loop;
            bus_out.lhold <= '0';
        end if;
    end;

    procedure plxsim_wait_cycles(
               n          : in    natural;
        signal bus_in     : in    locbus_in_t)
    is
    begin
        for i in 0 to n - 1 loop
            wait until bus_in.lclk'event and bus_in.lclk = '1';
        end loop;
    end;

    procedure plxsim_wait_demand(
        signal bus_in     : in    locbus_in_t;
        signal dd_in      : in    locbus_ddma_in_t)
    is
    begin
        loop
            exit when dd_in.ldreq_l = '0';
            wait until bus_in.lclk'event and bus_in.lclk = '1';
        end loop;
    end;

    procedure plxsim_write_demand(
               order      : in    natural;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t)
    is
    begin
        plxsim_burst_write_demand(order, false, address, be, data, nxfered, bus_in, bus_out, dd_in, dd_out);
    end;

    procedure plxsim_read_const_demand(
               order      : in    natural;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : out   byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t)
    is
    begin
        plxsim_burst_read_demand(order, true, address, be, data, nxfered, bus_in, bus_out, dd_in, dd_out);
    end;

    procedure plxsim_write_const_demand(
               order      : in    natural;
               address    : in    std_logic_vector;
               be         : in    byte_enable_t;
               data       : in    byte_vector_t;
               nxfered    : out   natural;
        signal bus_in     : in    locbus_in_t;
        signal bus_out    : out   locbus_out_t;
        signal dd_in      : in    locbus_ddma_in_t;
        signal dd_out     : out   locbus_ddma_out_t)
    is
    begin
        plxsim_burst_write_demand(order, true, address, be, data, nxfered, bus_in, bus_out, dd_in, dd_out);
    end;

end;
