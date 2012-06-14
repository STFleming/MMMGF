--
-- ddr2sram_port_v4.vhd - DDR-II SSRAM interface for Virtex-4 / Virtex-5
--
-- SYNTHESIZABLE
--
-- This memory interface assumes a burst length 4 device, although it
-- is also compatible with burst length 2 devices.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

library work;
use work.memif.all;
use work.memif_int.all;

entity ddr2sram_port_v4 is
    generic(
        pinout          : in    ddr2sram_pinout_t;
        ra_width        : in    natural;
        rd_width        : in    natural;
        rc_width        : in    natural;
        a_width         : in    natural;
        d_width         : in    natural;
        tag_width       : in    natural);
    port(
        clk0            : in    std_logic;                                   -- Clock, baseline phase
        clk45           : in    std_logic;                                   -- As 'clk0' but 45 degrees ahead
        clk2x0          : in    std_logic;                                   -- As 'clk0' but double the frequency
        clk2x90         : in    std_logic;                                   -- As 'clk45' but double the frequency
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
        -- Sideband control signals (inputs must be stable during operation)
        dll_off         : in    std_logic;                                   -- Disables DLL in SSRAM device when high
        trained         : out   std_logic;                                   -- 1 => training was successful
        -- To/from memories
        ra              : out   std_logic_vector(ra_width - 1 downto 0);
        rc              : inout std_logic_vector(rc_width - 1 downto 0);
        rd              : inout std_logic_vector(rd_width - 1 downto 0));
end entity;

architecture mixed of ddr2sram_port_v4 is

    component OBUF
        port(
            I  : in    std_logic;
            O  : out   std_logic);
    end component;

    component IOBUF
        port(
            I  : in    std_logic;
            IO : inout std_logic;
            O  : out   std_logic;
            T  : in    std_logic);
    end component;

    component ddr2sram_bwe
        generic(
            bwe_width       : in  natural);
        port(
            clk0            : in  std_logic;
            clk45           : in  std_logic;
            clk2x0          : in  std_logic;
            clk2x90         : in  std_logic;
            sr              : in  std_logic_vector(bwe_width - 1 downto 0);
            ce              : in  std_logic_vector(bwe_width - 1 downto 0);
            be_l            : in  std_logic_vector(bwe_width * 4 - 1 downto 0);
            bwe_o_l         : out std_logic_vector(bwe_width - 1 downto 0);
            bwe_t           : out std_logic_vector(bwe_width - 1 downto 0));
    end component;

    component ddr2sram_dq_in
        generic(
            dq_width        : in  natural;
            tag_width       : in  natural);
        port( 
            clk0            : in  std_logic;
            clk45           : in  std_logic;
            clk2x0          : in  std_logic;
            clk2x90         : in  std_logic;
            sr              : in  std_logic_vector(dq_width - 1 downto 0);
            ce              : in  std_logic_vector(dq_width - 1 downto 0);
            dlysr           : in  std_logic_vector(dq_width - 1 downto 0);
            dlyce           : in  std_logic_vector(dq_width - 1 downto 0);
            dlyinc          : in  std_logic_vector(dq_width - 1 downto 0);
            qce             : in  std_logic_vector(dq_width - 1 downto 0);
            qdelay          : in  std_logic_vector(dq_width * 2 - 1 downto 0);
            vdelay          : in  std_logic_vector(3 downto 0);
            rd              : in  std_logic;
            train_done      : in  std_logic;
            tag             : in  std_logic_vector(tag_width - 1 downto 0);
            dq_i            : in  std_Logic_vector(dq_width - 1 downto 0);
            q               : out std_logic_vector(dq_width * 4 - 1 downto 0);
            dq              : out std_logic_vector(dq_width - 1 downto 0); -- unregistered data, for debug
            qtag            : out std_logic_vector(tag_width - 1 downto 0);
            valid           : out std_logic;
            train_valid     : out std_logic);
    end component;

    component ddr2sram_dq_out
        generic(
            dq_width        : in  natural);
        port( 
            clk0            : in  std_logic;
            clk45           : in  std_logic;
            clk2x0          : in  std_logic;
            clk2x90         : in  std_logic;
            sr              : in  std_logic_vector(dq_width - 1 downto 0);
            ce              : in  std_logic_vector(dq_width - 1 downto 0);
            oe_l            : in  std_logic_vector(dq_width - 1 downto 0);
            d               : in  std_logic_vector(dq_width * 4 - 1 downto 0);
            dq_o            : out std_logic_vector(dq_width - 1 downto 0);
            dq_t            : out std_Logic_vector(dq_width - 1 downto 0));
    end component;

    component ddr2sram_training
        generic(
            dq_width        : in    natural);
        port(
            clk             : in    std_logic;
            rst             : in    std_logic;
            sr              : in    std_logic;
            dq_i            : in    std_logic_vector(4 * dq_width - 1 downto 0);
            valid           : in    std_logic;
            rd              : out   std_logic;
            wr              : out   std_logic;
            addr            : out   std_logic_vector(2 downto 0);
            done            : out   std_logic;
            trained         : out   std_logic;
            dq_o            : out   std_logic_vector(4 * dq_width - 1 downto 0);
            dlysr_dq        : out   std_logic_vector(dq_width - 1 downto 0);
            dlyce_dq        : out   std_logic_vector(dq_width - 1 downto 0);
            dlyinc_dq       : out   std_logic_vector(dq_width - 1 downto 0);
            qce             : out   std_logic_vector(dq_width - 1 downto 0);
            qdelay          : out   std_logic_vector(dq_width * 2 - 1 downto 0);
            vdelay          : out   std_logic_vector(3 downto 0));
    end component;

    component ODDR
        generic(
            DDR_CLK_EDGE : in  string := "OPPOSITE_EDGE";
            INIT         : in  bit := '1';
            SRTYPE       : in  string := "SYNC");
        port(
            D1           : in  std_logic;
            D2           : in  std_logic;
            CE           : in  std_logic;
            C            : in  std_logic;
            S            : in  std_logic;
            R            : in  std_logic;
            Q            : out std_logic);
    end component;

    constant bwe_width : natural := rd_width / 8;
    constant be_width : natural := bwe_width * 4;
    constant cmd_width : natural := (rd_width * 4) + be_width + (ra_width - 2) + 1 + tag_width;

    signal read : std_logic;
    signal i_q : std_logic_vector(rd_width * 4 - 1 downto 0);
    signal i_valid : std_logic;
    signal i_qtag : std_logic_vector(tag_width - 1 downto 0);
    signal i_ready : std_logic;

    -- Signals to/from command FIFO
    signal cmd_d : std_logic_vector(cmd_width - 1 downto 0);
    signal cmd_q : std_logic_vector(cmd_width - 1 downto 0);
    signal cmd_q_d : std_logic_vector(rd_width * 4 - 1 downto 0);
    signal cmd_q_be_l : std_logic_vector(be_width - 1 downto 0);
    signal cmd_q_a : std_logic_vector(ra_width - 3 downto 0);
    signal cmd_q_w : std_logic;
    signal cmd_q_tag : std_logic_vector(tag_width - 1 downto 0);
    signal cmd_empty : std_logic;
    signal cmd_prev_rd : std_logic;
    signal cmd_stall : std_logic;
    signal cmd_read : std_logic;

    -- IDELAY control signals for DQ and DQS
    signal dlysr_dq : std_logic_vector(rd_width - 1 downto 0);
    signal dlyce_dq : std_logic_vector(rd_width - 1 downto 0);
    signal dlyinc_dq : std_logic_vector(rd_width - 1 downto 0);

    -- Delay values obtained from training
    signal qce : std_logic_vector(rd_width - 1 downto 0);
    signal qdelay : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal vdelay : std_logic_vector(3 downto 0);

    signal train_a : std_logic_vector(2 downto 0);
    signal train_d : std_logic_vector(rd_width * 4 - 1 downto 0);
    signal train_done : std_logic;
    signal train_rd : std_logic;
    signal train_valid : std_logic;
    signal train_wr : std_logic;

    signal dq_out : std_logic_vector(rd_width * 4 - 1 downto 0);
    signal be_out_l : std_logic_vector(be_width - 1 downto 0);

    signal bwe_o_l : std_logic_vector(bwe_width - 1 downto 0);
    signal bwe_t : std_logic_vector(bwe_width - 1 downto 0);
    signal ld_o_l : std_logic;
    signal w_o_l : std_logic;
    signal k_o : std_logic;
    signal k_o_l : std_logic;
    signal c_o : std_logic;
    signal c_o_l : std_logic;
    signal doff_o_l : std_logic;

    signal dq_oe_l : std_logic_vector(rd_width - 1 downto 0);

    signal ra_o : std_logic_vector(ra_width - 1 downto 0);
    signal rc_t : std_logic_vector(rc_width - 1 downto 0);
    signal rc_o : std_logic_vector(rc_width - 1 downto 0);
    signal rc_i : std_logic_vector(rc_width - 1 downto 0);
    signal rd_t : std_logic_vector(rd_width - 1 downto 0);
    signal rd_o : std_logic_vector(rd_width - 1 downto 0);
    signal rd_i : std_logic_vector(rd_width - 1 downto 0);

    -- Allow sufficient time for DLL within DDR-II SSRAM device to lock,
    -- after reset is removed and clocks begin to toggle.
    signal lsrcnt : std_logic_vector(12 downto 0);
    signal lsr0 : std_logic;
    signal lsr1 : std_logic;
    signal lsr2 : std_logic;

    signal ce0_dq, ce1_dq : std_logic;
    signal ce_dq : std_logic_vector(rd_width - 1 downto 0);
    signal ce_bwe : std_logic_vector(bwe_width - 1 downto 0);
    signal sr0_dq : std_logic;
    signal sr_dq : std_logic_vector(rd_width - 1 downto 0);
    signal sr_bwe : std_logic_vector(bwe_width - 1 downto 0);

    signal logic0 : std_logic;
    signal logic1 : std_logic;

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

begin

    logic0 <= '0';
    logic1 <= '1';

    --
    -- Generate interface outputs from internal versions of signals.
    --

    q <= EXT(i_q, d_width); -- Truncate SRAM data if necessary
    qtag <= i_qtag;
    valid <= i_valid;
    ready <= i_ready;

    --
    -- Buffer incoming commands in command FIFO and generate 'ready'.
    --

    cmd_d <= tag & w & EXT(a, ra_width - 2) & be & EXT(d, rd_width * 4);

    cmd_fifo_0 : cmd_fifo
        generic map(
            width => cmd_width)
        port map(
            clk => clk0,
            rst => logic0,
            sr => lsr1,
            w => ce,
            d => cmd_d,
            ready => i_ready,
            r => cmd_read,
            empty => cmd_empty,
            q => cmd_q);

    cmd_q_d <= cmd_q(rd_width * 4 - 1 downto 0);
    cmd_q_be_l <= not cmd_q(rd_width * 4 + be_width - 1 downto rd_width * 4);
    cmd_q_a <= cmd_q(rd_width * 4 + be_width + ra_width - 3 downto rd_width * 4 + be_width);
    cmd_q_w <= cmd_q(rd_width * 4 + be_width + ra_width - 2);
    cmd_q_tag <= cmd_q(rd_width * 4 + be_width + ra_width - 2 + tag_width downto rd_width * 4 + be_width + ra_width - 1);

    remember_read : process(rst, clk0)
    begin
        if clk0'event and clk0 = '1' then
            cmd_prev_rd <= cmd_read and not cmd_q_w;
        end if;
    end process;

    -- If next command is a write, but previous clock cycle was a read, stall
    -- for 1 cycle.
    cmd_stall <= cmd_q_w and cmd_prev_rd;
    cmd_read <= not cmd_empty and train_done and not cmd_stall;

    --
    -- Generate DDR-II SSRAM address, 'ra_o'.
    --
    -- Bit 1 of the address toggles freely at the SSRAM device clock frequency,
    -- so that burst length 2 and 4 SSRAM devices work with this interface.
    --

    gen_ra_o : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if train_done = '1' then
                ra_o(ra_width - 1 downto 2) <= EXT(cmd_q_a, ra_width - 2);
            else
                ra_o(ra_width - 1 downto 3) <= (others => '0');
                ra_o(2) <= train_a(2);
            end if;
            ra_o(0) <= '0';
        end if;
    end process;

    gen_ra_o_1 : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => logic0,
            D2 => logic1,
            CE => logic1,
            C  => clk0,
            S  => logic0,
            R  => logic0,
            Q  => ra_o(1));

    --
    -- Generate DDR-II SSRAM control bus, 'rc_o'.
    --

    gen_doff_o_l : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            doff_o_l <= not dll_off;
        end if;
    end process;

    gen_ld_o_l : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            ld_o_l <= not (cmd_read or train_wr or train_rd);
        end if;
    end process;

    gen_w_o_l : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            w_o_l <= not ((cmd_read and cmd_q_w) or train_wr);
        end if;
    end process;

    gen_k_o : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => logic0,
            D2 => logic1,
            CE => logic1,
            C  => clk2x0,
            S  => logic0,
            R  => logic0,
            Q  => k_o);

    gen_k_o_l : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => logic1,
            D2 => logic0,
            CE => logic1,
            C  => clk2x0,
            S  => logic0,
            R  => logic0,
            Q  => k_o_l);

    gen_c_o : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => logic0,
            D2 => logic1,
            CE => logic1,
            C  => clk2x0,
            S  => logic0,
            R  => logic0,
            Q  => c_o);

    gen_c_o_l : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => logic1,
            D2 => logic0,
            CE => logic1,
            C  => clk2x0,
            S  => logic0,
            R  => logic0,
            Q  => c_o_l);

    -- Bundle up the individual clocks and control signals into the 'rc_o' bus.
    gen_rc_o : process(
        bwe_o_l,
        bwe_t,
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
        rc_o(index + bwe_width - 1 downto index) <= bwe_o_l;
        rc_t(index + bwe_width - 1 downto index) <= bwe_t;
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
    -- Outbound data path (writing to SRAM)
    --

    dq_oe_l <= (others => not ((cmd_read and cmd_q_w) or train_wr));

    dq_out <= cmd_q_d when train_done = '1' else train_d;

    dq_out_0 : ddr2sram_dq_out
        generic map(
            dq_width => rd_width)
        port map(
            clk0 => clk0,
            clk45 => clk45,
            clk2x0 => clk2x0,
            clk2x90 => clk2x90,
            sr => sr_dq,
            ce => ce_dq,
            oe_l => dq_oe_l,
            d => dq_out,
            dq_o => rd_o,
            dq_t => rd_t);

    be_out_l <= cmd_q_be_l when train_done = '1' else (others => '0');

    bwe_0 : ddr2sram_bwe
        generic map(
            bwe_width => bwe_width)
        port map(
            clk0 => clk0,
            clk45 => clk45,
            clk2x0 => clk2x0,
            clk2x90 => clk2x90,
            sr => sr_bwe,
            ce => ce_bwe,
            be_l => be_out_l,
            bwe_o_l => bwe_o_l,
            bwe_t => bwe_t);

    --
    -- Inbound data path (reading SRAM)
    --

    read <= (cmd_read and not cmd_q_w) or train_rd;

    dq_in_0 : ddr2sram_dq_in
        generic map(
            dq_width => rd_width,
            tag_width => tag_width)
        port map(
            clk0 => clk0,
            clk45 => clk45,
            clk2x0 => clk2x0,
            clk2x90 => clk2x90,
            sr => sr_dq,
            ce => ce_dq,
            dlysr => dlysr_dq,
            dlyce => dlyce_dq,
            dlyinc => dlyinc_dq,
            qce => qce,
            qdelay => qdelay,
            vdelay => vdelay,
            rd => read,
            train_done => train_done,
            tag => cmd_q_tag,
            dq_i => rd_i,
            q => i_q,
            dq => open,
            qtag => i_qtag,
            valid => i_valid,
            train_valid => train_valid);

    --
    -- Instantiate training module; takes control of this interface after
    -- reset and relinquishes control after the interface has been trained.
    --

    training_0 : ddr2sram_training
        generic map(
            dq_width => rd_width)
        port map(
            clk => clk0,
            rst => logic0,
            sr => lsr0,
            dq_i => i_q,
            valid => train_valid,
            rd => train_rd,
            wr => train_wr,
            addr => train_a,
            done => train_done,
            trained => trained,
            dq_o => train_d,
            dlysr_dq => dlysr_dq,
            dlyce_dq => dlyce_dq,
            dlyinc_dq => dlyinc_dq,
            qce => qce,
            qdelay => qdelay,
            vdelay => vdelay);

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
    -- Generate local resets for module
    --

    local_reset : process(clk0, rst)
    begin
        if rst = '1' then
            lsrcnt <= (others => '0');
            lsr0 <= '1';
            lsr1 <= '1';
            lsr2 <= '1';
        elsif clk0'event and clk0 = '1' then
            if sr = '1' then
                lsrcnt <= (others => '0');
                lsr0 <= '1';
                lsr1 <= '1';
                lsr2 <= '1';
            else
                if lsr0 = '1' then
                    lsrcnt <= lsrcnt + 1;
                    if lsrcnt(12 downto 11) = "11" then
                        -- Deassert reset for most logic in this interface
                        lsr0 <= '0';
                    end if;
                    if lsrcnt(12 downto 11) = "10" then
                        -- All clock enables for ISERDES and OSERDES to be asserted
                        lsr1 <= '0';
                    end if;
                    if lsrcnt(12 downto 10) = "01" then
                        -- Allow resets for ISERDES and OSERDES to be deasserted
                        lsr2 <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;

    --
    -- Generate local reset and clock enables for ISERDES and OSERDES primitives for DQ / DM pins
    --

    local_reset_dq : process(clk45, rst)
    begin
        if rst = '1' then
            ce0_dq <= '0';
            ce1_dq <= '0';
            ce_bwe <= (others => '0');
            ce_dq <= (others => '0');
            sr0_dq <= '1';
            sr_bwe <= (others => '1');
            sr_dq <= (others => '1');
        elsif clk45'event and clk45 = '1' then
            if lsr1 = '1' then
                ce0_dq <= '0';
                ce1_dq <= '0';
                ce_bwe <= (others => '0');
                ce_dq <= (others => '0');
            else
                ce0_dq <= '1';
                ce1_dq <= ce0_dq;
                ce_bwe <= (others => ce1_dq);
                ce_dq <= (others => ce1_dq);
            end if;

            if lsr2 = '1' then
                sr0_dq <= '1';
                sr_bwe <= (others => '1');
                sr_dq <= (others => '1');
            else
                sr0_dq <= '0';
                sr_bwe <= (others => sr0_dq);
                sr_dq <= (others => sr0_dq);
            end if;
        end if;
    end process;

end mixed;
