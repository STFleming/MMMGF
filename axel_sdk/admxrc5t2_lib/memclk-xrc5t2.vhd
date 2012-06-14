--
-- memclk-xrc5t2.vhd - generate memory interface clocks (Virtex-5)
--
-- This module produces 4 clocks to drive DDR-II SDRAM ports.
--
-- SYNTHESIZABLE
--
-- Targets models:
--
--   o ADM-XRC-5T2
--
-- 'clk0' is baseline clock ('clk2x' divided by 2)
--
-- 'clk45' is baseline clock phase shifted by +45 degrees ('clk2x90' divided by 2)
--
-- 'clk2x' is 'clk0' multiplied by 2
--
-- 'clk2x90' is 'clk2x' phase shifted by +90 degrees
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library work;
use work.memif_def.all;

entity memclk is
port (
      mclk              : in  std_logic;
      rst               : in  std_logic;
      refclk200         : in  std_logic;
      clk0              : out std_logic;
      clk45             : out std_logic;
      clk2x0            : out std_logic;
      clk2x90           : out std_logic;
      locked            : out std_logic_vector(1 downto 0);
      memrst            : out std_logic);
end entity;

architecture mixed of memclk is

    component BUFG
        port(
            O : out std_ulogic;
            I : in  std_ulogic);
    end component;

    component PLL_BASE
        generic(
            BANDWIDTH : string := "OPTIMIZED";
            CLKFBOUT_MULT : integer := 1;
            CLKFBOUT_PHASE : real := 0.0;
            CLKIN_PERIOD : real := 0.000;
            CLKOUT0_DIVIDE : integer := 1;
            CLKOUT0_DUTY_CYCLE : real := 0.5;
            CLKOUT0_PHASE : real := 0.0;
            CLKOUT1_DIVIDE : integer := 1;
            CLKOUT1_DUTY_CYCLE : real := 0.5;
            CLKOUT1_PHASE : real := 0.0;
            CLKOUT2_DIVIDE : integer := 1;
            CLKOUT2_DUTY_CYCLE : real := 0.5;
            CLKOUT2_PHASE : real := 0.0;
            CLKOUT3_DIVIDE : integer := 1;
            CLKOUT3_DUTY_CYCLE : real := 0.5;
            CLKOUT3_PHASE : real := 0.0;
            CLKOUT4_DIVIDE : integer := 1;
            CLKOUT4_DUTY_CYCLE : real := 0.5;
            CLKOUT4_PHASE : real := 0.0;
            CLKOUT5_DIVIDE : integer := 1;
            CLKOUT5_DUTY_CYCLE : real := 0.5;
            CLKOUT5_PHASE : real := 0.0;
            COMPENSATION : string := "SYSTEM_SYNCHRONOUS";
            DIVCLK_DIVIDE : integer := 1;
            REF_JITTER : real := 0.100;
            RESET_ON_LOSS_OF_LOCK : boolean := FALSE);
        port(
            CLKFBOUT : out std_ulogic;
            CLKOUT0 : out std_ulogic;
            CLKOUT1 : out std_ulogic;
            CLKOUT2 : out std_ulogic;
            CLKOUT3 : out std_ulogic;
            CLKOUT4 : out std_ulogic;
            CLKOUT5 : out std_ulogic;
            LOCKED : out std_ulogic;
            CLKFBIN : in std_ulogic;
            CLKIN : in std_ulogic;
            RST : in std_ulogic);
    end component;

    signal memrst0 : std_logic_vector(7 downto 0);

    signal mclk0_pll : std_logic;
    signal mclkdiv0_pll : std_logic;
    signal mclk90_pll : std_logic;
    signal mclkdiv90_pll : std_logic;

    signal mclk0_bufg : std_logic;
    signal mclkdiv0_bufg : std_logic;
    signal mclk90_bufg : std_logic;
    signal mclkdiv90_bufg : std_logic;

    signal clkfb : std_logic;

    signal pll_locked : std_logic;
    signal idelay_rst : std_logic;
    signal idelay_rdy : std_logic;

    signal logic1 : std_logic;
    signal logic0 : std_logic;

    attribute CLKIN_PERIOD : real;
    attribute CLKOUT0_DIVIDE : integer;
    attribute CLKOUT0_PHASE : real;
    attribute CLKOUT1_DIVIDE : integer;
    attribute CLKOUT1_PHASE : real;
    attribute CLKOUT2_DIVIDE : integer;
    attribute CLKOUT2_PHASE : real;
    attribute CLKOUT3_DIVIDE : integer;
    attribute CLKOUT3_PHASE : real;
    attribute CLKFBOUT_MULT : integer;
    attribute DIVCLK_DIVIDE : integer;
    attribute REF_JITTER : real;
    attribute COMPENSATION : string;

    attribute CLKIN_PERIOD of pll_0 : label is 3.75;
    attribute CLKOUT0_DIVIDE of pll_0 : label is 2;
    attribute CLKOUT0_PHASE of pll_0 : label is 0.0;
    attribute CLKOUT1_DIVIDE of pll_0 : label is 4;
    attribute CLKOUT1_PHASE of pll_0 : label is 0.0;
    attribute CLKOUT2_DIVIDE of pll_0 : label is 2;
    attribute CLKOUT2_PHASE of pll_0 : label is 90.0;
    attribute CLKOUT3_DIVIDE of pll_0 : label is 4;
    attribute CLKOUT3_PHASE of pll_0 : label is 45.0;
    attribute CLKFBOUT_MULT of pll_0 : label is 2;

    --
    -- If the synthesizer replicates an asynchronous reset signal due high fanout,
    -- this can prevent flip-flops being mapped into IOBs. We set the maximum
    -- fanout for such nets to a high enough value that replication never occurs.
    --
    attribute MAX_FANOUT : string;
    attribute MAX_FANOUT of memrst : signal is "1000000";

begin

    logic1 <= '1';
    logic0 <= '0';

    clk0 <= mclkdiv90_bufg;
    clk45 <= mclkdiv0_bufg;
    clk2x0 <= mclk90_bufg;
    clk2x90 <= mclk0_bufg;

    locked <= idelay_rdy & pll_locked;

    gen_memrst : process(rst, refclk200)
    begin
        if rst = '1' then
            memrst0 <= (others => '1');
            memrst <= '1';
        elsif refclk200'event and refclk200 = '1' then
            if idelay_rdy = '0' or pll_locked = '0' then
                memrst0 <= (others => '1');
                memrst <= '1';
            else
                memrst0(0) <= '0';
                memrst0(memrst0'high downto 1) <= memrst0(memrst0'high - 1 downto 0);
                memrst <= OR_reduce(memrst0);
            end if;
        end if;
    end process;

    pll_0 : PLL_BASE
        generic map(
            CLKIN_PERIOD => 3.75,
            CLKOUT0_DIVIDE => 2,
            CLKOUT1_DIVIDE => 4,
            CLKOUT2_DIVIDE => 2,
            CLKOUT3_DIVIDE => 4,
            CLKOUT0_PHASE => 0.000,
            CLKOUT1_PHASE => 0.000,
            CLKOUT2_PHASE => 90.000,
            CLKOUT3_PHASE => 45.000,
            CLKFBOUT_MULT => 2)
        port map(
            CLKFBOUT => clkfb,
            CLKOUT0 => mclk0_pll,
            CLKOUT1 => mclkdiv0_pll,
            CLKOUT2 => mclk90_pll,
            CLKOUT3 => mclkdiv90_pll,
            CLKOUT4 => open,
            CLKOUT5 => open,
            LOCKED => pll_locked,
            CLKFBIN => clkfb,
            CLKIN => mclk,
            RST => rst);
            
    bufg_mclk0 : BUFG
        port map(
            I => mclk0_pll,
            O => mclk0_bufg);

    bufg_mclkdiv0 : BUFG
        port map(
            I => mclkdiv0_pll,
            O => mclkdiv0_bufg);

    bufg_mclk90 : BUFG
        port map(
            I => mclk90_pll,
            O => mclk90_bufg);

    bufg_mclkdiv90 : BUFG
        port map(
            I => mclkdiv90_pll,
            O => mclkdiv90_bufg);

    --------------------------------------------------------------------------------------------------------------------
    -- IDELAYCTRL instantiation
    --------------------------------------------------------------------------------------------------------------------

    idelay_rst <= not pll_locked;

    idelay_ctrl_0 : IDELAYCTRL
        port map(
            REFCLK => refclk200,
            RST => idelay_rst,
            RDY => idelay_rdy);

end architecture;
