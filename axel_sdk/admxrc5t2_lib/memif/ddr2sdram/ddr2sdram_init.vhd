--
-- ddr2sdram_init.vhd - DDR-II SDRAM memory interface, initialization and training
--                      module.
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

entity ddr2sdram_init is
    generic(
        auto_train      : in    boolean;
        direct_clocking : in    boolean;
        dq_width        : in    natural;
        dqs_width       : in    natural;
        rowcol_width    : in    natural;
        bank_width      : in    natural;
        cas_latency     : in    natural;
        t_refresh       : in    natural;
        t_act           : in    natural;
        t_mrd           : in    natural;
        t_dllr          : in    natural;
        t_rtp           : in    natural;
        t_wtp           : in    natural;
        t_rp            : in    natural;
        t_rfc           : in    natural);
    port(
        clk             : in    std_logic;
        rst             : in    std_logic;
        sr              : in    std_logic;
        ref_done        : in    std_logic;
        dq_i            : in    std_logic_vector(4 * dq_width - 1 downto 0);
        valid           : in    std_logic;
        ref_req         : out   std_logic;
        cke             : out   std_logic;
        done            : out   std_logic;
        command         : out   std_logic_vector(4 downto 0);
        addr            : out   std_logic_vector(rowcol_width + bank_width - 1 downto 0);
        dq_o            : out   std_logic_vector(4 * dq_width - 1 downto 0);
        rd              : out   std_logic;
        wr              : out   std_logic;
        trained         : out   std_logic;
        dlysr_dq        : out   std_logic_vector(dq_width - 1 downto 0);
        dlysr_dqs       : out   std_logic_vector(dqs_width - 1 downto 0);
        dlyce_dq        : out   std_logic_vector(dq_width - 1 downto 0);
        dlyce_dqs       : out   std_logic_vector(dqs_width - 1 downto 0);
        dlyinc_dq       : out   std_logic_vector(dq_width - 1 downto 0);
        dlyinc_dqs      : out   std_logic_vector(dqs_width - 1 downto 0);
        qce             : out   std_logic_vector(dq_width - 1 downto 0);
        qdelay          : out   std_logic_vector(dq_width * 2 - 1 downto 0);
        vdelay          : out   std_logic_vector(3 downto 0));
end entity;

architecture mixed of ddr2sdram_init is

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

    component ddr2sdram_training_dc is
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
    end component;

    --
    -- DDR commands
    --
    -- Order (4 downto 0) is (all, cs#, ras#, cas#, we#)
    --
    constant DDRCMD_NOP    : std_logic_vector(4 downto 0) := "-1111"; -- Deselect
    constant DDRCMD_PRE    : std_logic_vector(4 downto 0) := "10010"; -- Precharge
    constant DDRCMD_REF    : std_logic_vector(4 downto 0) := "10001"; -- Refresh
    constant DDRCMD_MRS    : std_logic_vector(4 downto 0) := "10000"; -- Set mode register

    --
    -- Number of cycles to wait after enabling clock to DDR SDRAM.
    -- 150 memory interface clocks is 300 DDR-II SDRAM clocks.
    --
    constant t_cke : natural := 150;

    --
    -- Values for mode register, extended mode register, extended mode register 2
    -- and extended mode register 3.
    --
    signal emodereg3_val : std_logic_vector(14 downto 0);
    signal emodereg2_val : std_logic_vector(14 downto 0);
    signal emodereg_val_normal : std_logic_vector(14 downto 0);
    signal emodereg_val_ocd : std_logic_vector(14 downto 0);
    signal modereg_val_normal : std_logic_vector(14 downto 0);
    signal modereg_val_dllreset : std_logic_vector(14 downto 0);

    --
    -- Power on delay timer
    --
    -- Results in delay of approx. 0.333-0.167s @ 200-400MHz SDRAM clock for synthesis
    -- and a delay of approx 20.5-10.2us @ 200-400MHz SDRAM clock for simulation
    --
    constant pwr_on_timer_width : natural := choice(25, 11, memif_simulation);
    signal pwr_on_timer : std_logic_vector(pwr_on_timer_width - 1 downto 0);
    signal pwr_on_done : std_logic;

    --
    -- Main initialization sequencer
    --
    constant log2_t_mrd : natural := log2up(t_mrd);
    constant log2_t_rp : natural := log2up(t_rp);
    constant log2_t_ref : natural := log2up(t_refresh);
    constant log2_t_cke : natural := log2up(t_cke);
    constant log2_t_dllr : natural := log2up(t_dllr);
    type state1_type is (
        s1_power_on,        -- Wait 200us
        s1_deselect,        -- Wait 400ns with CKE high
        s1_precharge_all1,  -- Issue precharge all command
        s1_emodereg2,       -- Init extended mode reg 2
        s1_emodereg3,       -- Init extended mode reg 3
        s1_emodereg,        -- Init extended mode reg
        s1_modereg1,        -- Init mode reg with DLL reset bit
        s1_precharge_all2,  -- Issue Precharge all command
        s1_refresh1,        -- Issue 1st refresh cycle
        s1_refresh2,        -- Issue 2nd refresh cycle
        s1_modereg2,        -- Clear DLL reset bit in mode reg
        s1_ocd_init,        -- Set OCD to default state via mode reg
        s1_ocd_exit,        -- Exit OCD callibration mode via mode reg
        s1_training,        -- Performing IDELAY training
        s1_done);
    signal state1, n_state1 : state1_type;
    signal i_cke, n_cke : std_logic;
    signal init_cmd, n_init_cmd : std_logic_vector(4 downto 0);
    signal init_addr, n_init_addr : std_logic_vector(14 downto 0);
    signal init_done, n_init_done : std_logic;
    signal train_go, n_train_go : std_logic;
    signal en_refresh, n_en_refresh : std_logic;
    signal timer_desel, n_timer_desel : std_logic_vector(log2_t_cke downto 0);
    signal timer_dllr, n_timer_dllr : std_logic_vector(log2_t_dllr downto 0);
    signal timer_mrd, n_timer_mrd : std_logic_vector(log2_t_mrd downto 0);
    signal timer_pre, n_timer_pre : std_logic_vector(log2_t_rp downto 0);
    signal timer_ref, n_timer_ref : std_logic_vector(log2_t_ref downto 0);

    --
    -- Refresh state machine
    --
    type state2_type is (
        s2_idle,
        s2_request);
    signal state2, n_state2 : state2_type;
    signal i_ref_req, n_ref_req : std_logic;
    signal refresh_timer : std_logic_vector(15 downto 0);

    --
    -- Signals from training module
    --

    signal train_addr : std_logic_vector(2 downto 0);
    signal train_cmd : std_logic_vector(4 downto 0);
    signal train_done : std_logic;
    signal train_rd : std_logic;
    signal train_wr : std_logic;
    signal train_dq_o : std_logic_vector(4 * dq_width - 1 downto 0);
    signal train_ok : std_logic;
    signal train_ref_done : std_logic;

    signal logic0, logic1 : std_logic;

begin

    -- synopsys translate_off
    assert t_dllr <= 1000
        report "*** ddrsdram_init: illegal value " & conv_string(t_dllr) & "for t_dllr : more than 1000"
        severity failure;

    assert t_rp >= 1
        report "*** ddrsdram_init: illegal value " & conv_string(t_rp) & "for t_rp : less than 1"
        severity failure;

    assert t_rp <= 31
        report "*** ddrsdram_init: illegal value " & conv_string(t_rp) & "for t_rp : more than 31"
        severity failure;

    assert t_rfc >= 1
        report "*** ddrsdram_init: illegal value " & conv_string(t_rfc) & "for t_rfc : less than 1"
        severity failure;

    assert t_rfc <= 31
        report "*** ddrsdram_init: illegal value " & conv_string(t_rfc) & "for t_rfc : more than 31"
        severity failure;
    -- synopsys translate_on

    logic0 <= '0';
    logic1 <= '1';

    modereg_val_normal(14 downto 13) <= "00"; -- Select mode register
    modereg_val_normal(12) <= '0';
    modereg_val_normal(11 downto 9) <= "010"; -- Write recovery = 3 (only applies to auto-precharge)
    modereg_val_normal(8) <= '0'; -- Reset DLL
    modereg_val_normal(7) <= '0'; -- Normal mode (not test mode)
    modereg_val_normal(6 downto 4) <= "011" when cas_latency = 3 else
                                      "100" when cas_latency = 4 else
                                      "101" when cas_latency = 5 else
                                      "110" when cas_latency = 6 else
                                      "---";
    modereg_val_normal(3) <= '0'; -- Sequential ordering
    modereg_val_normal(2 downto 0) <= "010"; -- Burst length 4

    modereg_val_dllreset(14 downto 9) <= modereg_val_normal(14 downto 9);
    modereg_val_dllreset(8) <= '1';
    modereg_val_dllreset(7 downto 0) <= modereg_val_normal(7 downto 0);

    emodereg_val_normal(14 downto 13) <= "01"; -- Select EMR
    emodereg_val_normal(12) <= '0'; -- Enable outputs
    emodereg_val_normal(11) <= '0'; -- Disable RDQS
    emodereg_val_normal(10) <= '0'; -- Enable DQS#
    emodereg_val_normal(9 downto 7) <= "000"; -- OCD not supported (?)
    emodereg_val_normal(6) <= '0'; -- ODT disabled, RTT = open
    emodereg_val_normal(5 downto 3) <= "000"; -- 0 additive latency
    emodereg_val_normal(2) <= '0'; -- ODT disabled, RTT = open
    emodereg_val_normal(1) <= '0'; -- Full strength drive
    emodereg_val_normal(0) <= '0'; -- Enable DLL

    emodereg_val_ocd(14 downto 10) <= emodereg_val_normal(14 downto 10);
    emodereg_val_ocd(9 downto 7) <= "111"; -- OCD to default state
    emodereg_val_ocd(6 downto 0) <= emodereg_val_normal(6 downto 0);

    emodereg2_val(14 downto 13) <= "10"; -- Select EMR2
    emodereg2_val(12 downto 0) <= (others => '0'); -- Reserved

    emodereg3_val(14 downto 13) <= "11"; -- Select EMR3
    emodereg3_val(12 downto 0) <= (others => '0'); -- Reserved

    outputs : process(rst, clk)
    begin
        if rst = '1' then
            dq_o <= (others => '-');
            rd <= '0';
            wr <= '0';
            trained <= '0';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                trained <= '0';
            else
                if train_done = '1' then
                    trained <= train_ok;
                end if;
            end if;

            dq_o <= train_dq_o;
            rd <= train_rd;
            wr <= train_wr;
        end if;
    end process;

    cke <= i_cke;
    command <= init_cmd;
    done <= init_done;
    ref_req <= i_ref_req;
    addr <= EXT(init_addr(14 downto 13), bank_width) & EXT(init_addr(12 downto 0), rowcol_width);

    --
    -- DDR SDRAM controller refresh state machine
    --

    gen_refresh_timer : process(rst, clk)
    begin
        if rst = '1' then
            refresh_timer <= (others => '0');
        elsif clk'event and clk = '1' then
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

    gen_state2 : process(rst, clk)
    begin
        if rst = '1' then
            state2 <= s2_idle;
            i_ref_req <= '0';
        elsif clk'event and clk = '1' then
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
        train_ref_done)
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
                if ref_done = '1' or train_ref_done = '1' then
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

    gen_state1 : process(rst, clk)
    begin
        if rst = '1' then
            state1 <= s1_power_on;
            i_cke <= '0';
            init_cmd <= (others => '1');
            init_addr <= (others => '0');
            init_done <= '0';
            train_go <= '0';
            en_refresh <= '0';
            timer_desel <= (others => '0');
            timer_dllr <= (others => '0');
            timer_mrd <= (others => '0');
            timer_pre <= (others => '0');
            timer_ref <= (others => '0');
        elsif clk'event and clk = '1' then
            if sr = '1' then
                state1 <= s1_power_on;
                i_cke <= '0';
                init_cmd <= (others => '1');
                init_addr <= (others => '0');
                init_done <= '0';
                train_go <= '0';
                en_refresh <= '0';
                timer_desel <= (others => '0');
                timer_dllr <= (others => '0');
                timer_mrd <= (others => '0');
                timer_pre <= (others => '0');
                timer_ref <= (others => '0');
            else
                state1 <= n_state1;
                i_cke <= n_cke;
                init_cmd <= n_init_cmd;
                init_addr <= n_init_addr;
                init_done <= n_init_done;
                train_go <= n_train_go;
                en_refresh <= n_en_refresh;
                timer_desel <= n_timer_desel;
                timer_dllr <= n_timer_dllr;
                timer_mrd <= n_timer_mrd;
                timer_pre <= n_timer_pre;
                timer_ref <= n_timer_ref;
            end if;
        end if;
    end process;

    gen_n_state1 : process(
        state1,
        emodereg_val_normal,
        emodereg_val_ocd,
        emodereg2_val,
        emodereg3_val,
        modereg_val_normal,
        modereg_val_dllreset,
        pwr_on_done,
        train_done,
        train_cmd,
        train_addr,
        timer_desel,
        timer_dllr,
        timer_mrd,
        timer_pre,
        timer_ref)
    begin
        case state1 is
            when s1_power_on =>
                if pwr_on_done = '1' then
                    n_state1 <= s1_deselect;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '0');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_power_on;
                    n_init_addr <= (others => '-');
                    n_cke <= '0';
                    n_init_cmd <= (others => '1');
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_deselect =>
                if timer_desel = t_cke then
                    -- Execute a 'precharge all' command
                    n_state1 <= s1_precharge_all1;
                    n_init_addr <= (10 => '1', others => '0');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_PRE;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '0');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_deselect;
                    n_cke <= '1';
                    n_init_addr <= (others => '-');
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= timer_desel + 1;
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_precharge_all1 =>
                if timer_pre = t_rp then
                    -- Establish extended mode register 2
                    n_state1 <= s1_emodereg2;
                    n_init_addr <= emodereg2_val;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '0');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_precharge_all1;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= timer_pre + 1;
                    n_timer_ref <= (others => '-');
                end if;

            when s1_emodereg2 =>
                if timer_mrd = t_mrd then
                    -- Establish extended mode register 3
                    n_state1 <= s1_emodereg3;
                    n_init_addr <= emodereg3_val;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '0');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_emodereg2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= timer_mrd + 1;
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_emodereg3 =>
                if timer_mrd = t_mrd then
                    -- Establish extended mode register
                    n_state1 <= s1_emodereg;
                    n_init_addr <= emodereg_val_normal;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '0');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_emodereg3;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= timer_mrd + 1;
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_emodereg =>
                if timer_mrd = t_mrd then
                    -- Establish mode register and reset DLL
                    n_state1 <= s1_modereg1;
                    n_init_addr <= modereg_val_dllreset;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '0');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_emodereg;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= timer_mrd + 1;
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_modereg1 =>
                if timer_mrd = t_mrd then
                    -- Execute second 'precharge all' command
                    n_state1 <= s1_precharge_all2;
                    n_init_addr <= (10 => '1', others => '0');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_PRE;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '0');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_modereg1;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= timer_mrd + 1;
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_precharge_all2 =>
                if timer_pre = t_rp then
                    -- Execute first refresh cycle
                    n_state1 <= s1_refresh1;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_REF;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '0');
                else
                    n_state1 <= s1_precharge_all2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '0';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= timer_pre + 1;
                    n_timer_ref <= (others => '-');
                end if;

            when s1_refresh1 =>
                if timer_ref = t_rfc then
                    -- Execute second refresh cycle
                    n_state1 <= s1_refresh2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_REF;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '0');
                else
                    n_state1 <= s1_refresh1;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= timer_ref + 1;
                end if;

            when s1_refresh2 =>
                if timer_ref = t_rfc then
                    -- Reprogram mode register without resetting DLL
                    n_state1 <= s1_modereg2;
                    n_init_addr <= modereg_val_normal;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '0');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_refresh2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= timer_ref + 1;
                end if;

            when s1_modereg2 =>
                if timer_dllr = t_dllr then
                    -- Initialize OCD
                    n_state1 <= s1_ocd_init;
                    n_init_addr <= emodereg_val_ocd;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '0');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_modereg2;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= timer_dllr + 1;
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_ocd_init =>
                if timer_mrd = t_mrd then
                    -- Exit OCD callibration mode
                    n_state1 <= s1_ocd_exit;
                    n_init_addr <= emodereg_val_normal;
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_MRS;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '0');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_ocd_init;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= timer_mrd + 1;
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_ocd_exit =>
                if timer_mrd = t_mrd then
                    n_state1 <= s1_training;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '1';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_ocd_exit;
                    n_init_addr <= (others => '-');
                    n_cke <= '1';
                    n_init_cmd <= DDRCMD_NOP;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= timer_mrd + 1;
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_training =>
                if train_done = '1' then
                    n_state1 <= s1_done;
                    n_init_addr <= EXT(train_addr, init_addr'length);
                    n_cke <= '1';
                    n_init_cmd <= train_cmd;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                else
                    n_state1 <= s1_training;
                    n_init_addr <= EXT(train_addr, init_addr'length);
                    n_cke <= '1';
                    n_init_cmd <= train_cmd;
                    n_init_done <= '0';
                    n_train_go <= '0';
                    n_en_refresh <= '1';
                    n_timer_desel <= (others => '-');
                    n_timer_dllr <= (others => '-');
                    n_timer_mrd <= (others => '-');
                    n_timer_pre <= (others => '-');
                    n_timer_ref <= (others => '-');
                end if;

            when s1_done =>
                -- Stay in this state for ever
                n_state1 <= s1_done;
                n_init_addr <= (others => '-');
                n_cke <= '1';
                n_init_cmd <= DDRCMD_NOP;
                n_init_done <= '1';
                n_train_go <= '0';
                n_en_refresh <= '1';
                n_timer_desel <= (others => '-');
                n_timer_dllr <= (others => '-');
                n_timer_mrd <= (others => '-');
                n_timer_pre <= (others => '-');
                n_timer_ref <= (others => '-');
        end case;
    end process;

    --
    -- DQ/DQS IDELAY training module
    --

    training_dc : if auto_train and direct_clocking generate
        U0 : ddr2sdram_training_dc
            generic map(
                dq_width => dq_width,
                dqs_width => dqs_width,
                t_act => t_act,
                t_rfc => t_rfc,
                t_rp => t_rp,
                t_rtp => t_rtp,
                t_wtp => t_wtp)
            port map(
                clk => clk,
                rst => rst,
                sr => sr,
                go => train_go,
                dq_i => dq_i,
                valid => valid,
                ref_req => i_ref_req,
                rd => train_rd,
                wr => train_wr,
                command => train_cmd,
                addr => train_addr,
                done => train_done,
                trained => train_ok,
                ref_done => train_ref_done,
                dq_o => train_dq_o,
                dlysr_dq => dlysr_dq,
                dlysr_dqs => dlysr_dqs,
                dlyce_dq => dlyce_dq,
                dlyce_dqs => dlyce_dqs,
                dlyinc_dq => dlyinc_dq,
                dlyinc_dqs => dlyinc_dqs,
                qce => qce,
                qdelay => qdelay,
                vdelay => vdelay);
    end generate;

    no_training : if not auto_train or not direct_clocking generate
        train_done <= '1';
        dlysr_dq <= (others => '0'); -- TO DO
        dlysr_dqs <= (others => '0'); -- TO DO
        dlyce_dq <= (others => '0'); -- TO DO
        dlyce_dqs <= (others => '0'); -- TO DO
        dlyinc_dq <= (others => '0'); -- TO DO
        dlyinc_dqs <= (others => '0'); -- TO DO
        gen_qdelay : for i in 0 to dq_width - 1 generate
            qdelay(2 * i + 1 downto 2 * i) <= "01";
        end generate;
        vdelay <= "0111";
        qce <= (others => '0');
        train_cmd <= (others => '1');
        train_addr <= "000";
        train_dq_o <= (others => '0');
        train_done <= '1';
        train_rd <= '0';
        train_wr <= '0';
        train_ok <= '1';
        train_ref_done <= '0';
    end generate;

end mixed;
