--
-- ddr2sram_training_v2.vhd - DDR-II SDRAM training module for Virtex-II and
--                            Virtex-II Pro
--
-- SYNTHESIZABLE
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

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

library work;
use work.memif.all;
use work.memif_def.all;
use work.memif_int.all;
--use work.ilap.all;

entity ddr2sram_training_v2 is
    generic(
        num_port        : in    natural);
    port(
        -- To/from clocking infrastructure
        clk             : in    std_logic;                                   -- Interface clock
        rst             : in    std_logic;                                   -- Aynchronous reset
        sr              : in    std_logic;                                   -- Synchronous reset
        clkc            : in    std_logic;                                   -- Clock from which 'clkc0' is derived
        -- Signals to/from DDR-II SSRAM ports
        tstdone         : in    std_logic_vector(num_port - 1 downto 0);     -- Pulsed to indicate test completed
        tstok           : in    std_logic_vector(num_port - 1 downto 0);     -- Qualified by 'tstdone', 1 => test successful
        clkc0           : out   std_logic;                                   -- Capture clock out, 0 deg phase
        clkc180         : out   std_logic;                                   -- Capture clock out, 180 deg phase
        cedge           : out   std_logic_vector(2 downto 0);                -- Edge to use for retiming data
        tstcomp         : out   std_logic;                                   -- 1 => training complete
        tstdo           : out   std_logic;                                   -- Asserted (and held) until all banks pulse 'tstdone'
        -- Miscellaneous
        trained         : out   std_logic);                                  -- 1 => training was successful
end;

architecture mixed of ddr2sram_training_v2 is

    constant this_module : string := "ddr2sram_training_v2";

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

    function max(
        a, b : in integer)
    return integer is
    begin
        if a > b then
            return a;
        else
            return b;
        end if;
    end;

    function choice(
        a, b : in integer;
        p : in boolean)
    return integer is
    begin
        if p then
            return b;
        else
            return a;
        end if;
    end;

    component DCM
        generic(
            CLKDV_DIVIDE : real := 2.0;
            CLKFX_DIVIDE : integer := 1;
            CLKFX_MULTIPLY : integer := 4;
            CLKIN_DIVIDE_BY_2 : boolean := false;
            CLKIN_PERIOD : real := 10.0;                    -- non-simulatable
            CLKOUT_PHASE_SHIFT : string := "NONE";
            CLK_FEEDBACK : string := "1X";
            DESKEW_ADJUST : string := "SYSTEM_SYNCHRONOUS"; -- non-simulatable
            DFS_FREQUENCY_MODE : string := "LOW";
            DLL_FREQUENCY_MODE : string := "LOW";
            DSS_MODE : string := "NONE";                    -- non-simulatable
            DUTY_CYCLE_CORRECTION : boolean := true;
            FACTORY_JF : bit_vector := X"C080";             -- non-simulatable
            PHASE_SHIFT : integer := 0;
            STARTUP_WAIT : boolean := false);               -- non-simulatable
        port(
            CLKIN         : in  std_logic;
            CLKFB         : in  std_logic;
            DSSEN         : in  std_logic;
            PSINCDEC      : in  std_logic;
            PSEN          : in  std_logic;
            PSCLK         : in  std_logic;
            RST           : in  std_logic;
            CLK0          : out std_logic;
            CLK90         : out std_logic;
            CLK180        : out std_logic;
            CLK270        : out std_logic;
            CLK2X         : out std_logic;
            CLK2X180      : out std_logic;
            CLKDV         : out std_logic;
            CLKFX         : out std_logic;
            CLKFX180      : out std_logic;
            LOCKED        : out std_logic;
            PSDONE        : out std_logic;
            STATUS        : out std_logic_vector(7 downto 0));
    end component;

    component BUFG
        port(
            I  : in  std_logic;
            O  : out std_logic);
    end component;

    component BUFGMUX
        port(
            I0 : in  std_logic;
            I1 : in  std_logic;
            S  : in  std_logic;
            O  : out std_logic);
    end component;

    --
    -- This constant determines how many consecutive memory readback test
    -- passes must occur in order to be regarded as the beginning of the
    -- correct data window.
    --
    constant num_consecutive_pass : natural := 8;

    -- Local reset generation
    signal lsr0 : std_logic;
    signal lsr1 : std_logic;
    signal lsr : std_logic;

    signal clkc0_unbuf : std_logic;
    signal clkc90_unbuf : std_logic;
    signal clkc180_unbuf : std_logic;
    signal clkc270_unbuf : std_logic;
    signal clkfb : std_logic;
    signal clkc0_bufg : std_logic;
    signal clkc180_bufg : std_logic;
    signal dcm_locked : std_logic;
    signal dcm_locked_q0 : std_logic;
    signal dcm_locked_q1 : std_logic;
    signal dcm_psdone : std_logic;
    signal dcm_psdone_q : std_logic;

    signal tstdone_q : std_logic_vector(num_port - 1 downto 0);
    signal tstok_q : std_logic_vector(num_port - 1 downto 0);
    signal all_done : std_logic;
    signal all_ok : std_logic_vector(num_consecutive_pass - 1 downto 0);
    signal all_ok_q : std_logic;
    signal tests_done : std_logic;
    signal tests_done_q0 : std_logic;
    signal tests_done_q1 : std_logic;

    -- Current data correct window information
    signal in_window : std_logic;
    signal window_start : std_logic_vector(7 downto 0);
    signal window_stop : std_logic_vector(8 downto 0);
    signal window_size : std_logic_vector(8 downto 0);
    signal window_mid : std_logic_vector(8 downto 0);
    signal calc_window : std_logic;
    signal calc_window_q : std_logic;
    signal found_window : std_logic;

    -- Best data correct window information
    signal best_window : std_logic_vector(7 downto 0);
    signal best_window_ok : std_logic;
    signal best_ps : std_logic_vector(7 downto 0);
    signal best_edge : std_logic_vector(3 downto 1);

    -- Executive state machine
    type state1_t is (
        s1_reset_dcm_a1,
        s1_reset_dcm_a2,
        s1_wait_locked_a,
        s1_do_tests,
        s1_inc_phase,
        s1_reset_dcm_b1,
        s1_reset_dcm_b2,
        s1_wait_locked_b,
        s1_set_phase_1,
        s1_set_phase_2,
        s1_done);
    signal state1, n_state1 : state1_t;
    signal complete, n_complete : std_logic;
    signal do_tests, n_do_tests : std_logic;
    signal dcm_psen, n_dcm_psen : std_logic;
    signal dcm_rst, n_dcm_rst : std_logic;
    -- edge(0) => MUX select for BUFGMUXes
    -- edge(1) = 0 => recapture using clk0/clk180 in ddr2sram_port_v2
    -- edge(1) = 1 => recapture using clk180/clk0 in ddr2sram_port_v2
    -- edge(3:2) = amount of delay for 'valid' and 'qtag' in ddr2sram_port_v2
    signal edge, n_edge : std_logic_vector(3 downto 1);
    signal timer1, n_timer1 : std_logic_vector(1 downto 0);
    signal i_trained, n_trained : std_logic;

    -- A value of 0 for 'pscount' represents an actual DCM phase shift of -128 units (or -180 deg)
    -- A value of 255 for 'pscount' represents an actual DCM phase shift of +127 units (or ~180 deg)
    signal pscount : std_logic_vector(7 downto 0);
    signal pscount_last : std_logic; -- true when pscount = 255

    signal logic0, logic1 : std_logic;

--    signal trig0 : std_logic_vector(254 downto 0);
--    signal trig_out : std_logic;
--    attribute keep : string;
--    attribute keep of trig_out : signal is "true";

    attribute DLL_FREQUENCY_MODE : string;
    attribute DUTY_CYCLE_CORRECTION : boolean;
    attribute STARTUP_WAIT : boolean;
    attribute CLK_FEEDBACK : string;
    attribute CLKOUT_PHASE_SHIFT : string;
    attribute PHASE_SHIFT : integer;

    attribute DLL_FREQUENCY_MODE of dcm_0 : label is "LOW";
    attribute DUTY_CYCLE_CORRECTION of dcm_0 : label is true;
    attribute STARTUP_WAIT of dcm_0 : label is false;
    attribute CLK_FEEDBACK of dcm_0 : label is "1X";
    attribute CLKOUT_PHASE_SHIFT of dcm_0 : label is "VARIABLE";
    attribute PHASE_SHIFT of dcm_0 : label is -128;

begin

    logic0 <= '0';
    logic1 <= '1';

    tstcomp <= complete;
    tstdo <= do_tests;
    clkc0 <= clkc0_bufg;
    clkc180 <= clkc180_bufg;
    cedge <= edge(3 downto 1);
    trained <= i_trained;

    --
    -- Generate local reset
    --

    local_reset : process(rst, clk)
    begin
        if rst = '1' then
            lsr0 <= '1';
            lsr1 <= '1';
            lsr <= '1';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                lsr0 <= '1';
                lsr1 <= '1';
                lsr <= '1';
            else
                lsr0 <= '0';
                lsr1 <= lsr0;
                lsr <= lsr1;
            end if;
        end if;
    end process;

    --
    -- DCM phase shift counter.
    --
    -- A value of 0 for 'pscount' is equivalent to a DCM phase shift of -128 units or
    -- -0.5 * period or -PI / 2.
    --
    -- A value of 255 for 'pscount' is equivalent to a DCM phase shift of 127 units
    -- or slightly less than 0.5 * period or slightly less than PI / 2.
    --

    gen_pscount : process(clk)
    begin
        if clk'event and clk = '1' then
            if dcm_rst = '1' then
                pscount <= (others => '0');
                pscount_last <= '0';
            else
                if dcm_psen = '1' then -- should use dcm_psdone_q ?
                    pscount <= pscount + 1;
                    if pscount(7 downto 1) = "1111111" then
                        pscount_last <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    --
    -- Figure out when all memory banks have pulsed 'tstdone', and record which
    -- ones reported that their test succeeded in 'tstok_q'.
    --

    gen_all_done : process(clk)
    begin
        if clk'event and clk = '1' then
            for i in 0 to num_port - 1 loop
                if do_tests = '0' then
                    tstdone_q(i) <= '0';
                else
                    if tstdone(i) = '1' then
                        tstdone_q(i) <= '1';
                    end if;
                end if;

                if tstdone(i) = '1' then
                    tstok_q(i) <= tstok(i);
                end if;
            end loop;

            if do_tests = '0' then
                all_done <= '0';
            else
                all_done <= AND_reduce(tstdone_q);
            end if;
        end if;
    end process;

    --
    -- Record best window found so far along with best DCM phase shift and best
    -- 'edge' value.
    --

    best_windows : process(clk)
    begin
        if clk'event and clk = '1' then
            if lsr = '1' then
                best_window_ok <= '0';
                best_window <= (others => '0');
            else
                if found_window = '1' then
                    best_window_ok <= '1';
                    if window_size(7 downto 0) > best_window then
                        best_window <= window_size(7 downto 0);
                    end if;
                end if;
            end if;

            if found_window = '1' then
                if window_size(7 downto 0) > best_window then
                    best_edge <= edge;
                    best_ps <= window_mid(8 downto 1);
                end if;
            end if;
        end if;
    end process;

    --
    -- Detect windows where memory tests from all banks succeed whilst the DCM phase shift is
    -- swept from -128 units to +127 units.
    --
    -- When the end of a window is detected, 'found_window' is pulsed, qualifying
    -- 'window_size' and the 'window_mid'. These values are in 'pscount' units.
    --

    tests_done <= all_done and do_tests;

    detect_window : process(clk)
    begin
        if clk'event and clk = '1' then
            tests_done_q0 <= tests_done;
            tests_done_q1 <= tests_done_q0;

            if dcm_rst = '1' then
                all_ok <= (others => '0');
            else
                if tests_done = '1' then
                    all_ok(0) <= AND_reduce(tstok_q);
                    all_ok(num_consecutive_pass - 1 downto 1) <= all_ok(num_consecutive_pass - 2 downto 0);
                end if;
            end if;

            all_ok_q <= AND_reduce(all_ok);

            if lsr = '1' then
                in_window <= '0';
            else
                if tests_done_q1 = '1' then
                    in_window <= all_ok_q and not pscount_last;
                end if;
            end if;

            if tests_done_q1 = '1' then
                if in_window = '1' then
                    if all_ok_q = '0' then
                        window_stop <= "0" & pscount;
                    end if;
                else
                    if all_ok_q = '1' then
                        window_start <= pscount;
                        window_stop <= "100000000";
                    end if;
                end if;
            end if;

            calc_window <= tests_done_q1 and ((in_window and not all_ok_q) or
                                              (in_window and all_ok_q and pscount_last) or
                                              (not in_window and all_ok_q and pscount_last));
            if calc_window = '1' then
                window_mid <= EXT(window_start, 9) - (num_consecutive_pass - 1) + window_stop;
                window_size <= window_stop - EXT(window_start, 9);
            end if;

            calc_window_q <= calc_window;

           -- Note that bit 8 of 'window_size' is 1 if arithmetic overflowed, and window
           -- must be considered invalid.
           found_window <= calc_window_q and not window_size(8);
        end if;
    end process;

    --
    -- Executive state machine
    --

    gen_state1 : process(clk)
    begin
        if clk'event and clk = '1' then
            if lsr = '1' then
                state1 <= s1_reset_dcm_a1;
                complete <= '0';
                do_tests <= '0';
                dcm_psen <= '0';
                dcm_rst <= '0';
                edge <= (others => '-');
                timer1 <= "00";
                i_trained <= '0';
            else
                state1 <= n_state1;
                complete <= n_complete;
                do_tests <= n_do_tests;
                dcm_psen <= n_dcm_psen;
                dcm_rst <= n_dcm_rst;
                edge <= n_edge;
                timer1 <= n_timer1;
                i_trained <= n_trained;
            end if;
        end if;
    end process;

    gen_n_state1 : process(
        state1,
        all_done,
        best_edge,
        best_ps,
        best_window_ok,
        dcm_locked_q1,
        dcm_psdone_q,
        edge,
        pscount,
        pscount_last,
        timer1)
    begin
        case state1 is
            when s1_reset_dcm_a1 =>
                if timer1 = "11" then
                    n_state1 <= s1_reset_dcm_a2;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '1';
                    n_edge <= (others => '-');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_reset_dcm_a1;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '1';
                    n_edge <= (others => '-');
                    n_timer1 <= timer1 + 1;
                    n_trained <= '0';
                end if;
            
            when s1_reset_dcm_a2 =>
                if dcm_locked_q1 = '0' then
                    n_state1 <= s1_wait_locked_a;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_reset_dcm_a2;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '1';
                    n_edge <= (others => '-');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_wait_locked_a =>
                if dcm_locked_q1 = '1' then
                    n_state1 <= s1_do_tests;
                    n_complete <= '0';
                    n_do_tests <= '1';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '0');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_wait_locked_a;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_do_tests =>
                if all_done = '1' then
                    n_state1 <= s1_inc_phase;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '1';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_do_tests;
                    n_complete <= '0';
                    n_do_tests <= '1';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_inc_phase =>
                if dcm_psdone_q = '1' then
                    if pscount_last = '1' then
                        n_state1 <= s1_reset_dcm_b1;
                        n_complete <= '0';
                        n_do_tests <= '0';
                        n_dcm_psen <= '0';
                        n_dcm_rst <= '1';
                        n_edge <= edge;
                        n_timer1 <= "00";
                        n_trained <= '0';
                    else
                        n_state1 <= s1_do_tests;
                        n_complete <= '0';
                        n_do_tests <= '1';
                        n_dcm_psen <= '0';
                        n_dcm_rst <= '0';
                        n_edge <= edge;
                        n_timer1 <= (others => '-');
                        n_trained <= '0';
                    end if;
                else
                    n_state1 <= s1_inc_phase;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_reset_dcm_b1 =>
                if timer1 = "11" then
                    n_state1 <= s1_reset_dcm_b2;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '1';
                    n_edge <= edge;
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_reset_dcm_b1;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '1';
                    n_edge <= edge;
                    n_timer1 <= timer1 + 1;
                    n_trained <= '0';
                end if;

            when s1_reset_dcm_b2 =>
                if dcm_locked_q1 = '0' then
                    n_state1 <= s1_wait_locked_b;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_reset_dcm_b2;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '1';
                    n_edge <= edge;
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_wait_locked_b =>
                if dcm_locked_q1 = '1' then
                    if AND_reduce(edge) = '1' then
                        n_state1 <= s1_set_phase_1;
                        n_complete <= '0';
                        n_do_tests <= '0';
                        n_dcm_psen <= '0';
                        n_dcm_rst <= '0';
                        n_edge <= edge;
                        n_timer1 <= (others => '-');
                        n_trained <= '0';
                    else
                        n_state1 <= s1_do_tests;
                        n_complete <= '0';
                        n_do_tests <= '1';
                        n_dcm_psen <= '0';
                        n_dcm_rst <= '0';
                        n_edge <= edge + 1;
                        n_timer1 <= (others => '-');
                        n_trained <= '0';
                    end if;
                else
                    n_state1 <= s1_wait_locked_b;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_set_phase_1 =>
                if pscount = best_ps or best_window_ok = '0' then
                    n_state1 <= s1_done;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_set_phase_2;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '1';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_set_phase_2 =>
                if dcm_psdone_q = '1' then
                    n_state1 <= s1_set_phase_1;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_set_phase_2;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_timer1 <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_done =>
                n_state1 <= s1_done;
                n_complete <= '1';
                n_do_tests <= '0';
                n_dcm_psen <= '0';
                n_dcm_rst <= '0';
                n_edge <= best_edge;
                n_timer1 <= (others => '-');
                n_trained <= best_window_ok;
        end case;
    end process;

    --
    -- Instantiate the DCM that generates the DQ capture clocks, 'clkc0' and 'clkc180'.
    --

    dcm_0 : DCM
        generic map(
            DLL_FREQUENCY_MODE => "LOW",
            DUTY_CYCLE_CORRECTION => true,
            STARTUP_WAIT => false,
            CLK_FEEDBACK => "1X",
            CLKOUT_PHASE_SHIFT => "VARIABLE",
            PHASE_SHIFT => -128)
        port map(
            CLKIN => clkc,
            CLKFB => clkc0_bufg,
            DSSEN => logic0,
            PSINCDEC => dcm_psen,
            PSEN => dcm_psen,
            PSCLK => clk,
            RST => dcm_rst,
            CLK0 => clkc0_unbuf,
            CLK90 => clkc90_unbuf,
            CLK180 => clkc180_unbuf,
            CLK270 => clkc270_unbuf,
            CLK2X => open,
            CLK2X180 => open,
            CLKDV => open,
            CLKFX => open,
            CLKFX180 => open,
            LOCKED => dcm_locked,
            PSDONE => dcm_psdone,
            STATUS => open);

    bufg_clkfb : BUFG
        port map(
            I => clkc0_unbuf,
            O => clkfb);

    bufg_clk : BUFG
       port map(
            I => clkc0_unbuf,
            O => clkc0_bufg);

    bufg_clk180 : BUFG
        port map(
            I => clkc180_unbuf,
            O => clkc180_bufg);

--    bufg_clkc0 : BUFGMUX
--        port map(
--            I0 => clkc0_unbuf,
--            I1 => clkc90_unbuf,
--            S => edge(0),
--            O => clkc0_bufg);

--    bufg_clkc180 : BUFGMUX
--        port map(
--            I0 => clkc180_unbuf,
--            I1 => clkc270_unbuf,
--            S => edge(0),
--            O => clkc180_bufg);

    -- Synchronize DCM lock flag with 'clk' domain.
    gen_dcm_locked_q1 : process(clk)
    begin
        if clk'event and clk = '1' then
            dcm_locked_q0 <= dcm_locked;
            dcm_locked_q1 <= dcm_locked_q0;
            dcm_psdone_q <= dcm_psdone;
        end if;
    end process;

    --
    -- Debug
    --
    -- Ensure that the 'dummy' parameter of 'ila0' is true in production code.
    --

--    trig0(0) <= '0';
--    trig0(1) <= '0';
--    trig0(2) <= dcm_locked_q1;
--    trig0(3) <= dcm_psdone_q;
--    trig0(11 downto 4) <= EXT(tstdone_q, 8);
--    trig0(19 downto 12) <= EXT(tstok_q, 8);
--    trig0(20) <= all_done;
--    trig0(28 downto 21) <= EXT(all_ok, 8);
--    trig0(29) <= all_ok_q;
--    trig0(30) <= tests_done;
--    trig0(31) <= tests_done_q0;
--    trig0(32) <= tests_done_q1;
--    trig0(33) <= in_window;
--    trig0(41 downto 34) <= window_start;
--    trig0(50 downto 42) <= window_stop;
--    trig0(59 downto 51) <= window_size;
--    trig0(68 downto 60) <= window_mid;
--    trig0(69) <= calc_window;
--    trig0(70) <= calc_window_q;
--    trig0(71) <= found_window;
--    trig0(79 downto 72) <= best_window;
--    trig0(80) <= best_window_ok;
--    trig0(88 downto 81) <= best_ps;
--    trig0(92 downto 89) <= EXT(best_edge, 4);
--    trig0(93) <= complete;
--    trig0(94) <= do_tests;
--    trig0(95) <= dcm_psen;
--    trig0(96) <= dcm_rst;
--    trig0(100 downto 97) <= EXT(edge, 4);
--    trig0(108 downto 101) <= pscount;
--    trig0(109) <= pscount_last;
--    trig0(117 downto 110) <= EXT(tstdone, 8);
--    trig0(125 downto 118) <= EXT(tstok, 8);
--    trig0(254 downto 126) <= (others => '0');

--    ila0 : ilacombo
--        generic map(
--            dummy => true)
--        port map(
--            clk => clk,
--            trig0 => trig0,
--            trig_out => trig_out);

end mixed;
