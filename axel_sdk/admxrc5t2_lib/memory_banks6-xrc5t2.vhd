--
-- memory_banks6-xrc5t2.vhd - Memory banks for ADM-XRC-5T2
--
-- (C) Copyright Alpha Data 2008
--
-- SYNTHESIZABLE
--
-- Targets models:
--
--   o ADM-XRC-5T2 with 5VLX330T / 5VFX200T / 5VSX240T
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

library work;
use work.memif.all;
use work.admxrc5t2_common.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

entity memory_banks is
    generic(
        addr_width    : in    natural;
        data_width    : in    natural;
        bank0         : in    bank_t;
        bank1         : in    bank_t;
        bank2         : in    bank_t;
        bank3         : in    bank_t;
        bank4         : in    bank_t;
        bank5         : in    bank_t;
        bank6         : in    bank_t;
        bank7         : in    bank_t;
        bank8         : in    bank_t;
        bank9         : in    bank_t;
        bank10        : in    bank_t;
        bank11        : in    bank_t;
        bank12        : in    bank_t;
        bank13        : in    bank_t;
        bank14        : in    bank_t;
        bank15        : in    bank_t;
        num_ramclk    : in    natural);
    port(
        rst           : in    std_logic;
        clk           : in    std_logic;
        mclk_i        : in    std_logic;
        refclk_i      : in    std_logic; -- 200MHz clock from oscillator
        -- To/from local bus
        sel_bank_1h   : in    std_logic_vector(15 downto 0);
        bank_reg      : in    std_logic_vector(3 downto 0);
        mode_reg      : in    std_logic_vector(511 downto 0);
        mem_ce        : in    std_logic;
        mem_term      : in    std_logic;
        mem_cw        : in    std_logic;
        mem_adv       : in    std_logic;
        mem_wr        : in    std_logic;
        mem_a         : in    std_logic_vector(addr_width - 1 downto 0);
        mem_d         : in    std_logic_vector(data_width - 1 downto 0);
        mem_be        : in    std_logic_vector(data_width / 8 - 1 downto 0);
        mem_q         : out   std_logic_vector(data_width - 1 downto 0);
        mem_wf        : out   std_logic;
        mem_wpf       : out   std_logic;
        mem_re        : out   std_logic;
        mem_rpe       : out   std_logic;
        locked        : out   std_logic_vector(7 downto 0);
        trained       : out   std_logic_vector(15 downto 0);
        -- To/from user application
        user_req      : in    control_vector_t(max_num_bank - 1 downto 0);
        user_ce       : in    control_vector_t(max_num_bank - 1 downto 0);
        user_w        : in    control_vector_t(max_num_bank - 1 downto 0);
        user_a        : in    address_vector_t(max_num_bank - 1 downto 0);
        user_tag      : in    tag_vector_t(max_num_bank - 1 downto 0);
        user_d        : in    data_vector_t(max_num_bank - 1 downto 0);
        user_be       : in    be_vector_t(max_num_bank - 1 downto 0);
        user_rst      : out   std_logic;
        user_clk      : out   std_logic;
        user_clk2x    : out   std_logic;
        user_valid    : out   control_vector_t(max_num_bank - 1 downto 0);
        user_q        : out   data_vector_t(max_num_bank - 1 downto 0);
        user_qtag     : out   tag_vector_t(max_num_bank - 1 downto 0);
        user_ready    : out   control_vector_t(max_num_bank - 1 downto 0);
        -- To/from FPGA memory pins
        ra0           : out   std_logic_vector(bank0.ra_width - 1 downto 0);
        rc0           : inout std_logic_vector(bank0.rc_width - 1 downto 0);
        rd0           : inout std_logic_vector(bank0.rd_width - 1 downto 0);
        ra1           : out   std_logic_vector(bank1.ra_width - 1 downto 0);
        rc1           : inout std_logic_vector(bank1.rc_width - 1 downto 0);
        rd1           : inout std_logic_vector(bank1.rd_width - 1 downto 0);
        ra2           : out   std_logic_vector(bank2.ra_width - 1 downto 0);
        rc2           : inout std_logic_vector(bank2.rc_width - 1 downto 0);
        rd2           : inout std_logic_vector(bank2.rd_width - 1 downto 0);
        ra3           : out   std_logic_vector(bank3.ra_width - 1 downto 0);
        rc3           : inout std_logic_vector(bank3.rc_width - 1 downto 0);
        rd3           : inout std_logic_vector(bank3.rd_width - 1 downto 0);
        ra4           : out   std_logic_vector(bank4.ra_width - 1 downto 0);
        rc4           : inout std_logic_vector(bank4.rc_width - 1 downto 0);
        rd4           : inout std_logic_vector(bank4.rd_width - 1 downto 0);
        ra5           : out   std_logic_vector(bank5.ra_width - 1 downto 0);
        rc5           : inout std_logic_vector(bank5.rc_width - 1 downto 0);
        rd5           : inout std_logic_vector(bank5.rd_width - 1 downto 0);
        ra6           : out   std_logic_vector(bank6.ra_width - 1 downto 0);
        rc6           : inout std_logic_vector(bank6.rc_width - 1 downto 0);
        rd6           : inout std_logic_vector(bank6.rd_width - 1 downto 0);
        ra7           : out   std_logic_vector(bank7.ra_width - 1 downto 0);
        rc7           : inout std_logic_vector(bank7.rc_width - 1 downto 0);
        rd7           : inout std_logic_vector(bank7.rd_width - 1 downto 0);
        ra8           : out   std_logic_vector(bank8.ra_width - 1 downto 0);
        rc8           : inout std_logic_vector(bank8.rc_width - 1 downto 0);
        rd8           : inout std_logic_vector(bank8.rd_width - 1 downto 0);
        ra9           : out   std_logic_vector(bank9.ra_width - 1 downto 0);
        rc9           : inout std_logic_vector(bank9.rc_width - 1 downto 0);
        rd9           : inout std_logic_vector(bank9.rd_width - 1 downto 0);
        ra10          : out   std_logic_vector(bank10.ra_width - 1 downto 0);
        rc10          : inout std_logic_vector(bank10.rc_width - 1 downto 0);
        rd10          : inout std_logic_vector(bank10.rd_width - 1 downto 0);
        ra11          : out   std_logic_vector(bank11.ra_width - 1 downto 0);
        rc11          : inout std_logic_vector(bank11.rc_width - 1 downto 0);
        rd11          : inout std_logic_vector(bank11.rd_width - 1 downto 0);
        ra12          : out   std_logic_vector(bank12.ra_width - 1 downto 0);
        rc12          : inout std_logic_vector(bank12.rc_width - 1 downto 0);
        rd12          : inout std_logic_vector(bank12.rd_width - 1 downto 0);
        ra13          : out   std_logic_vector(bank13.ra_width - 1 downto 0);
        rc13          : inout std_logic_vector(bank13.rc_width - 1 downto 0);
        rd13          : inout std_logic_vector(bank13.rd_width - 1 downto 0);
        ra14          : out   std_logic_vector(bank14.ra_width - 1 downto 0);
        rc14          : inout std_logic_vector(bank14.rc_width - 1 downto 0);
        rd14          : inout std_logic_vector(bank14.rd_width - 1 downto 0);
        ra15          : out   std_logic_vector(bank15.ra_width - 1 downto 0);
        rc15          : inout std_logic_vector(bank15.rc_width - 1 downto 0);
        rd15          : inout std_logic_vector(bank15.rd_width - 1 downto 0);
        ramclki       : in    std_logic_vector(num_ramclk - 1 downto 0);
        ramclko       : out   std_logic_vector(num_ramclk - 1 downto 0));
end entity;

architecture mixed of memory_banks is

    constant num_bank_dram : natural := 4;
    constant num_bank_sram : natural := 2;
    constant num_bank : natural := num_bank_dram + num_bank_sram;

    constant mux_order_dram : natural := 1;
    constant port_width_dram : natural := 128;
    constant port_be_width_dram : natural := port_width_dram / 8;
    constant port_addr_width_dram : natural := addr_width - mux_order_dram;

    constant mux_order_sram : natural := 0;
    constant port_width_sram : natural := 64;
    constant port_be_width_sram : natural := port_width_sram / 8;
    constant port_addr_width_sram : natural := addr_width - mux_order_sram;

    signal logic0, logic1 : std_logic;

    signal memclk0 : std_logic;
    signal memclk45 : std_logic;
    signal memclk2x0 : std_logic;
    signal memclk2x90 : std_logic;
    signal memrst : std_logic;

    signal mem_cew : std_logic;

    signal rep_be_dram : std_logic_vector(port_be_width_dram - 1 downto 0);
    signal rep_d_dram : std_logic_vector(port_width_dram - 1 downto 0);
    signal rep_valid_dram : std_logic;
    signal rep_final_dram : std_logic;

    signal rep_be_sram : std_logic_vector(port_be_width_sram - 1 downto 0);
    signal rep_d_sram : std_logic_vector(port_width_sram - 1 downto 0);
    signal rep_valid_sram : std_logic;
    signal rep_final_sram : std_logic;

    signal tag_base : std_logic_vector(tag_width - 1 downto 0);
    signal tag_mask : std_logic_vector(tag_width - 1 downto 0);

    signal port_pce : std_logic_vector(num_bank - 1 downto 0);
    signal port_pcw : std_logic_vector(num_bank - 1 downto 0);
    signal port_pterm : std_logic_vector(num_bank - 1 downto 0);
    signal port_padv : std_logic_vector(num_bank - 1 downto 0);
    signal port_pwr : std_logic_vector(num_bank - 1 downto 0);
    signal port_pwf : std_logic_vector(num_bank - 1 downto 0);
    signal port_pwpf : std_logic_vector(num_bank - 1 downto 0);
    signal port_pre : std_logic_vector(num_bank - 1 downto 0);
    signal port_prpe : std_logic_vector(num_bank - 1 downto 0);

    type port_pq_dram_t is array(0 to num_bank_dram - 1) of std_logic_vector(port_width_dram - 1 downto 0);
    signal port_pq_dram : port_pq_dram_t;
    signal port_plast_dram : std_logic;
    signal port_pq_muxed_dram : std_logic_vector(port_width_dram - 1 downto 0);
    signal mem_q_dram : std_logic_vector(data_width - 1 downto 0);

    type port_pq_sram_t is array(0 to num_bank_sram - 1) of std_logic_vector(port_width_sram - 1 downto 0);
    signal port_pq_sram : port_pq_sram_t;
    signal port_plast_sram : std_logic;
    signal port_pq_muxed_sram : std_logic_vector(port_width_sram - 1 downto 0);
    signal mem_q_sram : std_logic_vector(data_width - 1 downto 0);

    type port_stag_t is array(0 to num_bank - 1) of std_logic_vector(tag_width - 1 downto 0);
    signal port_sce : std_logic_vector(num_bank - 1 downto 0);
    signal port_sw : std_logic_vector(num_bank - 1 downto 0);
    signal port_stag : port_stag_t;
    signal port_sqtag : port_stag_t;
    signal port_svalid : std_logic_vector(num_bank - 1 downto 0);
    signal port_sready : std_logic_vector(num_bank - 1 downto 0);
    signal port_sreq : std_logic_vector(num_bank - 1 downto 0);

    type port_sa_dram_t is array(0 to num_bank_dram - 1) of std_logic_vector(port_addr_width_dram - 1 downto 0);
    type port_sd_dram_t is array(0 to num_bank_dram - 1) of std_logic_vector(port_width_dram - 1 downto 0);
    type port_sbe_dram_t is array(0 to num_bank_dram - 1) of std_logic_vector(port_be_width_dram - 1 downto 0);
    signal port_sa_dram : port_sa_dram_t;
    signal port_sd_dram : port_sd_dram_t;
    signal port_sbe_dram : port_sbe_dram_t;
    signal port_sq_dram : port_sd_dram_t;

    type port_sa_sram_t is array(0 to num_bank_sram - 1) of std_logic_vector(port_addr_width_sram - 1 downto 0);
    type port_sd_sram_t is array(0 to num_bank_sram - 1) of std_logic_vector(port_width_sram - 1 downto 0);
    type port_sbe_sram_t is array(0 to num_bank_sram - 1) of std_logic_vector(port_be_width_sram - 1 downto 0);
    signal port_sa_sram : port_sa_sram_t;
    signal port_sd_sram : port_sd_sram_t;
    signal port_sbe_sram : port_sbe_sram_t;
    signal port_sq_sram : port_sd_sram_t;

    signal arb_ce : std_logic_vector(num_bank - 1 downto 0);
    signal arb_w : std_logic_vector(num_bank - 1 downto 0);
    signal arb_tag : port_stag_t;
    signal arb_qtag : port_stag_t;
    signal arb_valid : std_logic_vector(num_bank - 1 downto 0);
    signal arb_ready : std_logic_vector(num_bank - 1 downto 0);

    signal arb_a_dram : port_sa_dram_t;
    signal arb_d_dram : port_sd_dram_t;
    signal arb_be_dram : port_sbe_dram_t;
    signal arb_q_dram : port_sd_dram_t;

    signal arb_a_sram : port_sa_sram_t;
    signal arb_d_sram : port_sd_sram_t;
    signal arb_be_sram : port_sbe_sram_t;
    signal arb_q_sram : port_sd_sram_t;

    component memclk
        port(
            mclk              : in  std_logic;
            rst               : in  std_logic;
            refclk200         : in  std_logic;
            clk0              : out std_logic;
            clk45             : out std_logic;
            clk2x0            : out std_logic;
            clk2x90           : out std_logic;
            locked            : out std_logic_vector(1 downto 0);
            memrst            : out std_logic);
    end component;

begin

    logic0 <= '0';
    logic1 <= '1';

    mem_wf <= OR_reduce(sel_bank_1h(num_bank - 1 downto 0) and port_pwf);
    mem_wpf <= OR_reduce(sel_bank_1h(num_bank - 1 downto 0) and port_pwpf);
    mem_re <= OR_reduce(sel_bank_1h(num_bank - 1 downto 0) and port_pre);
    mem_rpe <= OR_reduce(sel_bank_1h(num_bank - 1 downto 0) and port_prpe);

    locked(7 downto 2) <= (others => '0');

    user_rst <= memrst;
    user_clk <= memclk0;
    user_clk2x <= memclk2x0;

    -- Unused memory banks
    trained(15 downto 6) <= (others => '0');

    --
    -- Instantiate logic to generate memory clocks
    --

    memclk_0 : memclk
        port map(
            mclk => mclk_i,
            rst => rst,
            refclk200 => refclk_i,
            clk0 => memclk0,
            clk45 => memclk45,
            clk2x0 => memclk2x0,
            clk2x90 => memclk2x90,
            locked => locked(1 downto 0),
            memrst => memrst);

    --
    -- Instantiate outbound data replicator for the DDR-II SDRAM banks
    --

    mem_cew <= mem_ce and mem_cw;

    port_repl_dram : port_repl
        generic map(
            order => mux_order_dram,
            in_width => data_width,
            out_width => port_width_dram,
            partial => true)
        port map(
            rst => rst,
            clk => clk,
            init => mem_cew,
            addr => mem_a(mux_order_dram - 1 downto 0),
            wr => mem_wr,
            last => mem_term,
            din => mem_d,
            bein => mem_be,
            dout => rep_d_dram,
            beout => rep_be_dram,
            valid => rep_valid_dram,
            final => rep_final_dram);

    --
    -- There is no outbound data replicator for the DDR-II SSRAM, since
    -- the width of the local bus data is the same as the width of a DDR-II
    -- SSRAM port on the ADM-XRC-5T2.
    --

    rep_d_sram <= mem_d;
    rep_be_sram <= mem_be;
    rep_valid_sram <= mem_wr;
    rep_final_sram <= mem_term;

    --
    -- Instantiate inbound data multiplexor for DDR-II SDRAM
    --

    gen_port_pq_muxed_dram : process(
        port_pq_dram,
        sel_bank_1h)
        variable x : std_logic_vector(port_width_dram - 1 downto 0);
    begin
        x := (others => '0');
        for i in 0 to num_bank_dram - 1 loop
            if sel_bank_1h(i) = '1' then
                x := x or port_pq_dram(i);
            end if;
        end loop;
        port_pq_muxed_dram <= x;
    end process;

    port_mux_dram : port_mux
        generic map(
            order => mux_order_dram,
            in_width => port_width_dram,
            out_width => data_width)
        port map(
            rst => rst,
            clk => clk,
            init => mem_ce,
            addr => mem_a(mux_order_dram - 1 downto 0),
            adv => mem_adv,
            din => port_pq_muxed_dram,
            dout => mem_q_dram,
            last => port_plast_dram);

    --
    -- There is no inbound data multiplexor for the DDR-II SSRAM, since the
    -- width of the local bus data is the same as the width of a DDR-II SSRAM
    -- port on the ADM-XRC-5T2.
    --

    gen_port_pq_muxed_sram : process(
        port_pq_sram,
        sel_bank_1h)
        variable x : std_logic_vector(port_width_sram - 1 downto 0);
    begin
        x := (others => '0');
        for i in 0 to num_bank_sram - 1 loop
            if sel_bank_1h(i + num_bank_dram) = '1' then
                x := x or port_pq_sram(i);
            end if;
        end loop;
        port_pq_muxed_sram <= x;
    end process;

    mem_q_sram <= port_pq_muxed_sram;
    port_plast_sram <= logic1;

    --
    -- Output outbound data to local bus
    --

    mem_q <= mem_q_sram when bank_reg(2) = '1' else mem_q_dram;

    --
    -- Tags used by local bus to memory interface are "00" and "01", leaving
    -- "10" and "11" spare.
    --

    tag_base <= EXT("00", tag_width);
    tag_mask <= EXT("01", tag_width);

    --
    -- Instantiate 'async_port' components for DDR-II SDRAM memory banks.
    --
    -- These instances decouple the local bus clock domain from the
    -- memory interface clock domain.
    --

    gen_async_ports_dram : for i in 0 to num_bank_dram - 1 generate
        port_pce(i) <= sel_bank_1h(i) and mem_ce;
        port_pcw(i) <= mem_cw;
        port_pterm(i) <= sel_bank_1h(i) and rep_final_dram;
        port_padv(i) <= sel_bank_1h(i) and port_plast_dram and mem_adv;
        port_pwr(i) <= sel_bank_1h(i) and rep_valid_dram;

        async_port_0 : async_port
            generic map(
                family => family_virtex5,
                order => 6,
                iwpfl => 4,
                orpel => 1,
                owpfl => 32,
                addr_width => port_addr_width_dram,
                data_width => port_width_dram,
                tag_width => 2)
            port map(
                rst => rst,
                pclk => clk,
                psr => logic0,
                pce => port_pce(i),
                pcw => port_pcw(i),
                pterm => port_pterm(i),
                padv => port_padv(i),
                pwr => port_pwr(i),
                pa => mem_a(addr_width - 1 downto mux_order_dram),
                pd => rep_d_dram,
                pbe => rep_be_dram,
                pq => port_pq_dram(i),
                pwf => port_pwf(i),
                pwpf => port_pwpf(i),
                pre => port_pre(i),
                prpe => port_prpe(i),
                sclk => memclk0,
                sce => port_sce(i),
                sw => port_sw(i),
                stag => port_stag(i),
                sa => port_sa_dram(i),
                sd => port_sd_dram(i),
                sbe => port_sbe_dram(i),
                sq => port_sq_dram(i),
                sqtag => port_sqtag(i),
                svalid => port_svalid(i),
                sready => port_sready(i),
                sreq => port_sreq(i),
                tag_base => tag_base,
                tag_mask => tag_mask);
    end generate;

    --
    -- Instantiate 'async_port' components for DDR-II SSRAM memory banks.
    --
    -- These instances decouple the local bus clock domain from the
    -- memory interface clock domain.
    --

    gen_async_ports_sram : for i in 0 to num_bank_sram - 1 generate
        port_pce(i + num_bank_dram) <= sel_bank_1h(i + num_bank_dram) and mem_ce;
        port_pcw(i + num_bank_dram) <= mem_cw;
        port_pterm(i + num_bank_dram) <= sel_bank_1h(i + num_bank_dram) and rep_final_sram;
        port_padv(i + num_bank_dram) <= sel_bank_1h(i + num_bank_dram) and port_plast_sram and mem_adv;
        port_pwr(i + num_bank_dram) <= sel_bank_1h(i + num_bank_dram) and rep_valid_sram;

        async_port_0 : async_port
            generic map(
                family => family_virtex5,
                order => 6,
                iwpfl => 3,
                orpel => 1,
                owpfl => 32,
                addr_width => port_addr_width_sram,
                data_width => port_width_sram,
                tag_width => 2)
            port map(
                rst => rst,
                pclk => clk,
                psr => logic0,
                pce => port_pce(i + num_bank_dram),
                pcw => port_pcw(i + num_bank_dram),
                pterm => port_pterm(i + num_bank_dram),
                padv => port_padv(i + num_bank_dram),
                pwr => port_pwr(i + num_bank_dram),
                pa => mem_a(addr_width - 1 downto mux_order_sram),
                pd => rep_d_sram,
                pbe => rep_be_sram,
                pq => port_pq_sram(i),
                pwf => port_pwf(i + num_bank_dram),
                pwpf => port_pwpf(i + num_bank_dram),
                pre => port_pre(i + num_bank_dram),
                prpe => port_prpe(i + num_bank_dram),
                sclk => memclk0,
                sce => port_sce(i + num_bank_dram),
                sw => port_sw(i + num_bank_dram),
                stag => port_stag(i + num_bank_dram),
                sa => port_sa_sram(i),
                sd => port_sd_sram(i),
                sbe => port_sbe_sram(i),
                sq => port_sq_sram(i),
                sqtag => port_sqtag(i + num_bank_dram),
                svalid => port_svalid(i + num_bank_dram),
                sready => port_sready(i + num_bank_dram),
                sreq => port_sreq(i + num_bank_dram),
                tag_base => tag_base,
                tag_mask => tag_mask);
    end generate;

    --
    -- Arbitrate between the two clients that require access to the memory banks:
    --
    --   1. Local bus interface
    --   2. Matcher
    --
    -- The local bus interface is given priority, because PCI/PCI-X transfers targetting
    -- memory banks may time out if timely access to the memory is not granted.
    --

    gen_arbiters_dram : for i in 0 to num_bank_dram - 1 generate
        U0 : arbiter_2
            generic map(
                registered => true,
                ready_delay => 1,
                latency => 16,
                unfair => true,
                bias => 0,
                a_width => port_addr_width_dram,
                d_width => port_width_dram,
                tag_width => tag_width)
            port map(
                rst => memrst,
                clk => memclk0,
                sr => logic0,
                ce => arb_ce(i),
                w => arb_w(i),
                tag => arb_tag(i),
                a => arb_a_dram(i),
                d => arb_d_dram(i),
                be => arb_be_dram(i),
                q => arb_q_dram(i),
                qtag => arb_qtag(i),
                valid => arb_valid(i),
                ready => arb_ready(i),
                req0 => port_sreq(i),
                ce0 => port_sce(i),
                w0 => port_sw(i),
                tag0 => port_stag(i),
                a0 => port_sa_dram(i),
                d0 => port_sd_dram(i),
                be0 => port_sbe_dram(i),
                q0 => port_sq_dram(i),
                qtag0 => port_sqtag(i),
                valid0 => port_svalid(i),
                ready0 => port_sready(i),
                req1 => user_req(i),
                ce1 => user_ce(i),
                w1 => user_w(i),
                tag1 => user_tag(i),
                a1 => user_a(i)(port_addr_width_dram - 1 downto 0),
                d1 => user_d(i)(port_width_dram - 1 downto 0),
                be1 => user_be(i)(port_be_width_dram - 1 downto 0),
                q1 => user_q(i)(port_width_dram - 1 downto 0),
                qtag1 => user_qtag(i),
                valid1 => user_valid(i),
                ready1 => user_ready(i));
    end generate;

    gen_arbiters_sram : for i in 0 to num_bank_sram - 1 generate
        U0 : arbiter_2
            generic map(
                registered => true,
                ready_delay => 1,
                latency => 16,
                unfair => true,
                bias => 0,
                a_width => port_addr_width_sram,
                d_width => port_width_sram,
                tag_width => tag_width)
            port map(
                rst => memrst,
                clk => memclk0,
                sr => logic0,
                ce => arb_ce(i + num_bank_dram),
                w => arb_w(i + num_bank_dram),
                tag => arb_tag(i + num_bank_dram),
                a => arb_a_sram(i),
                d => arb_d_sram(i),
                be => arb_be_sram(i),
                q => arb_q_sram(i),
                qtag => arb_qtag(i + num_bank_dram),
                valid => arb_valid(i + num_bank_dram),
                ready => arb_ready(i + num_bank_dram),
                req0 => port_sreq(i + num_bank_dram),
                ce0 => port_sce(i + num_bank_dram),
                w0 => port_sw(i + num_bank_dram),
                tag0 => port_stag(i + num_bank_dram),
                a0 => port_sa_sram(i),
                d0 => port_sd_sram(i),
                be0 => port_sbe_sram(i),
                q0 => port_sq_sram(i),
                qtag0 => port_sqtag(i + num_bank_dram),
                valid0 => port_svalid(i + num_bank_dram),
                ready0 => port_sready(i + num_bank_dram),
                req1 => user_req(i + num_bank_dram),
                ce1 => user_ce(i + num_bank_dram),
                w1 => user_w(i + num_bank_dram),
                tag1 => user_tag(i + num_bank_dram),
                a1 => user_a(i + num_bank_dram)(port_addr_width_sram - 1 downto 0),
                d1 => user_d(i + num_bank_dram)(port_width_sram - 1 downto 0),
                be1 => user_be(i + num_bank_dram)(port_be_width_sram - 1 downto 0),
                q1 => user_q(i + num_bank_dram)(port_width_sram - 1 downto 0),
                qtag1 => user_qtag(i + num_bank_dram),
                valid1 => user_valid(i + num_bank_dram),
                ready1 => user_ready(i + num_bank_dram));
    end generate;

    --
    -- Instantiate memory ports
    --

    dram_port_0 : ddr2sdram_port
        generic map(
            pinout => ddr2sdram_pinout_admxrc5t2,
            timing => ddr2sdram_timing_266,
            ra_width => bank0.ra_width,
            rc_width => bank0.rc_width,
            rd_width => bank0.rd_width,
            a_width => port_addr_width_dram,
            d_width => port_width_dram,
            tag_width => tag_width)
        port map(
            rst => memrst,
            clk0 => memclk0,
            clk45 => memclk45,
            clk2x0 => memclk2x0,
            clk2x90 => memclk2x90,
            sr => logic0,
            ce => arb_ce(0),
            w => arb_w(0),
            tag => arb_tag(0),
            a => arb_a_dram(0),
            d => arb_d_dram(0),
            be => arb_be_dram(0),
            q => arb_q_dram(0),
            qtag => arb_qtag(0),
            ready => arb_ready(0),
            valid => arb_valid(0),
            row => mode_reg(32 * 0 + 3 downto 32 * 0 + 2),
            col => mode_reg(32 * 0 + 5 downto 32 * 0 + 4),
            bank => mode_reg(32 * 0 + 7 downto 32 * 0 + 6),
            pbank => mode_reg(32 * 0 + 9 downto 32 * 0 + 8),
            trained => trained(0),
            ra => ra0,
            rc => rc0,
            rd => rd0);

    dram_port_1 : ddr2sdram_port
        generic map(
            pinout => ddr2sdram_pinout_admxrc5t2,
            timing => ddr2sdram_timing_266,
            ra_width => bank1.ra_width,
            rc_width => bank1.rc_width,
            rd_width => bank1.rd_width,
            a_width => port_addr_width_dram,
            d_width => port_width_dram,
            tag_width => tag_width)
        port map(
            rst => memrst,
            clk0 => memclk0,
            clk45 => memclk45,
            clk2x0 => memclk2x0,
            clk2x90 => memclk2x90,
            sr => logic0,
            ce => arb_ce(1),
            w => arb_w(1),
            tag => arb_tag(1),
            a => arb_a_dram(1),
            d => arb_d_dram(1),
            be => arb_be_dram(1),
            q => arb_q_dram(1),
            qtag => arb_qtag(1),
            ready => arb_ready(1),
            valid => arb_valid(1),
            row => mode_reg(32 * 1 + 3 downto 32 * 1 + 2),
            col => mode_reg(32 * 1 + 5 downto 32 * 1 + 4),
            bank => mode_reg(32 * 1 + 7 downto 32 * 1 + 6),
            pbank => mode_reg(32 * 1 + 9 downto 32 * 1 + 8),
            trained => trained(1),
            ra => ra1,
            rc => rc1,
            rd => rd1);

    dram_port_2 : ddr2sdram_port
        generic map(
            pinout => ddr2sdram_pinout_admxrc5t2,
            timing => ddr2sdram_timing_266,
            ra_width => bank2.ra_width,
            rc_width => bank2.rc_width,
            rd_width => bank2.rd_width,
            a_width => port_addr_width_dram,
            d_width => port_width_dram,
            tag_width => tag_width)
        port map(
            rst => memrst,
            clk0 => memclk0,
            clk45 => memclk45,
            clk2x0 => memclk2x0,
            clk2x90 => memclk2x90,
            sr => logic0,
            ce => arb_ce(2),
            w => arb_w(2),
            tag => arb_tag(2),
            a => arb_a_dram(2),
            d => arb_d_dram(2),
            be => arb_be_dram(2),
            q => arb_q_dram(2),
            qtag => arb_qtag(2),
            ready => arb_ready(2),
            valid => arb_valid(2),
            row => mode_reg(32 * 2 + 3 downto 32 * 2 + 2),
            col => mode_reg(32 * 2 + 5 downto 32 * 2 + 4),
            bank => mode_reg(32 * 2 + 7 downto 32 * 2 + 6),
            pbank => mode_reg(32 * 2 + 9 downto 32 * 2 + 8),
            trained => trained(2),
            ra => ra2,
            rc => rc2,
            rd => rd2);

    dram_port_3 : ddr2sdram_port
        generic map(
            pinout => ddr2sdram_pinout_admxrc5t2,
            timing => ddr2sdram_timing_266,
            ra_width => bank3.ra_width,
            rc_width => bank3.rc_width,
            rd_width => bank3.rd_width,
            a_width => port_addr_width_dram,
            d_width => port_width_dram,
            tag_width => tag_width)
        port map(
            rst => memrst,
            clk0 => memclk0,
            clk45 => memclk45,
            clk2x0 => memclk2x0,
            clk2x90 => memclk2x90,
            sr => logic0,
            ce => arb_ce(3),
            w => arb_w(3),
            tag => arb_tag(3),
            a => arb_a_dram(3),
            d => arb_d_dram(3),
            be => arb_be_dram(3),
            q => arb_q_dram(3),
            qtag => arb_qtag(3),
            ready => arb_ready(3),
            valid => arb_valid(3),
            row => mode_reg(32 * 3 + 3 downto 32 * 3 + 2),
            col => mode_reg(32 * 3 + 5 downto 32 * 3 + 4),
            bank => mode_reg(32 * 3 + 7 downto 32 * 3 + 6),
            pbank => mode_reg(32 * 3 + 9 downto 32 * 3 + 8),
            trained => trained(3),
            ra => ra3,
            rc => rc3,
            rd => rd3);

    sram_port_0 : ddr2sram_port_v4
        generic map(
            pinout => ddr2sram_pinout_admxrc5t2,
            ra_width => bank4.ra_width,
            rc_width => bank4.rc_width,
            rd_width => bank4.rd_width,
            a_width => port_addr_width_sram,
            d_width => port_width_sram,
            tag_width => tag_width)
        port map(
            rst => memrst,
            clk0 => memclk0,
            clk45 => memclk45,
            clk2x0 => memclk2x0,
            clk2x90 => memclk2x90,
            sr => logic0,
            ce => arb_ce(4),
            w => arb_w(4),
            tag => arb_tag(4),
            a => arb_a_sram(0),
            d => arb_d_sram(0),
            be => arb_be_sram(0),
            q => arb_q_sram(0),
            qtag => arb_qtag(4),
            valid => arb_valid(4),
            ready => arb_ready(4),
            dll_off => mode_reg(32 * 4 + 2),
            trained => trained(4),
            ra => ra4,
            rc => rc4,
            rd => rd4);

    sram_port_1 : ddr2sram_port_v4
        generic map(
            pinout => ddr2sram_pinout_admxrc5t2,
            ra_width => bank5.ra_width,
            rc_width => bank5.rc_width,
            rd_width => bank5.rd_width,
            a_width => port_addr_width_sram,
            d_width => port_width_sram,
            tag_width => tag_width)
        port map(
            rst => memrst,
            clk0 => memclk0,
            clk45 => memclk45,
            clk2x0 => memclk2x0,
            clk2x90 => memclk2x90,
            sr => logic0,
            ce => arb_ce(5),
            w => arb_w(5),
            tag => arb_tag(5),
            a => arb_a_sram(1),
            d => arb_d_sram(1),
            be => arb_be_sram(1),
            q => arb_q_sram(1),
            qtag => arb_qtag(5),
            valid => arb_valid(5),
            ready => arb_ready(5),
            dll_off => mode_reg(32 * 5 + 2),
            trained => trained(5),
            ra => ra5,
            rc => rc5,
            rd => rd5);

    --
    -- Banks 6-15 are not present/used.
    --

    ra6 <= (others => 'Z');
    rc6 <= (others => 'Z');
    rd6 <= (others => 'Z');
    ra7 <= (others => 'Z');
    rc7 <= (others => 'Z');
    rd7 <= (others => 'Z');
    ra8 <= (others => 'Z');
    rc8 <= (others => 'Z');
    rd8 <= (others => 'Z');
    ra9 <= (others => 'Z');
    rc9 <= (others => 'Z');
    rd9 <= (others => 'Z');
    ra10 <= (others => 'Z');
    rc10 <= (others => 'Z');
    rd10 <= (others => 'Z');
    ra11 <= (others => 'Z');
    rc11 <= (others => 'Z');
    rd11 <= (others => 'Z');
    ra12 <= (others => 'Z');
    rc12 <= (others => 'Z');
    rd12 <= (others => 'Z');
    ra13 <= (others => 'Z');
    rc13 <= (others => 'Z');
    rd13 <= (others => 'Z');
    ra14 <= (others => 'Z');
    rc14 <= (others => 'Z');
    rd14 <= (others => 'Z');
    ra15 <= (others => 'Z');
    rc15 <= (others => 'Z');
    rd15 <= (others => 'Z');

    --
    -- No memory clocks to generate (clocks generated for each port)
    --

    ramclko <= (others => 'Z');

end architecture;
