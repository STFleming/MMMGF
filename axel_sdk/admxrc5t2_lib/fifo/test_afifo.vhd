--
-- test_afifo.vhd - testbench for entity 'afifo'
--
-- NOT SYNTHESIZABLE
--
-- When running this simulation, it is not complete until the following
-- message is displayed in the Modelsim main window:
--
--     "Simulation of afifo complete."
-- 
-- Checks performed:
-- =================
--
-- Let depth        = (2 ** order) - 1
-- Let domain_delay = the longer of 'n' wk' clock cycles or 'n' rk clock cycles
--
--  1. Data first in is data first out.
--
--  2. After reset the 'we' flag is '1'.
--
--  3. After reset the 'wpf' flag is '0'.
--
--  4. After reset the 'wf' flag is '0'.
--
--  5. After reset the 're' flag is '1'.
--
--  6. After reset the 'rpe' flag is '1'.
--
--  7. After reset the 'rf' flag is '0'.
--
--  8. With no consumer, after a reset, the first write into the FIFO causes
--     the 'we' flag to be deasserted.
--
--  9. With no consumer, after a reset, the first write into the FIFO causes
--     the 're' flag to be deasserted no more than 'domain_delay' later.
--
-- 10. With no consumer, after a reset, 'depth - wpfl' words can be written into the
--     FIFO before the 'wpf' flag is asserted.
--
-- 11. With no consumer, after a reset, after 'rpel + 1' words have been written
--     into the FIFO, the 'rpe' flag is deasserted no more than 'delay(10)'
--     later.
--
-- 12. With no consumer, after a reset, the 'wf' flag is asserted after
--     'depth' words have been written into the FIFO.
--
-- 13. With no consumer, after a reset, the 'rf' flag is asserted no more than
--     'domain_delay' later after 'depth' words have been written into the FIFO.
--
-- 14. With no producer, starting from FIFO full, the first read from the
--     FIFO causes the 'rf' flag to be deasserted.
--
-- 15. With no producer, starting from FIFO full, the first read from the
--     FIFO causes the 'wf' flag to be deasserted no more than 'domain_delay'
--     later.
--
-- 16. With no producer, starting from FIFO full, the 'rpe' flag is asserted
--     after 'depth - rpel' words have been read from the FIFO.
--
-- 17. With no producer, starting from FIFO full, the 'wpf' flag is deasserted
--     no more than 'domain_delay' later after 'wpfl' words have
--     been read from the FIFO.
--
-- 18. With no producer, starting from FIFO full, the 're' flag is asserted after
--     'depth' words have been read from the FIFO.
--
-- 19. With no producer, starting from FIFO full, the 'we' flag is asserted no
--     later than 'domain_delay' after 'depth' words have been read from the
--     FIFO.
--
-- 20. The 'we' and 'wf' flags are mutually exclusive.
--
-- 21. The 're' and 'rf' flags are mutually exclusive.
--
-- 22. If the 'wf' flag is asserted, the 'wpf' flag is always also asserted.
--
-- 23. If the 're' flag is asserted, the 'rpe' flag is always also asserted.
--
-- 24. The FIFO functions correctly when 'wk' is stopped and 'rk' is not
--     stopped.
--
-- 25. The FIFO functions correctly when 'rk' is stopped and 'wk' is not
--     stopped.
--
-- 26. The FIFO functions correctly when the writer clock is fast enough to
--     cause the 're' and 'rf' flags to invert on the same edge of 'rk'.
--
-- 27. The FIFO functions correctly when the reader clock is fast enough to
--     cause the 'we' and 'wf' flags to invert on the same edge of 'wk'.
--
-- 28. The FIFO functions correctly when the writer clock is fast enough to
--     cause the 're' and 'rpe' flags to invert on the same edge of 'rk'.
--
-- 29. The FIFO functions correctly when the reader clock is fast enough to
--     cause the 'wf' and 'wpf' flags to invert on the same edge of 'wk'.
--
-- 30. The FIFO functions correctly when the writer clock is slightly
--     faster than the reader clock.
--
-- 31. The FIFO functions correctly when the reader clock is slightly
--     slower than the reader clock.
--
-- 32. When 're' is asserted, 'rlevel' is 0.
--
-- 33. When 'rpe' is asserted, 'rlevel' is less than or equal to 'rpel'
--
-- 34. When 'rf' is asserted, 'rlevel' is equal to 'depth'
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library std;
use std.textio.all;

library work;
use work.fifo.all;

entity test_afifo is
end;

architecture behav of test_afifo is

    constant width  : integer := 16;
    constant order  : integer := 8;
    constant full   : integer := 2**order - 1;
    constant wpfl   : integer := 250;
    constant wpfl2  : integer := 200;
    constant rpel   : integer := 5;
    constant family : integer := fifo_family_virtex;
    constant safety : boolean := false;

    function conv_string_hexdigit(
        val : in std_logic_vector)
    return character is
    begin
        case val(3 downto 0) is
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

    function conv_string_hex(
        val : in std_logic_vector)
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

    procedure report_error(
        str : in string)
    is
        constant str1 : string := "*** [";
        constant str2 : string := "] ";
        variable msg : line;
    begin
        write(msg, str1);
        write(msg, now);
        write(msg, str2);
        write(msg, str);
        writeline(output, msg);
    end;

    signal rst    : std_logic := '1';
    signal wk     : std_logic := '0';
    signal wd     : std_logic_vector(width - 1 downto 0) := CONV_STD_LOGIC_VECTOR(0, width);
    signal wadv   : std_logic := '0';
    signal we     : std_logic;
    signal wpf    : std_logic;
    signal wpf2   : std_logic;
    signal wf     : std_logic;
    signal rk     : std_logic := '0';
    signal rq     : std_logic_vector(width - 1 downto 0);
    signal radv   : std_logic := '0';
    signal rflush : std_logic;
    signal re     : std_logic;
    signal rpe    : std_logic;
    signal rf     : std_logic;
    signal rlevel : std_logic_vector(15 downto 0);

    signal logic_zero : std_logic := '0';

    constant depth : integer := (2 ** order) - 1;

    --
    -- Several clocks are generated, for testing the FIFO at various
    -- clock frequency ratios
    --
    constant num_clock : integer := 6;
    type period_array is array(0 to num_clock * 2 - 1) of time;
    constant clock_periods : period_array :=
        (7 ns, 8 ns, 7 ns, 73 ns, 7 ns, 1001 ns,
         8 ns, 7 ns, 73 ns, 7 ns, 1001 ns, 7 ns);
    signal clocks : std_logic_vector(num_clock * 2 - 1 downto 0) := (others => '0');

    --
    -- Used to multiplex the clocks onto 'rk' and 'wk',
    -- glitch-free.
    --
    type mux_array is array(0 to 1) of integer;
    signal mux_wk : integer := 0;
    signal mux_rk : integer := 1;
    signal muxed_wk : std_logic;
    signal muxed_rk : std_logic;
    signal en_wk : std_logic := '1';
    signal en_rk : std_logic := '1';

    signal rflush_q : std_logic := '0';
    signal rflush0, rflush1 : std_logic := '0';

    --
    -- 10 'rk' clocks or 10 'wk' clocks, whichever is longer.
    -- Used to allow for delay in flags updating across the
    -- clock divide.
    --
    signal domain_delay : time;

    signal wr_go, wr_go_q : boolean := false;
    signal rd_go, rd_go_q : boolean := false;
    signal flush, flush_q : boolean := false;

    -- Used by CHECK 8 to 13
    signal do_check_8 : boolean := false;
    signal do_check_9, do_check_11, do_check_13 : boolean := false;
    -- Used by CHECK 14 to 19
    signal do_check_14 : boolean := false;
    signal do_check_15, do_check_17, do_check_19 : boolean := false;

begin

    gen_domain_delay : process(mux_rk, mux_wk) begin
        if clock_periods(mux_wk) > clock_periods(mux_rk + num_clock) then
            domain_delay <= 10 * clock_periods(mux_wk);
        else
            domain_delay <= 10 * clock_periods(mux_rk + num_clock);
        end if;
    end process;

    gen_clocks : for i in 0 to num_clock * 2 - 1 generate
        clocks(i) <= not clocks(i) after clock_periods(i) / 2;
    end generate;

    gen_muxed_clocks : process(mux_wk, mux_rk, clocks) begin
        muxed_wk <= clocks(mux_wk);
        muxed_rk <= clocks(mux_rk + num_clock);
    end process;
    
    mux_clock : process(en_wk, en_rk, muxed_wk, muxed_rk) begin
        if en_wk = '1' then
            wk <= muxed_wk;
        else
            wk <= '0';
        end if;
        if en_rk = '1' then
            rk <= muxed_rk;
        else
            rk <= '0';
        end if;
    end process;

    --
    -- This process has overall control of the simulation.
    --
    -- For 6 different reader/writer clock ratios, the following
    -- is performed:
    --
    --     1. The FIFO is filled, with 'radv' always '0'. The flags
    --        on the writer side and reader side are monitored for
    --        correctness.
    --     2. The FIFO is then emptied, without being reset, with
    --        'radv' always '0'. The flags on the writer side and
    --        reader side are monitored for correctness.
    --
    stimulate : process
    begin
        --
        -- Wait until a positive edge has occurred on both the
        -- writer clock and the reader clock. This seems to be
        -- necessary to make BlockRAMs to behave sensibly.
        --
        wait until rk'event and rk = '1';
        wait until wk'event and wk = '1';

        -- Reset the FIFO
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 30 ns;

        --
        -- CHECKS 26 to 31 correspond to the iterated values of 'i'
        -- in this loop
        --
        -- CHECKS 8 to 23 are performed by other processes over
        -- the course of this loop.
        --
        for i in 0 to 6 loop
            -- Kick off checks 8 to 13
            -- The FIFO is filled with no reads taking place. The
            -- FIFO flags are monitored for correctness.
            wr_go <= true;
            do_check_8 <= true;
            -- Wait for the FIFO to fill up
            wait until rf = '1';
            wr_go <= false;
            wait for domain_delay;
            -- Stop performing checks 8 to 13
            do_check_8 <= false;
            wait for domain_delay;

            -- Kick off checks 14 to 19
            -- The FIFO is emptied with no writes taking place. The
            -- FIFO flags are monitored for correctness.
            rd_go <= true;
            do_check_14 <= true;
            -- wait for FIFO to empty
            wait until we = '1';
            rd_go <= false;
            wait for domain_delay;
            -- Stop performing checks 14 to 19
            do_check_14 <= false;
            wait for domain_delay;

            --
            -- The FIFO is read and written simultaneously. The FIFO
            -- flags are unpredictable here so the only check performed
            -- during this phase is that 'rq' is correct.
            --
            rd_go <= true;
            wr_go <= true;
            -- Wait for 200 cycles of 'rk' or 'wk', whichever is the
            -- slower of the two.
            wait for domain_delay * 20;
            rd_go <= false;
            wr_go <= false;

            if true then
                wait for domain_delay;
                flush <= true;
                wait for domain_delay;
                flush <= false;
            else
                -- Reset the FIFO
                rst <= '1';
                wait for 20 ns;
                rst <= '0';
                wait for 30 ns;
            end if;

            -- switch 'wk' to the next clock
            wait until wk'event and wk = '0';
            en_wk <= '0';
            mux_wk <= (i + 1) rem 6;
            wait until muxed_wk'event and muxed_wk = '0';
            en_wk <= '1';
            
            -- switch 'rk' to the next clock
            wait until rk'event and rk = '0';
            en_rk <= '0';
            mux_rk <= (i + 1) rem 6;
            wait until muxed_rk'event and muxed_rk = '0';
            en_rk <= '1';
        end loop;

        --
        -- CHECKS 24 to 25 correspond to the iterated values of 'i'
        -- in this loop
        --
        -- CHECKS 8 to 23 are performed by other processes over
        -- the course of this loop.
        --
        for i in 0 to 1 loop
            if i = 0 then
                -- Disable reader clock
                wait until rk'event and rk = '0';
                en_rk <= '0';
                -- Kick off checks 8, 10 and 12
                -- The FIFO is filled with no reads taking place. The
                -- FIFO flags are monitored for correctness.
                wr_go <= true;
                do_check_8 <= true;
                -- Wait for the FIFO to fill up
                wait until wf = '1';
                wr_go <= false;
                do_check_8 <= false;
                -- Enable reader clock
                wait until muxed_rk'event and muxed_rk = '0';
                en_rk <= '1';
                -- Allow reader side flags time to update to reflect 'full' status
                wait for domain_delay;
            elsif i = 1 then
                -- Disable writer clock
                wait until wk'event and wk = '0';
                en_wk <= '0';
                -- Kick off checks 14, 16 and 18
                -- The FIFO is emptied with no writes taking place. The
                -- FIFO flags are monitored for correctness.
                rd_go <= true;
                do_check_14 <= true;
                -- Wait for the FIFO to fill up
                wait until re = '1';
                rd_go <= false;
                do_check_14 <= false;
                -- Enable writer clock
                wait until muxed_wk'event and muxed_wk = '0';
                en_wk <= '1';
                -- Allow writer side flags time to update to reflect 'full' status
                wait for domain_delay;
            end if;
        end loop;
        
        assert false report "Simulation of afifo complete" severity failure;
        wait;
        
    end process;

    gen_wr_go_q : process(rst, wk) begin
        if rst = '1' then
            wr_go_q <= false;
        elsif wk'event and wk = '1' then
            wr_go_q <= wr_go;
        end if;
    end process;
    
    gen_rd_go_q : process(rst, rk) begin
        if rst = '1' then
            rd_go_q <= false;
        elsif rk'event and rk = '1' then
            rd_go_q <= rd_go;
        end if;
    end process;

    gen_wadv : process(wr_go_q, wf) begin
        if wr_go_q then
            wadv <= not wf;
        else
            wadv <= '0';
        end if;
    end process;

    gen_radv : process(rd_go_q, re) begin
        if rd_go_q then
            radv <= not re;
        else
            radv <= '0';
        end if;
    end process;

    --
    -- Generates an increasing test pattern for the FIFO
    -- input data.
    --
    stimulate4: process(wk, rst) begin
        if rst = '1' then
            wd <= CONV_STD_LOGIC_VECTOR(0, wd'length);
        elsif wk'event and wk = '1' then
            if wadv = '1' then
                wd <= wd + 1;
            end if;
        end if;
    end process;

    --
    -- Flush the FIFO on command
    --
    stimulate5: process(rk, rst) begin
        if rk'event and rk = '1' then
            if flush = true and flush_q = false then
                rflush0 <= '1';
            else
                rflush0 <= '0';
            end if;
            flush_q <= flush;
            rflush1 <= rflush0;
        end if;
    end process;
    rflush <= rflush1 or rflush0;

    --
    -- This checks that the data first in is the data first out.
    --
    check_1: process(rst, rk)
        variable exp_rq : std_logic_vector(width - 1 downto 0);
    begin
        if rst = '1' then
            exp_rq := CONV_STD_LOGIC_VECTOR(0, rq'length);
        elsif rk'event and rk = '1' then
            rflush_q <= rflush;
            if rflush = '1' then
                if rflush_q = '0' then
                    exp_rq := exp_rq + rlevel;
                end if;
            else
                -- CHECK 1
                if radv = '1' then
                    if rq /= exp_rq then
                        report_error("[1] exp_rq/rq = " & conv_string_hex(exp_rq) & "/" & conv_string_hex(rq));
                    end if;
                    exp_rq := exp_rq + 1;
                end if;
            end if;
        end if;
    end process;

    --
    -- This checks that 'rst' causes the FIFO flags to be at
    -- their reset states.
    --
    check_2_3_4_5_6_7: process(rst) begin
        if rst'event and rst = '0' then
            -- CHECK 2
            assert we = '1' report "(2) we = '1'" severity note;
            -- CHECK 3
            assert wpf = '0' report "(3) wpf = '0'" severity note;
            -- CHECK 4
            assert wf = '0' report "(4) wf = '0'" severity note;
            -- CHECK 5
            assert re = '1' report "(5) re = '1'" severity note;
            -- CHECK 6
            assert rpe = '1' report "(6) rpe = '1'" severity note;
            -- CHECK 7
            assert rf = '0' report "(7) rf = '0'" severity note;
        end if;
    end process;

    --
    -- When do_check_8 becomes TRUE, the FIFO state should be 'empty',
    -- hence the initial values of 'level', 'exp_re' etc.
    --
    check_8_9_10_11_12_13: process
        variable exp_we, exp_wpf, exp_wf : std_logic;
        variable exp_re, exp_rpe, exp_rf : std_logic;
        variable level : integer;
    begin
        while true loop
            wait on do_check_8, wk, rk;
            if not do_check_8 then
                level := 0;
                do_check_9 <= false;
                do_check_11 <= false;
                do_check_13 <= false;
                exp_we := '1';
                exp_wpf := '0';
                exp_wf := '0';
                exp_re := '1';
                exp_rpe := '1';
                exp_rf := '0';
            else
                if wk'event and wk = '1' then
                    -- CHECK 8
                    if level = 1 then
                        exp_we := '0';
                        -- we need to begin checking 're' soon
                        exp_re := '0';
                        do_check_9 <= true after domain_delay;
                    end if;
                    assert exp_we = we report "(8) we behaving incorrectly" severity note;

                    -- CHECK 10
                    if level = depth - wpfl then
                        exp_wpf := '1';
                    end if;
                    assert exp_wpf = wpf report "(10) wpf behaving incorrectly" severity note;

                    if level = rpel + 1 then
                        -- we need to begin checking 'rpe' soon
                        exp_rpe := '0';
                        do_check_11 <= true after domain_delay;
                    end if;

                    -- CHECK 12
                    if level = depth then
                        exp_wf := '1';
                        -- we need to begin checking 'rf' soon
                        exp_rf := '1';
                        do_check_13 <= true after domain_delay;
                    end if;
                    assert exp_wf = wf report "(12) wf behaving incorrectly" severity note;

                    if wadv = '1' then
                        level := level + 1;
                    end if;
                end if;

                if rk'event and rk = '1' and rk'last_value = '0' then
                    -- CHECK 9
                    if do_check_9 then
                        assert exp_re = re report "(9) re behaving incorrectly" severity note;
                    end if;
                    -- CHECK 11
                    if do_check_11 then
                        assert exp_rpe = rpe report "(11) rpe behaving incorrectly" severity note;
                    end if;
                    -- CHECK 13
                    if do_check_13 then
                        assert exp_rf = rf report "(13) rf behaving incorrectly" severity note;
                    end if;
                end if;
            end if;
        end loop;
    end process;

    --
    -- When do_check_14 becomes TRUE, the FIFO state should be 'full',
    -- hence the initial values of 'level', 'exp_re' etc.
    --
    check_14_15_16_17_18_19: process
        variable level : integer;
        variable exp_re, exp_rpe, exp_rf : std_logic;
        variable exp_we, exp_wpf, exp_wf : std_logic;
    begin
        while true loop
            wait on do_check_14, wk, rk;
            if not do_check_14 then
                level := depth;
                do_check_15 <= false;
                do_check_17 <= false;
                do_check_19 <= false;
                exp_re := '0';
                exp_rpe := '0';
                exp_rf := '1';
                exp_we := '0';
                exp_wpf := '1';
                exp_wf := '1';
            else
                if rk'event and rk = '1' then
                    -- CHECK 14
                    if level = depth - 1 then
                        exp_rf := '0';
                        -- we need to begin checking 'wf' soon
                        exp_wf := '0';
                        do_check_15 <= true after domain_delay;
                    end if;
                    assert exp_rf = rf report "(14) rf behaving incorrectly" severity note;

                    -- CHECK 16
                    if level = rpel then
                        exp_rpe := '1';
                    end if;
                    assert exp_rpe = rpe report "(16) rpe behaving incorrectly" severity note;

                    if level = depth - wpfl - 1 then
                        -- we need to begin checking 'wpf' soon
                        exp_wpf := '0';
                        do_check_17 <= true after domain_delay;
                    end if;

                    -- CHECK 18
                    if level = 0 then
                        exp_re := '1';
                        -- we need to begin checking 'we' soon
                        exp_we := '1';
                        do_check_19 <= true after domain_delay;
                    end if;
                    assert exp_re = re report "(18) re behaving incorrectly" severity note;

                    if radv = '1' then
                        level := level - 1;
                    end if;
                end if;

                if wk'event and wk = '1' and wk'last_value = '0' then
                    -- CHECK 15
                    if do_check_15 then
                        assert exp_wf = wf report "(15) wf behaving incorrectly" severity note;
                    end if;
                    -- CHECK 17
                    if do_check_17 then
                        assert exp_wpf = wpf report "(17) wpf behaving incorrectly" severity note;
                    end if;
                    -- CHECK 19
                    if do_check_19 then
                        assert exp_wf = wf report "(19) we behaving incorrectly" severity note;
                    end if;
                end if;
            end if;
        end loop;
    end process;

    check_20_22: process(wk, rst) begin
        if rst = '0' then
            null;
        elsif wk'event and wk = '1' then
            -- CHECK 20
            if we = '1' then
                assert wf = '0' report "(20) 'we' implies 'not wf'" severity note;
            end if;
            -- CHECK 22
            if wf = '1' then
                assert wpf = '1' report "(22) 'wf' implies 'wpf'" severity note;
            end if;
        end if;
    end process;

    check_21_23: process(rk, rst) begin
        if rst = '0' then
            null;
        elsif rk'event and rk = '1' then
            -- CHECK 21
            if re = '1' then
                assert rf = '0' report "(21) 're' implies 'not rf'" severity note;
            end if;
            -- CHECK 23
            if re = '1' then
                assert rpe = '1' report "(23) 're' implies 'rpe'" severity note;
            end if;
        end if;
    end process;

    check_32_33_34 : process(rk, rst) begin
        if rst = '0' then
            null;
        elsif rk'event and rk = '1' then
            -- CHECK 32
            if re = '1' then
                assert rlevel = 0 report "(32) 're' and 'rlevel' mismatched" severity note;
            end if;
            -- CHECK 33
            if rpe = '1' then
                assert rlevel <= rpel report "(33) 're' and 'rlevel' mismatched" severity note;
            end if;
            -- CHECK 34
            if rf = '1' then
                assert rlevel = depth report "(34) 're' and 'rlevel' mismatched" severity note;
            end if;
        end if;
    end process;

    afifo_0 : afifo
        generic map(
            width  => width,
            order  => order,
            wpfl   => wpfl,
            wpfl2  => wpfl2,
            rpel   => rpel,
            family => family,
            safety => safety)
        port map(
            rst    => rst,
            rk     => rk,
            wk     => wk,
            wd     => wd,
            wadv   => wadv,
            we     => we,
            wpf    => wpf,
            wpf2   => wpf2,
            wf     => wf,
            rq     => rq,
            radv   => radv,
            rflush => rflush,
            re     => re,
            rpe    => rpe,
            rf     => rf,
            rlevel => rlevel);

end;
