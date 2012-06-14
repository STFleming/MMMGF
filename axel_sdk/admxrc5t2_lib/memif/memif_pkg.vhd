--
-- memif_pkg.vhd - Package of memory interface components
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

package memif is

    --
    -- Type that represents a FPGA family
    --
    type family_t is (
        family_virtex,    -- Virtex/Virtex-E/Virtex-EM
        family_virtex2,   -- Virtex-II
        family_virtex2p,  -- Virtex-II Pro
        family_virtex4,   -- Virtex-4
        family_virtex5);  -- Virtex-5

    -- Type that describes a memory bank's external pinout
    type bank_t is
    record
        enable   : boolean;  -- 'true' if bank is physically present, otherwise false
        ra_width : natural;  -- Number of physical address wires in bank
        rc_width : natural;  -- Number of physical control wires in bank
        rd_width : natural;  -- Number of physical data wires in bank
    end record;

    constant bank_disable : bank_t := (
        enable   => false,
        ra_width => 1, -- 1 instead of 0, to avoid 'std_logic_vector(-1 downto 0)'
        rc_width => 1,
        rd_width => 1);

    alias no_bank is bank_disable; -- For compatibility with older source code

    --
    -- Type that describes a DDR SDRAM bank timing
    -- All values are in 'clk0' cycles
    --
    type ddrsdram_timing_t is
    record
        cas_latency : natural; -- CAS latency * 2 (i.e. specified in 1/2 clock cycles)
        t_refresh   : natural; -- Average periodic refresh interval
        t_mrd       : natural; -- Minimum time between mode register set commands
        t_dllr      : natural; -- Minimum time between DLL leaving reset and first read command
        t_rp        : natural; -- Minimum time between row precharge and row activate commands
        t_rfc       : natural; -- Minimum time between refresh command and any other command
        t_act       : natural; -- Minimum time between row activate command and any read/write command
        t_wtr       : natural; -- Minimum time between write command and read command, assuming same row
        t_rtw       : natural; -- Minimum time between read command and write command, assuming same row
        t_rtp       : natural; -- Minimum time between read command and precharge command
        t_wtp       : natural; -- Minimum time between write command and precharge command
        t_ras       : natural; -- Minimum number of cycles that a row must be open
    end record;

    --
    -- Timings for CL2.5 133MHz DDR SDRAM, i.e. 133MHz 'clk0'
    --
    constant ddrsdram_timing_cl25_133 : ddrsdram_timing_t := (
        cas_latency => 5, -- CL2.5
        t_refresh   => 700, -- OK for 'clk0' >= 100MHz, commercial/industrial parts (15.6/7.8us refresh)
        t_mrd       => 3,   -- Datasheet requires 2, 1 extra for safety
        t_dllr      => 300, -- Datasheet requires 200 'clk0' cycles, 100 extra for safety
        t_rp        => 3,
        t_rfc       => 10,
        t_act       => 3,
        t_wtr       => 3,
        t_rtw       => 3,
        t_rtp       => 2,
        t_wtp       => 4,
        t_ras       => 6);

    --
    -- Type that describes the pinout of a DDR SDRAM bank.
    -- These values are numbers of physical pins.
    --
    type ddrsdram_pinout_t is
    record
        family        : family_t;  -- FPGA family
        flight_time   : natural;         -- PCB round trip (DQS + DQ) trace delay, in 1/4 clock cycles
        use_dqs       : boolean;         -- TRUE if DQS used for data capture on reads
        dqs_dq_delay  : boolean;         -- TRUE if DQS traces have extra delay w.r.t. DQ
        dqs_dm_delay  : boolean;         -- TRUE if DQS traces have extra delay w.r.t. DM
        ck_width      : natural;         -- Number of CK pins present
        cke_width     : natural;         -- Number of CKE pins present
        num_phys_bank : natural;         -- Number of CS# pins present
        num_bank_bits : natural;         -- Number of BA pins present
        num_addr_bits : natural;         -- Number of row/column address pins present        
    end record;

    --
    -- Description of ADM-XPL DDR SDRAM pinout
    --
    constant ddrsdram_pinout_admxpl : ddrsdram_pinout_t := (
        family        => family_virtex2p,
        flight_time   => 0,
        use_dqs       => false,
        dqs_dq_delay  => false,
        dqs_dm_delay  => false,
        ck_width      => 1,
        cke_width     => 1,
        num_phys_bank => 1,
        num_bank_bits => 2,
        num_addr_bits => 13);

    --
    -- Description of ADM-XP DDR SDRAM pinout
    --
    constant ddrsdram_pinout_admxp : ddrsdram_pinout_t := (
        family        => family_virtex2p,
        flight_time   => 1,
        use_dqs       => false,
        dqs_dq_delay  => false,
        dqs_dm_delay  => false,
        ck_width      => 1,
        cke_width     => 1,
        num_phys_bank => 1,
        num_bank_bits => 2,
        num_addr_bits => 13);

    --
    -- Description of ADP-XPI DDR SDRAM pinout
    --
    constant ddrsdram_pinout_adpxpi : ddrsdram_pinout_t := (
        family        => family_virtex2p,
        flight_time   => 0,
        use_dqs       => false,
        dqs_dq_delay  => true,
        dqs_dm_delay  => false,
        ck_width      => 3,
        cke_width     => 2,
        num_phys_bank => 4,
        num_bank_bits => 3,
        num_addr_bits => 16);

    --
    -- Type that describes a DDR-II SDRAM bank timing
    -- All values are in 'clk0' cycles
    --
    type ddr2sdram_timing_t is
    record
        t_refresh : natural; -- Average periodic refresh interval
        t_mrd     : natural; -- Minimum time between mode register set commands
        t_dllr    : natural; -- Minimum time between DLL leaving reset and first read command
        t_rp      : natural; -- Minimum time between row precharge and row activate commands
        t_rfc     : natural; -- Minimum time between refresh command and any other command
        t_act     : natural; -- Minimum time between row activate command and any read/write command
        t_wtr     : natural; -- Minimum time between write command and read command, assuming same row
        t_rtw     : natural; -- Minimum time between read command and write command, assuming same row
        t_rtp     : natural; -- Minimum time between read command and precharge command
        t_wtp     : natural; -- Minimum time between write command and precharge command
        t_ras     : natural; -- Minimum number of cycles that a row must be open
    end record;

    --
    -- Timings for 266MHz DDR-II SDRAM, i.e. 133MHz 'clk0'
    --
    constant ddr2sdram_timing_266 : ddr2sdram_timing_t := (
        t_refresh => 350, -- OK for 'clk0' >= 100MHz, commercial/industrial parts (7.8/3.9us refresh)
        t_mrd     => 3,   -- Datasheet requires 2, 1 extra for safety
        t_dllr    => 150, -- Datasheet requires 100 'clk0' cycles, 50 extra for safety
        t_rp      => 3,   -- Datasheet tRP(15ns) => 3 'clk0' cycles
        t_rfc     => 20,  -- Datasheet tRFC(150ns) => 20 'clk0' cycles
        t_act     => 2,   -- Datasheet tACT(15ns) => 2 'clk0' cycles
        t_wtr     => 4,   -- Datasheet 6.tCK(3.75ns) + tWTR(7.5ns) => 4 'clk0' cycles
        t_rtw     => 2,   -- Because AL = 0, WL = RL - 1 => t_rtw is 2 'clk0' cycles
        t_rtp     => 1,   -- Datasheet tRTP(7.5ns) => 1 'clk0' cycle
        t_wtp     => 5,   -- Datasheet 6.tCK(3.75ns) + tWR(15ns) => 5 'clk0' cycles
        t_ras     => 6);  -- Datasheet tRAS(45ns) => 6 'clk0' cycles

    --
    -- Timings for 333MHz DDR-II SDRAM, i.e. 167MHz 'clk0'
    --
    constant ddr2sdram_timing_333 : ddr2sdram_timing_t := (
        t_refresh => 600, -- OK for 'clk0' >= 133MHz, commercial/industrial parts (7.8/3.9us refresh)
        t_mrd     => 3,   -- Datasheet requires 2, 1 extra for safety
        t_dllr    => 150, -- Datasheet requires 100 'clk0' cycles, 50 extra for safety
        t_rp      => 3,   -- Datasheet tRP(15ns) => 3 'clk0' cycles
        t_rfc     => 25,  -- Datasheet tRFC(150ns) => 25 'clk0' cycles
        t_act     => 3,   -- Datasheet tACT(15ns) => 3 'clk0' cycles
        t_wtr     => 4,   -- Datasheet 6.tCK(3ns) + tWTR(7.5ns) => 5 'clk0' cycles
        t_rtw     => 2,   -- Because AL = 0, WL = RL - 1 => t_rtw is 2 'clk0' cycles
        t_rtp     => 2,   -- Datasheet tRTP(7.5ns) => 2 'clk0' cycles
        t_wtp     => 6,   -- Datasheet 6.tCK(3ns) + tWR(15ns) => 6 'clk0' cycles
        t_ras     => 8);  -- Datasheet tRAS(45ns) => 8 'clk0' cycles

    --
    -- Type that describes the pinout of a DDR-II SDRAM bank.
    -- These values are numbers of physical pins.
    --
    type ddr2sdram_pinout_t is
    record
        family        : family_t;  -- FPGA family
        ck_width      : natural;         -- Number of CK pins present
        cke_width     : natural;         -- Number of CKE pins present
        odt_width     : natural;         -- Number of ODT pins present
        num_phys_bank : natural;         -- Number of CS# pins present
        num_bank_bits : natural;         -- Number of BA pins present
        num_addr_bits : natural;         -- Number of row/column address pins present        
    end record;

    --
    -- Description of ADM-XRC-4FX DDR-II SDRAM pinout
    --
    constant ddr2sdram_pinout_admxrc4fx : ddr2sdram_pinout_t := (
        family        => family_virtex4,
        ck_width      => 2,
        cke_width     => 1,
        odt_width     => 1,
        num_phys_bank => 1,
        num_bank_bits => 3,
        num_addr_bits => 16);

    --
    -- Description of ADPE-XRC-4FX DDR-II SDRAM pinout
    --
    constant ddr2sdram_pinout_adpexrc4fx : ddr2sdram_pinout_t := (
        family        => family_virtex4,
        ck_width      => 2,
        cke_width     => 1,
        odt_width     => 1,
        num_phys_bank => 1,
        num_bank_bits => 3,
        num_addr_bits => 13);

    --
    -- Description of ADM-XRC-5LX DDR-II SDRAM pinout
    --
    constant ddr2sdram_pinout_admxrc5lx : ddr2sdram_pinout_t := (
        family        => family_virtex5,
        ck_width      => 2,
        cke_width     => 1,
        odt_width     => 1,
        num_phys_bank => 1,
        num_bank_bits => 3,
        num_addr_bits => 15);

    --
    -- Description of ADM-XRC-5T1 DDR-II SDRAM pinout
    --
    constant ddr2sdram_pinout_admxrc5t1 : ddr2sdram_pinout_t := (
        family        => family_virtex5,
        ck_width      => 2,
        cke_width     => 1,
        odt_width     => 1,
        num_phys_bank => 1,
        num_bank_bits => 3,
        num_addr_bits => 16);

    --
    -- Description of ADM-XRC-5T2 DDR-II SDRAM pinout
    --
    constant ddr2sdram_pinout_admxrc5t2 : ddr2sdram_pinout_t := (
        family        => family_virtex5,
        ck_width      => 2,
        cke_width     => 1,
        odt_width     => 1,
        num_phys_bank => 1,
        num_bank_bits => 3,
        num_addr_bits => 15);

    --
    -- Description of ADM-XRC-5T-DA1 DDR-II SDRAM pinout
    --
    constant ddr2sdram_pinout_admxrc5tda1 : ddr2sdram_pinout_t := (
        family        => family_virtex5,
        ck_width      => 2,
        cke_width     => 1,
        odt_width     => 1,
        num_phys_bank => 1,
        num_bank_bits => 3,
        num_addr_bits => 15);

    --
    -- Type that describes the pinout of a DDR-II SSRAM bank.
    --
    type ddr2sram_pinout_t is
    record
        family        : family_t;  -- FPGA family
        has_c         : boolean;         -- TRUE => C & C# pins are present
        has_cq        : boolean;         -- TRUE => CQ & CQ# pins are present
        capture_180   : boolean;         -- TRUE => use +180 'clk180' for DQ capture
    end record;

    --
    -- Description of ADM-XP DDR-II SSRAM pinout
    --
    constant ddr2sram_pinout_admxp : ddr2sram_pinout_t := (
        family        => family_virtex2p,
        has_c         => true,
        has_cq        => false,
        capture_180   => true);

    --
    -- Description of ADP-XPI DDR-II SSRAM pinout
    --
    constant ddr2sram_pinout_adpxpi : ddr2sram_pinout_t := (
        family        => family_virtex2p,
        has_c         => true,
        has_cq        => false,
        capture_180   => true);

    --
    -- Description of ADPE-XRC-4FX DDR-II SSRAM pinout
    --
    constant ddr2sram_pinout_adpexrc4fx : ddr2sram_pinout_t := (
        family        => family_virtex4,
        has_c         => true,
        has_cq        => false,
        capture_180   => true);

    --
    -- Description of ADM-XRC-5T1 DDR-II SSRAM pinout
    --
    constant ddr2sram_pinout_admxrc5t1 : ddr2sram_pinout_t := (
        family        => family_virtex5,
        has_c         => false,
        has_cq        => true,
        capture_180   => true);

    --
    -- Description of ADM-XRC-5T2 DDR-II SSRAM pinout
    --
    constant ddr2sram_pinout_admxrc5t2 : ddr2sram_pinout_t := (
        family        => family_virtex5,
        has_c         => false,
        has_cq        => true,
        capture_180   => true);

    --
    -- Description of ADM-XRC-5T-DA1 DDR-II SSRAM pinout
    --
    constant ddr2sram_pinout_admxrc5tda1 : ddr2sram_pinout_t := (
        family        => family_virtex5,
        has_c         => false,
        has_cq        => true,
        capture_180   => true);

    --
    -- Type that describes the pinout of a ZBT SSRAM bank.
    --
    type zbtsram_pinout_t is
    record
        family        : family_t;  -- FPGA family
        has_ce2       : boolean;         -- TRUE => has CE2 pin (active high)
        has_ce2_l     : boolean;         -- TRUE => has CE2# pin (active low)
        has_cke_l     : boolean;         -- TRUE => has CKE# pin
    end record;

    --
    -- Description of ADM-XRC ZBT SSRAM pinout
    --
    constant zbtsram_pinout_admxrc : zbtsram_pinout_t := (
        family        => family_virtex,
        has_ce2       => false,
        has_ce2_l     => false,
        has_cke_l     => true);

    --
    -- Description of ADM-XRC-P ZBT SSRAM pinout
    --
    constant zbtsram_pinout_admxrcp : zbtsram_pinout_t := (
        family        => family_virtex,
        has_ce2       => false,
        has_ce2_l     => false,
        has_cke_l     => true);

    --
    -- Description of ADM-XRC-II-Lite ZBT SSRAM pinout
    --
    constant zbtsram_pinout_admxrc2l : zbtsram_pinout_t := (
        family        => family_virtex2,
        has_ce2       => false,
        has_ce2_l     => false,
        has_cke_l     => false);

    --
    -- Description of ADM-XRC-II ZBT SSRAM pinout
    --
    constant zbtsram_pinout_admxrc2 : zbtsram_pinout_t := (
        family        => family_virtex2,
        has_ce2       => false,
        has_ce2_l     => false,
        has_cke_l     => true);

    --
    -- Description of ADM-XPL ZBT SSRAM pinout
    --
    constant zbtsram_pinout_admxpl : zbtsram_pinout_t := (
        family        => family_virtex2p,
        has_ce2       => true,
        has_ce2_l     => true,
        has_cke_l     => true);

    --
    -- Description of ADM-XRC-4LX ZBT SSRAM pinout
    --
    constant zbtsram_pinout_admxrc4lx : zbtsram_pinout_t := (
        family        => family_virtex4,
        has_ce2       => false,
        has_ce2_l     => false,
        has_cke_l     => false);

    --
    -- Description of ADM-XRC-4SX ZBT SSRAM pinout
    --
    constant zbtsram_pinout_admxrc4sx : zbtsram_pinout_t := (
        family        => family_virtex4,
        has_ce2       => false,
        has_ce2_l     => false,
        has_cke_l     => false);

    --
    -- Description of ADM-XRC-5TZ ZBT SSRAM pinout
    --
    constant zbtsram_pinout_admxrc5tz : zbtsram_pinout_t := (
        family        => family_virtex5,
        has_ce2       => false,
        has_ce2_l     => false,
        has_cke_l     => false);

    component arbiter_2
        generic(
            registered    : in    boolean;  -- 'true' to register memory port outputs
            ready_delay   : in    natural;  -- Delay from deassertion of 'ready(x)' to deassertion of 'ce(x)'
            latency       : in    natural;  -- Maximum number of clocks to award a grant if other clients are requesting
            unfair        : in    boolean;  -- 'true' to favor a particular client
            bias          : in    natural;  -- If 'unfair' is 'true', specifies which client to favor
            a_width       : in    natural;  -- Address width
            d_width       : in    natural;  -- Data width
            tag_width     : in    natural); -- Tag width
        port(
            rst           : in    std_logic;
            clk           : in    std_logic;
            sr            : in    std_logic;
            -- Memory port interface
            ce            : out   std_logic;
            w             : out   std_logic;
            tag           : out   std_logic_vector(tag_width - 1 downto 0);
            a             : out   std_logic_vector(a_width - 1 downto 0);
            d             : out   std_logic_vector(d_width - 1 downto 0);
            be            : out   std_logic_vector(d_width / 8 - 1 downto 0);
            q             : in    std_logic_vector(d_width - 1 downto 0);
            qtag          : in    std_logic_vector(tag_width - 1 downto 0);
            valid         : in    std_logic;
            ready         : in    std_logic;
            -- Client 0 interface
            req0          : in    std_logic;
            ce0           : in    std_logic;
            w0            : in    std_logic;
            tag0          : in    std_logic_vector(tag_width - 1 downto 0);
            a0            : in    std_logic_vector(a_width - 1 downto 0);
            d0            : in    std_logic_vector(d_width - 1 downto 0);
            be0           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q0            : out   std_logic_vector(d_width - 1 downto 0);
            qtag0         : out   std_logic_vector(tag_width - 1 downto 0);
            valid0        : out   std_logic;
            ready0        : out   std_logic;
            -- Client 1 interface
            req1          : in    std_logic;
            ce1           : in    std_logic;
            w1            : in    std_logic;
            tag1          : in    std_logic_vector(tag_width - 1 downto 0);
            a1            : in    std_logic_vector(a_width - 1 downto 0);
            d1            : in    std_logic_vector(d_width - 1 downto 0);
            be1           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q1            : out   std_logic_vector(d_width - 1 downto 0);
            qtag1         : out   std_logic_vector(tag_width - 1 downto 0);
            valid1        : out   std_logic;
            ready1        : out   std_logic);
    end component;

    component arbiter_3
        generic(
            registered    : in    boolean;  -- 'true' to register memory port outputs
            ready_delay   : in    natural;  -- Delay from deassertion of 'ready(x)' to deassertion of 'ce(x)'
            latency       : in    natural;  -- Maximum number of clocks to award a grant if other clients are requesting
            unfair        : in    boolean;  -- 'true' to favor a particular client
            bias          : in    natural;  -- If 'unfair' is 'true', specifies which client to favor
            a_width       : in    natural;  -- Address width
            d_width       : in    natural;  -- Data width
            tag_width     : in    natural); -- Tag width
        port(
            rst           : in    std_logic;
            clk           : in    std_logic;
            sr            : in    std_logic;
            -- Memory port interface
            ce            : out   std_logic;
            w             : out   std_logic;
            tag           : out   std_logic_vector(tag_width - 1 downto 0);
            a             : out   std_logic_vector(a_width - 1 downto 0);
            d             : out   std_logic_vector(d_width - 1 downto 0);
            be            : out   std_logic_vector(d_width / 8 - 1 downto 0);
            q             : in    std_logic_vector(d_width - 1 downto 0);
            qtag          : in    std_logic_vector(tag_width - 1 downto 0);
            valid         : in    std_logic;
            ready         : in    std_logic;
            -- Client 0 interface
            req0          : in    std_logic;
            ce0           : in    std_logic;
            w0            : in    std_logic;
            tag0          : in    std_logic_vector(tag_width - 1 downto 0);
            a0            : in    std_logic_vector(a_width - 1 downto 0);
            d0            : in    std_logic_vector(d_width - 1 downto 0);
            be0           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q0            : out   std_logic_vector(d_width - 1 downto 0);
            qtag0         : out   std_logic_vector(tag_width - 1 downto 0);
            valid0        : out   std_logic;
            ready0        : out   std_logic;
            -- Client 1 interface
            req1          : in    std_logic;
            ce1           : in    std_logic;
            w1            : in    std_logic;
            tag1          : in    std_logic_vector(tag_width - 1 downto 0);
            a1            : in    std_logic_vector(a_width - 1 downto 0);
            d1            : in    std_logic_vector(d_width - 1 downto 0);
            be1           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q1            : out   std_logic_vector(d_width - 1 downto 0);
            qtag1         : out   std_logic_vector(tag_width - 1 downto 0);
            valid1        : out   std_logic;
            ready1        : out   std_logic;
            -- Client 2 interface
            req2          : in    std_logic;
            ce2           : in    std_logic;
            w2            : in    std_logic;
            tag2          : in    std_logic_vector(tag_width - 1 downto 0);
            a2            : in    std_logic_vector(a_width - 1 downto 0);
            d2            : in    std_logic_vector(d_width - 1 downto 0);
            be2           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q2            : out   std_logic_vector(d_width - 1 downto 0);
            qtag2         : out   std_logic_vector(tag_width - 1 downto 0);
            valid2        : out   std_logic;
            ready2        : out   std_logic);
    end component;

    component arbiter_4
        generic(
            registered    : in    boolean;  -- 'true' to register memory port outputs
            ready_delay   : in    natural;  -- Delay from deassertion of 'ready(x)' to deassertion of 'ce(x)'
            latency       : in    natural;  -- Maximum number of clocks to award a grant if other clients are requesting
            unfair        : in    boolean;  -- 'true' to favor a particular client
            bias          : in    natural;  -- If 'unfair' is 'true', specifies which client to favor
            a_width       : in    natural;  -- Address width
            d_width       : in    natural;  -- Data width
            tag_width     : in    natural); -- Tag width
        port(
            rst           : in    std_logic;
            clk           : in    std_logic;
            sr            : in    std_logic;
            -- Memory port interface
            ce            : out   std_logic;
            w             : out   std_logic;
            tag           : out   std_logic_vector(tag_width - 1 downto 0);
            a             : out   std_logic_vector(a_width - 1 downto 0);
            d             : out   std_logic_vector(d_width - 1 downto 0);
            be            : out   std_logic_vector(d_width / 8 - 1 downto 0);
            q             : in    std_logic_vector(d_width - 1 downto 0);
            qtag          : in    std_logic_vector(tag_width - 1 downto 0);
            valid         : in    std_logic;
            ready         : in    std_logic;
            -- Client 0 interface
            req0          : in    std_logic;
            ce0           : in    std_logic;
            w0            : in    std_logic;
            tag0          : in    std_logic_vector(tag_width - 1 downto 0);
            a0            : in    std_logic_vector(a_width - 1 downto 0);
            d0            : in    std_logic_vector(d_width - 1 downto 0);
            be0           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q0            : out   std_logic_vector(d_width - 1 downto 0);
            qtag0         : out   std_logic_vector(tag_width - 1 downto 0);
            valid0        : out   std_logic;
            ready0        : out   std_logic;
            -- Client 1 interface
            req1          : in    std_logic;
            ce1           : in    std_logic;
            w1            : in    std_logic;
            tag1          : in    std_logic_vector(tag_width - 1 downto 0);
            a1            : in    std_logic_vector(a_width - 1 downto 0);
            d1            : in    std_logic_vector(d_width - 1 downto 0);
            be1           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q1            : out   std_logic_vector(d_width - 1 downto 0);
            qtag1         : out   std_logic_vector(tag_width - 1 downto 0);
            valid1        : out   std_logic;
            ready1        : out   std_logic;
            -- Client 2 interface
            req2          : in    std_logic;
            ce2           : in    std_logic;
            w2            : in    std_logic;
            tag2          : in    std_logic_vector(tag_width - 1 downto 0);
            a2            : in    std_logic_vector(a_width - 1 downto 0);
            d2            : in    std_logic_vector(d_width - 1 downto 0);
            be2           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q2            : out   std_logic_vector(d_width - 1 downto 0);
            qtag2         : out   std_logic_vector(tag_width - 1 downto 0);
            valid2        : out   std_logic;
            ready2        : out   std_logic;
            -- Client 3 interface
            req3          : in    std_logic;
            ce3           : in    std_logic;
            w3            : in    std_logic;
            tag3          : in    std_logic_vector(tag_width - 1 downto 0);
            a3            : in    std_logic_vector(a_width - 1 downto 0);
            d3            : in    std_logic_vector(d_width - 1 downto 0);
            be3           : in    std_logic_vector(d_width / 8 - 1 downto 0);
            q3            : out   std_logic_vector(d_width - 1 downto 0);
            qtag3         : out   std_logic_vector(tag_width - 1 downto 0);
            valid3        : out   std_logic;
            ready3        : out   std_logic);
    end component;

    component async_port
        generic(
            family     : in    family_t;
            order      : in    natural;
            iwpfl      : in    natural;
            owpfl      : in    natural;
            orpel      : in    natural;
            addr_width : in    natural;
            data_width : in    natural;
            tag_width  : in    natural);
        port(
            rst        : in    std_logic;
            -- To/from primary clock domain
            pclk       : in    std_logic;
            psr        : in    std_logic;
            pce        : in    std_logic;
            pcw        : in    std_logic;
            pterm      : in    std_logic;
            padv       : in    std_logic;
            pwr        : in    std_logic;
            pa         : in    std_logic_vector(addr_width - 1 downto 0);
            pd         : in    std_logic_vector(data_width - 1 downto 0);
            pbe        : in    std_logic_vector(data_width / 8 - 1 downto 0);
            pq         : out   std_logic_vector(data_width - 1 downto 0);
            pwf        : out   std_logic;
            pwpf       : out   std_logic;
            pre        : out   std_logic;
            prpe       : out   std_logic;
            -- To/from memory interface
            sclk       : in    std_logic;
            sce        : out   std_logic;
            stag       : out   std_logic_vector(tag_width - 1 downto 0);
            sw         : out   std_logic;
            sa         : out   std_logic_vector(addr_width - 1 downto 0);
            sd         : out   std_logic_vector(data_width - 1 downto 0);
            sbe        : out   std_logic_vector(data_width / 8 - 1 downto 0);
            sready     : in    std_logic;
            svalid     : in    std_logic;
            sq         : in    std_logic_vector(data_width - 1 downto 0);
            sqtag      : in    std_logic_vector(tag_width - 1 downto 0);
            -- To/from memory interface arbiter
            sreq       : out   std_logic;
            -- Should be driven with constant values
            tag_base   : in    std_logic_vector(tag_width - 1 downto 0);
            tag_mask   : in    std_logic_vector(tag_width - 1 downto 0));
    end component;

    component blockram_port
        generic(
            family          : in    family_t;
            a_width         : in    natural;
            d_width         : in    natural;
            tag_width       : in    natural);
        port(
            clk0            : in    std_logic;                                   -- Baseline clock
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
            ready           : out   std_logic);                                  -- When low, indicates that 'ce' is ignored
    end component;

    component ddrsdram_port
        generic(
            auto_train      : in    boolean := true;
            pinout          : in    ddrsdram_pinout_t;
            timing          : in    ddrsdram_timing_t;
            ra_width        : in    natural;                                     -- Number of physical address pins
            rd_width        : in    natural;                                     -- Number of physical data pins
            rc_width        : in    natural;                                     -- Number of physical control pins
            a_width         : in    natural;                                     -- Number of logical address bits
            d_width         : in    natural;                                     -- Number of logical data bits
            tag_width       : in    natural);                                    -- Number of tag bits
        port(
            -- To/from clocking infrastructure
            clk0            : in    std_logic;                                  -- Interface clock
            clk90           : in    std_logic;                                  -- As 'clk0' but lags by 90 degrees
            clk180          : in    std_logic;                                  -- As 'clk0' but lags by 180 degrees
            clk270          : in    std_logic;                                  -- As 'clk0' but lags by 270 degrees
            rst             : in    std_logic;                                  -- Asynchronous reset
            -- To/from application
            sr              : in    std_logic;                                  -- Synchronous reset
            ce              : in    std_logic;                                  -- Ignored unless 'ready'
            tag             : in    std_logic_vector(tag_width - 1 downto 0);   -- Qualified by 'ce and not w'
            w               : in    std_logic;                                  -- Qualified by 'ce'
            a               : in    std_logic_vector(a_width - 1 downto 0);     -- Qualified by 'ce'
            d               : in    std_logic_vector(d_width - 1 downto 0);     -- Qualified by 'ce and w'
            be              : in    std_logic_vector(d_width / 8 - 1 downto 0); -- Qualified by 'ce and w'
            ready           : out   std_logic;                                  -- Qualifies 'ce'
            valid           : out   std_logic;                                  -- Indicates 'q' and 'qtag' valid
            q               : out   std_logic_vector(d_width - 1 downto 0);     -- Qualified by 'valid'
            qtag            : out   std_logic_vector(tag_width - 1 downto 0);   -- Qualified by 'valid'
            -- Sideband control signals (inputs must be stable during operation)
            regd            : in    std_logic;                                  -- 0 => unbuffered, 1 => registered
            x4              : in    std_logic;                                  -- 0 => normal, 1 => DM functions as DQS (x4 devices on DIMM)
            row             : in    std_logic_vector(1 downto 0);               -- Row addr width: 00 => 12, ... , 11 => 15
            col             : in    std_logic_vector(1 downto 0);               -- Col addr width: 00 => row - 3, ... , 11 => row
            bank            : in    std_logic_vector(1 downto 0);               -- Bank addr width: 00 => 0, ... , 11 => 3
            pbank           : in    std_logic_vector(1 downto 0);               -- Num. phys banks: 00 => 1, ... , 11 => 8
            -- To/from memories
            ra              : out   std_logic_vector(ra_width - 1 downto 0);
            rc              : inout std_logic_vector(rc_width - 1 downto 0);
            rd              : inout std_logic_vector(rd_width - 1 downto 0));
    end component;

    --
    -- DDR-II SDRAM memory interface component
    --
    component ddr2sdram_port
        generic(
            auto_train      : in    boolean := true;
            pinout          : in    ddr2sdram_pinout_t;
            timing          : in    ddr2sdram_timing_t;
            ra_width        : in    natural;                                     -- Number of physical address pins
            rd_width        : in    natural;                                     -- Number of physical data pins
            rc_width        : in    natural;                                     -- Number of physical control pins
            a_width         : in    natural;                                     -- Number of logical address bits
            d_width         : in    natural;                                     -- Number of logical data bits
            tag_width       : in    natural);                                    -- Number of tag bits
        port(
            -- To/from clocking infrastructure
            clk0            : in    std_logic;                                   -- Interface clock
            clk45           : in    std_logic;                                   -- As 'clk2x90' but divided by 2
            clk2x0          : in    std_logic;                                   -- As 'clk0' but double frequency
            clk2x90         : in    std_logic;                                   -- As 'clk2x0' but -90 deg. phase shift
            rst             : in    std_logic;                                   -- Asynchronous reset
            -- To/from application
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
            row             : in    std_logic_vector(1 downto 0);                -- row addr width: 00 => 12, ... , 11 => 15
            col             : in    std_logic_vector(1 downto 0);                -- col addr width: 00 => row - 4, ... , 11 => row - 1
            bank            : in    std_logic_vector(1 downto 0);                -- bank addr width: 00 => 0, ... , 11 => 3
            pbank           : in    std_logic_vector(1 downto 0);                -- num. phys banks: 00 => 1, ... , 11 => 8
            trained         : out   std_logic;                                   -- 1 => training was successful
            -- To/from memories
            ra              : out   std_logic_vector(ra_width - 1 downto 0);
            rc              : inout std_logic_vector(rc_width - 1 downto 0);
            rd              : inout std_logic_vector(rd_width - 1 downto 0));
    end component;

    component ddrsdram_port_v2
        generic(
            auto_train      : in    boolean := true;
            pinout          : in    ddrsdram_pinout_t;
            timing          : in    ddrsdram_timing_t;
            ra_width        : in    natural;                                     -- Number of physical address pins
            rd_width        : in    natural;                                     -- Number of physical data pins
            rc_width        : in    natural;                                     -- Number of physical control pins
            a_width         : in    natural;                                     -- Number of logical address bits
            d_width         : in    natural;                                     -- Number of logical data bits
            tag_width       : in    natural);                                    -- Number of tag bits
        port(
            -- To/from clocking infrastructure
            clk0            : in    std_logic;                                   -- I/O clock
            clk90           : in    std_logic;                                   -- As 'clk0' but lags by 90 degrees
            clk180          : in    std_logic;                                   -- As 'clk0' but lags by 180 degrees
            clk270          : in    std_logic;                                   -- As 'clk0' but lags by 270 degrees
            rst             : in    std_logic;                                   -- Aynchronous reset
            -- To/from application
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
            regd            : in    std_logic;                                   -- 0 => unbuffered, 1 => registered
            x4              : in    std_logic;                                   -- 0 => normal, 1 => DM functions as DQS (x4 devices on DIMM)
            row             : in    std_logic_vector(1 downto 0);                -- row addr width: 00 => 12, ... , 11 => 15
            col             : in    std_logic_vector(1 downto 0);                -- col addr width: 00 => row - 4, ... , 11 => row - 1
            bank            : in    std_logic_vector(1 downto 0);                -- bank addr width: 00 => 0, ... , 11 => 3
            pbank           : in    std_logic_vector(1 downto 0);                -- num. phys banks: 00 => 1, ... , 11 => 8
            -- To/from memories
            ra              : out   std_logic_vector(ra_width - 1 downto 0);
            rc              : inout std_logic_vector(rc_width - 1 downto 0);
            rd              : inout std_logic_vector(rd_width - 1 downto 0));
    end component;

    component ddrsdram_training_v2
        generic(
            num_port        : in    natural);
        port(
            -- To/from clocking infrastructure
            clk             : in    std_logic;                                   -- Interface clock
            rst             : in    std_logic;                                   -- Aynchronous reset
            -- To/from application
            clkc            : in    std_logic;                                   -- Clock from which 'clkc0' is derived
            sr              : in    std_logic;                                   -- Synchronous reset
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
    end component;

    component ddr2sram_port
        generic(
            pinout          : in    ddr2sram_pinout_t;
            ra_width        : in    natural;                                     -- Number of physical address pins
            rd_width        : in    natural;                                     -- Number of physical data pins
            rc_width        : in    natural;                                     -- Number of physical control pins
            a_width         : in    natural;                                     -- Number of logical address bits
            d_width         : in    natural;                                     -- Number of logical data bits
            tag_width       : in    natural);                                    -- Number of tag bits
        port(
            -- To/from clocking infrastructure
            clk0            : in    std_logic;                                  -- Interface clock
            clk90           : in    std_logic;                                  -- As 'clk0' but lags by 90 degrees
            clk180          : in    std_logic;                                  -- As 'clk0' but lags by 180 degrees
            clk270          : in    std_logic;                                  -- As 'clk0' but lags by 270 degrees
            rst             : in    std_logic;                                  -- Asynchronous reset
            -- To/from application
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
            burst_len       : in    std_logic;                                   -- Supported burst length: 0 => 2 only, 1 => 2 & 4
            dll_off         : in    std_logic;                                   -- Disables DLL in SSRAM device when high
            -- To/from memories
            ra              : out   std_logic_vector(ra_width - 1 downto 0);
            rc              : inout std_logic_vector(rc_width - 1 downto 0);
            rd              : inout std_logic_vector(rd_width - 1 downto 0));
    end component;

    component ddr2sram_port_v2
        generic(
            pinout          : in    ddr2sram_pinout_t;
            ra_width        : in    natural;                                     -- Number of physical address pins
            rd_width        : in    natural;                                     -- Number of physical data pins
            rc_width        : in    natural;                                     -- Number of physical control pins
            a_width         : in    natural;                                     -- Number of logical address bits
            d_width         : in    natural;                                     -- Number of logical data bits
            tag_width       : in    natural);                                    -- Number of tag bits
        port(
            -- To/from clocking infrastructure
            clk0            : in    std_logic;                                   -- I/O clock
            clk90           : in    std_logic;                                   -- As 'clk0' but lags by 90 degrees
            clk180          : in    std_logic;                                   -- As 'clk0' but lags by 180 degrees
            clk270          : in    std_logic;                                   -- As 'clk0' but lags by 270 degrees
            rst             : in    std_logic;                                   -- Asynchronous reset
            -- To/from application
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
            -- Sideband control signals (inputs must be stable during operation)
            burst_len       : in    std_logic;                                   -- Supported burst length: 0 => 2 only, 1 => 2 & 4
            dll_off         : in    std_logic;                                   -- Disables DLL in SSRAM device when high
            -- To/from memories
            ra              : out   std_logic_vector(ra_width - 1 downto 0);
            rc              : inout std_logic_vector(rc_width - 1 downto 0);
            rd              : inout std_logic_vector(rd_width - 1 downto 0));
    end component;

    component ddr2sram_port_v4
        generic(
            pinout          : in    ddr2sram_pinout_t;
            ra_width        : in    natural;                                     -- Number of physical address pins
            rd_width        : in    natural;                                     -- Number of physical data pins
            rc_width        : in    natural;                                     -- Number of physical control pins
            a_width         : in    natural;                                     -- Number of logical address bits
            d_width         : in    natural;                                     -- Number of logical data bits
            tag_width       : in    natural);                                    -- Number of tag bits
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
    end component;

    component ddr2sram_training_v2
        generic(
            num_port        : in    natural);
        port(
            -- To/from clocking infrastructure
            clk             : in    std_logic;                                   -- Interface clock
            rst             : in    std_logic;                                   -- Aynchronous reset
            -- To/from application
            clkc            : in    std_logic;                                   -- Clock from which 'clkc0' is derived
            sr              : in    std_logic;                                   -- Synchronous reset
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
    end component;

    component memory_test
        generic(
            a_width       : in    natural;                       -- Number of (logical) address bits in memory port
            d_width       : in    natural;                       -- Number of logical bits in a memory port word
            tag_width     : in    natural;                       -- Number of tag bits
            rd_width      : in    natural);                      -- Number of physical data pins on memory bank
        port(
            rst           : in    std_logic;                     -- Sync or async. reset
            clk           : in    std_logic;                     -- Clock
            -- Control interface
            go            : in    std_logic;                     -- Pulse high for at least one cycle to initiate test
            offset        : in    std_logic_vector(31 downto 0); -- Starting word address of test
            length        : in    std_logic_vector(31 downto 0); -- Number of words to test, minus 1
            done          : out   std_logic;                     -- High indicates finished or idle
            error         : out   std_logic;                     -- Qualified by 'done', high indicates at least one error ocurred
            eaddr         : out   std_logic_vector(31 downto 0); -- Qualified by 'done and error', gives word address of first error
            ephase        : out   std_logic_vector(7 downto 0);  -- Qualified by 'done and error', gives phase in which first error occurred
            -- To/from memory bank
            valid         : in    std_logic;
            q             : in    std_logic_vector(d_width - 1 downto 0);
            qtag          : in    std_logic_vector(tag_width - 1 downto 0);
            ready         : in    std_logic;
            req           : out   std_logic;
            ce            : out   std_logic;
            w             : out   std_logic;
            a             : out   std_logic_vector(a_width - 1 downto 0);
            tag           : out   std_logic_vector(tag_width - 1 downto 0);
            d             : out   std_logic_vector(d_width - 1 downto 0);
            be            : out   std_logic_vector(d_width / 8 - 1 downto 0));
    end component;

    component port_mux
        generic(
            order           : in    natural;                                       -- Must be log2(in_width / out_width)
            in_width        : in    natural;                                       -- Unmultiplexed data width
            out_width       : in    natural);                                      -- Multiplexed segment width
        port(
            rst             : in    std_logic;                                     -- Asychronous reset
            clk             : in    std_logic;                                     -- Clock
            init            : in    std_logic;                                     -- Pulse to load 'addr'
            addr            : in    std_logic_vector(order - 1 downto 0);          -- Selects first segment of a 'din'
            adv             : in    std_logic;                                     -- Advances 'dout' to next segment
            din             : in    std_logic_vector(in_width - 1 downto 0);       -- Unmultiplexed data
            dout            : out   std_logic_vector(out_width - 1 downto 0);      -- Multiplexed segment
            last            : out   std_logic);                                    -- Asserted when 'dout' is last segment of 'din'
    end component;

    component port_repl
        generic(
            order           : in    natural;
            in_width        : in    natural;
            out_width       : in    natural;
            partial         : in    boolean);
        port(
            rst             : in    std_logic;
            clk             : in    std_logic;
            init            : in    std_logic;
            addr            : in    std_logic_vector(order - 1 downto 0);
            wr              : in    std_logic;
            last            : in    std_logic;
            din             : in    std_logic_vector(in_width - 1 downto 0);
            bein            : in    std_logic_vector(in_width / 8 - 1 downto 0);
            dout            : out   std_logic_vector(out_width - 1 downto 0);      -- Qual. by 'valid'
            beout           : out   std_logic_vector(out_width / 8 - 1 downto 0);  -- Qual. by 'valid'
            valid           : out   std_logic;
            final           : out   std_logic);                                    -- Qual. by 'valid'
    end component;

    component pulse_sync
        port(
            ar : in  std_logic;
            ik : in  std_logic;
            i  : in  std_logic;
            ok : in  std_logic;
            o  : out std_logic);
    end component;

    component spd_i2c
        generic(
            scldiv          : in    natural;
            enable_write    : in    boolean := false);
        port(
            -- Client interface
            clk             : in    std_logic;                                     -- Clock
            rst             : in    std_logic;                                     -- Asynchronous reset
            sr              : in    std_logic;                                     -- Synchronous reset
            ce              : in    std_logic;                                     -- Command enable, initiates operation
            wr              : in    std_logic;                                     -- Qualified by 'ce', '1' => write
            sa              : in    std_logic_vector(2 downto 0);                  -- Slot address
            a               : in    std_logic_vector(7 downto 0);                  -- Location in EEPROM to access
            d               : in    std_logic_vector(7 downto 0);                  -- Word to be written to EEPROM
            ack             : out   std_logic;                                     -- Pulsed to indicate read/write finished
            busy            : out   std_logic;                                     -- '1' => 'ce' is ignored
            q               : out   std_logic_vector(7 downto 0);                  -- Word read from EEPROM, qual. by 'ack'
            err             : out   std_logic;                                     -- '1' => operation failed, qual. by 'ack'
            -- To/from EEPROM pins
            sda_i           : in    std_logic;                                     -- Serial data from EEPROM
            sda_o           : out   std_logic;                                     -- Serial data to EEPROM
            scl_i           : in    std_logic;                                     -- Serial clock from EEPROM
            scl_o           : out   std_logic);                                    -- Serial clock to EEPROM
    end component;
            
    --
    -- ZBT SSRAM memory interface component
    --
    component zbtsram_port
        generic(
            pinout          : in    zbtsram_pinout_t;
            ra_width        : in    natural;
            rd_width        : in    natural;
            rc_width        : in    natural;
            a_width         : in    natural;
            d_width         : in    natural;
            tag_width       : in    natural);
        port(
            -- To/from clocking infrastructure
            clk0            : in    std_logic;                                   -- Clock
            rst             : in    std_logic;                                   -- Asynchronous reset
            -- To/from application
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
            pipeline        : in    std_logic;                                   -- 1 => operate in pipelined mode
            trained         : out   std_logic;                                   -- 1 => training was successful
            -- To/from memories
            ra              : out   std_logic_vector(ra_width - 1 downto 0);
            rc              : inout std_logic_vector(rc_width - 1 downto 0);
            rd              : inout std_logic_vector(rd_width - 1 downto 0));
    end component;

end;

package body memif is

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

end;
