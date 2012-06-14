--
-- ddr2sdram_training_dc.vhd - DDR-II SDRAM memory interface, training module for
--                             direct clocking scheme.
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

library work;
use work.memif.all;
use work.memif_def.all;
use work.memif_int.all;
--use work.ilap.all;

entity ddr2sdram_training_dc is
    generic(
        dq_width        : in    natural;
        dqs_width       : in    natural;
        t_act           : in    natural;
        t_rfc           : in    natural;
        t_rp            : in    natural;
        t_rtp           : in    natural;
        t_wtp           : in    natural);
    port(
        clk             : in    std_logic;
        rst             : in    std_logic;
        sr              : in    std_logic;
        go              : in    std_logic;
        dq_i            : in    std_logic_vector(4 * dq_width - 1 downto 0);
        valid           : in    std_logic;
        ref_req         : in    std_logic;
        rd              : out   std_logic;
        wr              : out   std_logic;
        command         : out   std_logic_vector(4 downto 0);
        addr            : out   std_logic_vector(2 downto 0);
        done            : out   std_logic;
        trained         : out   std_logic;
        ref_done        : out   std_logic;
        dq_o            : out   std_logic_vector(4 * dq_width - 1 downto 0);
        dlysr_dq        : out   std_logic_vector(dq_width - 1 downto 0);
        dlyce_dq        : out   std_logic_vector(dq_width - 1 downto 0);
        dlyinc_dq       : out   std_logic_vector(dq_width - 1 downto 0);
        dlysr_dqs       : out   std_logic_vector(dqs_width - 1 downto 0);
        dlyce_dqs       : out   std_logic_vector(dqs_width - 1 downto 0);
        dlyinc_dqs      : out   std_logic_vector(dqs_width - 1 downto 0);
        qce             : out   std_logic_vector(dq_width - 1 downto 0);
        qdelay          : out   std_logic_vector(dq_width * 2 - 1 downto 0);
        vdelay          : out   std_logic_vector(3 downto 0));
end entity;

architecture mixed of ddr2sdram_training_dc is

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

    --
    -- This constant determines how many consecutive memory readback test
    -- passes must occur in order to be regarded as the beginning of the
    -- valid data window.
    --
    constant num_consecutive_pass : natural := 4;

    --
    -- DDR commands
    --
    -- Order (4 downto 0) is (all, cs#, ras#, cas#, we#)
    --
    constant DDRCMD_NOP    : std_logic_vector(4 downto 0) := "-1111"; -- Deselect
    constant DDRCMD_ACT    : std_logic_vector(4 downto 0) := "10011"; -- Activate
    constant DDRCMD_PRE    : std_logic_vector(4 downto 0) := "10010"; -- Precharge
    constant DDRCMD_REF    : std_logic_vector(4 downto 0) := "10001"; -- Refresh
    constant DDRCMD_READ   : std_logic_vector(4 downto 0) := "00101"; -- Read
    constant DDRCMD_WRITE  : std_logic_vector(4 downto 0) := "10100"; -- Write
    constant DDRCMD_X      : std_logic_vector(4 downto 0) := "-----";

    --
    -- Executive training state machine
    --

    type train_state_t is (
        ts_idle,
        ts_opening,
        ts_write_pattern_0,
        ts_write_pattern_0a,
        ts_write_pattern_1,
        ts_write_pattern_1b,
        ts_waiting,
        ts_closing,
        ts_find_windows,
        ts_program_idelays,
        ts_done);
    signal t_state, n_t_state : train_state_t;
    signal t_idle, n_t_idle : std_logic;
    signal t_dl_go, n_t_dl_go : std_logic;
    signal t_pd_go, n_t_pd_go : std_logic;
    signal t_cmd, n_t_cmd : std_logic_vector(4 downto 0);
    signal t_addr, n_t_addr : std_logic_vector(2 downto 0);
    signal t_wr, n_t_wr : std_logic;
    signal t_done, n_t_done : std_logic;
    signal t_timer, n_t_timer : std_logic_vector(4 downto 0);
    signal t_sel_rb_addr, n_t_sel_rb_addr : std_logic;

    --
    -- This state machine cycles through the possible values of QCE/QDELAY
    --

    type dly_loop_state_t is (
        dls_idle,
        dls_waiting,
        dls_reset_idelays,
        dls_done);
    signal dl_tl_go, n_dl_tl_go : std_logic;
    signal dl_state, n_dl_state : dly_loop_state_t;
    signal dl_index, n_dl_index : std_logic_vector(2 downto 0);
    signal dl_timer, n_dl_timer : std_logic_vector(3 downto 0);
    signal dl_rst_idelays, n_dl_rst_idelays : std_logic;
    signal dl_done, n_dl_done : std_logic;

    signal dl_found_window : std_logic_vector(dq_width - 1 downto 0);
    signal dl_best_qce : std_logic_vector(dq_width - 1 downto 0);
    type qdelay_t is array(0 to dq_width - 1) of std_logic_vector(1 downto 0);
    signal dl_best_qdelay : qdelay_t;
    signal dl_ok : std_logic_vector(dq_width - 1 downto 0);
    type dl_best_tap_t is array(0 to dq_width - 1) of std_logic_vector(5 downto 0);
    signal dl_best_tap : dl_best_tap_t;
    type dl_best_window_t is array(0 to dq_width - 1) of std_logic_vector(5 downto 0);
    signal dl_best_window : dl_best_window_t;

    signal dl_trained : std_logic;

    --
    -- This state machine performs 64 readback cycles.
    --

    type tap_loop_state_t is (
        tls_idle,
        tls_waiting,
        tls_pause1,
        tls_pause2,
        tls_compare,
        tls_done);
    signal tl_rb_go, n_tl_rb_go : std_logic;
    signal tl_state, n_tl_state : tap_loop_state_t;
    signal tl_tap_index, n_tl_tap_index : std_logic_vector(5 downto 0);
    signal tl_tap_last, n_tl_tap_last : std_logic;
    signal tl_done, n_tl_done : std_logic;

    signal rb_done_q0 : std_logic;
    signal rb_done_q1 : std_logic;

    type tl_ok_t is array(0 to num_consecutive_pass - 1) of std_logic_vector(dq_width - 1 downto 0);
    signal tl_ok : tl_ok_t;
    signal tl_ok_q : std_logic_vector(dq_width - 1 downto 0);

    signal tl_in_window : std_logic_vector(dq_width - 1 downto 0);
    signal tl_calc_window : std_logic_vector(dq_width - 1 downto 0);
    signal tl_found_window : std_logic_vector(dq_width - 1 downto 0);

    type tl_window_start_t is array(0 to dq_width - 1) of std_logic_vector(5 downto 0);
    signal tl_window_start : tl_window_start_t;
    type tl_window_stop_t is array(0 to dq_width - 1) of std_logic_vector(6 downto 0);
    signal tl_window_stop : tl_window_stop_t;
    type tl_tap_mid_t is array(0 to dq_width - 1) of std_logic_vector(6 downto 0);
    signal tl_window_mid : tl_tap_mid_t;
    type tl_window_size_t is array(0 to dq_width - 1) of std_logic_vector(6 downto 0);
    signal tl_window_size : tl_window_size_t;

    --
    -- This state machine performs a readback cycle.
    --

    type readback_state_t is (
        rbs_idle,
        rbs_opening,
        rbs_reading,
        rbs_wait_8valid,
        rbs_wait_rtp,
        rbs_closing,
        rbs_refreshing,
        rbs_done);
    signal rb_state, n_rb_state : readback_state_t;
    signal rb_timer, n_rb_timer : std_logic_vector(4 downto 0);
    signal rb_inc_idelay, n_rb_inc_idelay : std_logic;
    signal rb_cmd, n_rb_cmd : std_logic_vector(4 downto 0);
    signal rb_addr, n_rb_addr : std_logic_vector(2 downto 0);
    signal rb_rd, n_rb_rd : std_logic;
    signal rb_num_cmd, n_rb_num_cmd : std_logic_vector(2 downto 0);
    signal rb_num_valid, n_rb_num_valid : std_logic_vector(2 downto 0);
    signal rb_match_addr, n_rb_match_addr : std_logic;
    signal rb_ref_done, n_rb_ref_done : std_logic;
    signal rb_done, n_rb_done : std_logic;

    signal rb_match : std_logic_vector(4 * dq_width - 1 downto 0);
    signal rb_match4 : std_logic_vector(dq_width - 1 downto 0);
    signal rb_match_valid : std_logic;
    signal rb_ok : std_logic_vector(dq_width - 1 downto 0);

    --
    -- This state machine programs the IDELAYs with their final values at the
    -- end of training.
    --

    type pds_state_t is (
        pds_idle,
        pds_rst_idelays,
        pds_wait1,
        pds_programming,
        pds_wait2,
        pds_done);
    signal pd_state, n_pd_state : pds_state_t;
    signal pd_timer, n_pd_timer : std_logic_vector(3 downto 0);
    signal pd_inc_idelays, n_pd_inc_idelays : std_logic;
    signal pd_rst_idelays, n_pd_rst_idelays : std_logic;
    signal pd_done, n_pd_done : std_logic;

    signal pd_tap_idx : std_logic_vector(5 downto 0);
    signal pd_inc_idelay : std_logic_vector(dq_width - 1 downto 0);
    signal pd_inc_idelays_q : std_logic;

--    constant probe_index : natural := 0;
--    signal trig0 : std_logic_vector(254 downto 0);
--    signal trig_out : std_logic;
--    attribute keep : string;
--    attribute keep of trig_out : signal is "true";

begin

    gen_command : process(clk)
    begin
        if clk'event and clk = '1' then
            command <= t_cmd and rb_cmd;
            if t_sel_rb_addr = '1' then
                addr <= rb_addr;
            else
                addr <= t_addr;
            end if;
            wr <= t_wr;
            rd <= rb_rd;
            if t_addr(2) = '0' then
                dq_o(1 * dq_width - 1 downto 0 * dq_width) <= (others => '1');
                dq_o(2 * dq_width - 1 downto 1 * dq_width) <= (others => '0');
                dq_o(3 * dq_width - 1 downto 2 * dq_width) <= (others => '1');
                dq_o(4 * dq_width - 1 downto 3 * dq_width) <= (others => '0');
            else
                dq_o(1 * dq_width - 1 downto 0 * dq_width) <= (others => '0');
                dq_o(2 * dq_width - 1 downto 1 * dq_width) <= (others => '1');
                dq_o(3 * dq_width - 1 downto 2 * dq_width) <= (others => '1');
                dq_o(4 * dq_width - 1 downto 3 * dq_width) <= (others => '0');
            end if;
        end if;
    end process;

    gen_idelaycmd : process(clk)
    begin
        if clk'event and clk = '1' then
            dlysr_dq <= (others => dl_rst_idelays or pd_rst_idelays);
            for i in 0 to dq_width - 1 loop
                dlyce_dq(i) <= rb_inc_idelay or (pd_inc_idelay(i) and pd_inc_idelays_q);
            end loop;
            dlyinc_dq <= (others => '1');
            if t_idle = '1' then
                qce <= dl_best_qce;
                for i in 0 to dq_width - 1 loop
                    qdelay(2 * i + 1 downto 2 * i) <= dl_best_qdelay(i);
                end loop;
            else
                qce <= (others => dl_index(0));
                for i in 0 to dq_width - 1 loop
                    qdelay(2 * i + 1 downto 2 * i) <= dl_index(2 downto 1);
                end loop;
            end if;
        end if;
    end process;

    dlysr_dqs <= (others => '0');
    dlyce_dqs <= (others => '0');
    dlyinc_dqs <= (others => '1');

    ref_done <= rb_ref_done;

    done <= t_done;
    trained <= dl_trained;

    vdelay <= "0111";

    --
    -- Executive training state machine
    --

    gen_t_state : process(rst, clk)
    begin
        if rst = '1' then
            t_state <= ts_idle;
            t_idle <= '1';
            t_dl_go <= '0';
            t_pd_go <= '0';
            t_cmd <= DDRCMD_X;
            t_addr <= (others => '-');
            t_wr <= '0';
            t_done <= '0';
            t_timer <= (others => '-');
            t_sel_rb_addr <= '-';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                t_state <= ts_idle;
                t_idle <= '1';
                t_dl_go <= '0';
                t_pd_go <= '0';
                t_cmd <= DDRCMD_X;
                t_addr <= (others => '-');
                t_wr <= '0';
                t_done <= '0';
                t_timer <= (others => '-');
                t_sel_rb_addr <= '-';
            else
                t_state <= n_t_state;
                t_idle <= n_t_idle;
                t_dl_go <= n_t_dl_go;
                t_pd_go <= n_t_pd_go;
                t_cmd <= n_t_cmd;
                t_addr <= n_t_addr;
                t_wr <= n_t_wr;
                t_done <= n_t_done;
                t_timer <= n_t_timer;
                t_sel_rb_addr <= n_t_sel_rb_addr;
            end if;
        end if;
    end process;

    gen_n_t_state : process(
        t_state,
        t_timer,
        go,
        dl_done,
        pd_done)
    begin
        case t_state is
            when ts_idle =>
                if go = '1' then
                    n_t_state <= ts_opening;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_ACT;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= (others => '0');
                    n_t_sel_rb_addr <= '0';
                else
                    n_t_state <= ts_idle;
                    n_t_idle <= '1';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= (others => '-');
                    n_t_sel_rb_addr <= '0';
                end if;

            when ts_opening =>
                if t_timer = t_act then
                    n_t_state <= ts_write_pattern_0a;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_WRITE;
                    n_t_addr <= "000";
                    n_t_wr <= '1';
                    n_t_done <= '0';
                    n_t_timer <= (others => '-');
                    n_t_sel_rb_addr <= '0';
                else
                    n_t_state <= ts_opening;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= t_timer + 1;
                    n_t_sel_rb_addr <= '0';
                end if;

            when ts_write_pattern_0 =>
                n_t_state <= ts_write_pattern_0a;
                n_t_idle <= '0';
                n_t_dl_go <= '0';
                n_t_pd_go <= '0';
                n_t_cmd <= DDRCMD_WRITE;
                n_t_addr <= "000";
                n_t_wr <= '1';
                n_t_done <= '0';
                n_t_timer <= (others => '-');
                n_t_sel_rb_addr <= '0';

            when ts_write_pattern_0a =>
                n_t_state <= ts_write_pattern_1b;
                n_t_idle <= '0';
                n_t_dl_go <= '0';
                n_t_pd_go <= '0';
                n_t_cmd <= DDRCMD_WRITE;
                n_t_addr <= "100";
                n_t_wr <= '1';
                n_t_done <= '0';
                n_t_timer <= (others => '-');
                n_t_sel_rb_addr <= '0';

            when ts_write_pattern_1 =>
                n_t_state <= ts_write_pattern_1b;
                n_t_idle <= '0';
                n_t_dl_go <= '0';
                n_t_pd_go <= '0';
                n_t_cmd <= DDRCMD_WRITE;
                n_t_addr <= "100";
                n_t_wr <= '1';
                n_t_done <= '0';
                n_t_timer <= (others => '-');
                n_t_sel_rb_addr <= '0';

            when ts_write_pattern_1b =>
                n_t_state <= ts_waiting;
                n_t_idle <= '0';
                n_t_dl_go <= '0';
                n_t_pd_go <= '0';
                n_t_cmd <= DDRCMD_NOP;
                n_t_addr <= "000";
                n_t_wr <= '0';
                n_t_done <= '0';
                n_t_timer <= (others => '0');
                n_t_sel_rb_addr <= '0';

            when ts_waiting =>
                if t_timer = t_wtp then
                    n_t_state <= ts_closing;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_PRE;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= (others => '0');
                    n_t_sel_rb_addr <= '0';
                else
                    n_t_state <= ts_waiting;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= t_timer + 1;
                    n_t_sel_rb_addr <= '0';
                end if;

            when ts_closing =>
                if t_timer = t_rp then
                    n_t_state <= ts_find_windows;
                    n_t_idle <= '0';
                    n_t_dl_go <= '1';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= (others => '-');
                    n_t_sel_rb_addr <= '1';
                else
                    n_t_state <= ts_closing;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= t_timer + 1;
                    n_t_sel_rb_addr <= '1';
                end if;

            when ts_find_windows =>
                if dl_done = '1' then
                    n_t_state <= ts_program_idelays;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '1';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= (others => '-');
                    n_t_sel_rb_addr <= '1';
                else
                    n_t_state <= ts_find_windows;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= (others => '-');
                    n_t_sel_rb_addr <= '1';
                end if;

            when ts_program_idelays =>
                if pd_done = '1' then
                    n_t_state <= ts_done;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= (others => '-');
                    n_t_sel_rb_addr <= '1';
                else
                    n_t_state <= ts_program_idelays;
                    n_t_idle <= '0';
                    n_t_dl_go <= '0';
                    n_t_pd_go <= '0';
                    n_t_cmd <= DDRCMD_NOP;
                    n_t_addr <= "000";
                    n_t_wr <= '0';
                    n_t_done <= '0';
                    n_t_timer <= (others => '-');
                    n_t_sel_rb_addr <= '1';
                end if;

            when ts_done =>
                n_t_state <= ts_idle;
                n_t_idle <= '1';
                n_t_dl_go <= '0';
                n_t_pd_go <= '0';
                n_t_cmd <= DDRCMD_NOP;
                n_t_addr <= "000";
                n_t_wr <= '0';
                n_t_done <= '1';
                n_t_timer <= (others => '-');
                n_t_sel_rb_addr <= '1';
        end case;
    end process;

    --
    -- QCE/QDELAY loop state machine
    --
    -- This state machine cycles through all 8 possible values of QCE and QDELAY,
    -- commanding the DQS tap loop state machine to perform a cycle for each QCE/QDELAY
    -- value.
    --

    gen_dl_found_window : process(
        tl_found_window,
        tl_window_size)
    begin
        for i in 0 to dq_width - 1 loop
            dl_found_window(i) <= tl_found_window(i) and not tl_window_size(i)(6);
        end loop;
    end process;

    best_windows : process(clk)
    begin
        if clk'event and clk = '1' then
            if t_dl_go = '1' then
                dl_ok <= (others => '0');
                dl_best_window <= (others => "000000");
            else
                for i in 0 to dq_width - 1 loop
                    if dl_found_window(i) = '1' then
                        dl_ok(i) <= '1';
                        if tl_window_size(i)(5 downto 0) > dl_best_window(i) then
                            dl_best_window(i) <= tl_window_size(i)(5 downto 0);
                        end if;
                    end if;
                end loop;
            end if;

            for i in 0 to dq_width - 1 loop
                if dl_found_window(i) = '1' then
                    if tl_window_size(i)(5 downto 0) > dl_best_window(i) then
                        dl_best_qce(i) <= dl_index(0);
                        dl_best_qdelay(i) <= dl_index(2 downto 1);
                        dl_best_tap(i) <= tl_window_mid(i)(6 downto 1);
                    end if;
                end if;
            end loop;

            dl_trained <= AND_reduce(dl_ok);
        end if;
    end process;

    gen_dl_state : process(rst, clk)
    begin
        if rst = '1' then
            dl_state <= dls_idle;
            dl_tl_go <= '0';
            dl_index <= (others => '-');
            dl_timer <= (others => '-');
            dl_rst_idelays <= '0';
            dl_done <= '0';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                dl_state <= dls_idle;
                dl_tl_go <= '0';
                dl_index <= (others => '-');
                dl_timer <= (others => '-');
                dl_rst_idelays <= '0';
                dl_done <= '0';
            else
                dl_state <= n_dl_state;
                dl_tl_go <= n_dl_tl_go;
                dl_index <= n_dl_index;
                dl_timer <= n_dl_timer;
                dl_rst_idelays <= n_dl_rst_idelays;
                dl_done <= n_dl_done;
            end if;
        end if;
    end process;

    gen_n_dl_state : process(
        dl_state,
        t_dl_go,
        tl_done,
        dl_index,
        dl_timer,
        dl_done)
    begin
        case dl_state is
            when dls_idle =>
                if t_dl_go = '1' then
                    n_dl_state <= dls_reset_idelays;
                    n_dl_index <= (others => '0');
                    n_dl_tl_go <= '0';
                    n_dl_timer <= (others => '0');
                    n_dl_rst_idelays <= '1';
                    n_dl_done <= '0';
                else
                    n_dl_state <= dls_idle;
                    n_dl_index <= (others => '-');
                    n_dl_tl_go <= '0';
                    n_dl_timer <= (others => '-');
                    n_dl_rst_idelays <= '0';
                    n_dl_done <= '0';
                end if;

            when dls_reset_idelays =>
                if AND_reduce(dl_timer) = '1' then
                    n_dl_state <= dls_waiting;
                    n_dl_index <= dl_index;
                    n_dl_tl_go <= '1';
                    n_dl_timer <= (others => '-');
                    n_dl_rst_idelays <= '0';
                    n_dl_done <= '0';
                else
                    n_dl_state <= dls_reset_idelays;
                    n_dl_index <= dl_index;
                    n_dl_tl_go <= '0';
                    n_dl_timer <= dl_timer + 1;
                    n_dl_rst_idelays <= '0';
                    n_dl_done <= '0';
                end if;

            when dls_waiting =>
                if tl_done = '1' then
                    if AND_reduce(dl_index) = '1' then
                        n_dl_state <= dls_done;
                        n_dl_index <= (others => '-');
                        n_dl_tl_go <= '0';
                        n_dl_timer <= (others => '-');
                        n_dl_rst_idelays <= '0';
                        n_dl_done <= '0';
                    else
                        n_dl_state <= dls_reset_idelays;
                        n_dl_index <= dl_index + 1;
                        n_dl_tl_go <= '0';
                        n_dl_timer <= (others => '0');
                        n_dl_rst_idelays <= '1';
                        n_dl_done <= '0';
                    end if;
                else
                    n_dl_state <= dls_waiting;
                    n_dl_index <= dl_index;
                    n_dl_tl_go <= '0';
                    n_dl_timer <= (others => '-');
                    n_dl_rst_idelays <= '0';
                    n_dl_done <= '0';
                end if;

            when dls_done =>
                n_dl_state <= dls_idle;
                n_dl_index <= (others => '-');
                n_dl_tl_go <= '0';
                n_dl_timer <= (others => '-');
                n_dl_rst_idelays <= '0';
                n_dl_done <= '1';
        end case;
    end process;

    --
    -- DQS tap loop state machine.
    --
    -- When this state machine is idle and 'dl_tl_go' is asserted, it commands the readback
    -- state machine to perform 64 readback cycles. On completion, it asserts 'tl_done'.
    --

    find_windows : process(clk)
        variable ok : std_logic;
    begin
        if clk'event and clk = '1' then
            if dl_tl_go = '1' then
                tl_ok <= (others => (others => '0'));
            else
                if rb_done = '1' then
                    tl_ok(0) <= rb_ok;
                    tl_ok(1 to num_consecutive_pass - 1) <= tl_ok(0 to num_consecutive_pass - 2);
                end if;
            end if;

            rb_done_q0 <= rb_done;
            rb_done_q1 <= rb_done_q0;

            for i in 0 to dq_width - 1 loop
                ok := '1';
                for j in 0 to num_consecutive_pass - 1 loop
                    ok := ok and tl_ok(j)(i);
                end loop;
                tl_ok_q(i) <= ok;
            end loop;

            if dl_tl_go = '1' then
                tl_in_window <= (others => '0');
            else
                if rb_done_q1 = '1' then
                    for i in 0 to dq_width - 1 loop
                        if tl_in_window(i) = '1' then
                            if tl_ok_q(i) = '0' then
                                tl_window_stop(i) <= "0" & tl_tap_index;
                            end if;
                        else
                            if tl_ok_q(i) = '1' then
                                tl_window_start(i) <= tl_tap_index;
                                tl_window_stop(i) <= "1000000";
                            end if;
                        end if;

                        tl_in_window(i) <= tl_ok_q(i) and not tl_tap_last;
                    end loop;
                end if;
            end if;

            for i in 0 to dq_width - 1 loop
                tl_calc_window(i) <= rb_done_q1 and
                                     ((tl_in_window(i) and not tl_ok_q(i)) or
                                      (tl_in_window(i) and tl_ok_q(i) and tl_tap_last) or
                                      (not tl_in_window(i) and tl_ok_q(i) and tl_tap_last));

                if tl_calc_window(i) = '1' then
                    tl_window_mid(i) <= EXT(tl_window_start(i), 7) + tl_window_stop(i) - (num_consecutive_pass - 1);
                    -- Note that bit 6 of tl_window_size(i) is 1 if arithmetic overflowed, and window must be considered invalid
                    tl_window_size(i) <= tl_window_stop(i) - EXT(tl_window_start(i), 7) - (num_consecutive_pass - 1);
                end if;

                tl_found_window(i) <= tl_calc_window(i);
            end loop;
        end if;
    end process;

    gen_tl_state : process(rst, clk)
    begin
        if rst = '1' then
            tl_state <= tls_idle;
            tl_rb_go <= '0';
            tl_tap_index <= (others => '-');
            tl_tap_last <= '-';
            tl_done <= '0';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                tl_state <= tls_idle;
                tl_rb_go <= '0';
                tl_tap_index <= (others => '-');
                tl_tap_last <= '-';
                tl_done <= '0';
            else
                tl_state <= n_tl_state;
                tl_rb_go <= n_tl_rb_go;
                tl_tap_index <= n_tl_tap_index;
                tl_tap_last <= n_tl_tap_last;
                tl_done <= n_tl_done;
            end if;
        end if;
    end process;

    gen_n_tl_state : process(
        tl_state,
        dl_tl_go,
        tl_tap_index,
        tl_tap_last,
        rb_done)
    begin
        case tl_state is
            when tls_idle =>
                if dl_tl_go = '1' then
                    n_tl_state <= tls_waiting;
                    n_tl_tap_index <= (others => '0');
                    n_tl_tap_last <= '0';
                    n_tl_rb_go <= '1';
                    n_tl_done <= '0';
                else
                    n_tl_state <= tls_idle;
                    n_tl_tap_index <= (others => '-');
                    n_tl_tap_last <= '-';
                    n_tl_rb_go <= '0';
                    n_tl_done <= '0';
                end if;

            when tls_waiting =>
                if rb_done = '1' then
                    n_tl_state <= tls_pause1;
                    n_tl_tap_index <= tl_tap_index;
                    n_tl_tap_last <= tl_tap_last;
                    n_tl_rb_go <= '0';
                    n_tl_done <= '0';
                else
                    n_tl_state <= tls_waiting;
                    n_tl_tap_index <= tl_tap_index;
                    n_tl_tap_last <= tl_tap_last;
                    n_tl_rb_go <= '0';
                    n_tl_done <= '0';
                end if;

            when tls_pause1 =>
                n_tl_state <= tls_pause2;
                n_tl_tap_index <= tl_tap_index;
                n_tl_tap_last <= tl_tap_last;
                n_tl_rb_go <= '0';
                n_tl_done <= '0';

            when tls_pause2 =>
                n_tl_state <= tls_compare;
                n_tl_tap_index <= tl_tap_index;
                n_tl_tap_last <= tl_tap_last;
                n_tl_rb_go <= '0';
                n_tl_done <= '0';

            when tls_compare =>
                if tl_tap_last = '1' then
                    n_tl_state <= tls_done;
                    n_tl_tap_index <= (others => '-');
                    n_tl_tap_last <= '-';
                    n_tl_rb_go <= '0';
                    n_tl_done <= '0';
                else
                    n_tl_state <= tls_waiting;
                    n_tl_tap_index <= tl_tap_index + 1;
                    n_tl_tap_last <= AND_reduce(tl_tap_index(5 downto 1));
                    n_tl_rb_go <= '1';
                    n_tl_done <= '0';
                end if;

            when tls_done =>
                n_tl_state <= tls_idle;
                n_tl_tap_index <= (others => '-');
                n_tl_tap_last <= '-';
                n_tl_rb_go <= '0';
                n_tl_done <= '1';
        end case;
    end process;

    --
    -- Readback state machine
    --
    -- When the machine is idle and 'rb_go' is asserted:
    --
    --   1. Issues an ACT command to DDR-II SDRAM, and waits the appropriate number of cycles.
    --   2. Issues 8 back-to-back reads to the DDR-II SDRAM, and waits for 8 'valid' pulses.
    --   3. Waits for the appropriate number of cycles to prevent t_rtp being violated.
    --   4. Issues a PRE command to the DDR-II SDRAM, and waits the appropriate number of
    --      cycles.
    --   5. Issues a REF command to the DDR-II SDRAM, and waits the appropriate number of
    --      cycles.
    --   6. Asserts 'rb_done'.
    --

    gen_rb_match : process(dq_i, rb_match_addr)
        variable exp_dq : std_logic_vector(4 * dq_width - 1 downto 0);
    begin
        if rb_match_addr = '0' then
            exp_dq(1 * dq_width - 1 downto 0 * dq_width) := (others => '1');
            exp_dq(2 * dq_width - 1 downto 1 * dq_width) := (others => '0');
            exp_dq(3 * dq_width - 1 downto 2 * dq_width) := (others => '1');
            exp_dq(4 * dq_width - 1 downto 3 * dq_width) := (others => '0');
        else
            exp_dq(1 * dq_width - 1 downto 0 * dq_width) := (others => '0');
            exp_dq(2 * dq_width - 1 downto 1 * dq_width) := (others => '1');
            exp_dq(3 * dq_width - 1 downto 2 * dq_width) := (others => '1');
            exp_dq(4 * dq_width - 1 downto 3 * dq_width) := (others => '0');
        end if;

        for i in 0 to 3 loop
            for j in 0 to dq_width - 1 loop
                if (dq_i(dq_width * i + j) xnor exp_dq(dq_width * i + j)) = '1' then
                    rb_match(dq_width * i + j) <= '1';
                else
                    rb_match(dq_width * i + j) <= '0';
                end if;
            end loop;
        end loop;
    end process;

    gen_rb_match4 : process(clk)
        variable exp_dq : std_logic_vector(4 * dq_width - 1 downto 0);
    begin
        if clk'event and clk = '1' then
            if valid = '1' then
                for j in 0 to dq_width - 1 loop
                    rb_match4(j) <= rb_match(dq_width * 0 + j) and rb_match(dq_width * 1 + j) and
                                    rb_match(dq_width * 2 + j) and rb_match(dq_width * 3 + j);
                end loop;
            end if;
            rb_match_valid <= valid;

            if tl_rb_go = '1' then
                rb_ok <= (others => '1');
            else
                if rb_match_valid = '1' then
                    rb_ok <= rb_ok and rb_match4;
                end if;
            end if;
        end if;
    end process;

    gen_rb_state : process(rst, clk)
    begin
        if rst = '1' then
            rb_state <= rbs_idle;
            rb_cmd <= DDRCMD_X;
            rb_addr <= (others => '-');
            rb_rd <= '0';
            rb_timer <= (others => '-');
            rb_num_cmd <= (others => '-');
            rb_num_valid <= (others => '-');
            rb_match_addr <= '-';
            rb_inc_idelay <= '0';
            rb_ref_done <= '0';
            rb_done <= '-';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                rb_state <= rbs_idle;
                rb_cmd <= DDRCMD_X;
                rb_addr <= (others => '-');
                rb_rd <= '0';
                rb_timer <= (others => '-');
                rb_num_cmd <= (others => '-');
                rb_num_valid <= (others => '-');
                rb_match_addr <= '-';
                rb_inc_idelay <= '0';
                rb_ref_done <= '0';
                rb_done <= '0';
            else
                rb_state <= n_rb_state;
                rb_cmd <= n_rb_cmd;
                rb_addr <= n_rb_addr;
                rb_rd <= n_rb_rd;
                rb_timer <= n_rb_timer;
                rb_num_cmd <= n_rb_num_cmd;
                rb_num_valid <= n_rb_num_valid;
                rb_match_addr <= n_rb_match_addr;
                rb_inc_idelay <= n_rb_inc_idelay;
                rb_ref_done <= n_rb_ref_done;
                rb_done <= n_rb_done;
            end if;
        end if;
    end process;

    gen_n_rb_state : process(
        rb_state,
        tl_rb_go,
        rb_addr,
        rb_num_cmd,
        rb_num_valid,
        rb_match_addr,
        rb_timer,
        ref_req,
        valid)
    begin
        case rb_state is
            when rbs_idle =>
                if tl_rb_go = '1' then
                    n_rb_state <= rbs_opening;
                    n_rb_cmd <= DDRCMD_ACT;
                    n_rb_addr <= (others => '0');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '-');
                    n_rb_match_addr <= '-';
                    n_rb_timer <= (others => '0');
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                else
                    n_rb_state <= rbs_idle;
                    n_rb_cmd <= DDRCMD_NOP;
                    n_rb_addr <= (others => '-');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '-');
                    n_rb_match_addr <= '-';
                    n_rb_timer <= (others => '-');
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                end if;

            when rbs_opening =>
                if rb_timer = t_act then
                    n_rb_state <= rbs_reading;
                    n_rb_cmd <= DDRCMD_READ;
                    n_rb_addr <= (others => '0');
                    n_rb_rd <= '1';
                    n_rb_num_cmd <= (others => '0');
                    n_rb_num_valid <= (others => '0');
                    n_rb_match_addr <= '0';
                    n_rb_timer <= (others => '-');
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                else
                    n_rb_state <= rbs_opening;
                    n_rb_cmd <= DDRCMD_NOP;
                    n_rb_addr <= (others => '-');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '-');
                    n_rb_match_addr <= '-';
                    n_rb_timer <= rb_timer + 1;
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                end if;

            when rbs_reading =>
                if rb_num_cmd = 7 then
                    n_rb_state <= rbs_wait_8valid;
                    n_rb_cmd <= DDRCMD_NOP;
                    n_rb_addr <= (others => '-');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '0');
                    n_rb_timer <= (others => '-');
                    if valid = '1' then
                        n_rb_num_valid <= rb_num_valid + 1;
                        n_rb_match_addr <= not rb_match_addr;
                    else
                        n_rb_num_valid <= rb_num_valid;
                        n_rb_match_addr <= rb_match_addr;
                    end if;
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                else
                    n_rb_state <= rbs_reading;
                    n_rb_cmd <= DDRCMD_READ;
                    n_rb_addr <= not rb_addr(2) & rb_addr(1 downto 0);
                    n_rb_rd <= '1';
                    n_rb_num_cmd <= rb_num_cmd + 1;
                    n_rb_timer <= (others => '-');
                    if valid = '1' then
                        n_rb_num_valid <= rb_num_valid + 1;
                        n_rb_match_addr <= not rb_match_addr;
                    else
                        n_rb_num_valid <= rb_num_valid;
                        n_rb_match_addr <= rb_match_addr;
                    end if;
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                end if;

            when rbs_wait_8valid =>
                if valid = '1' then
                    if rb_num_valid = 7 then
                        n_rb_state <= rbs_wait_rtp;
                        n_rb_cmd <= DDRCMD_NOP;
                        n_rb_addr <= (others => '-');
                        n_rb_rd <= '0';
                        n_rb_num_cmd <= (others => '-');
                        n_rb_num_valid <= (others => '-');
                        n_rb_match_addr <= '-';
                        n_rb_timer <= (others => '0');
                        n_rb_inc_idelay <= '1';
                        n_rb_ref_done <= '0';
                        n_rb_done <= '0';
                    else
                        n_rb_state <= rbs_wait_8valid;
                        n_rb_cmd <= DDRCMD_NOP;
                        n_rb_addr <= (others => '-');
                        n_rb_rd <= '0';
                        n_rb_num_cmd <= (others => '-');
                        n_rb_num_valid <= rb_num_valid + 1;
                        n_rb_match_addr <= not rb_match_addr;
                        n_rb_timer <= (others => '-');
                        n_rb_inc_idelay <= '0';
                        n_rb_ref_done <= '0';
                        n_rb_done <= '0';
                    end if;
                else
                    n_rb_state <= rbs_wait_8valid;
                    n_rb_cmd <= DDRCMD_NOP;
                    n_rb_addr <= (others => '-');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= rb_num_valid;
                    n_rb_match_addr <= rb_match_addr;
                    n_rb_timer <= (others => '-');
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                end if;

            when rbs_wait_rtp =>
                if rb_timer = t_rtp then
                    n_rb_state <= rbs_closing;
                    n_rb_cmd <= DDRCMD_PRE;
                    n_rb_addr <= (others => '0');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '-');
                    n_rb_match_addr <= '-';
                    n_rb_timer <= (others => '0');
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                else
                    n_rb_state <= rbs_wait_rtp;
                    n_rb_cmd <= DDRCMD_NOP;
                    n_rb_addr <= (others => '-');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '-');
                    n_rb_match_addr <= '-';
                    n_rb_timer <= rb_timer + 1;
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                end if;

            when rbs_closing =>
                if rb_timer = t_rp then
                    if ref_req = '1' then
                        n_rb_state <= rbs_refreshing;
                        n_rb_cmd <= DDRCMD_REF;
                        n_rb_addr <= (others => '-');
                        n_rb_rd <= '0';
                        n_rb_num_cmd <= (others => '-');
                        n_rb_num_valid <= (others => '-');
                        n_rb_match_addr <= '-';
                        n_rb_timer <= (others => '0');
                        n_rb_inc_idelay <= '0';
                        n_rb_ref_done <= '1';
                        n_rb_done <= '0';
                    else
                        n_rb_state <= rbs_done;
                        n_rb_cmd <= DDRCMD_NOP;
                        n_rb_addr <= (others => '-');
                        n_rb_rd <= '0';
                        n_rb_num_cmd <= (others => '-');
                        n_rb_num_valid <= (others => '-');
                        n_rb_match_addr <= '-';
                        n_rb_timer <= (others => '-');
                        n_rb_inc_idelay <= '0';
                        n_rb_ref_done <= '0';
                        n_rb_done <= '0';
                    end if;
                else
                    n_rb_state <= rbs_closing;
                    n_rb_cmd <= DDRCMD_NOP;
                    n_rb_addr <= (others => '-');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '-');
                    n_rb_match_addr <= '-';
                    n_rb_timer <= rb_timer + 1;
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                end if;

            when rbs_refreshing =>
                if rb_timer = t_rfc then
                    n_rb_state <= rbs_done;
                    n_rb_cmd <= DDRCMD_NOP;
                    n_rb_addr <= (others => '-');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '-');
                    n_rb_match_addr <= '-';
                    n_rb_timer <= (others => '-');
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                else
                    n_rb_state <= rbs_refreshing;
                    n_rb_cmd <= DDRCMD_NOP;
                    n_rb_addr <= (others => '-');
                    n_rb_rd <= '0';
                    n_rb_num_cmd <= (others => '-');
                    n_rb_num_valid <= (others => '-');
                    n_rb_match_addr <= '-';
                    n_rb_timer <= rb_timer + 1;
                    n_rb_inc_idelay <= '0';
                    n_rb_ref_done <= '0';
                    n_rb_done <= '0';
                end if;

            when rbs_done =>
                n_rb_state <= rbs_idle;
                n_rb_cmd <= DDRCMD_NOP;
                n_rb_addr <= (others => '-');
                n_rb_rd <= '0';
                n_rb_num_cmd <= (others => '-');
                n_rb_num_valid <= (others => '-');
                n_rb_match_addr <= '-';
                n_rb_timer <= (others => '-');
                n_rb_inc_idelay <= '0';
                n_rb_ref_done <= '0';
                n_rb_done <= '1';
        end case;
    end process;

    --
    -- IDELAY programming state machine
    --
    -- At the end of training, the IDELAYs are programmed according to the values of
    -- 'best_tap'.
    --

    gen_pd_inc_idelay : process(clk)
    begin
        if clk'event and clk = '1' then
            if t_pd_go = '1' then
                pd_tap_idx <= (others => '0');
            else
                if pd_inc_idelays = '1' then
                    pd_tap_idx <= pd_tap_idx + 1;
                end if;
            end if;

            for i in 0 to dq_width - 1 loop
                if pd_tap_idx < dl_best_tap(i) then
                    pd_inc_idelay(i) <= '1';
                else
                    pd_inc_idelay(i) <= '0';
                end if;
            end loop;

            pd_inc_idelays_q <= pd_inc_idelays;
        end if;
    end process;

    gen_pd_state : process(rst, clk)
    begin
        if rst = '1' then
            pd_state <= pds_idle;
            pd_timer <= (others => '-');
            pd_inc_idelays <= '0';
            pd_rst_idelays <= '0';
            pd_done <= '-';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                pd_state <= pds_idle;
                pd_timer <= (others => '-');
                pd_inc_idelays <= '0';
                pd_rst_idelays <= '0';
                pd_done <= '-';
            else
                pd_state <= n_pd_state;
                pd_timer <= n_pd_timer;
                pd_inc_idelays <= n_pd_inc_idelays;
                pd_rst_idelays <= n_pd_rst_idelays;
                pd_done <= n_pd_done;
            end if;
        end if;
    end process;

    gen_n_pd_state : process(
        pd_state,
        pd_timer,
        t_pd_go,
        pd_tap_idx)
    begin
        case pd_state is
            when pds_idle =>
                if t_pd_go = '1' then
                    n_pd_state <= pds_rst_idelays;
                    n_pd_timer <= (others => '0');
                    n_pd_inc_idelays <= '0';
                    n_pd_rst_idelays <= '1';
                    n_pd_done <= '0';
                else
                    n_pd_state <= pds_idle;
                    n_pd_timer <= (others => '-');
                    n_pd_inc_idelays <= '0';
                    n_pd_rst_idelays <= '0';
                    n_pd_done <= '0';
                end if;

            when pds_rst_idelays =>
                if AND_reduce(pd_timer) = '1' then
                    n_pd_state <= pds_wait1;
                    n_pd_timer <= (others => '0');
                    n_pd_inc_idelays <= '0';
                    n_pd_rst_idelays <= '0';
                    n_pd_done <= '0';
                else
                    n_pd_state <= pds_rst_idelays;
                    n_pd_timer <= pd_timer + 1;
                    n_pd_inc_idelays <= '0';
                    n_pd_rst_idelays <= '0';
                    n_pd_done <= '0';
                end if;

            when pds_wait1 =>
                if AND_reduce(pd_timer) = '1' then
                    n_pd_state <= pds_programming;
                    n_pd_timer <= (others => '-');
                    n_pd_inc_idelays <= '0';
                    n_pd_rst_idelays <= '0';
                    n_pd_done <= '0';
                else
                    n_pd_state <= pds_wait1;
                    n_pd_timer <= pd_timer + 1;
                    n_pd_inc_idelays <= '0';
                    n_pd_rst_idelays <= '0';
                    n_pd_done <= '0';
                end if;

            when pds_programming =>
                if AND_reduce(pd_tap_idx) = '1' then
                    n_pd_state <= pds_done;
                    n_pd_timer <= (others => '-');
                    n_pd_inc_idelays <= '0';
                    n_pd_rst_idelays <= '0';
                    n_pd_done <= '0';
                else
                    n_pd_state <= pds_wait2;
                    n_pd_timer <= (others => '-');
                    n_pd_inc_idelays <= '1';
                    n_pd_rst_idelays <= '0';
                    n_pd_done <= '0';
                end if;

            when pds_wait2 =>
                n_pd_state <= pds_programming;
                n_pd_timer <= (others => '-');
                n_pd_inc_idelays <= '0';
                n_pd_rst_idelays <= '0';
                n_pd_done <= '0';

            when pds_done =>
                n_pd_state <= pds_idle;
                n_pd_timer <= (others => '-');
                n_pd_inc_idelays <= '0';
                n_pd_rst_idelays <= '0';
                n_pd_done <= '1';
        end case;
    end process;

--    trig0(0) <= t_idle;
--    trig0(1) <= t_dl_go;
--    trig0(2) <= t_pd_go;
--    trig0(7 downto 3) <= t_cmd;
--    trig0(10 downto 8) <= t_addr;
--    trig0(11) <= t_wr;
--    trig0(12) <= t_done;
--    trig0(17 downto 13) <= t_timer;
--    trig0(18) <= t_sel_rb_addr;
--    trig0(19) <= dl_tl_go;
--    trig0(22 downto 20) <= dl_index;
--    trig0(26 downto 23) <= dl_timer;
--    trig0(27) <= dl_rst_idelays;
--    trig0(28) <= dl_done;
--    trig0(29) <= tl_rb_go;
--    trig0(35 downto 30) <= tl_tap_index;
--    trig0(36) <= tl_done;
--    trig0(41 downto 37) <= rb_timer;
--    trig0(42) <= rb_inc_idelay;
--    trig0(47 downto 43) <= rb_cmd;
--    trig0(50 downto 48) <= rb_addr;
--    trig0(51) <= rb_rd;
--    trig0(54 downto 52) <= rb_num_cmd;
--    trig0(57 downto 55) <= rb_num_valid;
--    trig0(58) <= rb_match_addr;
--    trig0(59) <= rb_done;
--    trig0(63 downto 60) <= pd_timer;
--    trig0(69 downto 64) <= pd_tap_idx;
--    trig0(70) <= pd_inc_idelays;
--    trig0(71) <= pd_rst_idelays;
--    trig0(72) <= pd_done;
--    trig0(73) <= go;
--    trig0(74) <= sr;
--    trig0(75) <= rst;
--    trig0(76) <= valid;
--    trig0(77) <= dl_trained;
--    trig0(78) <= rb_match_valid;
--    trig0(79 downto 79) <= (others => '0');
--    trig0(85 downto 80) <= tl_window_start(0 + probe_index);
--    trig0(91 downto 86) <= tl_window_start(1 + probe_index);
--    trig0(97 downto 92) <= tl_window_start(2 + probe_index);
--    trig0(103 downto 98) <= tl_window_start(3 + probe_index);
--    trig0(110 downto 104) <= tl_window_stop(0 + probe_index)(6 downto 0);
--    trig0(117 downto 111) <= tl_window_stop(1 + probe_index)(6 downto 0);
--    trig0(124 downto 118) <= tl_window_stop(2 + probe_index)(6 downto 0);
--    trig0(131 downto 125) <= tl_window_stop(3 + probe_index)(6 downto 0);
--    trig0(135 downto 132) <= pd_inc_idelay(3 + probe_index downto 0 + probe_index);
--    trig0(139 downto 136) <= dl_found_window(3 + probe_index downto 0 + probe_index);
--    trig0(143 downto 140) <= dl_best_qce(3 + probe_index downto 0 + probe_index);
--    trig0(145 downto 144) <= dl_best_qdelay(0 + probe_index);
--    trig0(147 downto 146) <= dl_best_qdelay(1 + probe_index);
--    trig0(149 downto 148) <= dl_best_qdelay(2 + probe_index);
--    trig0(151 downto 150) <= dl_best_qdelay(3 + probe_index);
--    trig0(155 downto 152) <= rb_ok(3 + probe_index downto 0 + probe_index);
--    trig0(161 downto 156) <= dl_best_tap(0 + probe_index);
--    trig0(167 downto 162) <= dl_best_tap(1 + probe_index);
--    trig0(173 downto 168) <= dl_best_tap(2 + probe_index);
--    trig0(179 downto 174) <= dl_best_tap(3 + probe_index);
--    trig0(185 downto 180) <= dl_best_window(0 + probe_index);
--    trig0(191 downto 186) <= dl_best_window(1 + probe_index);
--    trig0(197 downto 192) <= dl_best_window(2 + probe_index);
--    trig0(203 downto 198) <= dl_best_window(3 + probe_index);
--    trig0(207 downto 204) <= tl_in_window(3 + probe_index downto 0 + probe_index);
--    trig0(211 downto 208) <= tl_found_window(3 + probe_index downto 0 + probe_index);
--    trig0(215 downto 212) <= rb_match4(3 + probe_index downto 0 + probe_index);
--    trig0(222 downto 216) <= (others => '0');
--    trig0(226 downto 223) <= dq_i(3 + 0 * dq_width downto 0 * dq_width);
--    trig0(230 downto 227) <= dq_i(3 + 1 * dq_width downto 1 * dq_width);
--    trig0(234 downto 231) <= dq_i(3 + 2 * dq_width downto 2 * dq_width);
--    trig0(238 downto 235) <= dq_i(3 + 3 * dq_width downto 3 * dq_width);
--    trig0(254 downto 239) <= dl_ok(15 downto 0);

--    ila0 : ilacombo
--        generic map(
--            dummy => true)
--        port map(
--            clk => clk,
--            trig0 => trig0,
--            trig_out => trig_out);

end mixed;
