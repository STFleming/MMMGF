--
-- ddr2sdram_dqs_out.vhd
--
-- Module for generating outbound DQS/DQS# signals for DDR-II SDRAM.
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

entity ddr2sdram_dqs_out is
    generic(
        dqs_width     : in  natural);
    port(
        clk           : in  std_logic;
        clk2x         : in  std_logic;
        sr            : in  std_logic_vector(dqs_width - 1 downto 0);
        ce            : in  std_logic_vector(dqs_width - 1 downto 0);
        oe_l          : in  std_logic_vector(dqs_width - 1 downto 0);
        wr            : in  std_logic;
        dqs_o         : out std_logic_vector(dqs_width - 1 downto 0);
        dqs_o_l       : out std_logic_vector(dqs_width - 1 downto 0);
        dqs_t         : out std_logic_vector(2 * dqs_width - 1 downto 0));
end;

architecture mixed of ddr2sdram_dqs_out is

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

    signal wr_l : std_logic;

    signal logic0, logic1 : std_logic;

    component ddr2sdram_oserdes_dqs is
        port(
            clk        : in  std_logic;
            clk2x      : in  std_logic;
            sr         : in  std_logic;
            ce         : in  std_logic;
            d          : in  std_logic;
            db         : in  std_logic;
            t          : in  std_logic;
            q          : out std_logic;
            tq         : out std_logic;
            qb         : out std_logic;
            tqb        : out std_logic);
    end component;

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of dqs_o : signal is "no";
    attribute equivalent_register_removal of dqs_t : signal is "no";

begin

    logic0 <= '0';
    logic1 <= '1';

    --
    -- Generate DDR flip-flops for DQS pins
    --

    wr_l <= not wr;

    gen_serdes : for i in 0 to dqs_width - 1 generate
        U0 : ddr2sdram_oserdes_dqs
            port map(
                clk => clk,
                clk2x => clk2x,
                sr => sr(i),
                ce => ce(i),
                d => wr,
                db => wr_l,
                t => oe_l(i),
                q => dqs_o(i),
                tq => dqs_t(i),
                qb => dqs_o_l(i),
                tqb => dqs_t(i + dqs_width));
    end generate;

end mixed;
