--
-- ddrsdram_dm.vhd
--
-- Module for generating DM signals for DDR-II SDRAM.
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

entity ddr2sdram_odt is
    generic(
        num_odt         : in    natural);
    port(
        clk             : in    std_logic;
        wr              : in    std_logic;
        odt_o           : out   std_logic_vector(num_odt - 1 downto 0));
end entity;

architecture mixed of ddr2sdram_odt is

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

    signal wr_q : std_logic_vector(1 downto 0);

begin

    gen_odt : process(clk)
    begin
        if clk'event and clk = '1' then
            wr_q(0) <= wr;
            wr_q(wr_q'high downto 1) <= wr_q(wr_q'high - 1 downto 0);
            odt_o <= (others => OR_reduce(wr & wr_q));
        end if;
    end process;

end mixed;
