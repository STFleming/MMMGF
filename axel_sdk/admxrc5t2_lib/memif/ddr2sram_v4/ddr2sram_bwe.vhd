--
-- ddrsram_bwe.vhd
--
-- Module for generating BWE# signals for DDR-II SSRAM.
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

entity ddr2sram_bwe is
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
end entity;

architecture mixed of ddr2sram_bwe is

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

    component ddr2sram_oserdes_dq is
        port(
            clk45      : in  std_logic;
            clk2x90    : in  std_logic;
            sr         : in  std_logic;
            ce         : in  std_logic;
            d          : in  std_logic_vector(3 downto 0);
            t          : in  std_logic;
            q          : out std_logic;
            tq         : out std_logic);
    end component;

    signal be_ro_l : std_logic_vector(4 * bwe_width - 1 downto 0);

    signal logic0 : std_logic;

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of bwe_o_l : signal is "no";
    attribute equivalent_register_removal of bwe_t : signal is "no";

begin

    logic0 <= '0';

    reorder : process(be_l)
    begin
        for i in 0 to bwe_width - 1 loop
            be_ro_l(4 * i + 0) <= be_l(i + 0 * bwe_width);
            be_ro_l(4 * i + 1) <= be_l(i + 1 * bwe_width);
            be_ro_l(4 * i + 2) <= be_l(i + 2 * bwe_width);
            be_ro_l(4 * i + 3) <= be_l(i + 3 * bwe_width);
        end loop;
    end process;

    gen_serdes : for i in 0 to bwe_width - 1 generate
        U0 : ddr2sram_oserdes_dq
            port map(
                clk45 => clk45,
                clk2x90 => clk2x90,
                sr => sr(i),
                ce => ce(i),
                d => be_ro_l(4 * (i + 1) - 1 downto 4 * i),
                t => logic0,
                q => bwe_o_l(i),
                tq => bwe_t(i));
    end generate;

end mixed;
