--
-- spd_i2c.vhd - Interface to DIMM SPD I2C EEPROM
--
-- SYNTHESIZABLE
--
-- Performs single reads and writes of an I2C EEPROM device in I2C
-- standard mode. Does not make use of any burst-access or
-- page-access mechanisms in the EEPROM device.
--
-- Generics
-- ========
--
-- 'scldiv'         Number of clock cycles for a quarter of a bit
--                  time. A bit time should be no less than 10
--                  microseconds.
--
-- 'enable_write'   Map to 'true' if and only if write access to the
--                  EEPROM is required. Otherwise, should be 'false'.
--
-- ==================================================================
--                              IMPORTANT
--
-- DO NOT map the 'enable_write' generic to 'true' unless there is a
-- definite requirement to write to the EEPROM.
--
-- ==================================================================
--
-- Summary of operation
-- ====================
--
-- 1. Initiating an operation
--
-- The 'ce' input should be pulsed when 'busy' is deasserted to
-- begin a read or write operation. Alternatively, if 'busy' is
-- asserted 'ce', may be held asserted until 'busy' is deasserted.
--
-- When 'ce' is asserted and 'busy' is deasserted, the values on the
-- 'sa', 'a', and 'wr' inputs are latched. Additional, if 'wr' is
-- asserted, the value on 'd' is latched. Note that if the
-- 'enable_write' generic is 'false', the 'wr' input is ignored and
-- treated as always being deasserted.
--
-- 2. Write operations
--
-- If a write operation was initiated ('wr' asserted), the module
-- writes the value latched from 'd' into location 'a' of the
-- device selected by 'sa'.
--
-- 3. Read operations
--
-- If a read operation was initiated ('wr' deasserted), the module
-- reads location 'a' of the device selected by 'sa'.
--
-- 4. Completion of an operation
--
-- When the operaton is complete, the module pulses 'ack' for one
-- cycle and deasserts 'busy' in the following cycle. ('ack' and
-- 'busy' both transition to zero in the same clock cycle).
--
-- If the operation was a read, the 'q' output contains the word
-- read from the device. 'q' is valid from the assertion of 'ack'
-- until the next operation is initiated.
--
-- Restrictions
-- ============
--
-- This module does not implement the arbitration protocol of the
-- I2C standard. Thus it should be used only for communication with
-- serial EEPROMs fitted to DIMMs.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

-- synopsys translate_off
library std;
use std.textio.all;
-- synopsys translate_on

library work;
use work.memif.all;

entity spd_i2c is
    generic(
        scldiv          : in    natural;
        enable_write    : in    boolean := false);
    port(
        -- Client interface
        rst             : in    std_logic;
        clk             : in    std_logic;
        sr              : in    std_logic;
        ce              : in    std_logic;
        wr              : in    std_logic;
        sa              : in    std_logic_vector(2 downto 0);
        a               : in    std_logic_vector(7 downto 0);
        d               : in    std_logic_vector(7 downto 0);
        ack             : out   std_logic;
        busy            : out   std_logic;
        q               : out   std_logic_vector(7 downto 0);
        err             : out   std_logic;
        -- To/from EEPROM pins (must be open drain outputs)
        scl_i           : in    std_logic;
        scl_o           : out   std_logic;
        sda_i           : in    std_logic;
        sda_o           : out   std_logic);
end;

architecture mixed of spd_i2c is

    -- synopsys translate_off
    function conv_string(
        val : in integer)
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
    -- synopsys translate_on

    function log2up(
        n : in integer)
    return integer is begin
        assert n > 0
            report "*** log2up: n > 0 violated"
            severity failure;

        for i in 0 to 30 loop
            if 2**i >= n then
                return i;
            end if;
        end loop;

        assert false
            report "*** log2up: n out of range"
            severity failure;
        return -1;
    end;

    constant n : natural := log2up(scldiv);

    constant trig_nop : std_logic_vector(2 downto 0) := "0--";
    constant trig_short : std_logic_vector(2 downto 0) := "100";
    constant trig_short_wait : std_logic_vector(2 downto 0) := "101";
    constant trig_long : std_logic_vector(2 downto 0) := "110";
    constant trig_long_wait : std_logic_vector(2 downto 0) := "111";

    --
    -- Executive state machine
    --
    type state1_t is (
        -- Begin common to reads and writes
        s1_idle,
        s1_latch,
        s1_start_0,
        s1_start_1,
        s1_sladdr_0,
        s1_sladdr_1,
        s1_sladdr_2,
        s1_sladdr_ack_0,
        s1_sladdr_ack_1,
        s1_sladdr_ack_2,
        s1_devaddr_0,
        s1_devaddr_1,
        s1_devaddr_2,
        s1_devaddr_ack_0,
        s1_devaddr_ack_1,
        s1_devaddr_ack_2,
        -- End common to reads and writes
        -- Begin specific to writes
        s1_wrdata_0,
        s1_wrdata_1,
        s1_wrdata_2,
        s1_wrdata_ack_0,
        s1_wrdata_ack_1,
        s1_wrdata_ack_2,
        -- End specific to writes
        -- Begin specific to reads
        s1_restart_0,
        s1_restart_1,
        s1_restart_2,
        s1_restart_3,
        s1_sladdr_3,
        s1_sladdr_4,
        s1_sladdr_5,
        s1_sladdr_ack_3,
        s1_sladdr_ack_4,
        s1_sladdr_ack_5,
        s1_rddata_0,
        s1_rddata_1,
        s1_rddata_2,
        s1_rddata_3,
        s1_rddata_ack_0,
        s1_rddata_ack_1,
        s1_rddata_ack_2,
        -- End specific to reads
        -- Begin common to reads and writes
        s1_stop_0,
        s1_stop_1,
        s1_stop_2);
        -- End common to reads and writes
    signal state1, n_state1 : state1_t;
    signal i_busy, n_busy : std_logic;
    signal trig, n_trig : std_logic_vector(2 downto 0);
    signal i_scl, n_scl : std_logic;
    signal i_sda, n_sda : std_logic;

    --
    -- Bit timing state machine
    --
    type state2_t is (
        s2_idle,
        s2_wait,
        s2_running);
    signal state2, n_state2 : state2_t;
    signal count2, n_count2 : std_logic_vector(n downto 0);
    signal tc1, n_tc1 : std_logic;
    signal tc, n_tc : std_logic;

    signal bitcnt : std_logic_vector(2 downto 0);
    signal sladdr : std_logic_vector(7 downto 0);
    signal devaddr : std_logic_vector(7 downto 0);
    signal rddata : std_logic_vector(7 downto 0);
    signal wrdata : std_logic_vector(7 downto 0);

    signal a_q : std_logic_vector(7 downto 0);
    signal d_q : std_logic_vector(7 downto 0);
    signal sa_q : std_logic_vector(2 downto 0);
    signal wr_q : std_logic;

    signal scl_iq : std_logic;
    signal sda_iq : std_logic;

    signal logic0, logic1 : std_logic;

begin

    logic0 <= '0';
    logic1 <= '1';

    scl_o <= i_scl;
    sda_o <= i_sda;
    q <= rddata;
    busy <= i_busy;
    err <= '0';

    capture_client_inputs : process(clk)
    begin
        if clk'event and clk = '1' then
            if state1 = s1_idle and ce = '1' then
                a_q <= a;
                d_q <= d;
                sa_q <= sa;
                if enable_write then
                    wr_q <= wr;
                else
                    wr_q <= '0';
                end if;
            end if;
        end if;
    end process;

    capture_i2c : process(clk)
    begin
        if clk'event and clk = '1' then
            scl_iq <= to_X01(scl_i);
            sda_iq <= to_X01(sda_i);
        end if;
    end process;

    gen_state1 : process(rst, clk)
    begin
        if rst = '1' then
            state1 <= s1_idle;
            i_busy <= '0';
            trig <= trig_nop;
            i_scl <= '1';
            i_sda <= '1';
            bitcnt <= "---";
            sladdr <= (others => '-');
            devaddr <= (others => '-');
            wrdata <= (others => '-');
            rddata <= (others => '-');
            ack <= '0';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                state1 <= s1_idle;
                i_busy <= '0';
                trig <= trig_nop;
                i_scl <= '1';
                i_sda <= '1';
            else
                state1 <= n_state1;
                i_busy <= n_busy;
                trig <= n_trig;
                i_scl <= n_scl;
                i_sda <= n_sda;
            end if;

            case state1 is
                when s1_start_0 =>
                    sladdr <= "1010" & sa_q & "0";
                    bitcnt <= "000";

                when s1_sladdr_2 =>
                    if tc1 = '1' then
                        sladdr <= sladdr(6 downto 0) & "-";
                    end if;
                    if tc = '1' then
                        bitcnt <= bitcnt + 1;
                    end if;

                when s1_sladdr_ack_0 =>
                    devaddr <= a_q;
                    bitcnt <= "000";

                when s1_devaddr_2 =>
                    if tc1 = '1' then
                        devaddr <= devaddr(6 downto 0) & "-";
                    end if;
                    if tc = '1' then
                        bitcnt <= bitcnt + 1;
                    end if;

                when s1_devaddr_ack_0 =>
                    wrdata <= d_q;
                    bitcnt <= "000";

                when s1_wrdata_2 =>
                    if tc1 = '1' then
                        wrdata <= wrdata(6 downto 0) & "-";
                    end if;
                    if tc = '1' then
                        bitcnt <= bitcnt + 1;
                    end if;

                when s1_restart_0 =>
                    sladdr <= "1010" & sa_q & (not wr_q);
                    bitcnt <= "000";

                when s1_sladdr_5 =>
                    if tc1 = '1' then
                        sladdr <= sladdr(6 downto 0) & "-";
                    end if;
                    if tc = '1' then
                        bitcnt <= bitcnt + 1;
                    end if;

                when s1_sladdr_ack_3 =>
                    bitcnt <= "000";

                when s1_rddata_1 =>
                    if tc = '1' then
                        rddata <= rddata(6 downto 0) & sda_iq;
                    end if;

                when s1_rddata_3 =>
                    if tc = '1' then
                        bitcnt <= bitcnt + 1;
                    end if;

                when s1_stop_2 =>
                    ack <= tc;

                when others =>
                    ack <= '0';
            end case;
        end if;
    end process;

    gen_n_state1 : process(
        state1,
        bitcnt,
        ce,
        tc,
        sladdr,
        devaddr,
        wrdata,
        sa_q,
        a_q,
        d_q,
        wr_q)
    begin
        case state1 is
            when s1_idle =>
                if ce = '1' then
                    n_state1 <= s1_latch;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_idle;
                    n_busy <= '0';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_latch =>
                n_state1 <= s1_start_0;
                n_busy <= '1';
                n_trig <= trig_long_wait;
                n_scl <= '1';
                n_sda <= '0';

            when s1_start_0 =>
                if tc = '1' then
                    n_state1 <= s1_start_1;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '0';
                    n_sda <= '0';
                else
                    n_state1 <= s1_start_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '0';
                end if;

            when s1_start_1 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_0;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= sladdr(7);
                else
                    n_state1 <= s1_start_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '0';
                end if;

            when s1_sladdr_0 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_1;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= sladdr(7);
                else
                    n_state1 <= s1_sladdr_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= sladdr(7);
                end if;

            when s1_sladdr_1 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_2;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= sladdr(7);
                else
                    n_state1 <= s1_sladdr_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= sladdr(7);
                end if;

            when s1_sladdr_2 =>
                if tc = '1' then
                    if bitcnt = "111" then
                        n_state1 <= s1_sladdr_ack_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= '1';
                    else
                        n_state1 <= s1_sladdr_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= sladdr(7);
                    end if;
                else
                    n_state1 <= s1_sladdr_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= sladdr(7);
                end if;

            when s1_sladdr_ack_0 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_ack_1;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_sladdr_ack_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_sladdr_ack_1 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_ack_2;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= '1';
                else
                    n_state1 <= s1_sladdr_ack_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_sladdr_ack_2 =>
                if tc = '1' then
                    n_state1 <= s1_devaddr_0;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= devaddr(7);
                else
                    n_state1 <= s1_sladdr_ack_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_devaddr_0 =>
                if tc = '1' then
                    n_state1 <= s1_devaddr_1;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= devaddr(7);
                else
                    n_state1 <= s1_devaddr_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= devaddr(7);
                end if;

            when s1_devaddr_1 =>
                if tc = '1' then
                    n_state1 <= s1_devaddr_2;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= devaddr(7);
                else
                    n_state1 <= s1_devaddr_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= devaddr(7);
                end if;

            when s1_devaddr_2 =>
                if tc = '1' then
                    if bitcnt = "111" then
                        n_state1 <= s1_devaddr_ack_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= '1';
                    else
                        n_state1 <= s1_devaddr_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= devaddr(7);
                    end if;
                else
                    n_state1 <= s1_devaddr_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= devaddr(7);
                end if;

            when s1_devaddr_ack_0 =>
                if tc = '1' then
                    n_state1 <= s1_devaddr_ack_1;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_devaddr_ack_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_devaddr_ack_1 =>
                if tc = '1' then
                    n_state1 <= s1_devaddr_ack_2;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= '1';
                else
                    n_state1 <= s1_devaddr_ack_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_devaddr_ack_2 =>
                if tc = '1' then
                    if wr_q = '1' then
                        n_state1 <= s1_wrdata_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= wrdata(7);
                    else
                        n_state1 <= s1_restart_0;
                        n_busy <= '1';
                        n_trig <= trig_long;
                        n_scl <= '0';
                        n_sda <= '1';
                    end if;
                else
                    n_state1 <= s1_devaddr_ack_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_wrdata_0 =>
                if tc = '1' then
                    n_state1 <= s1_wrdata_1;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= wrdata(7);
                else
                    n_state1 <= s1_wrdata_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= wrdata(7);
                end if;

            when s1_wrdata_1 =>
                if tc = '1' then
                    n_state1 <= s1_wrdata_2;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= wrdata(7);
                else
                    n_state1 <= s1_wrdata_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= wrdata(7);
                end if;

            when s1_wrdata_2 =>
                if tc = '1' then
                    if bitcnt = "111" then
                        n_state1 <= s1_wrdata_ack_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= '1';
                    else
                        n_state1 <= s1_wrdata_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= wrdata(7);
                    end if;
                else
                    n_state1 <= s1_wrdata_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= wrdata(7);
                end if;

            when s1_wrdata_ack_0 =>
                if tc = '1' then
                    n_state1 <= s1_wrdata_ack_1;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_wrdata_ack_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_wrdata_ack_1 =>
                if tc = '1' then
                    n_state1 <= s1_wrdata_ack_2;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= '1';
                else
                    n_state1 <= s1_wrdata_ack_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_wrdata_ack_2 =>
                if tc = '1' then
                    n_state1 <= s1_stop_0;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '0';
                    n_sda <= '0';
                else
                    n_state1 <= s1_wrdata_ack_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_restart_0 =>
                if tc = '1' then
                    n_state1 <= s1_restart_1;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_restart_0;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_restart_1 =>
                if tc = '1' then
                    n_state1 <= s1_restart_2;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= '0';
                else
                    n_state1 <= s1_restart_1;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_restart_2 =>
                if tc = '1' then
                    n_state1 <= s1_restart_3;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '0';
                    n_sda <= '0';
                else
                    n_state1 <= s1_restart_2;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '1';
                    n_sda <= '0';
                end if;

            when s1_restart_3 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_3;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= sladdr(7);
                else
                    n_state1 <= s1_restart_3;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '0';
                end if;

            when s1_sladdr_3 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_4;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= sladdr(7);
                else
                    n_state1 <= s1_sladdr_3;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= sladdr(7);
                end if;

            when s1_sladdr_4 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_5;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= sladdr(7);
                else
                    n_state1 <= s1_sladdr_4;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= sladdr(7);
                end if;

            when s1_sladdr_5 =>
                if tc = '1' then
                    if bitcnt = "111" then
                        n_state1 <= s1_sladdr_ack_3;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= '1';
                    else
                        n_state1 <= s1_sladdr_3;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= sladdr(7);
                    end if;
                else
                    n_state1 <= s1_sladdr_5;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= sladdr(7);
                end if;

            when s1_sladdr_ack_3 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_ack_4;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_sladdr_ack_3;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_sladdr_ack_4 =>
                if tc = '1' then
                    n_state1 <= s1_sladdr_ack_5;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= '1';
                else
                    n_state1 <= s1_sladdr_ack_4;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_sladdr_ack_5 =>
                if tc = '1' then
                    n_state1 <= s1_rddata_0;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= '1';
                else
                    n_state1 <= s1_sladdr_ack_5;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_rddata_0 =>
                if tc = '1' then
                    n_state1 <= s1_rddata_1;
                    n_busy <= '1';
                    n_trig <= trig_short_wait;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_rddata_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_rddata_1 =>
                if tc = '1' then
                    n_state1 <= s1_rddata_2;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_rddata_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_rddata_2 =>
                if tc = '1' then
                    n_state1 <= s1_rddata_3;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= '1';
                else
                    n_state1 <= s1_rddata_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_rddata_3 =>
                if tc = '1' then
                    if bitcnt = "111" then
                        n_state1 <= s1_rddata_ack_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= '1';
                    else
                        n_state1 <= s1_rddata_0;
                        n_busy <= '1';
                        n_trig <= trig_short;
                        n_scl <= '0';
                        n_sda <= '1';
                    end if;
                else
                    n_state1 <= s1_rddata_3;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_rddata_ack_0 =>
                if tc = '1' then
                    n_state1 <= s1_rddata_ack_1;
                    n_busy <= '1';
                    n_trig <= trig_long_wait;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_rddata_ack_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_rddata_ack_1 =>
                if tc = '1' then
                    n_state1 <= s1_rddata_ack_2;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '0';
                    n_sda <= '1';
                else
                    n_state1 <= s1_rddata_ack_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;

            when s1_rddata_ack_2 =>
                if tc = '1' then
                    n_state1 <= s1_stop_0;
                    n_busy <= '1';
                    n_trig <= trig_short;
                    n_scl <= '0';
                    n_sda <= '0';
                else
                    n_state1 <= s1_rddata_ack_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '1';
                end if;

            when s1_stop_0 =>
                if tc = '1' then
                    n_state1 <= s1_stop_1;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '1';
                    n_sda <= '0';
                else
                    n_state1 <= s1_stop_0;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '0';
                    n_sda <= '0';
                end if;

            when s1_stop_1 =>
                if tc = '1' then
                    n_state1 <= s1_stop_2;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_stop_1;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '0';
                end if;

            when s1_stop_2 =>
                if tc = '1' then
                    n_state1 <= s1_idle;
                    n_busy <= '1';
                    n_trig <= trig_long;
                    n_scl <= '1';
                    n_sda <= '1';
                else
                    n_state1 <= s1_stop_2;
                    n_busy <= '1';
                    n_trig <= trig_nop;
                    n_scl <= '1';
                    n_sda <= '1';
                end if;
        end case;
    end process;

    gen_state2 : process(rst, clk)
    begin
        if rst = '1' then
            state2 <= s2_idle;
            count2 <= (others => '-');
            tc1 <= '0';
            tc <= '0';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                state2 <= s2_idle;
                count2 <= (others => '-');
                tc1 <= '0';
                tc <= '0';
            else
                state2 <= n_state2;
                count2 <= n_count2;
                tc1 <= n_tc1;
                tc <= n_tc;
            end if;
        end if;
    end process;

    gen_n_state2 : process(
        state2,
        trig,
        count2,
        scl_iq)
    begin
        case state2 is
            when s2_idle =>
                if trig(2) = '1' then
                    if trig(0) = '0' or scl_iq = '1' then
                        n_state2 <= s2_running;
                    else
                        n_state2 <= s2_wait;
                    end if;
                    if trig(1) = '1' then
                        n_count2 <= CONV_STD_LOGIC_VECTOR(scldiv - 1, n) & "0";
                    else
                        n_count2 <= "0" & CONV_STD_LOGIC_VECTOR(scldiv - 1, n);
                    end if;
                    n_tc1 <= '0';
                    n_tc <= '0';
                else
                    n_state2 <= s2_idle;
                    n_count2 <= (others => '-');
                    n_tc1 <= '0';
                    n_tc <= '0';
                end if;

            when s2_wait =>
                if scl_iq = '1' then
                    n_state2 <= s2_running;
                    n_count2 <= count2;
                    n_tc1 <= '0';
                    n_tc <= '0';
                else
                    n_state2 <= s2_wait;
                    n_count2 <= count2;
                    n_tc1 <= '0';
                    n_tc <= '0';
                end if;

            when s2_running =>
                if count2 = 1 then
                    n_tc1 <= '1';
                else
                    n_tc1 <= '0';
                end if;
                n_count2 <= count2 - 1;
                if count2 = 0 then
                    n_state2 <= s2_idle;
                    n_tc <= '1';
                else
                    n_state2 <= s2_running;
                    n_tc <= '0';
                end if;
        end case;
    end process;

end mixed;
