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

entity ddr2sdram_dm is
    generic(
        be_width      : in  natural;
        dm_width      : in  natural);
    port(
        clk0            : in  std_logic;
        clk45           : in  std_logic;
        clk2x0          : in  std_logic;
        clk2x90         : in  std_logic;
        sr              : in  std_logic_vector(dm_width - 1 downto 0);
        ce              : in  std_logic_vector(dm_width - 1 downto 0);
        oe_l            : in  std_logic_vector(dm_width - 1 downto 0);
        be_l            : in  std_logic_vector(be_width - 1 downto 0);
        dm_o            : out std_logic_vector(dm_width - 1 downto 0);
        dm_t            : out std_logic_vector(dm_width - 1 downto 0));
end entity;

architecture mixed of ddr2sdram_dm is

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

    signal dm_ext : std_logic_vector(4 * dm_width - 1 downto 0);
    signal dm_ext_q : std_logic_vector(4 * dm_width - 1 downto 0);
    signal dm_ro : std_logic_vector(4 * dm_width - 1 downto 0);

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of dm_o : signal is "no";
    attribute equivalent_register_removal of dm_t : signal is "no";

begin

    dm_ext <= not EXT(not be_l, dm_width * 4);

    delay_dm_ext : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            dm_ext_q <= dm_ext;
        end if;
    end process;

    reorder : process(dm_ext, dm_ext_q)
    begin
        for i in 0 to dm_width - 1 loop
            dm_ro(4 * i + 0) <= dm_ext(i + 0 * dm_width);
            dm_ro(4 * i + 1) <= dm_ext(i + 1 * dm_width);
            dm_ro(4 * i + 2) <= dm_ext(i + 2 * dm_width);
            dm_ro(4 * i + 3) <= dm_ext(i + 3 * dm_width);
        end loop;
    end process;

    gen_serdes : for i in 0 to dm_width - 1 generate
        U0 : ddr2sdram_oserdes_dq
            port map(
                clk45 => clk45,
                clk2x90 => clk2x90,
                sr => sr(i),
                ce => ce(i),
                d => dm_ro(4 * (i + 1) - 1 downto 4 * i),
                t => oe_l(i),
                q => dm_o(i),
                tq => dm_t(i));
    end generate;

end mixed;
