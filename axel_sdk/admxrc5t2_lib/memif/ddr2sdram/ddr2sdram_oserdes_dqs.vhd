--
-- ddr2sdram_oserdes_dqs.vhd - ODDR emulation of OSERDES instance for Virtex-4 / Virtex-5
--                             DDR-II SDRAM interface
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

entity ddr2sdram_oserdes_dqs is
    port (
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
end entity;

architecture mixed of ddr2sdram_oserdes_dqs is

    signal d_q, db_q : std_logic;
    signal t_q : std_logic;

    signal logic0 : std_logic;
    signal logic1 : std_logic;

    component OSERDES
        generic(
            DATA_RATE_OQ : in  string := "DDR";
            DATA_RATE_TQ : in  string := "DDR";
            DATA_WIDTH   : in  integer := 4;
            INIT_OQ      : in  bit := '0';
            INIT_TQ      : in  bit := '0';
            SERDES_MODE  : in  string := "MASTER";
            SRVAL_OQ     : in  bit := '0';
            SRVAL_TQ     : in  bit := '0';
            TRISTATE_WIDTH : in  integer := 4);
        port(
            OQ           : out std_logic;
            SHIFTOUT1    : out std_logic;
            SHIFTOUT2    : out std_logic;
            TQ           : out std_logic;
            CLK          : in  std_logic;
            CLKDIV       : in  std_logic;
            D1           : in  std_logic;
            D2           : in  std_logic;
            D3           : in  std_logic;
            D4           : in  std_logic;
            D5           : in  std_logic;
            D6           : in  std_logic;
            OCE          : in  std_logic;
            REV          : in  std_logic;
            SHIFTIN1     : in  std_logic;
            SHIFTIN2     : in  std_logic;
            SR           : in  std_logic;
            T1           : in  std_logic;
            T2           : in  std_logic;
            T3           : in  std_logic;
            T4           : in  std_logic;
            TCE          : in  std_logic);
    end component;

    attribute INIT_TQ : bit;
    attribute INIT_TQ of U0 : label is '1';
    attribute INIT_TQ of U1 : label is '1';
    attribute SRVAL_TQ : bit;
    attribute SRVAL_TQ of U0 : label is '1';
    attribute SRVAL_TQ of U1 : label is '1';

begin

    logic0 <= '0';
    logic1 <= '1';

    delay : process(clk)
    begin
        if clk'event and clk = '1' then
            d_q <= d;
            t_q <= t;
        end if;
    end process;

    U0 : OSERDES
        generic map(
            INIT_TQ => '1',
            SRVAL_TQ => '1')
        port map(
            OQ => q,
            SHIFTOUT1 => open,
            SHIFTOUT2 => open,
            TQ => tq,
            CLK => clk2x,
            CLKDIV => clk,
            D1 => logic0,
            D2 => d,
            D3 => logic0,
            D4 => d,
            D5 => logic0,
            D6 => logic0,
            OCE => ce,
            REV => logic0,
            SHIFTIN1 => logic0,
            SHIFTIN2 => logic0,
            SR => sr,
            T1 => t_q,
            T2 => t_q,
            T3 => t_q,
            T4 => t,
            TCE => ce);

    U1 : OSERDES
        generic map(
            INIT_TQ => '1',
            SRVAL_TQ => '1')
        port map(
            OQ => qb,
            SHIFTOUT1 => open,
            SHIFTOUT2 => open,
            TQ => tqb,
            CLK => clk2x,
            CLKDIV => clk,
            D1 => logic1,
            D2 => db,
            D3 => logic1,
            D4 => db,
            D5 => logic0,
            D6 => logic0,
            OCE => ce,
            REV => logic0,
            SHIFTIN1 => logic0,
            SHIFTIN2 => logic0,
            SR => sr,
            T1 => t_q,
            T2 => t_q,
            T3 => t_q,
            T4 => t,
            TCE => ce);

end mixed;
