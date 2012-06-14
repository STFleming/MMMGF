--
-- ddr2sram_port_v2.vhd - DDR-II SSRAM interface for Virtex and Virtex-II Pro
--
-- SYNTHESIZABLE
--
-- The following inputs control the mode of this memory interface. Except where
-- noted, they do not have to be driven by constant values:
--
--   burst_len     0 => Burst length 2
--                 1 => Burst length 4 (also works with BL2 devices)
--
--   dll_off       0 => DLL enabled (normal operation) 
--                 1 => DLL disabled
--                 (Note: the normal setting is '0', to enable the DLL. Disabling
--                 the DLL may be necessary when operating the device at a clock
--                 frequency below its minimum frequency).
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
--use work.ilap.all;

entity ddr2sram_port_v2 is
    generic(
        pinout          : in    ddr2sram_pinout_t;
        ra_width        : in    natural;
        rc_width        : in    natural;
        rd_width        : in    natural;
        a_width         : in    natural;
        d_width         : in    natural;
        tag_width       : in    natural);
    port(
        clk0            : in    std_logic;                                   -- Baseline I/O clock
        clk90           : in    std_logic;                                   -- As 'clk0' but lags by 90 degrees
        clk180          : in    std_logic;                                   -- As 'clk0' but lags by 180 degrees
        clk270          : in    std_logic;                                   -- As 'clk0' but lags by 270 degrees
        rst             : in    std_logic;                                   -- Aynchronous reset
        sr              : in    std_logic;                                   -- Synchronous reset
        ce              : in    std_logic;                                   -- Command enable, qualified by 'ready'
        tag             : in    std_logic_vector(tag_width - 1 downto 0);    -- Tag, qualified by 'ce and not w')
        w               : in    std_logic;                                   -- 1 => write, qualified by 'ce')
        a               : in    std_logic_vector(a_width - 1 downto 0);      -- Address, qualified by 'ce'
        d               : in    std_logic_vector(d_width - 1 downto 0);      -- Write data, qualified by 'ce and w'
        be              : in    std_logic_vector(d_width / 8 - 1 downto 0);  -- Write byte enables, qualified by 'ce and w'
        q               : out   std_logic_vector(d_width - 1 downto 0);      -- Read data, qualified by 'valid'
        qtag            : out   std_logic_vector(tag_width - 1 downto 0);    -- Read tag, qualified by 'valid'
        valid           : out   std_logic;                                   -- 1 => 'q' and 'qtag' are valid
        ready           : out   std_logic;                                   -- When low, indicates that 'ce' is ignored
        -- Signals to/from training module
        clkc0           : in    std_logic;
        clkc180         : in    std_logic;
        cedge           : in    std_logic_vector(2 downto 0);
        tstcomp         : in    std_logic;
        tstdo           : in    std_logic;
        tstdone         : out   std_logic;
        tstok           : out   std_logic;
        -- Sideband control signals, must be stable during operation
        burst_len       : in    std_logic;                                   -- Supported burst length: 0 => 2 only, 1 => 2 & 4
        dll_off         : in    std_logic;                                   -- Disables DLL in SSRAM device when high
        -- To/from memories
        ra              : out   std_logic_vector(ra_width - 1 downto 0);
        rc              : inout std_logic_vector(rc_width - 1 downto 0);
        rd              : inout std_logic_vector(rd_width - 1 downto 0));
end entity;

architecture mixed of ddr2sram_port_v2 is

    constant this_module : string := "ddr2sram_port_v2";

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

    constant bwe_width : natural := rd_width / 8;
    constant be_width : natural := bwe_width * 2;
    constant cmd_width : natural := (rd_width * 2) + be_width + a_width + 1 + tag_width;

    -- Local reset generation
    signal lsr0 : std_logic;
    signal lsr1 : std_logic;
    signal lsr : std_logic;

    -- Power-on timer
    signal power_on_timer : std_logic_vector(11 downto 0);
    signal power_on_done : std_logic;

    -- Signals to/from command FIFO (i.e. stage 0 of command pipeline)
    signal cmd_d : std_logic_vector(cmd_width - 1 downto 0);
    signal cmd_q : std_logic_vector(cmd_width - 1 downto 0);
    signal cmd_q_d : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal cmd_q_be : std_logic_vector(be_width - 1 downto 0);
    signal cmd_q_a : std_logic_vector(ra_width - 2 downto 0);
    signal cmd_q_w : std_logic;
    signal cmd_q_tag : std_logic_vector(tag_width - 1 downto 0);
    signal cmd_empty : std_logic;
    signal cmd_avail : std_logic;
    signal cmd_read : std_logic;

    signal cmd_q1_a : std_logic_vector(ra_width - 2 downto 0);
    signal cmd_q1_d : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal cmd_q2_d : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal cmd_q3_d : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal cmd_q4_d : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal cmd_q1_be_l : std_logic_vector(be_width - 1 downto 0);
    signal cmd_q2_be_l : std_logic_vector(be_width - 1 downto 0);
    signal cmd_q3_be_l : std_logic_vector(be_width - 1 downto 0);
    signal cmd_q4_be_l : std_logic_vector(be_width - 1 downto 0);
    signal cmd_q1_w : std_logic;
    signal cmd_q1_tag : std_logic_vector(tag_width - 1 downto 0);
    signal cmd_q2_tag : std_logic_vector(tag_width - 1 downto 0);

    -- Burst control
    signal b_idle : std_logic;
    signal full : std_logic;
    signal ce_b_hit : std_logic;
    signal b_hit : std_logic;
    signal b_write : std_logic;
    signal b_addr : std_logic_vector(ra_width - 1 downto 1);
    signal b_next_addr : std_logic_vector(ra_width - 1 downto 1);
    signal do_ld_l : std_logic;
    signal do_w_l : std_logic;
    signal do_wbe : std_logic;
    signal do_read : std_logic;
    signal do_write : std_logic;
    signal do_write_q : std_logic;

    signal srl_tap : std_logic_vector(3 downto 0);

    signal do_read_ntrn : std_logic;
    signal i_qtag : std_logic_vector(tag_width - 1 downto 0);
    signal i_valid : std_logic;

    constant ld_phase_270 : boolean := false;
    signal ld_o_l : std_logic;
    signal w_o_l : std_logic;
    signal k_o : std_logic;
    signal k_o_l : std_logic;
    signal c_o : std_logic;
    signal c_o_l : std_logic;
    signal doff_o_l : std_logic;
    signal be_o_l : std_logic_vector(bwe_width - 1 downto 0);

    signal q_l, q_h : std_logic_vector(rd_width - 1 downto 0);
    signal q0_l0, q0_h0 : std_logic_vector(rd_width - 1 downto 0);
    signal q0_l1, q0_h1 : std_logic_vector(rd_width - 1 downto 0);
    signal q0 : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal q180_l0, q180_h0 : std_logic_vector(rd_width - 1 downto 0);
    signal q180_l1 : std_logic_vector(rd_width - 1 downto 0);
    signal q180 : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal i_q : std_logic_vector(rd_width * 2 - 1 downto 0);

    signal ra_t : std_logic_vector(ra_width - 1 downto 0);
    signal ra_o : std_logic_vector(ra_width - 1 downto 0);
    signal rc_t : std_logic_vector(rc_width - 1 downto 0);
    signal rc_o : std_logic_vector(rc_width - 1 downto 0);
    signal rc_i : std_logic_vector(rc_width - 1 downto 0);
    signal rd_t : std_logic_vector(rd_width - 1 downto 0);
    signal rd_o : std_logic_vector(rd_width - 1 downto 0);
    signal rd_i : std_logic_vector(rd_width - 1 downto 0);

    signal num_valid : std_logic_vector(3 downto 0);
    signal match : std_logic;
    signal trn_dq_o : std_logic_vector(2 * rd_width - 1 downto 0);
    signal do_read_trn : std_logic;
    signal trn_valid : std_logic;
    signal trn_valid_q : std_logic;

    type state3_t is (
        s3_start,
        s3_write_pattern,
        s3_wait_event,
        s3_reading,
        s3_wait_valid,
        s3_checking,
        s3_wait_tstdo,
        s3_finished);
    signal state3, n_state3 : state3_t;
    signal num_read, n_num_read : std_logic_vector(2 downto 0);
    signal patt_addr, n_patt_addr : std_logic_vector(2 downto 1);
    signal sr_num_valid, n_sr_num_valid : std_logic;
    signal timer3, n_timer3 : std_logic_vector(1 downto 0);
    signal trn_done, n_trn_done : std_logic;
    signal trn_rd, n_trn_rd : std_logic;
    signal trn_wr, n_trn_wr : std_logic;
    signal i_tstdone, n_tstdone : std_logic;

    signal trn_rd_q : std_logic;
    signal trn_wr_q : std_logic;
    signal trn_rdwr_q : std_logic;
    signal trn_addr : std_logic_vector(2 downto 1);

    signal i_tstok : std_logic;

    signal logic0, logic1 : std_logic;
    signal zeroes : std_logic_vector(31 downto 0);

--    signal trig0 : std_logic_vector(254 downto 0);
--    signal trig_out : std_logic;
--    attribute keep : string;
--    attribute keep of trig_out : signal is "true";

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of ra_o : signal is "no";
    attribute equivalent_register_removal of rc_o : signal is "no";
    attribute equivalent_register_removal of rd_o : signal is "no";
    attribute equivalent_register_removal of rd_i : signal is "no";
    attribute equivalent_register_removal of rd_t : signal is "no";
    attribute equivalent_register_removal of k_o : signal is "no";
    attribute equivalent_register_removal of k_o_l : signal is "no";
    attribute equivalent_register_removal of c_o : signal is "no";
    attribute equivalent_register_removal of c_o_l : signal is "no";
    attribute iob : string;
    attribute iob of rd_t : signal is "false";
    attribute iob of rd_o : signal is "true";
    attribute iob of rd_i : signal is "true";
    attribute iob of be_o_l : signal is "true";
    attribute iob of w_o_l : signal is "true";
    attribute iob of ld_o_l : signal is "true";
    attribute iob of c_o : signal is "true";
    attribute iob of c_o_l : signal is "true";
    attribute iob of k_o : signal is "true";
    attribute iob of k_o_l : signal is "true";
    attribute iob of doff_o_l : signal is "true";

    attribute INIT : string;
    attribute INIT of gen_k_o : label is "0";
    attribute INIT of gen_k_o_l : label is "1";
    attribute INIT of gen_c_o : label is "0";
    attribute INIT of gen_c_o_l : label is "1";

    component cmd_fifo
        generic(
            width         : in  natural);
        port(
            clk           : in  std_logic;
            rst           : in  std_logic;
            sr            : in  std_logic;
            w             : in  std_logic;
            d             : in  std_logic_vector(width - 1 downto 0);
            r             : in  std_logic;
            q             : out std_logic_vector(width - 1 downto 0);
            ready         : out std_logic;
            empty         : out std_logic);
    end component;

    component FDDRRSE
        -- synthesis translate_off
        generic(
            INIT : bit := '1');
        -- synthesis translate_on
        port(
            Q    : out   std_logic;
            C0   : in    std_logic;
            C1   : in    std_logic;
            CE   : in    std_logic;
            D0   : in    std_logic;
            D1   : in    std_logic;
            R    : in    std_logic;
            S    : in    std_logic);
    end component;

    component FDDRCPE
        -- synthesis translate_off
        generic(
            INIT : bit := '1');
        -- synthesis translate_on
        port(
            Q    : out   std_logic;
            C0   : in    std_logic;
            C1   : in    std_logic;
            CE   : in    std_logic;
            D0   : in    std_logic;
            D1   : in    std_logic;
            CLR  : in    std_logic;
            PRE  : in    std_logic);
    end component;

    component IOBUF
        port(
            I  : in    std_logic;
            IO : inout std_logic;
            O  : out   std_logic;
            T  : in    std_logic);
    end component;

    component OBUF
        port(
            I  : in    std_logic;
            O  : out   std_logic);
    end component;

    component SRLC16E
        port(
            D   : in  std_logic;
            CE  : in  std_logic;
            CLK : in  std_logic;
            A0  : in  std_logic;
            A1  : in  std_logic;
            A2  : in  std_logic;
            A3  : in  std_logic;
            Q   : out std_logic;
            Q15 : out std_logic);
    end component;

begin

    logic0 <= '0';
    logic1 <= '1';
    zeroes <= (others => '0');

    q <= i_q;
    qtag <= i_qtag;
    valid <= i_valid;

    tstdone <= i_tstdone;
    tstok <= i_tstok;

    --
    -- Generate local reset
    --

    local_reset : process(rst, clk0)
    begin
        if rst = '1' then
            lsr0 <= '1';
            lsr1 <= '1';
            lsr <= '1';
        elsif clk0'event and clk0 = '1' then
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
    -- Timer to ensure that there is a sufficient delay after configuration /
    -- reset to enable the DLL in the SSRAM device to achieve lock.
    --

    power_on_delay : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if lsr = '1' then
                power_on_timer <= (others => '0');
                power_on_done <= '0';
            else
                if power_on_done = '0' then
                    power_on_timer <= power_on_timer + 1;
                    power_on_done <= AND_reduce(power_on_timer);
                end if;
            end if;
        end if;
    end process;

    --
    -- Buffer incoming commands in command FIFO
    --

    cmd_d <= tag & w & a & EXT(be, be_width) & EXT(d, rd_width * 2);
    cmd_read <= ce_b_hit;

    cmd_fifo_0 : cmd_fifo
        generic map(
            width => cmd_width)
        port map(
            clk => clk0,
            rst => logic0,
            sr => lsr,
            w => ce,
            d => cmd_d,
            ready => ready,
            r => cmd_read,
            empty => cmd_empty,
            q => cmd_q);

    cmd_avail <= not cmd_empty and trn_done;

    cmd_q_d <= cmd_q(rd_width * 2 - 1 downto 0);
    cmd_q_be <= cmd_q(rd_width * 2 + be_width - 1 downto rd_width * 2);
    cmd_q_a <= EXT(cmd_q(rd_width * 2 + be_width + a_width - 1 downto rd_width * 2 + be_width), ra_width - 1);
    cmd_q_w <= cmd_q(rd_width * 2 + be_width + a_width );
    cmd_q_tag <= cmd_q(rd_width * 2 + be_width + a_width + tag_width downto rd_width * 2 + be_width + a_width + 1);

    --
    -- DDR-II SRAM burst state machine
    --

    burst_state_machine : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if trn_done = '0' then
                b_idle <= '1';
                b_write <= '-';
                b_addr <= EXT(trn_addr, ra_width - 1);
            else
                case b_idle is
                    when '1' => -- Idle
                        if full = '1' and (cmd_q1_w = '0' or do_read = '0') then
                            b_idle <= '0';
                            b_write <= cmd_q1_w;
                            b_addr <= cmd_q1_a;
                        else
                            b_idle <= '1';
                        end if;

                    when '0' => -- Bursting
                        b_idle <= '1';
                        b_addr(1) <= not b_addr(1);

                    when others =>
                        b_idle <= '-';
                end case;
            end if;
        end if;
    end process;

    --
    -- Full state machine
    --

    full_state_machine : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if lsr = '1' then
                full <= '0';
            else
                case full is
                    when '0' =>
                        if cmd_avail = '1' then
                            full <= '1';
                        else
                            full <= '0';
                        end if;

                    when '1' =>
                        if cmd_avail = '0' and ((b_idle = '1' and (cmd_q1_w = '0' or do_read = '0')) or b_hit = '1') then
                            full <= '0';
                        else
                            full <= '1';
                        end if;

                    when others =>
                        full <= '-';
                end case;
            end if;
        end if;
    end process;

    --
    -- Burst and pipeline control logic
    --

    ce_b_hit <= (cmd_avail and not full) or (cmd_avail and full and ((b_idle and (not cmd_q1_w or not do_read)) or b_hit));

    b_next_addr(ra_width - 1 downto 2) <= cmd_q1_a(ra_width - 2 downto 1);
    b_next_addr(1) <= not cmd_q1_a(0);

    check_addr : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if lsr = '1' then
                cmd_q1_a <= (others => '-');
                cmd_q1_d <= (others => '-');
                cmd_q1_be_l <= (others => '1');
                cmd_q1_w <= '-';
                cmd_q1_tag <= (others => '-');
                cmd_q2_tag <= (others => '-');
                b_hit <= '-';
            else            
                if ce_b_hit = '1' then
                    cmd_q1_a <= cmd_q_a;
                    cmd_q1_d <= cmd_q_d;
                    cmd_q1_be_l <= not cmd_q_be;
                    cmd_q1_w <= cmd_q_w;
                    cmd_q1_tag <= cmd_q_tag;
                    b_hit <= full and AND_reduce(b_next_addr xnor cmd_q_a) and (cmd_q1_w xnor cmd_q_w);
                end if;

                cmd_q2_tag <= cmd_q1_tag;
            end if;
        end if;
    end process;

    --
    -- Figure out if we can do a read or a write
    --

    process(clk0)
        variable x : std_logic;
    begin
        if clk0'event and clk0 = '1' then
            if lsr = '1' then
                do_ld_l <= '1';
                do_w_l <= '1';
                do_write <= '0';
                do_write_q <= '0';
                do_wbe <= '0';
                do_read <= '0';
            else
                x := (b_idle and full and (not cmd_q1_w or not do_read)) or not b_idle or trn_rdwr_q;
                do_ld_l <= not x;
                x := (b_idle and full and cmd_q1_w and not do_read) or (not b_idle and b_write) or trn_wr_q;
                do_w_l <= not x;
                do_write <= x;
                do_write_q <= do_write;
                do_wbe <= (full and ((b_idle and cmd_q1_w and not do_read) or (not b_idle and b_write and b_hit))) or trn_wr_q;
                do_read <= (full and ((b_idle and not cmd_q1_w) or (not b_idle and not b_write and b_hit))) or trn_rd_q;
            end if;
        end if;
    end process;

    gen_ld_phase_180 : if not ld_phase_270 generate
        --
        -- Generate 'ld_o_l' (LD#) using 'clk180'
        --

        gen_ld_o_l : process(lsr, clk180)
        begin
            if lsr = '1' then
                ld_o_l <= '1';
            elsif clk180'event and clk180 = '1' then
                ld_o_l <= do_ld_l;
            end if;
        end process;
    end generate;

    gen_ld_phase_270 : if ld_phase_270 generate
        --
        -- Generate 'ld_o_l' (LD#) using 'clk270'
        --

        gen_ld_o_l : process(lsr, clk270)
        begin
            if lsr = '1' then
                ld_o_l <= '1';
            elsif clk270'event and clk270 = '1' then
                ld_o_l <= do_ld_l;
            end if;
        end process;
    end generate;

    --
    -- Generate 'w_o_l' (W#)
    --

    gen_w_o_l : process(lsr, clk270)
    begin
        if lsr = '1' then
            w_o_l <= '1';
        elsif clk270'event and clk270 = '1' then
            w_o_l <= do_w_l;
        end if;
    end process;

    --
    -- Delay byte enables and data for two cycles, since DDR-II SSRAM
    -- devices want write data two cycles after LD#
    --

    delay_data : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if trn_done = '1' then
                cmd_q2_d <= cmd_q1_d;
            else
                cmd_q2_d <= trn_dq_o;
            end if;
            cmd_q3_d <= cmd_q2_d;
            cmd_q4_d <= cmd_q3_d;
        end if;
    end process;

    delay_be : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if trn_done = '1' then
                cmd_q2_be_l <= cmd_q1_be_l;
            else
                cmd_q2_be_l <= (others => '0');
            end if;
            if do_wbe = '1' then
                cmd_q3_be_l <= cmd_q2_be_l;
            else
                cmd_q3_be_l <= (others => '1');
            end if;
            cmd_q4_be_l <= cmd_q3_be_l;
        end if;
    end process;

    --
    -- Generate 'be_o_l' (BE#)
    --

    gen_be_o_l : for i in 0 to bwe_width - 1 generate
        U0 : FDDRRSE
            -- synthesis translate_off
            generic map(
                INIT => '1')
            -- synthesis translate_on
            port map(
                Q => be_o_l(i),
                C0 => clk0,
                C1 => clk180,
                CE => logic1,
                D0 => cmd_q3_be_l(i),
                D1 => cmd_q4_be_l(i + bwe_width),
                R => logic0,
                S => logic0);
    end generate;

    --
    -- Generate 'rd_o' (DQ to SSRAM)
    --

    gen_rd_o : for i in 0 to rd_width - 1 generate
        U0 : FDDRRSE
            -- synthesis translate_off
            generic map(
                INIT => '1')
            -- synthesis translate_on
            port map(
                Q => rd_o(i),
                C0 => clk0,
                C1 => clk180,
                CE => logic1,
                D0 => cmd_q3_d(i),
                D1 => cmd_q4_d(i + rd_width),
                R => logic0,
                S => logic0);
    end generate;

    --
    -- Generate 'rd_t' (tristate control for DQ)
    --

    gen_rd_t : process(lsr, clk0)
    begin
        if lsr = '1' then
            rd_t <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            rd_t <= (others => not (do_write or do_write_q));
        end if;
    end process;

    --
    -- Capture DQ from DDR SDRAM into DDR IOB flip-flops using capture clocks.
    --

    capture0 : process(clkc0)
    begin
        if clkc0'event and clkc0 = '1' then
            q_l <= rd_i;
        end if;
    end process;

    capture180 : process(clkc180)
    begin
        if clkc180'event and clkc180 = '1' then
            q_h <= rd_i;
        end if;
    end process;

    --
    -- Retime DQ from 'clkc0/180' domain to 'clk' domain, using 'clk0/clk180'
    --

    recapture_0a : process(clk0)
    begin
       if clk0'event and clk0 = '1' then
            q0_l0 <= q_l;
            q0_l1 <= q0_l0;
            q0_h1 <= q0_h0;
        end if;
    end process;

    recapture_0b : process(clk180)
    begin
       if clk180'event and clk180 = '1' then
            q0_h0 <= q_h;
        end if;
    end process;

    q0 <= q0_h1 & q0_l1;

    --
    -- Retime DQ from 'clkc0/180' domain to 'clk' domain, using 'clk180/clk0'
    --

    recapture_180a : process(clk180)
    begin
       if clk180'event and clk180 = '1' then
            q180_l0 <= q_l;
        end if;
    end process;

    recapture_180b : process(clk0)
    begin
       if clk0'event and clk0 = '1' then
            q180_h0 <= q_h;
            q180_l1 <= q180_l0;
        end if;
    end process;

    q180 <= q180_h0 & q180_l1;

    --
    -- Generate 'q', selecting either:
    --
    -- (a) IOB-captured data that has been retimed using 'clk0/180', OR
    -- (b) IOB-captured data that has been retimed using 'clk180/0'.
    --
    -- This is necessary because 'clkc0' will either be at least 180 degrees
    -- different from 'clk0', in which case (a) applies, OR at least 180 degrees
    -- different from 'clk180', in which case (b) applies.
    --

    gen_i_q : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if cedge(0) = '1' then
                i_q <= q180;
            else
                i_q <= q0;
            end if;
        end if;
    end process;

    q <= EXT(i_q, d_width);

    --
    -- Generate tap value for SRLC16s that form a programmable delay line for
    -- 'valid' and 'qtag'
    --

    gen_srl_tap : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            case cedge(2 downto 1) is
                when "00" =>
                    srl_tap <= "0011";
                when "01" =>
                    srl_tap <= "0100";
                when "10" =>
                    srl_tap <= "0101";
                when "11"  =>
                    srl_tap <= "0110";
                when others =>
                    srl_tap <= "----";
            end case;
        end if;
    end process;

    --
    -- Programmable delay lines for 'valid' and 'qtag'
    --

    do_read_ntrn <= do_read and trn_done;

    gen_valid_not_init : SRLC16E
        port map(
            D => do_read_ntrn,
            CE => logic1,
            CLK => clk0,
            A0 => srl_tap(0),
            A1 => srl_tap(1),
            A2 => srl_tap(2),
            A3 => srl_tap(3),
            Q => i_valid,
            Q15 => open);

    do_read_trn <= do_read and not trn_done;

    gen_trn_valid : SRLC16E
        port map(
            D => do_read_trn,
            CE => logic1,
            CLK => clk0,
            A0 => srl_tap(0),
            A1 => srl_tap(1),
            A2 => srl_tap(2),
            A3 => srl_tap(3),
            Q => trn_valid,
            Q15 => open);

    gen_tag : for i in qtag'range generate
        U0 : SRLC16E
            port map(
                D => cmd_q2_tag(i),
                CE => logic1,
                CLK => clk0,
                A0 => srl_tap(0),
                A1 => srl_tap(1),
                A2 => srl_tap(2),
                A3 => srl_tap(3),
                Q => i_qtag(i),
                Q15 => open);
    end generate;

    --
    -- Generate clocks to SSRAM device
    --

    gen_k_o : FDDRCPE
        -- synthesis translate_off
        generic map(
            INIT => '0')
        -- synthesis translate_on
        port map(
            Q => k_o,
            C0 => clk90,
            C1 => clk270,
            CE => logic1,
            D0 => logic1,
            D1 => logic0,
            CLR => logic0,
            PRE => logic0);

    gen_k_o_l : FDDRCPE
        -- synthesis translate_off
        generic map(
            INIT => '1')
        -- synthesis translate_on
        port map(
            Q => k_o_l,
            C0 => clk90,
            C1 => clk270,
            CE => logic1,
            D0 => logic0,
            D1 => logic1,
            CLR => logic0,
            PRE => logic0);

    gen_c_o : FDDRCPE
        -- synthesis translate_off
        generic map(
            INIT => '0')
        -- synthesis translate_on
        port map(
            Q => c_o,
            C0 => clk90,
            C1 => clk270,
            CE => logic1,
            D0 => logic1,
            D1 => logic0,
            CLR => logic0,
            PRE => logic0);

    gen_c_o_l : FDDRCPE
        -- synthesis translate_off
        generic map(
            INIT => '1')
        -- synthesis translate_on
        port map(
            Q => c_o_l,
            C0 => clk90,
            C1 => clk270,
            CE => logic1,
            D0 => logic0,
            D1 => logic1,
            CLR => logic0,
            PRE => logic0);

    --
    -- Generate 'ra_o' (address to SSRAM device)
    --

    gen_ra_o : process(clk270)
    begin
        if clk270'event and clk270 = '1' then
            ra_o(ra_width - 1 downto 1) <= b_addr;
            ra_o(0) <= '0';
        end if;
    end process;

    --
    -- Address is always driven to SSRAM device
    --

    ra_t <= (others => '0');

    --
    -- Generate 'doff_o_l' (DOFF#)
    --

    gen_doff_o_l : process(lsr, clk0)
    begin
        if lsr = '1' then
            -- Assert DOFF# asynchronously to reset DLL on DDR-II SSRAM device
            doff_o_l <= '0';
        elsif clk0'event and clk0 = '1' then
            -- Deassert DOFF# synchronously, assuming 'dll_off' in normal state (0)
            doff_o_l <= not dll_off;
        end if;
    end process;

    --
    -- Package up control signals into 'rc_o' bus, in a model-dependent way.
    -- Also generate tristate controls 'rc_t' for 'rc_o'.
    --

    gen_rc_o : process(
        be_o_l,
        ld_o_l,
        w_o_l,
        k_o,
        k_o_l,
        c_o,
        c_o_l,
        doff_o_l)
        variable index : natural;
    begin
        index := 0;

        -- Byte enables
        rc_o(index + bwe_width - 1 downto index) <= be_o_l;
        rc_t(index + bwe_width - 1 downto index) <= (others => '0');
        index := index + bwe_width;

        -- ADV/LD#
        rc_o(index) <= ld_o_l;
        rc_t(index) <= '0';
        index := index + 1;

        -- R/W#
        rc_o(index) <= w_o_l;
        rc_t(index) <= '0';
        index := index + 1;

        -- K & K#
        rc_o(index) <= k_o;
        rc_t(index) <= '0';
        rc_o(index + 1) <= k_o_l;
        rc_t(index + 1) <= '0';
        index := index + 2;

        -- C & C# (if present)
        if pinout.has_c then
            rc_o(index) <= c_o;
            rc_t(index) <= '0';
            rc_o(index + 1) <= c_o_l;
            rc_t(index + 1) <= '0';
            index := index + 2;
        end if;

        -- CQ & CQ# (if present)
        if pinout.has_cq then
            rc_o(index) <= '-';     -- CQ is an input, so don't care
            rc_t(index) <= '1';     -- Never drive CQ
            rc_o(index + 1) <= '-'; -- CQ# is an input, so don't care
            rc_t(index + 1) <= '1'; -- Never drive CQ#
            index := index + 2;
        end if;

        -- DOFF#
        rc_o(index) <= doff_o_l;
        rc_t(index) <= '0';
    end process;

    --
    -- DDR-II SSRAM training state machine
    --
    -- This state machine waits for the initialization state machine above to
    -- signal 'init_done', and then writes a pattern of 4 words (8 DDR words)
    -- to the first 4 logical locations in the memory. It then waits for
    -- 3 kinds of event (in order of highest to lowest prority):
    --
    --   1. 'tstcomp', indicating end of training
    --   2. 'tstdo', indicating that it should perform a test readback of the
    --      memory.
    --

    gen_trn_dq_o : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            case patt_addr is
                when "00" =>
                    trn_dq_o(1 * rd_width - 1 downto 0 * rd_width) <= (others => '1');
                    trn_dq_o(2 * rd_width - 1 downto 1 * rd_width) <= (others => '0');
                when "01" =>
                    trn_dq_o(1 * rd_width - 1 downto 0 * rd_width) <= (others => '1');
                    trn_dq_o(2 * rd_width - 1 downto 1 * rd_width) <= (others => '0');
                when "10" =>
                    trn_dq_o(1 * rd_width - 1 downto 0 * rd_width) <= (others => '0');
                    trn_dq_o(2 * rd_width - 1 downto 1 * rd_width) <= (others => '1');
                when "11" =>
                    trn_dq_o(1 * rd_width - 1 downto 0 * rd_width) <= (others => '1');
                    trn_dq_o(2 * rd_width - 1 downto 1 * rd_width) <= (others => '0');
                when others =>
                    trn_dq_o <= (others => '-');
            end case;

            trn_rd_q <= trn_rd;
            trn_wr_q <= trn_wr;
            trn_rdwr_q <= trn_rd or trn_wr;
            trn_addr <= patt_addr;
        end if;
    end process;

    count_valid : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if sr_num_valid = '1' then
                num_valid <= (others => '0');
            else
                if trn_valid = '1' then
                    num_valid <= num_valid + 1;
                end if;
            end if;
        end if;
    end process;

    check_dq_i : process(clk0)
        variable exp_q : std_logic_vector(rd_width * 2 - 1 downto 0);
    begin
        if clk0'event and clk0 = '1' then
            case num_valid(1 downto 0) is
                when "00" =>
                    exp_q(1 * rd_width - 1 downto 0 * rd_width) := (others => '1');
                    exp_q(2 * rd_width - 1 downto 1 * rd_width) := (others => '0');
                when "01" =>
                    exp_q(1 * rd_width - 1 downto 0 * rd_width) := (others => '1');
                    exp_q(2 * rd_width - 1 downto 1 * rd_width) := (others => '0');
                when "10" =>
                    exp_q(1 * rd_width - 1 downto 0 * rd_width) := (others => '0');
                    exp_q(2 * rd_width - 1 downto 1 * rd_width) := (others => '1');
                when "11" =>
                    exp_q(1 * rd_width - 1 downto 0 * rd_width) := (others => '1');
                    exp_q(2 * rd_width - 1 downto 1 * rd_width) := (others => '0');
                when others =>
                    exp_q := (others => '-');
            end case;

            if AND_reduce(exp_q xnor i_q) = '1' then
                match <= '1';
            else
                match <= '0';
            end if;

            trn_valid_q <= trn_valid;

            if sr_num_valid = '1' then
                -- assume OK, will zero if incorrect data seen
                i_tstok <= '1';
            else
                if trn_valid_q = '1' then
                    if match /= '1' then
                        i_tstok <= '0';
                    end if;
                end if;
            end if;
        end if; 
    end process;

    gen_state3 : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if lsr = '1' then
                state3 <= s3_start;
                num_read <= (others => '-');
                patt_addr <= "--";
                sr_num_valid <= '0';
                timer3 <= (others => '-');
                trn_done <= '0';
                trn_rd <= '0';
                trn_wr <= '0';
                i_tstdone <= '0';
            else
                state3 <= n_state3;
                num_read <= n_num_read;
                patt_addr <= n_patt_addr;
                sr_num_valid <= n_sr_num_valid;
                timer3 <= n_timer3;
                trn_done <= n_trn_done;
                trn_rd <= n_trn_rd;
                trn_wr <= n_trn_wr;
                i_tstdone <= n_tstdone;
            end if;
        end if;
    end process;

    gen_n_state3 : process(
        state3,
        num_read,
        num_valid,
        patt_addr,
        power_on_done,
        timer3,
        tstcomp,
        tstdo)
    begin
        case state3 is
            when s3_start =>
                if power_on_done = '1' then
                    n_state3 <= s3_write_pattern;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "00";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '1';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_start;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_write_pattern =>
                if patt_addr = "11" then
                    n_state3 <= s3_wait_event;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_write_pattern;
                    n_num_read <= (others => '-');
                    n_patt_addr <= patt_addr + 1;
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '1';
                    n_tstdone <= '0';
                end if;

            when s3_wait_event =>
                if tstcomp = '1' then
                    n_state3 <= s3_finished;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    if tstdo = '1' then
                        n_state3 <= s3_reading;
                        n_num_read <= (others => '0');
                        n_patt_addr <= "00";
                        n_sr_num_valid <= '1';
                        n_timer3 <= (others => '-');
                        n_trn_done <= '0';
                        n_trn_rd <= '1';
                        n_trn_wr <= '0';
                        n_tstdone <= '0';
                    else
                        n_state3 <= s3_wait_event;
                        n_num_read <= (others => '-');
                        n_patt_addr <= "--";
                        n_sr_num_valid <= '0';
                        n_timer3 <= (others => '-');
                        n_trn_done <= '0';
                        n_trn_rd <= '0';
                        n_trn_wr <= '0';
                        n_tstdone <= '0';
                    end if;
                end if;

            when s3_reading =>
                if num_read = 7 then
                    n_state3 <= s3_wait_valid;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_reading;
                    n_num_read <= num_read + 1;
                    n_patt_addr <= patt_addr + 1;
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '1';
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
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_wait_valid;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_checking =>
                if AND_reduce(timer3) = '1' then
                    n_state3 <= s3_wait_tstdo;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '1';
                else
                    n_state3 <= s3_checking;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= timer3 + 1;
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
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
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                else
                    n_state3 <= s3_wait_tstdo;
                    n_num_read <= (others => '-');
                    n_patt_addr <= "--";
                    n_sr_num_valid <= '0';
                    n_timer3 <= (others => '-');
                    n_trn_done <= '0';
                    n_trn_rd <= '0';
                    n_trn_wr <= '0';
                    n_tstdone <= '0';
                end if;

            when s3_finished =>
                n_state3 <= s3_finished;
                n_num_read <= (others => '-');
                n_patt_addr <= "--";
                n_sr_num_valid <= '0';
                n_timer3 <= (others => '-');
                n_trn_done <= '1';
                n_trn_rd <= '0';
                n_trn_wr <= '0';
                n_tstdone <= '0';
        end case;
    end process;

    --
    -- Instantiate I/O buffers
    --

    gen_ra : for i in 0 to ra_width - 1 generate
        U0 : OBUF
            port map(
                I => ra_o(i),
                O => ra(i));
    end generate;

    gen_rc : for i in 0 to rc_width - 1 generate
        U0 : IOBUF
            port map(
                I => rc_o(i),
                IO => rc(i),
                O => rc_i(i),
                T => rc_t(i));
    end generate;

    gen_rd : for i in 0 to rd_width - 1 generate
        U0 : IOBUF
            port map(
                I => rd_o(i),
                IO => rd(i),
                O => rd_i(i),
                T => rd_t(i));
    end generate;

    --
    -- Debug
    --
    -- Ensure that the 'dummy' parameter of 'ila0' is true in production code.
    --

--    trig0(63 downto 0) <= EXT(i_q, 64);
--    trig0(66 downto 64) <= cedge;
--    trig0(67) <= tstcomp;
--    trig0(68) <= tstdo;
--    trig0(69) <= i_tstdone;
--    trig0(70) <= i_tstok;
--    trig0(74 downto 71) <= num_valid;
--    trig0(75) <= match;
--    trig0(76) <= trn_valid;
--    trig0(77) <= trn_valid_q;
--    trig0(80 downto 78) <= num_read;
--    trig0(82 downto 81) <= patt_addr;
--    trig0(83) <= sr_num_valid;
--    trig0(85 downto 84) <= timer3;
--    trig0(86) <= trn_done;
--    trig0(87) <= trn_rd;
--    trig0(88) <= trn_rd_q;
--    trig0(89) <= trn_wr;
--    trig0(90) <= trn_wr_q;
--    trig0(91) <= trn_rdwr_q;
--    trig0(93 downto 92) <= trn_addr;
--    trig0(254 downto 94) <= (others => '0');

--    ila0 : ilacombo
--        generic map(
--            dummy => true)
--        port map(
--            clk => clk0,
--            trig0 => trig0,
--            trig_out => trig_out);

end mixed;
