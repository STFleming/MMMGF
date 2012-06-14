--
-- ddr2sram_oserdes_dq.vhd - ODDR emulation of OSERDES instance for
--                           Virtex-4 / Virtex-5 DDR-II SSRAM interface
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

entity ddr2sram_oserdes_dq is
    port (
        clk45      : in  std_logic;
        clk2x90    : in  std_logic;
        sr         : in  std_logic;
        ce         : in  std_logic;
        d          : in  std_logic_vector(3 downto 0);
        t          : in  std_logic;
        q          : out std_logic;
        tq         : out std_logic);
end entity;

architecture mixed of ddr2sram_oserdes_dq is

    signal d_q, d_q0, d_q1 : std_logic_vector(3 downto 0);
    signal t_q0, t_q1 : std_logic;
    signal d2 : std_logic_vector(1 downto 0);
    signal first : std_logic;

    signal logic0 : std_logic;
    signal logic1 : std_logic;
    signal logicx : std_logic;

    component ODDR
        generic(
            DDR_CLK_EDGE : in  string := "OPPOSITE_EDGE";
            INIT         : in  bit := '1';
            SRTYPE       : in  string := "SYNC");
        port(
            D1           : in  std_logic;
            D2           : in  std_logic;
            CE           : in  std_logic;
            C            : in  std_logic;
            S            : in  std_logic;
            R            : in  std_logic;
            Q            : out std_logic);
    end component;

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of d_q : signal is "no";
    attribute equivalent_register_removal of d_q0 : signal is "no";
    attribute equivalent_register_removal of d_q1 : signal is "no";
    attribute equivalent_register_removal of q : signal is "no";
    attribute equivalent_register_removal of first : signal is "no";
    attribute equivalent_register_removal of t_q0 : signal is "no";
    attribute equivalent_register_removal of t_q1 : signal is "no";
    attribute equivalent_register_removal of tq : signal is "no";

    attribute DDR_CLK_EDGE : string;
    attribute DDR_CLK_EDGE of U0 : label is "SAME_EDGE";
    attribute DDR_CLK_EDGE of U1 : label is "SAME_EDGE";
    attribute INIT : bit;
    attribute INIT of U0 : label is '1';
    attribute INIT of U1 : label is '0';
    attribute SRTYPE : string;
    attribute SRTYPE of U0 : label is "ASYNC";
    attribute SRTYPE of U1 : label is "ASYNC";

begin

    logic0 <= '0';
    logic1 <= '1';

    delay_t : process(clk45)
    begin
        if clk45'event and clk45 = '1' then
            if sr = '1' then
                t_q0 <= '1';
            else
                t_q0 <= t;
            end if;
        end if;
    end process;

    delay_t_q0 : process(clk2x90)
    begin
        if clk2x90'event and clk2x90 = '1' then
            if sr = '1' then
                t_q1 <= '1';
            else
                t_q1 <= t_q0;
            end if;
        end if;
    end process;

    U0 : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => t_q1,
            D2 => t_q0,
            CE => logic1,
            C => clk2x90,
            S => sr,
            R => logic0,
            Q => tq);

    delay_d : process(clk45)
    begin
        if clk45'event and clk45 = '1' then
            d_q <= d;
            d_q0 <= d(2 downto 0) & d_q(3);
        end if;
    end process;

    delay_d_q1 : process(clk2x90)
    begin
        if clk2x90'event and clk2x90 = '1' then
            d_q1 <= d_q0;
        end if;
    end process;

    gen_first : process(clk2x90)
    begin
        if clk2x90'event and clk2x90 = '1' then
            if sr = '1' then
                first <= '1';
            else
                first <= not first;
            end if;
        end if;
    end process;

    d2(0) <= d_q0(0) when first = '1' else d_q1(2);
    d2(1) <= d_q0(1) when first = '1' else d_q1(3);

    U1 : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => d2(0),
            D2 => d2(1),
            CE => logic1,
            C => clk2x90,
            S => logic0,
            R => logic0,
            Q => q);

end mixed;
