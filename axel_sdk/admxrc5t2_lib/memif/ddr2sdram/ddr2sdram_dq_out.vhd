--
-- ddr2sdram_dq_out.vhd
--
-- Module for generating outbound DQ signals for DDR-II SDRAM.
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

entity ddr2sdram_dq_out is
    generic(
        dq_width        : in  natural;
        d_width         : in  natural);
    port( 
        clk0            : in  std_logic;
        clk45           : in  std_logic;
        clk2x0          : in  std_logic;
        clk2x90         : in  std_logic;
        sr              : in  std_logic_vector(dq_width - 1 downto 0);
        ce              : in  std_logic_vector(dq_width - 1 downto 0);
        oe_l            : in  std_logic_vector(dq_width - 1 downto 0);
        d               : in  std_logic_vector(d_width - 1 downto 0);
        dq_o            : out std_logic_vector(dq_width - 1 downto 0);
        dq_t            : out std_Logic_vector(dq_width - 1 downto 0));
end entity;

architecture mixed of ddr2sdram_dq_out is

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

    component ddr2sdram_oserdes_dq is
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

    signal d_ext : std_logic_vector(4 * dq_width - 1 downto 0);
    signal d_ro : std_logic_vector(4 * dq_width - 1 downto 0);

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of dq_o : signal is "no";
    attribute equivalent_register_removal of dq_t : signal is "no";

begin

    d_ext <= EXT(d, dq_width * 4);

    reorder : process(d_ext)
    begin
        for i in 0 to dq_width - 1 loop
            d_ro(4 * i + 0) <= d_ext(i + 0 * dq_width);
            d_ro(4 * i + 1) <= d_ext(i + 1 * dq_width);
            d_ro(4 * i + 2) <= d_ext(i + 2 * dq_width);
            d_ro(4 * i + 3) <= d_ext(i + 3 * dq_width);
        end loop;
    end process;

    gen_serdes : for i in 0 to dq_width - 1 generate
        U0 : ddr2sdram_oserdes_dq
            port map(
                clk45 => clk45,
                clk2x90 => clk2x90,
                sr => sr(i),
                ce => ce(i),
                d => d_ro(4 * (i + 1) - 1 downto 4 * i),
                t => oe_l(i),
                q => dq_o(i),
                tq => dq_t(i));
    end generate;

end mixed;
