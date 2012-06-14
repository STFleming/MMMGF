--
-- ddrsdram_training_v2.vhd - DDR SDRAM training module for Virtex-II and
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

entity ddrsdram_training_v2 is
    generic(
        num_port        : in    natural);
    port(
        -- To/from clocking infrastructure
        clk             : in    std_logic;                                   -- Interface clock
        rst             : in    std_logic;                                   -- Aynchronous reset
        sr              : in    std_logic;                                   -- Synchronous reset
        clkc            : in    std_logic;                                   -- Clock from which 'clkc0' is derived
        -- Signals to/from DDR SDRAM ports
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

architecture mixed of ddrsdram_training_v2 is

    constant this_module : string := "ddrsdram_training_v2";

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
            I : in  std_logic;
            O : out std_logic);
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
    signal clkc180_unbuf : std_logic;
    signal clkc0_bufg : std_logic;
    signal clkc180_bufg : std_logic;
    signal dcm_locked : std_logic;
    signal dcm_locked_q0 : std_logic;
    signal dcm_locked_q1 : std_logic;
    signal dcm_psdone : std_logic;

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
    signal best_edge : std_logic_vector(2 downto 0);

    -- Executive state machine
    type state1_t is (
        s1_reset_dcm_a,
        s1_wait_locked_a,
        s1_do_tests,
        s1_inc_phase,
        s1_reset_dcm_b,
        s1_wait_locked_b,
        s1_set_phase_1,
        s1_set_phase_2,
        s1_done);
    signal state1, n_state1 : state1_t;
    signal complete, n_complete : std_logic;
    signal do_tests, n_do_tests : std_logic;
    signal dcm_psen, n_dcm_psen : std_logic;
    signal dcm_rst, n_dcm_rst : std_logic;
    -- edge(0) = 0 => recapture using clk0 in ddrsdram_port
    -- edge(0) = 1 => recapture using clk180 in ddrsdram_port
    -- edge(2:1) = 0 => no extra delay for 'qvalid' in ddrsdram_port
    -- edge(2:1) = 3 => 3 cycles extra delay for qvalid in ddrsdram_port
    signal edge, n_edge : std_logic_vector(2 downto 0);
    signal i_trained, n_trained : std_logic;

    -- A value of 0 for 'pscount' represents an actual DCM phase shift of -128 units
    -- A value of 255 for 'pscount' represents an actual DCM phase shift of +127 units
    signal pscount : std_logic_vector(7 downto 0);
    signal pscount_last : std_logic; -- true when pscount = 255

    signal logic0, logic1 : std_logic;

    attribute DLL_FREQUENCY_MODE : string;
    attribute DUTY_CYCLE_CORRECTION : string;
    attribute STARTUP_WAIT : string;
    attribute CLK_FEEDBACK : string;
    attribute CLKOUT_PHASE_SHIFT : string;
    attribute PHASE_SHIFT : integer;

    attribute DLL_FREQUENCY_MODE of dcm_0 : label is "LOW";
    attribute DUTY_CYCLE_CORRECTION of dcm_0 : label is "TRUE";
    attribute STARTUP_WAIT of dcm_0 : label is "FALSE";
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
    cedge <= edge;
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
    -- A value of 255 for 'pscount' is equivalent to a DCM phase shift of -127 units
    -- or slightly less than +0.5 * period or slightly less than +PI / 2.
    --

    gen_pscount : process(clk)
    begin
        if clk'event and clk = '1' then
            if dcm_rst = '1' then
                pscount <= (others => '0');
                pscount_last <= '0';
            else
                if dcm_psen = '1' then
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
                window_mid <= EXT(window_start, 9) + window_stop - (num_consecutive_pass - 1);
                window_size <= window_stop - EXT(window_start, 9) - (num_consecutive_pass - 1);
            end if;

            calc_window_q <= calc_window;
        end if;
    end process;

    -- Note that bit 8 of 'window_size' is 1 if arithmetic overflowed, and window
    -- must be considered invalid.
    found_window <= calc_window_q and not window_size(8);

    --
    -- Executive state machine
    --

    gen_state1 : process(clk)
    begin
        if clk'event and clk = '1' then
            if lsr = '1' then
                state1 <= s1_reset_dcm_a;
                complete <= '0';
                do_tests <= '0';
                dcm_psen <= '0';
                dcm_rst <= '0';
                edge <= (others => '-');
                i_trained <= '0';
            else
                state1 <= n_state1;
                complete <= n_complete;
                do_tests <= n_do_tests;
                dcm_psen <= n_dcm_psen;
                dcm_rst <= n_dcm_rst;
                edge <= n_edge;
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
        dcm_psdone,
        edge,
        pscount,
        pscount_last)
    begin
        case state1 is
            when s1_reset_dcm_a =>
                if dcm_locked_q1 = '0' then
                    n_state1 <= s1_wait_locked_a;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_reset_dcm_a;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '1';
                    n_edge <= (others => '-');
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
                    n_trained <= '0';
                else
                    n_state1 <= s1_wait_locked_a;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
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
                    n_trained <= '0';
                else
                    n_state1 <= s1_do_tests;
                    n_complete <= '0';
                    n_do_tests <= '1';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
                    n_trained <= '0';
                end if;

            when s1_inc_phase =>
                if dcm_psdone = '1' then
                    if pscount_last = '1' then
                        n_state1 <= s1_reset_dcm_b;
                        n_complete <= '0';
                        n_do_tests <= '0';
                        n_dcm_psen <= '0';
                        n_dcm_rst <= '1';
                        n_edge <= edge;
                        n_trained <= '0';
                    else
                        n_state1 <= s1_do_tests;
                        n_complete <= '0';
                        n_do_tests <= '1';
                        n_dcm_psen <= '0';
                        n_dcm_rst <= '0';
                        n_edge <= edge;
                        n_trained <= '0';
                    end if;
                else
                    n_state1 <= s1_inc_phase;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
                    n_trained <= '0';
                end if;

            when s1_reset_dcm_b =>
                if dcm_locked_q1 = '0' then
                    n_state1 <= s1_wait_locked_b;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
                    n_trained <= '0';
                else
                    n_state1 <= s1_reset_dcm_b;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '1';
                    n_edge <= edge;
                    n_trained <= '0';
                end if;

            when s1_wait_locked_b =>
                if dcm_locked_q1 = '1' then
                    if edge = "111" then
                        n_state1 <= s1_set_phase_1;
                        n_complete <= '0';
                        n_do_tests <= '0';
                        n_dcm_psen <= '0';
                        n_dcm_rst <= '0';
                        n_edge <= edge;
                        n_trained <= '0';
                    else
                        n_state1 <= s1_do_tests;
                        n_complete <= '0';
                        n_do_tests <= '1';
                        n_dcm_psen <= '0';
                        n_dcm_rst <= '0';
                        n_edge <= edge + 1;
                        n_trained <= '0';
                    end if;
                else
                    n_state1 <= s1_wait_locked_b;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= edge;
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
                    n_trained <= '0';
                else
                    n_state1 <= s1_set_phase_2;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '1';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_set_phase_2 =>
                if dcm_psdone = '1' then
                    n_state1 <= s1_set_phase_1;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_trained <= '0';
                else
                    n_state1 <= s1_set_phase_2;
                    n_complete <= '0';
                    n_do_tests <= '0';
                    n_dcm_psen <= '0';
                    n_dcm_rst <= '0';
                    n_edge <= (others => '-');
                    n_trained <= '0';
                end if;

            when s1_done =>
                n_state1 <= s1_done;
                n_complete <= '1';
                n_do_tests <= '0';
                n_dcm_psen <= '0';
                n_dcm_rst <= '0';
                n_edge <= best_edge;
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
            CLK90 => open,
            CLK180 => clkc180_unbuf,
            CLK270 => open,
            CLK2X => open,
            CLK2X180 => open,
            CLKDV => open,
            CLKFX => open,
            CLKFX180 => open,
            LOCKED => dcm_locked,
            PSDONE => dcm_psdone,
            STATUS => open);

    bufg_clk : BUFG
        port map(
            I => clkc0_unbuf,
            O => clkc0_bufg);

    bufg_clk180 : BUFG
        port map(
            I => clkc180_unbuf,
            O => clkc180_bufg);

    -- Synchronize DCM lock flag with 'clk' domain.
    gen_dcm_locked_q1 : process(clk)
    begin
        if clk'event and clk = '1' then
            dcm_locked_q0 <= dcm_locked;
            dcm_locked_q1 <= dcm_locked_q0;
        end if;
    end process;

end mixed;
