--
-- ddrsdram_clkfw.vhd - clock fowarding module for generating differential clock signals
--                      to DDR SDRAM.
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

entity ddrsdram_clkfw is
    generic(
        num_clock       : in  natural);
    port (
        clk0            : in  std_logic;
        clk180          : in  std_logic;
        rst             : in  std_logic;
        ddr_clk         : out std_logic_vector(num_clock - 1 downto 0);
        ddr_clk_l       : out std_logic_vector(num_clock - 1 downto 0));
end;

architecture mixed of ddrsdram_clkfw is

    signal logic0, logic1 : std_logic;

    component FDDRRSE
        port(
            D0 : in  std_logic;
            D1 : in  std_logic;
            C0 : in  std_logic;
            C1 : in  std_logic;
            CE : in  std_logic;
            R  : in  std_logic;
            S  : in  std_logic;
            Q  : out std_logic);
    end component;

begin

    logic0 <= '0';
    logic1 <= '1';

    gen_fddr : for i in 0 to num_clock - 1 generate
        gen_ddr_clk : FDDRRSE
            port map(
                D0 => logic1,
                D1 => logic0,
                C0 => clk180,
                C1 => clk0,
                CE => logic1,
                R  => logic0,
                S  => logic0,
                Q  => ddr_clk(i));

        gen_ddr_clk_l : FDDRRSE
            port map(
                D0 => logic0,
                D1 => logic1,
                C0 => clk180,
                C1 => clk0,
                CE => logic1,
                R  => logic0,
                S  => logic0,
                Q  => ddr_clk_l(i));
    end generate;

end mixed;
