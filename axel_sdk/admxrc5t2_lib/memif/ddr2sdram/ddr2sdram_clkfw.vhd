--
-- ddr2sdram_clkfw.vhd - clock fowarding module for generating differential clock signals
--                       to DDR-II SDRAM.
--
-- SYNTHESIZABLE
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

entity ddr2sdram_clkfw is
    generic(
        num_clock       : in  natural);
    port (
        clk2x           : in  std_logic;
        rst             : in  std_logic;
        ddr_clk         : out std_logic_vector(num_clock - 1 downto 0);
        ddr_clk_l       : out std_logic_vector(num_clock - 1 downto 0));
end entity;

architecture mixed of ddr2sdram_clkfw is

    signal logic0, logic1 : std_logic;

    component ODDR
        port(
            D1 : in  std_logic;
            D2 : in  std_logic;
            CE : in  std_logic;
            C  : in  std_logic;
            S  : in  std_logic;
            R  : in  std_logic;
            Q  : out std_logic);
    end component;

begin

    logic0 <= '0';
    logic1 <= '1';

    gen_oddr : for i in 0 to num_clock - 1 generate
        gen_ddr_clk : ODDR
            port map(
                D1 => logic0,
                D2 => logic1,
                CE => logic1,
                C  => clk2x,
                S  => logic0,
                R  => logic0,
                Q  => ddr_clk(i));

        gen_ddr_clk_l : ODDR
            port map(
                D1 => logic1,
                D2 => logic0,
                CE => logic1,
                C  => clk2x,
                S  => logic0,
                R  => logic0,
                Q  => ddr_clk_l(i));
    end generate;

end mixed;
