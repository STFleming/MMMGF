--
-- lbpcheck.vhd - local bus protocol checker for Direct Slave transfers
--
-- (C) Copyright Alpha Data 2002-2005
--
-- NOT SYNTHESIZABLE
--
-- =============================================================================================
--
-- Revision history
--
--   Version   Who       Date          Comment
--
--   1.0       TW(AD)    31/10/2002    First version, prerelease
--
--   1.1       TW(AD)    29/1/2004     Clarifications added for 32-bit and 64-bit local bus
--                                     operation with ADM-XPL/ADM-XP/ADP-XPI.
--
--   1.2       TW(AD)    25/3/2004     ADM-WRCII and ADM-DRCII comments added.
--
--   1.3       TW(AD)    29/3/2004     Changed active low signal suffix from '_n' to '_l'.
--
-- =============================================================================================
-- Usage:
--
--     The rules for instantiating this module differ depending on which ADM-XRC series card
--     your testbench is targetting.
--
--     All cards:
--
--          1. Map the ports 'lclk', 'lreset_l', 'lads_l', 'lwrite', 'lblast_l', 'lready_l' and
--             'lbterm_l' to the corresponding signals in your testbench.
--
--          2. Map the ports 'l64_l', 'la', 'lad_lo', 'lad_hi', 'lbe_lo_l', 'lbe_hi_l' according
--             to which card your testbench is targetting (see below).
--
--          3. Map the generics 'multiplexed' and 'wide' according to which card your testbench
--             is targetting (see below).
--
--          4. Ensure that your testbench pulls up the following signals: 'lads_l', 'lblast_l',
--             'lbterm_l', and 'lready_l'.
--
--     ADM-XRC / ADM-XRC-P / ADM-XRCII-L / ADM-XRCII / ADM-WRCII / ADM-DRCII / 
--     ADM-XRC-4LX / ADM-XRC-4SX specific:
--
--       The local bus is 32-bit with nonmultiplexed address and data. Therefore:
--
--          1. Map the 'multiplexed' generic to 'false'.
--
--          2. Map the 'wide' generic to 'false'.
--
--          3. Map the 'l64_l' port to any std_logic signal in your testbench.
--             Since 'wide' is false, its value will be ignored.
--
--          4. Map the 'la' port to the local address bus.
--
--          5. Map the 'lad_lo' port to the local data bus in your testbench.
--
--          6. Map the 'lad_hi' port to any 32-bit std_logic_vector in your testbench.
--             Since 'wide' is false, its value will be ignored.
--
--          7. Map the 'lbe_lo_l' port to the local byte enables in your testbench.
--
--          8. Map the 'lbe_hi_l' port to any 4-bit std_logic_vector in your testbench.
--             Since 'wide' is false, its value will be ignored.
--
--     ADM-XPL / ADM-XP / ADP-XPI specific:
--
--       The local bus is 32-bit or 64-bit with multiplexed address and data. Therefore:
--
--          1. Map the 'multiplexed' generic to 'true'.
--
--          2. Map the 'wide' generic to 'true' if you are operating the local bus in 64-bit
--             mode. Otherwise, map the 'wide' generic to 'false'.
--
--          3. If you are operating the local bus in 64-bit mode, map the 'l64_l' port to
--             the signal corresponding to it in your testbench, and ensure that 'l64_l' is
--             pulled up. Otherwise, map it to any signal (for example, a constant zero).
--
--          4. Map the 'la' port to any 30-bit bus in your testbench, as it will be ignored.
--
--          5. Map the 'lad_lo' port to the low 32 bits of the local address/data bus in your
--             testbench.
--
--          6. If you are operating the local bus in 64-bit mode, map the 'lad_hi' port to
--             the high 32 bits of the local address/data bus in your testbench. Otherwise,
--             map the 'lad_hi' port to any 32-bit bus (for example, constant zeroes), as it
--             will be ignored.
--
--          7. Map the 'lbe_lo_l' port to the low 4 bits of the local byte enables in your
--             testbench.
--
--          8. If you are operating the local bus in 64-bit mode, map the 'lbe_hi_l' port to
--             the high 4 bits of the local byte enables in your testbench. Otherwise, map
--             the 'lbe_hi_l' port to any 4-bit bus (for example, constant zeroes), as it will
--             be ignored.
--
-- =============================================================================================
-- This module assumes that rules given below govern the local bus protocol. The [WIDE] symbol
-- indicates that a rule applies only to a 64-bit local bus. The checks for these rules will
-- only be executed if the 'wide' generic is true.
--
-- The following terms are used in the rules below:
--
--    o 'valid'      - means that a signal, or each signal in a bus, can be interpreted as a
--                     valid logic 0 or logic 1. Thus '-', 'Z' and 'X' are considered invalid,
--                     whilst 'L', 'H', '0' and '1' are considered valid.
--
--    o 'asserted'   - For an active high signal, means a valid logic 1. For an active low
--                     signal, means a valid logic 0.
--
--    o 'deasserted' - For an active high signal, means a valid logic 0. For an active low
--                     signal, means a valid logic 1.
--
--    o 'tristated'  - A level of 'Z'.
--
-- A. General reset rules
-- ----------------------
--
-- A1.   'lreset_l' shall be valid at all times.
--
-- A2.   When 'lreset_l' is asserted, the 'lads_l' signal shall be deasserted or tristated
--       within 100 ns.
--
-- A3.   [WIDE] When 'lreset_l' is asserted, the 'l64_l' signal shall be deasserted or tristated
--       within 100 ns.
--
-- A4.   When 'lreset_l' is asserted, the 'lwrite' signal shall be tristated within 100 ns.
--
-- A5.   When 'lreset_l' is asserted, the 'lblast_l' signal shall be deasserted or tristated
--       within 100 ns.
--
-- A6.   When 'lreset_l' is asserted, the 'lready_l' signal shall be deasserted or tristated
--       within 100 ns.
--
-- A7.   When 'lreset_l' is asserted, the 'lbterm_l' signal shall be deasserted or tristated
--       within 100 ns.
--
-- A8.   When 'lreset_l' is asserted, 'lad<31:0>' shall be tristated within 100 ns.
--
-- A9.   [WIDE] When 'lreset_l' is asserted, 'lad<63:32>' shall be tristated within 100 ns.
--
-- A10.  When 'lreset_l' is asserted, 'lbe_l<3:0>' shall be tristated within 100 ns.
--
-- A11.  [WIDE] When 'lreset_l' is asserted, 'lbe_l<7:4>' shall be tristated within 100 ns.
--
-- A12.  'lclk' shall be valid at all times when 'lreset_l' is deasserted.
--
--
-- B. Reset rules for nonmultiplexed bus
-- -------------------------------------
--
-- B1.   When lreset_l' is asserted, the 'la<31:0>' signal shall be deasserted or tristated
--       within 100ns.
--
-- C. General transaction rules
-- ----------------------------
--
-- A local bus transaction is defined to be every 'lclk' cycle in the interval
--
--     o from and including the 'lclk' cycle where 'lads_l' is asserted,
--     o to and including the 'lclk' cycle where either (a) 'lbterm_l' is asserted, or
--       (b) 'lready_l' and 'lblast_l' are both asserted.
--
-- Cycle 0 of a local bus transaction is defined to be the one in which 'lads_l' is asserted.
-- Cycle n-1 is defined to be the final cycle of the transaction.
-- The turnaround cycle is defined to be the cycle following the final cycle of a transaction.
--
-- C1.   'lads_l' shall be valid at all rising edges of 'lclk' when 'lreset_l' is deasserted.
--
-- C2.   'lads_l' shall be asserted for exactly 1 'lclk' cycle per transaction.
--
-- C3.   'lready_l' shall be valid for the entire duration of a local bus transaction.
--
-- C4.   'lbterm_l' shall be valid for the entire duration of a local bus transaction.
--
-- C5.   'lwrite' shall be valid for the duration of the entire local bus transaction.
--
-- C6.   'lwrite' shall not change for the duration of the entire local bus transaction.
--
-- C7.   'lblast_l' shall be valid for the duration of the entire local bus transaction.
--
-- C8.   'lblast_l' shall be permitted, for the duration of a local bus transaction, only to
--        change at 'lclk' rising edges where 'lready_l' is asserted.
--
-- C9.   'lblast_l' shall, once asserted, remain asserted for the remainder of the local bus
--       transaction.
--
-- C10.  [WIDE] 'l64_l' shall be valid for the duration of the entire local bus transaction.
--
-- C11.  [WIDE] 'l64_l' shall not change for the duration of the entire local bus transaction.
--
-- C12.  'lbe_l<3:0>' shall be valid for all cycles in the local bus transaction.
--
-- C13.  'lbe_l<3:0>' shall, for the duration of the local bus transaction, change only at an
--       'lclk' edge where 'lready_l' is asserted.
--
-- C14.  [WIDE] If 'l64_l' is asserted when 'lads_l' is asserted, 'lbe_l<7:4>' shall be valid for
--       all cycles in the local bus transaction.
--
-- C15.  [WIDE] If 'l64_l' is asserted when 'lads_l' is asserted, then for the duration of the
--       local bus transaction, 'lbe_l<7:4>' shall change only at an 'lclk' edge where 'lready_l'
--       is asserted.
--
-- C16.  If 'lwrite' is deasserted when 'lads_l' is asserted, then 'lad<31:0>' shall be valid
--       whenever 'lready_l' or 'lbterm_l' is asserted.
--
-- C17.  [WIDE] If 'lwrite' is deasserted and 'l64_l' is asserted when 'lads_l' is asserted,
--       then 'lad<63:32>' shall be valid whenever 'lready_l' or 'lbterm_l' is asserted.
--
-- D. Transaction rules for multiplexed bus
-- ----------------------------------------
--
-- D1.   'lready_l' shall be deasserted in the cycle when 'lads_l' is asserted and in the
--       cycle following 'lads_l'.
--
-- D2.   'lbterm_l' shall be deasserted in the cycle when 'lads_l' is asserted and in
--       the cycle following 'lads_l'.
--
-- D3.   'lad<31:0>' shall be valid at the rising edge of 'lclk' when 'lads_l' is asserted.
--
-- D4.   [WIDE] If 'l64_l' is asserted when 'lads_l' is asserted, 'lad<63:32>' shall be valid
--       at the rising edge of 'lclk' when 'lads_l' is asserted.
--
-- D5.   If 'lwrite' is asserted when 'lads_l' is asserted, then 'lad<31:0>' shall be valid
--       for cycles 1 to n-1 of a local bus transaction.
--
-- D6.   [WIDE] If 'lwrite' and 'l64_l' are both asserted when 'lads_l' is asserted, then
--       'lad<63:32>' shall be valid for cycles 1 to n-1 of a local bus transaction.
--
-- D7.   'lad<1:0>' shall be zero at the rising edge of 'lclk' when 'lads_l' is asserted.
--
-- D8.   [WIDE] 'lad<2>' shall be zero at the rising edge of 'lclk' when both 'lads_l' and
--       and 'l64_l' are asserted.
--
-- D9.   If 'lwrite' is asserted when 'lads_l' is asserted, then for the duration of the local
--       bus transaction, 'lad<31:0>' shall change only at an 'lclk' edge where either 'lads_l'
--       or 'lready_l' is asserted.
--
-- D10.  [WIDE] If 'lwrite' is asserted and 'l64_l' is asserted when 'lads_l' is asserted, then
--       for the duration of the local bus transaction, 'lad<63:32>' shall change only at an
--       'lclk' edge where either 'lads_l' or 'lready_l' is asserted.
--
-- E. Transaction rules for nonmultiplexed bus
-- -------------------------------------------
--
-- E1.   'lready_l' shall be deasserted in any cycle when 'lads_l' is asserted.
--
-- E2.   'lbterm_l' shall be deasserted in any cycle when 'lads_l' is asserted.
--
-- E3.   'la<31:2>' shall be valid for all cycles in a local bus transaction.
--
-- E4.   'la<31:2>' shall, for the duration of the local bus transaction, change only at
--       an 'lclk' edge where 'lready_l' is asserted.
--
-- E5.   [WIDE] 'la<2>' shall, for the duration of a local bus transaction, be zero if 'lads_l'
--       and 'l64_l' are both asserted at the rising edge of 'lclk'.
--
-- E6.   If 'lwrite' is asserted when 'lads_l' is asserted, then 'lad<31:0>' shall be valid
--       for cycles 1 to n-1 of a local bus transaction.
--
-- E7.   [WIDE] If 'lwrite' and 'l64_l' are both asserted when 'lads_l' is asserted, then
--       'lad<63:32>' shall be valid for cycles 1 to n-1 of a local bus transaction.
--
-- E8.   If 'lwrite' is asserted when 'lads_l' is asserted, then for the duration of the local
--       bus transaction, 'lad<31:0>' shall change only at an 'lclk' rising edge where 'lready_l'
--       is asserted.
--
-- E9.   [WIDE] If 'lwrite' is asserted and 'l64_l' is asserted when 'lads_l' is asserted, then
--       for the duration of the local bus transaction, 'lad<63:32>' shall change only at an
--       'lclk' edge where 'lready_l' is asserted.
--
-- F. Extra-transaction rules
-- --------------------------
--
-- F1.   'lready_l' shall be deasserted in any cycle that is not part of a local bus
--       transaction.
--
-- F2.   'lbterm_l' shall be deasserted in any cycle that is not part of a local bus
--       transaction.
--
-- F3.   'lblast_l' shall be deasserted in any cycle that is not part of a local bus
--       transaction.
--
-- F4.   [WIDE] 'l64_l' shall be deasserted in any cycle that is not part of a local bus 
--       transaction.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library std;
use std.textio.all;

entity lbpcheck is
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
end lbpcheck;

architecture behav of lbpcheck is

    -- Maximum cycle duration is 2**16 local bus clock cycles
    constant transaction_cycle_order : natural := 16;
    constant transaction_phase_order : natural := 16;

    signal delayed_lreset_l : std_logic := '1';

    signal lad : std_logic_vector(63 downto 0);
    signal lbe_l : std_logic_vector(7 downto 0);

    signal lads_q_l : std_logic;
    signal lwrite_q : std_logic;
    signal l64_q_l : std_logic;
    signal lblast_q_l : std_logic;
    signal lready_q_l : std_logic;
    signal lbterm_q_l : std_logic;
    signal la_q : std_logic_vector(31 downto 2);
    signal lad_q : std_logic_vector(63 downto 0);
    signal lbe_q_l : std_logic_vector(7 downto 0);

    signal transaction_64bit : std_logic;
    signal in_transaction : std_logic;
    signal end_transaction : std_logic;
    signal start_transaction : std_logic;
    signal first_phase : std_logic;
    signal last_phase : std_logic;
    signal next_phase : std_logic;

    signal in_transaction_q : std_logic := '0';
    signal transaction_cycle : std_logic_vector(transaction_cycle_order - 1 downto 0);
    signal transaction_phase : std_logic_vector(transaction_phase_order - 1 downto 0);

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

    procedure report_message(
        str : in string)
    is
        variable msg : line;
    begin
        write(msg, str);
        writeline(output, msg);
    end;

begin

    lad   <= lad_hi & lad_lo;
    lbe_l <= lbe_hi_l & lbe_lo_l;

    delayed_lreset_l <= inertial lreset_l after 100 ns;

    end_transaction   <= in_transaction_q and (not lbterm_l or (not lblast_l and not lready_l));
    in_transaction    <= (not lads_l and not in_transaction_q) or in_transaction_q;
    start_transaction <= not lads_l;
    transaction_64bit <= (start_transaction and not l64_l) or (in_transaction_q and not l64_q_l);
    last_phase        <= in_transaction_q and not lblast_l;
    next_phase        <= in_transaction_q and (not lready_l and lblast_l);

    process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            in_transaction_q  <= '0';
            transaction_cycle <= (others => '-');
            transaction_phase <= (others => '-');
        elsif lclk'event and lclk = '1' then
            if start_transaction = '1' then
                in_transaction_q  <= '1';
                transaction_cycle <= CONV_STD_LOGIC_VECTOR(1, transaction_cycle_order);
                transaction_phase <= CONV_STD_LOGIC_VECTOR(0, transaction_phase_order);
                first_phase       <= '1';
            else
                if end_transaction = '1' then
                    in_transaction_q <= '0';
                end if;

                if in_transaction = '1' then
                    transaction_cycle <= transaction_cycle + 1;
                end if;

                if next_phase = '1' then
                    transaction_phase <= transaction_phase + 1;
                    first_phase       <= '0';
                end if;
            end if;
        end if;
    end process;

    process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            lads_q_l    <= '-';
            lready_q_l  <= '-';
            lbterm_q_l  <= '-';
            lblast_q_l  <= '-';
            la_q        <= (others => '-');
            lad_q       <= (others => '-');
            lbe_q_l     <= (others => '-');
        elsif lclk'event and lclk = '1' then
            lads_q_l    <= lads_l;
            lready_q_l  <= lready_l;
            lbterm_q_l  <= lbterm_l;
            lblast_q_l  <= lblast_l;
            la_q        <= la;
            lad_q       <= lad;
            lbe_q_l     <= lbe_l;
        end if;
    end process;

    check_A1 : process(lreset_l)
        variable x : std_logic;
    begin
        if to_X01(lreset_l) = 'X' and now > 1 ns then
            report_message("*** lbpcheck A1 [time = " & conv_string(now) & "] lreset_l invalid");
        end if;
    end process;

    check_A2 : process(delayed_lreset_l, lads_l)
    begin
        if delayed_lreset_l = '0' then
            if lads_l /= 'H' and l64_l /= 'Z' then
                report_message("*** lbpcheck A2 [time = " & conv_string(now) & "] lads_l not tristated/deasserted by reset");
            end if;
        end if;
    end process;

    check_A3 : process(delayed_lreset_l, l64_l)
    begin
        if wide and delayed_lreset_l = '0' then
            if l64_l /= 'H' and l64_l /= 'Z' then
                report_message("*** lbpcheck A3 [time = " & conv_string(now) & "] l64_l not tristated/deasserted by reset");
            end if;
        end if;
    end process;

    check_A4 : process(delayed_lreset_l, lwrite)
    begin
        if delayed_lreset_l = '0' then
            if lwrite /= 'H' and lwrite /= 'L' and lwrite /= 'Z' then
                report_message("*** lbpcheck A4 [time = " & conv_string(now) & "] lwrite not tristated by reset");
            end if;
        end if;
    end process;

    check_A5 : process(delayed_lreset_l, lblast_l)
    begin
        if delayed_lreset_l = '0' then
            if lblast_l /= 'H' and lblast_l /= 'Z' then
                report_message("*** lbpcheck A5 [time = " & conv_string(now) & "] lblast_l not tristated/deasserted by reset");
            end if;
        end if;
    end process;

    check_A6 : process(delayed_lreset_l, lready_l)
    begin
        if delayed_lreset_l = '0' then
            if lready_l /= 'H' and lready_l /= 'Z' then
                report_message("*** lbpcheck A6 [time = " & conv_string(now) & "] lready_l not tristated/deasserted by reset");
            end if;
        end if;
    end process;

    check_A7 : process(delayed_lreset_l, lbterm_l)
    begin
        if delayed_lreset_l = '0' then
            if lbterm_l /= 'H' and lbterm_l /= 'Z' then
                report_message("*** lbpcheck A7 [time = " & conv_string(now) & "] lbterm_l not tristated/deasserted by reset");
            end if;
        end if;
    end process;

    check_A8 : process(delayed_lreset_l, lad)
        variable error : boolean;
    begin
        if delayed_lreset_l = '0' then
            error := false;
            for i in 31 downto 0 loop
                if lad(i) /= 'H' and lad(i) /= 'L' and lad(i) /= 'Z' then
                    error := true;
                end if;
            end loop;

            if error then
                report_message("*** lbpcheck A8 [time = " & conv_string(now) & "] lad<31:0> not tristated by reset");
            end if;
        end if;
    end process;

    check_A9 : process(delayed_lreset_l, lad)
        variable error : boolean;
    begin
        if wide and delayed_lreset_l = '0' then
            error := false;
            for i in 63 downto 32 loop
                if lad(i) /= 'H' and lad(i) /= 'L' and lad(i) /= 'Z' then
                    error := true;
                end if;
            end loop;

            if error then
                report_message("*** lbpcheck A9 [time = " & conv_string(now) & "] lad<63:32> not tristated by reset");
            end if;
        end if;
    end process;

    check_A10 : process(delayed_lreset_l, lbe_l)
        variable error : boolean;
    begin
        if delayed_lreset_l = '0' then
            error := false;
            for i in 3 downto 0 loop
                if lbe_l(i) /= 'H' and lbe_l(i) /= 'L' and lbe_l(i) /= 'Z' then
                    error := true;
                end if;
            end loop;

            if error then
                report_message("*** lbpcheck A10 [time = " & conv_string(now) & "] lbe_l<3:0> not tristated by reset");
            end if;
        end if;
    end process;

    check_A11 : process(delayed_lreset_l, lbe_l)
        variable error : boolean;
    begin
        if wide and delayed_lreset_l = '0' then
            error := false;
            for i in 7 downto 4 loop
                if lbe_l(i) /= 'H' and lbe_l(i) /= 'L' and lbe_l(i) /= 'Z' then
                    error := true;
                end if;
            end loop;

            if error then
                report_message("*** lbpcheck A11 [time = " & conv_string(now) & "] lbe_l<7:4> not tristated by reset");
            end if;
        end if;
    end process;

    check_A12 : process(lreset_l, lclk)
    begin
        if lreset_l = '1' then
            if to_X01(lclk) = 'X' then
                report_message("*** lbpcheck A12 [time = " & conv_string(now) & "] lclk not valid out of reset");
            end if;
        end if;
    end process;

    check_B1 : process(delayed_lreset_l, la)
        variable error : boolean;
    begin
        if not multiplexed and delayed_lreset_l = '0' then
            error := false;
            for i in 31 downto 2 loop
                if la(i) /= 'H' and la(i) /= 'L' and la(i) /= 'Z' then
                    error := true;
                end if;
            end loop;

            if error then
                report_message("*** lbpcheck b1 [time = " & conv_string(now) & "] la<31:2> not tristated by reset");
            end if;
        end if;
    end process;

    check_C1 : process(
        lreset_l,
        lclk,
        lads_l)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if to_X01(lads_l) = 'X' then
                report_message("*** lbpcheck C1 [time = " & conv_string(now) & "] lads_l not valid");
            end if;
        end if;
    end process;

    check_C2 : process(lreset_l, lclk)
        variable x : std_logic;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if in_transaction = '1' and start_transaction = '0' and lads_l = '0' then
                report_message("*** lbpcheck C2 [time = " & conv_string(now) & "] lads_l asserted within transaction");
            end if;
        end if;
    end process;

    check_C3 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if in_transaction = '1' then
                if to_X01(lready_l) = 'X' then
                    report_message("*** lbpcheck C3 [time = " & conv_string(now) & "] lready_l not valid during transaction");
                end if;
            end if;
        end if;
    end process;

    check_C4 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if in_transaction = '1' then
                if to_X01(lbterm_l) = 'X' then
                    report_message("*** lbpcheck C4 [time = " & conv_string(now) & "] lbterm_l not valid during transaction");
                end if;
            end if;
        end if;
    end process;

    check_C5 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if in_transaction = '1' then
                if to_X01(lwrite) = 'X' then
                    report_message("*** lbpcheck C5 [time = " & conv_string(now) & "] lwrite not valid during transaction");
                end if;
            end if;
        end if;
    end process;

    check_C6 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            lwrite_q <= '-';
        elsif lclk'event and lclk = '1' then
            if start_transaction = '1' then
                lwrite_q <= lwrite;
            else
                if in_transaction = '1' and lwrite /= lwrite_q then
                    report_message("*** lbpcheck C6 [time = " & conv_string(now) & "] lwrite changed during transaction");
                end if;
            end if;
        end if;
    end process;

    check_C7 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if in_transaction = '1' then
                if to_X01(lblast_l) = 'X' then
                    report_message("*** lbpcheck C7 [time = " & conv_string(now) & "] lblast_l not valid during transaction");
                end if;
            end if;
        end if;
    end process;

    check_C8 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if start_transaction = '0' and in_transaction = '1' then
                if lblast_l /= lblast_q_l and lready_q_l = '1' then
                    report_message("*** lbpcheck C8 [time = " & conv_string(now) & "] lblast_l changed without lready_l");
                end if;
            end if;
        end if;
    end process;

    check_C9 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if start_transaction = '0' and in_transaction = '1' then
                if lblast_q_l = '0' and lblast_q_l = '1' then
                    report_message("*** lbpcheck C9 [time = " & conv_string(now) & "] lblast_l deasserted before end of transaction");
                end if;
            end if;
        end if;
    end process;

    check_C10 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide and in_transaction = '1' then
                if to_X01(l64_l) = 'X' then
                    report_message("*** lbpcheck C10 [time = " & conv_string(now) & "] l64_l not valid during transaction");
                end if;
            end if;
        end if;
    end process;

    check_C11 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            l64_q_l <= '-';
        elsif lclk'event and lclk = '1' then
            if wide then
                if start_transaction = '1' then
                    l64_q_l <= l64_l;
                else
                    if in_transaction = '1' and l64_l /= l64_q_l then
                        report_message("*** lbpcheck C11 [time = " & conv_string(now) & "] l64_l changed during transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_C12 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if in_transaction = '1' then
                error := false;
                for i in 3 downto 0 loop
                    if to_X01(lbe_l(i)) = 'X' then
                        error := true;
                    end if;
                end loop;

                if error then
                    report_message("*** lbpcheck C12 [time = " & conv_string(now) & "] lbe_l<3:0> not valid in transaction");
                end if;
            end if;
        end if;
    end process;

    check_C13 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if in_transaction = '1' and start_transaction = '0' and
               lbe_l(3 downto 0) /= lbe_q_l(3 downto 0) and lready_q_l /= '0'
            then
                report_message("*** lbpcheck C13 [time = " & conv_string(now) & "] lbe_l<3:0> changed illegally in transaction");
            end if;
        end if;
    end process;

    check_C14 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide then
                if in_transaction = '1' and transaction_64bit = '1' then
                    error := false;
                    for i in 7 downto 4 loop
                        if to_X01(lbe_l(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck C14 [time = " & conv_string(now) & "] lbe_l<7:4> not valid in 64-bit transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_C15 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide then
                if in_transaction = '1' and transaction_64bit = '1' and start_transaction = '0' then
                    if lbe_l(7 downto 4) /= lbe_q_l(7 downto 4) and lready_q_l /= '0' then
                        report_message("*** lbpcheck C15 [time = " & conv_string(now) & "] lbe_l<7:4> changed illegally in 64-bit transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_C16 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if in_transaction = '1' and lwrite_q = '0' and (lready_l = '0' or lbterm_l = '0') then
                error := false;
                for i in 31 downto 0 loop
                    if to_X01(lad(i)) = 'X' then
                        error := true;
                    end if;
                end loop;

                if error then
                    report_message("*** lbpcheck C16 [time = " & conv_string(now) & "] lad<31:0> not valid when lready_l or lbterm_l asserted in read transaction");
                end if;
            end if;
        end if;
    end process;

    check_C17 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide then
                if in_transaction = '1' and lwrite_q = '0' and l64_q_l = '0' and (lready_l = '0' or lbterm_l = '0') then
                    error := false;
                    for i in 63 downto 32 loop
                        if to_X01(lad(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck C17 [time = " & conv_string(now) & "] lad<63:32> not valid when lready_l or lbterm_l asserted in 64-bit read transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_D1 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if multiplexed then
                if (lads_l = '0' or lads_q_l = '0') and to_X01(lready_l) /= '1' then
                    report_message("*** lbpcheck D1 [time = " & conv_string(now) & "] lready_l not deasserted in transaction cycle 0 or 1");
                end if;
            end if;
        end if;
    end process;

    check_D2 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if multiplexed then
                if (lads_l = '0' or lads_q_l = '0') and to_X01(lbterm_l) /= '1' then
                    report_message("*** lbpcheck D2 [time = " & conv_string(now) & "] lbterm_l not deasserted in transaction cycle 0 or 1");
                end if;
            end if;
        end if;
    end process;

    check_D3 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if multiplexed then
                if start_transaction = '1' then
                    error := false;
                    for i in 31 downto 0 loop
                        if to_X01(lad(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck D3 [time = " & conv_string(now) & "] lad<31:0> not valid when lads_l asserted");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_D4 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide and multiplexed then
                if start_transaction = '1' and l64_l = '0' then
                    error := false;
                    for i in 63 downto 32 loop
                        if to_X01(lad(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck D4 [time = " & conv_string(now) & "] lad<63:32> not valid when lads_l asserted in 64-bit transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_D5 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if multiplexed then
                if start_transaction = '0' and in_transaction = '1' and lwrite_q = '1' then
                    error := false;
                    for i in 31 downto 0 loop
                        if to_X01(lad(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck D5 [time = " & conv_string(now) & "] lad<31:0> not valid in write transaction after address phase");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_D6 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide and multiplexed then
                if start_transaction = '0' and in_transaction = '1' and lwrite_q = '1' and l64_l = '0' then
                    error := false;
                    for i in 63 downto 32 loop
                        if to_X01(lad(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck D6 [time = " & conv_string(now) & "] lad<63:32> not valid in write transaction after address phase");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_D7 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if multiplexed then
                if start_transaction = '1' then
                    if to_X01(lad(1 downto 0)) /= "00" then
                        report_message("*** lbpcheck D7 [time = " & conv_string(now) & "] lad<1:0> not zero when lads_l asserted");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_D8 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide and multiplexed then
                if start_transaction = '1' and l64_l = '0' then
                    if to_X01(lad(2)) /= '0' then
                        report_message("*** lbpcheck D8 [time = " & conv_string(now) & "] lad<2> not zero when lads_l asserted in 64-bit transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_D9 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if multiplexed then
                if in_transaction = '1' and start_transaction = '0' and lwrite_q = '1' and
                   lad(31 downto 0) /= lad_q(31 downto 0) and
                   lads_q_l /= '0' and lready_q_l /= '0'
                then
                    report_message("*** lbpcheck D9 [time = " & conv_string(now) & "] lad<31:0> changed illegally in write transaction");
                end if;
            end if;
        end if;
    end process;

    check_D10 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide and multiplexed then
                if in_transaction = '1' and start_transaction = '0' and
                   lwrite_q = '1' and l64_q_l = '0' and
                   lad(63 downto 32) /= lad_q(63 downto 32) and lads_q_l /= '0' and lready_q_l /= '0'
                then
                    report_message("*** lbpcheck D10 [time = " & conv_string(now) & "] lad<63:32> changed illegally in 64-bit write transaction");
                end if;
            end if;
        end if;
    end process;

    check_E1 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if not multiplexed and lads_l = '0' and to_X01(lready_l) /= '1' then
                report_message("*** lbpcheck B5 [time = " & conv_string(now) & "] lready_l not deasserted in transaction cycle 0");
            end if;
        end if;
    end process;

    check_E2 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if not multiplexed and lads_l = '0' and to_X01(lbterm_l) /= '1' then
                report_message("*** lbpcheck B8 [time = " & conv_string(now) & "] lbterm_l not deasserted in transaction cycle 0");
            end if;
        end if;
    end process;

    check_E3 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if not multiplexed then
                if in_transaction = '1' then
                    error := false;
                    for i in 31 downto 2 loop
                        if to_X01(la(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck E3 [time = " & conv_string(now) & "] la<31:2> not valid in transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_E4: process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if not multiplexed then
                if in_transaction = '1' and start_transaction = '0' and la /= la_q and lready_q_l /= '0' then
                    report_message("*** lbpcheck E4 [time = " & conv_string(now) & "] la<31:2> changed illegally in transaction");
                end if;
            end if;
        end if;
    end process;

    check_E5 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide and not multiplexed then
                if start_transaction = '1' and l64_l = '0' then
                    if to_X01(la(2)) /= '0' then
                        report_message("*** lbpcheck E5 [time = " & conv_string(now) & "] la<2> not zero when lads_l asserted in 64-bit transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_E6 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if not multiplexed then
                if in_transaction = '1' and start_transaction = '0' and lwrite_q = '1' then
                    error := false;
                    for i in 31 downto 0 loop
                        if to_X01(lad(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck E6 [time = " & conv_string(now) & "] lad<31:0> not valid in write transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_E7 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if not multiplexed and wide then
                if in_transaction = '1' and start_transaction = '0' and lwrite_q = '1' and l64_l = '0' then
                    error := false;
                    for i in 63 downto 32 loop
                        if to_X01(lad(i)) = 'X' then
                            error := true;
                        end if;
                    end loop;

                    if error then
                        report_message("*** lbpcheck E7 [time = " & conv_string(now) & "] lad<63:32> not valid in 64-bit write transaction");
                    end if;
                end if;
            end if;
        end if;
    end process;

    check_E8 : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if not multiplexed then
                if in_transaction = '1' and transaction_cycle > 1 and
                   lwrite_q = '1' and
                   lad(31 downto 0) /= lad_q(31 downto 0) and lready_q_l /= '0'
                then
                    report_message("*** lbpcheck E8 [time = " & conv_string(now) & "] lad<31:0> changed illegally in write transaction");
                end if;
            end if;
        end if;
    end process;

    check_E9 : process(lreset_l, lclk)
        variable error : boolean;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide and not multiplexed then
                if in_transaction = '1' and transaction_cycle > 1 and
                   lwrite_q = '1' and l64_q_l = '0' and
                   lad(63 downto 32) /= lad_q(63 downto 32) and lready_q_l /= '0'
                then
                    report_message("*** lbpcheck E9 [time = " & conv_string(now) & "] lad<63:32> changed illegally in 64-bit write transaction");
                end if;
            end if;
        end if;
    end process;

    check_F1 : process(lreset_l, lclk)
        variable x : std_logic;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            x := to_X01Z(lready_l);
            if in_transaction = '0' and x /= '1' and x /= 'Z' then
                report_message("*** lbpcheck F1 [time = " & conv_string(now) & "] lready_l not tristated/deasserted outside transaction");
            end if;
        end if;
    end process;

    check_F2 : process(lreset_l, lclk)
        variable x : std_logic;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            x := to_X01Z(lbterm_l);
            if in_transaction = '0' and x /= '1' and x /= 'Z' then
                report_message("*** lbpcheck F2 [time = " & conv_string(now) & "] lbterm_l not tristated/deasserted outside transaction");
            end if;
        end if;
    end process;

    check_F3 : process(lreset_l, lclk)
        variable x : std_logic;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            x := to_X01Z(lblast_l);
            if in_transaction = '0' and x /= '1' and x /= 'Z' then
                report_message("*** lbpcheck F3 [time = " & conv_string(now) & "] lblast_l not tristated/deasserted outside transaction");
            end if;
        end if;
    end process;

    check_F4 : process(lreset_l, lclk)
        variable x : std_logic;
    begin
        if lreset_l = '0' then
            null;
        elsif lclk'event and lclk = '1' then
            if wide then
                x := to_X01Z(l64_l);
                if in_transaction = '0' and x /= '1' and x /= 'Z' then
                    report_message("*** lbpcheck F4 [time = " & conv_string(now) & "] l64_l not tristated/deasserted outside transaction");
                end if;
            end if;
        end if;
    end process;

end behav;
