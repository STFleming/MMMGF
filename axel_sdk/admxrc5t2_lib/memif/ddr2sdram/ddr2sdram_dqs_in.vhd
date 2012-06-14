--
-- ddr2sdram_dqs_in.vhd
--
-- Module for capturing inbound DQS/DQS# from DDR-II SDRAM.
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
library std;
use std.textio.all;
-- synopsys translate_on

library work;
use work.memif.all;

entity ddr2sdram_dqs_in is
    generic(
        dqs_width       : in  natural);
    port( 
        rst             : in  std_logic;
        clk             : in  std_logic;
        dlysr           : in  std_logic_vector(dqs_width - 1 downto 0);
        dlyce           : in  std_logic_vector(dqs_width - 1 downto 0);
        dlyinc          : in  std_logic_vector(dqs_width - 1 downto 0);
        dqs_i           : in  std_logic_vector(dqs_width - 1 downto 0);
        dqs_idelay      : out std_logic_vector(dqs_width - 1 downto 0));
end entity;

architecture mixed of ddr2sdram_dqs_in is

    constant this_module : string := "ddr2sdram_dqs_in";

    component IDELAY
        generic(
            IOBDELAY_TYPE  : string  := "DEFAULT"; -- (DEFAULT, FIXED, VARIABLE)
            IOBDELAY_VALUE : integer := 0);        -- (0 to 63)
        port(
            O              : out std_logic;
            I              : in  std_logic;
            C              : in  std_logic;
            CE             : in  std_logic;
            INC            : in  std_logic;
            RST            : in  std_logic);
    end component;

    component BUFIO
        port(
            I              : in  std_logic;
            O              : out std_logic);
    end component;

    signal dqs_unbuf : std_logic_vector(dqs_width - 1 downto 0);

begin

    gen_dqs_idelay : for i in 0 to dqs_width - 1 generate
        U0 : IDELAY
            generic map(
                IOBDELAY_TYPE => "VARIABLE")
            port map(
                O => dqs_unbuf(i),
                I => dqs_i(i),
                C => clk,
                CE => dlyce(i),
                INC => dlyinc(i),
                RST => dlysr(i));

        U1 : BUFIO
            port map(
                I => dqs_unbuf(i),
                O => dqs_idelay(i));
    end generate;

end mixed;
