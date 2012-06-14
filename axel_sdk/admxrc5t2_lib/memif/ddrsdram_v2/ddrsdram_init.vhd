--
-- ddrsdram_init.vhd - DDR SDRAM memory interface, initialization state machine
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

entity ddrsdram_init is
    generic(
        dq_width        : in    natural;
        rowcol_width    : in    natural;
        bank_width      : in    natural;
        cas_latency     : in    natural;
        t_refresh       : in    natural;
        t_mrd           : in    natural;
        t_dllr          : in    natural;
        t_act           : in    natural;
        t_rp            : in    natural;
        t_rfc           : in    natural;
        t_rtp           : in    natural;
        t_wtp           : in    natural);
    port(
        clk             : in    std_logic;
        sr              : in    std_logic;
        ref_done        : in    std_logic;
        dq_i            : in    std_logic_vector(2 * dq_width - 1 downto 0);
        valid           : in    std_logic;
        tstdo           : in    std_logic;
        tstcomp         : in    std_logic;
        ref_req         : out   std_logic;
        cke             : out   std_logic;
        done            : out   std_logic;
        command         : out   std_logic_vector(4 downto 0);
        addr            : out   std_logic_vector(rowcol_width + bank_width - 1 downto 0);
        dq_o            : out   std_logic_vector(2 * dq_width - 1 downto 0);
        rd              : out   std_logic;
        wr              : out   std_logic;
        tstdone         : out   std_logic;
        tstok           : out   std_logic);
end;

architecture mixed of ddrsdram_init is

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

    -- Order (4 downto 0) is (all, cs#, ras#, cas#, we#)
    constant DDRCMD_NOP    : std_logic_vector(4 downto 0) := "-1111"; -- Deselect
    constant DDRCMD_ACT    : std_logic_vector(4 downto 0) := "00011"; -- Activate          (one physical bank)
    constant DDRCMD_PRE    : std_logic_vector(4 downto 0) := "10010"; -- Precharge         (all physical banks)
    constant DDRCMD_PRE_1B : std_logic_vector(4 downto 0) := "00010"; -- Precharge         (one physical bank)
    constant DDRCMD_READ   : std_logic_vector(4 downto 0) := "00101"; -- Read              (one physical bank)
    constant DDRCMD_WRITE  : std_logic_vector(4 downto 0) := "00100"; -- Write             (one physical bank)
    constant DDRCMD_REF    : std_logic_vector(4 downto 0) := "10001"; -- Refresh           (all physical banks)
    constant DDRCMD_MRS    : std_logic_vector(4 downto 0) := "10000"; -- Set mode register (all physical banks)

    -- Number of cycles to wait after enabling clock to DDR SDRAM
    constant t_cke : natural := 5;

    signal modereg_val : std_logic_vector(6 downto 0);

    --
    -- Results in delay of approx. 0.25s @ 133MHz SDRAM clock for synthesis
    -- and a delay of approx 7.5us @ 133MHz SDRAM clock for simulation
    --
    constant pwr_on_timer_width : natural := choice(25, 10, memif_simulation);
    signal pwr_on_timer : std_logic_vector(pwr_on_timer_width - 1 downto 0);
    signal pwr_on_done : std_logic;

    type state1_t is (
        s1_power_on,
        s1_deselect,
        s1_precharge_all1,
        s1_emodereg,
        s1_modereg1,
        s1_precharge_all2,
        s1_refresh1,
        s1_refresh2,
        s1_modereg2,
        s1_training,
        s1_done);
    signal state1, n_state1 : state1_t;
    signal init_addr, n_init_addr : std_logic_vector(14 downto 0);
    signal i_cke, n_cke : std_logic;
    signal init_cmd, n_init_cmd : std_logic_vector(4 downto 0);
    signal i_done, n_done : std_logic;
    signal en_refresh, n_en_refresh : std_logic;
    signal timer1, n_timer1 : std_logic_vector(9 downto 0);
    signal trn_do, n_trn_do : std_logic;

    signal refresh_timer : std_logic_vector(15 downto 0);

    type state2_t is (
        s2_idle,
        s2_request);
    signal state2, n_state2 : state2_t;
    signal i_ref_req, n_ref_req : std_logic;

    signal num_valid : std_logic_vector(3 downto 0);
    signal match : std_logic;
    signal valid_q : std_logic;

    type state3_t is (
        s3_idle,
        s3_write_opening,
        s3_write_pattern,
        s3_write_delay,
        s3_write_closing,
        s3_wait_event,
        s3_refresh,
        s3_read_opening,
        s3_reading,
        s3_read_delay,
        s3_read_closing,
        s3_wait_valid,
        s3_checking,
        s3_wait_tstdo,
        s3_finished);
    signal state3, n_state3 : state3_t;
    signal num_read, n_num_read : std_logic_vector(2 downto 0);
    signal patt_addr, n_patt_addr : std_logic_vector(2 downto 1);
    signal sr_num_valid, n_sr_num_valid : std_logic;
    signal timer3, n_timer3 : std_logic_vector(4 downto 0);
    signal trn_cmd, n_trn_cmd : std_logic_vector(4 downto 0);
    signal trn_done, n_trn_done : std_logic;
    signal trn_rd, n_trn_rd : std_logic;
    signal trn_ref_done, n_trn_ref_done : std_logic;
    signal trn_wr, n_trn_wr : std_logic;
    signal i_tstdone, n_tstdone : std_logic;

    signal logic0, logic1 : std_logic;

begin

    -- synopsys translate_off
    assert t_dllr <= 1000
        report "*** ddrsdram_init: illegal value " & conv_string(t_dllr) & " for t_dllr : more than 1000"
        severity failure;

    assert t_rp >= 1
        report "*** ddrsdram_init: illegal value " & conv_string(t_rp) & " for t_rp : less than 1"
        severity failure;

    assert t_rp <= t_rfc
        report "*** ddrsdram_init: illegal value " & conv_string(t_rp) & " for t_rp : more than t_rfc (" & conv_string(t_rfc) & ")"
        severity failure;

    assert t_rfc >= 1
        report "*** ddrsdram_init: illegal value " & conv_string(t_rfc) & " for t_rfc : less than 1"
        severity failure;

    assert t_rfc <= 31
        report "*** ddrsdram_init: illegal value " & conv_string(t_rfc) & " for t_rfc : more than 31"
        severity failure;
    -- synopsys translate_on

    logic0 <= '0';
    logic1 <= '1';

    ref_req <= i_ref_req;

    modereg_val(2 downto 0) <= "001"; -- Burst length 2
    modereg_val(3) <= '0'; -- Sequential ordering
    modereg_val(6 downto 4) <= "101" when cas_latency = 3 else  -- CL1.5
                               "010" when cas_latency = 4 else  -- CL2
                               "110" when cas_latency = 5 else  -- CL2.5
                               "011" when cas_latency = 6 else  -- CL3
                               "111" when cas_latency = 7 else  -- CL3.5
                               "100" when cas_latency = 8 else  -- CL4
                               "---";

    gen_outputs : process(clk)
    begin
        if clk'event and clk = '1' then
            if state1 = s1_training then
                addr <= EXT(patt_addr & "0", bank_width + rowcol_width);
                command <= trn_cmd;
            else
                addr <= EXT(init_addr(14 downto 13), bank_width) & EXT(init_addr(12 downto 0), rowcol_width);
                command <= init_cmd;
            end if;
            cke <= i_cke;
            done <= i_done;
            wr <= trn_wr;
            rd <= trn_rd;
            case patt_addr is
                when "00" =>
                    dq_o(1 * dq_width - 1 downto 0 * dq_width) <= (others => '1');
                    dq_o(2 * dq_width - 1 downto 1 * dq_width) <= (others => '0');
                when "01" =>
                    dq_o(1 * dq_width - 1 downto 0 * dq_width) <= (others => '1');
                    dq_o(2 * dq_width - 1 downto 1 * dq_width) <= (others => '0');
                when "10" =>
                    dq_o(1 * dq_width - 1 downto 0 * dq_width) <= (others => '0');
                    dq_o(2 * dq_width - 1 downto 1 * dq_width) <= (others => '1');
                when "11" =>
                    dq_o(1 * dq_width - 1 downto 0 * dq_width) <= (others => '1');
                    dq_o(2 * dq_width - 1 downto 1 * dq_width) <= (others => '0');
                when others =>
                    dq_o <= (others => '-');
            end case;
        end if;
    end process;

    --
    -- DDR SDRAM controller refresh state machine
    --

    gen_refresh_timer : process(clk)
    begin
        if clk'event and clk = '1' then
            if en_refresh = '1' then
                if refresh_timer = t_refresh - 1 then
                    refresh_timer <= (others => '0');
                else
                    refresh_timer <= refresh_timer + 1;
                end if;
            else
                refresh_timer <= (others => '0');
            end if;
        end if;
    end process;

    gen_state2 : process(clk)
    begin
        if clk'event and clk = '1' then
            if sr = '1' then
                state2 <= s2_idle;
                i_ref_req <= '0';
            else
                state2 <= n_state2;
                i_ref_req <= n_ref_req;
            end if;
        end if;
    end process;

    gen_n_state2 : process(
        state2,
        refresh_timer,
        ref_done,
        trn_ref_done)
    begin
        case state2 is
            when s2_idle =>
                if refresh_timer = t_refresh - 1 then
                    n_state2 <= s2_request;
                    n_ref_req <= '1';
                else
                    n_state2 <= s2_idle;
                    n_ref_req <= '0';
                end if;

            when s2_request =>
                if ref_done = '1' or trn_ref_done = '1' then
                    n_state2 <= s2_idle;
                    n_ref_req <= '0';
                else
                    n_state2 <= s2_request;
                    n_ref_req <= '1';
                end if;
        end case;
    end process;

    --
    -- Timer for timing the delay following reset/power-on
    --
    gen_pwr_on_timer : process(clk)
    begin
        if clk'event and clk = '1' then
            if sr = '1' then
                pwr_on_timer <= (others => '0');
                pwr_on_done <= '0';
            else
                if pwr_on_done = '0' then
                    pwr_on_timer <= pwr_on_timer + 1;
                end if;

                if AND_reduce(pwr_on_timer) = '1' then
                    pwr_on_done <= '1';
                end if;
            end if;
        end if;
    end process;

    --
    -- DDR SDRAM initilization sequence state machine
    --

    gen_state1 : process(clk)
    begin
        if clk'event and clk = '1' then
            if sr = '1' then
                state1 <= s1_power_on;
                init_addr <= (others => '0');
                i_cke <= '0';
                init_cmd <= (others => '1');
                i_done <= '0';
                en_refresh <= '0';
                timer1 <= (others => '0');
                trn_do <= '0';
            else
                state1 <= n_state1;
                init_addr <= n_init_addr;
                i_cke <= n_cke;
                init_cmd <= n_init_cmd;
                i_done <= n_done;
                en_refresh <= n_en_refresh;
                timer1 <= n_timer1;
                trn_do <= n_trn_do;
            end if;
        end if;
    end process;

    gen_n_state1 : process(
        state1,
        modereg_val,
        pwr_on_done,
        trn_done,
        timer1)
    begin
        case state1 is
            when s1_power_on =>
                if pwr_on_done = '1' then
                    n_state1 <= s1_deselect;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= (others => '0');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_power_on;
                    n_init_addr <= (others => '-');
                    n_cke <= '0';
                    n_init_cmd <= (others => '1');
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= (others => '-');
                    n_trn_do <= '0';
                end if;

            when s1_deselect =>
                if timer1(2 downto 0) = t_cke then
                    -- Execute a 'precharge all' command
                    n_state1 <= s1_precharge_all1;
                    n_init_addr <= (10 => '1', others => '0');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_PRE;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= (others => '0');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_deselect;
                    n_cke <= '1';
                    n_init_addr <= (others => '-');
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= timer1 + 1;
                    n_trn_do <= '0';
                end if;

            when s1_precharge_all1 =>
                if timer1 = t_rp then
                    -- Establish extended mode register
                    n_state1 <= s1_emodereg;
                    n_init_addr <= "010000000000000";
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= (others => '0');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_precharge_all1;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= timer1 + 1;
                    n_trn_do <= '0';
                end if;

            when s1_emodereg =>
                if timer1 = t_mrd then
                    -- Establish mode register and reset DLL
                    n_state1 <= s1_modereg1;
                    n_init_addr <= "00000010" & modereg_val;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= (others => '0');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_emodereg;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= timer1 + 1;
                    n_trn_do <= '0';
                end if;

            when s1_modereg1 =>
                if timer1 = t_mrd then
                    -- Execute second 'precharge all' command
                    n_state1 <= s1_precharge_all2;
                    n_init_addr <= (10 => '1', others => '0');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_PRE;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= (others => '0');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_modereg1;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= timer1 + 1;
                    n_trn_do <= '0';
                end if;

            when s1_precharge_all2 =>
                if timer1 = t_rp then
                    -- Execute first refresh cycle
                    n_state1 <= s1_refresh1;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_REF;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= (others => '0');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_precharge_all2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= timer1 + 1;
                    n_trn_do <= '0';
                end if;

            when s1_refresh1 =>
                if timer1 = t_rfc then
                    -- Execute second refresh cycle
                    n_state1 <= s1_refresh2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_REF;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= (others => '0');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_refresh1;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= timer1 + 1;
                    n_trn_do <= '0';
                end if;

            when s1_refresh2 =>
                if timer1 = t_rfc then
                    -- Reprogram mode register without resetting DLL
                    n_state1 <= s1_modereg2;
                    n_init_addr <= "00000000" & modereg_val;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_done <= '0';
                    n_en_refresh <= '1';
                    n_timer1 <= (others => '0');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_refresh2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '0';
                    n_timer1 <= timer1 + 1;
                    n_trn_do <= '0';
                end if;

            when s1_modereg2 =>
                if timer1 = t_dllr then
                    n_state1 <= s1_training;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '1';
                    n_timer1 <= (others => '-');
                    n_trn_do <= '1';
                else
                    n_state1 <= s1_modereg2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '1';
                    n_timer1 <= timer1 + 1;
                    n_trn_do <= '0';
                end if;

            when s1_training =>
                if trn_done = '1' then
                    n_state1 <= s1_done;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '1';
                    n_en_refresh <= '1';
                    n_timer1 <= (others => '-');
                    n_trn_do <= '0';
                else
                    n_state1 <= s1_training;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_done <= '0';
                    n_en_refresh <= '1';
                    n_timer1 <= (others => '-');
                    n_trn_do <= '0';
                end if;

            when s1_done =>
                -- Stay in this state for ever
                n_state1 <= s1_done;
                n_init_addr <= (others => '-');
                n_cke <= '1';
                n_init_cmd <= DDRCMD_NOP;
                n_done <= '1';
                n_en_refresh <= '1';
                n_timer1 <= (others => '-');
                n_trn_do <= '0';
        end case;
    end process;

    --
    -- DDR SDRAM training state machine
    --
    -- This state machine waits for the initialization state machine above to
    -- signal 'init_done', and then writes a pattern of 4 words (8 DDR words)
    -- to the first 4 logical locations in the memory. It then waits for
    -- 3 kinds of event (in order of highest to lowest prority):
    --
    --   1. 'tstcomp', indicating end of training
    --   2. 'i_ref_req', indicating that refresh is necessary
    --   3. 'tstdo', indicating that it should perform a test readback of the
    --      memory.
    --

    count_valid : process(clk)
    begin
        if clk'event and clk = '1' then
            if sr_num_valid = '1' then
                num_valid <= (others => '0');
            else
                if valid = '1' then
                    num_valid <= num_valid + 1;
                end if;
            end if;
        end if;
    end process;

    check_dq_i : process(clk)
        variable exp_q : std_logic_vector(dq_width * 2 - 1 downto 0);
    begin
        if clk'event and clk = '1' then
            case num_valid(1 downto 0) is
                when "00" =>
                    exp_q(1 * dq_width - 1 downto 0 * dq_width) := (others => '1');
                    exp_q(2 * dq_width - 1 downto 1 * dq_width) := (others => '0');
                when "01" =>
                    exp_q(1 * dq_width - 1 downto 0 * dq_width) := (others => '1');
                    exp_q(2 * dq_width - 1 downto 1 * dq_width) := (others => '0');
                when "10" =>
                    exp_q(1 * dq_width - 1 downto 0 * dq_width) := (others => '0');
                    exp_q(2 * dq_width - 1 downto 1 * dq_width) := (others => '1');
                when "11" =>
                    exp_q(1 * dq_width - 1 downto 0 * dq_width) := (others => '1');
                    exp_q(2 * dq_width - 1 downto 1 * dq_width) := (others => '0');
                when others =>
                    exp_q := (others => '-');
            end case;

            if AND_reduce(exp_q xnor dq_i) = '1' then
                match <= '1';
            else
                match <= '0';
            end if;

            valid_q <= valid;

            if sr_num_valid = '1' then
                -- assume OK, will zero if incorrect data seen
                tstok <= '1';
            else
                if valid_q = '1' then
                    if match /= '1' then
                        tstok <= '0';
                    end if;
                end if;
            end if;
        end if; 
    end process;

    gen_state3 : process(clk)
    begin
        if clk'event and clk = '1' then
            if sr = '1' then
                state3 <= s3_idle;
                num_read <= (others => '-');
                patt_addr <= "--";
                sr_num_valid <= '0';
                timer3 <= (others => '-');
                trn_cmd <= DDRCMD_NOP;
                trn_done <= '0';
                trn_rd <= '0';
                trn_ref_done <= '0';
                trn_wr <= '0';
                tstdone <= '0';
            else
                state3 <= n_state3;
                num_read <= n_num_read;
                patt_addr <= n_patt_addr;
                sr_num_valid <= n_sr_num_valid;
                timer3 <= n_timer3;
                trn_cmd <= n_trn_cmd;
                trn_done <= n_trn_done;
                trn_rd <= n_trn_rd;
                trn_ref_done <= n_trn_ref_done;
                trn_wr <= n_trn_wr;
                tstdone <= n_tstdone;
            end if;
        end if;
    end process;

    gen_n_state3 : process(
        state3,
        num_read,
        num_valid,
        patt_addr,
        i_ref_req,
        timer3,
        trn_do,
        tstcomp,
        tstdo)
    begin
        case state3 is
            when s3_idle =>
                if trn_do = '1' then
                    n_state3 <= s3_write_opening;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "00";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '0');
                    n_trn_cmd <= DDRCMD_ACT;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_idle;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_write_opening =>
                if timer3 = t_act - 1 then
                    n_state3 <= s3_write_pattern;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "00";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_WRITE;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '1';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_write_opening;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_write_pattern =>
                if patt_addr = "11" then
                    n_state3 <= s3_write_delay;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '0');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_write_pattern;
                    n_num_read <= (others => '-');
                    n_patt_addr <= patt_addr + 1;
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_WRITE;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '1';
                    n_tstdone <= '0';
                end if;

            when s3_write_delay =>
                if timer3 = t_wtp - 1 then
                    n_state3 <= s3_write_closing;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "00";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '0');
                    n_trn_cmd <= DDRCMD_PRE_1B;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_write_delay;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_write_closing =>
                if timer3 = t_rp - 1 then
                    n_state3 <= s3_wait_event;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_write_closing;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_wait_event =>
                if tstcomp = '1' then
                    n_state3 <= s3_finished;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    if i_ref_req = '1' then
                        n_state3 <= s3_refresh;
                        n_num_read <= (others => '-');
                        n_patt_addr <= "--";
                        n_sr_num_valid <= '0';
                        n_timer3 <= (others => '0');
                        n_trn_cmd <= DDRCMD_REF;
                        n_trn_done <= '0';
                        n_trn_rd <= '0';
                        n_trn_ref_done <= '0';
                        n_trn_wr <= '0';
                        n_tstdone <= '0';
                    else
                        if tstdo = '1' then
                            n_state3 <= s3_read_opening;
                            n_num_read <= (others => '-');
                            n_patt_addr <= "00";
                            n_sr_num_valid <= '1';
                            n_timer3 <= (others => '0');
                            n_trn_cmd <= DDRCMD_ACT;
                            n_trn_done <= '0';
                            n_trn_rd <= '0';
                            n_trn_ref_done <= '0';
                            n_trn_wr <= '0';
                            n_tstdone <= '0';
                        else
                            n_state3 <= s3_wait_event;
                            n_num_read <= (others => '-');
                            n_patt_addr <= "--";
                            n_sr_num_valid <= '0';
                            n_timer3 <= (others => '-');
                            n_trn_cmd <= DDRCMD_NOP;
                            n_trn_done <= '0';
                            n_trn_rd <= '0';
                            n_trn_ref_done <= '0';
                            n_trn_wr <= '0';
                            n_tstdone <= '0';
                        end if;
                    end if;
                end if;

            when s3_refresh =>
                if timer3 = t_rfc - 1 then
                    n_state3 <= s3_wait_event;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '1';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_refresh;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_read_opening =>
                if timer3 = t_act - 1 then
                    n_state3 <= s3_reading;
                    n_num_read <= (others => '0');
                    n_patt_addr <= "00";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_READ;
                    n_trn_done <= '0';
                    n_trn_rd <= '1';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_read_opening;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_reading =>
                if num_read = 7 then
                    n_state3 <= s3_read_delay;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '0');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_reading;
                    n_num_read <= num_read + 1;
                    n_patt_addr <= patt_addr + 1;
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_READ;
                    n_trn_done <= '0';
                    n_trn_rd <= '1';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_read_delay =>
                if timer3 = t_rtp - 1 then
                    n_state3 <= s3_read_closing;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "00";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '0');
                    n_trn_cmd <= DDRCMD_PRE_1B;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_read_delay;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_read_closing =>
                if timer3 = t_rp - 1 then
                    n_state3 <= s3_wait_valid;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_read_closing;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_wait_valid =>
                if num_valid = 8 then
                    n_state3 <= s3_checking;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '0');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_wait_valid;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_checking =>
                if AND_reduce(timer3(1 downto 0)) = '1' then
                    n_state3 <= s3_wait_tstdo;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '1';
                else
                    n_state3 <= s3_checking;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_wait_tstdo =>
                if tstdo = '0' then
                    n_state3 <= s3_wait_event;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_wait_tstdo;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_cmd <= DDRCMD_NOP;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_ref_done <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_finished =>
                n_state3 <= s3_finished;
                n_num_read <= (others => '-');
                n_patt_addr <= "--";
                n_sr_num_valid <= '0';
                n_timer3 <= (others => '-');
                n_trn_cmd <= DDRCMD_NOP;
                n_trn_done <= '1';
                n_trn_rd <= '0';
                n_trn_ref_done <= '0';
                n_trn_wr <= '0';
                n_tstdone <= '0';
        end case;
    end process;

end mixed;
