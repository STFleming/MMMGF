--
-- ddr2sdram_iserdes_dq.vhd - ISERDES instance for Virtex-4 / Virtex-5 DDR-II
--                            SDRAM interface
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

entity ddr2sdram_iserdes_dq is
    port (
        clk2x      : in  std_logic;
        dlysr      : in  std_logic;
        dlyce      : in  std_logic;
        dlyinc     : in  std_logic;
        sr         : in  std_logic;
        ce         : in  std_logic;
        d          : in  std_logic;
        dqs        : in  std_logic;
        q          : out std_logic_vector(3 downto 0);
        o          : out std_logic);
end entity;

architecture mixed of ddr2sdram_iserdes_dq is

    signal dqs_delayed : std_logic;
    signal d_delayed : std_logic;

    signal logic0 : std_logic;
    signal logic1 : std_logic;
    signal logicx : std_logic;

    component ISERDES
        generic(
            BITSLIP_ENABLE : boolean := false;     -- (TRUE, FALSE)
            DATA_RATE      : string  := "DDR";     -- (SDR, DDR)
            DATA_WIDTH     : integer := 4;         -- (2, 3, 4, 5, 6, 7, 8, 10)
            INTERFACE_TYPE : string  := "MEMORY";  -- (MEMORY, NETWORKING)
            IOBDELAY       : string  := "NONE";    -- (NONE, IBUF, IFD, BOTH)
            IOBDELAY_TYPE  : string  := "DEFAULT"; -- (DEFAULT, FIXED, VARIABLE)
            IOBDELAY_VALUE : integer := 0;         -- (0 to 63)
            NUM_CE         : integer := 2;         -- (1, 2)
            SERDES_MODE    : string  := "MASTER"); -- (MASTER, SLAVE)
        port(
            O              : out std_logic;
            Q1             : out std_logic;
            Q2             : out std_logic;
            Q3             : out std_logic;
            Q4             : out std_logic;
            Q5             : out std_logic;
            Q6             : out std_logic;
            SHIFTOUT1      : out std_logic;
            SHIFTOUT2      : out std_logic;
            BITSLIP        : in  std_logic;
            CE1            : in  std_logic;
            CE2            : in  std_logic;
            CLK            : in  std_logic;
            CLKDIV         : in  std_logic;
            D              : in  std_logic;
            DLYCE          : in  std_logic;
            DLYINC         : in  std_logic;
            DLYRST         : in  std_logic;
            OCLK           : in  std_logic;
            REV            : in  std_logic;
            SHIFTIN1       : in  std_logic;
            SHIFTIN2       : in  std_logic;
            SR             : in  std_logic);
    end component;

    attribute BITSLIP_ENABLE : boolean;
    attribute BITSLIP_ENABLE of U0 : label is false;
    attribute DATA_RATE : string;
    attribute DATA_RATE of U0 : label is "DDR";
    attribute DATA_WIDTH : integer;
    attribute DATA_WIDTH of U0 : label is 4;
    attribute INTERFACE_TYPE : string;
    attribute INTERFACE_TYPE of U0 : label is "MEMORY";
    attribute IOBDELAY : string;
    attribute IOBDELAY of U0 : label is "IFD";
    attribute IOBDELAY_TYPE : string;
    attribute IOBDELAY_TYPE of U0 : label is "VARIABLE";
    attribute IOBDELAY_VALUE : integer;
    attribute IOBDELAY_VALUE of U0 : label is 0;
    attribute NUM_CE : integer;
    attribute NUM_CE of U0 : label is 2;
    attribute SERDES_MODE : string;
    attribute SERDES_MODE of U0 : label is "MASTER";

begin

    logic0 <= '0';
    logic1 <= '1';
    logicx <= '-';

    U0 : ISERDES
        generic map(
            IOBDELAY => "IFD",
            IOBDELAY_TYPE => "VARIABLE",
            NUM_CE => 2)
        port map(
            O => o,
            Q1 => q(3),
            Q2 => q(2),
            Q3 => q(1),
            Q4 => q(0),
            Q5 => open,
            Q6 => open,
            SHIFTOUT1 => open,
            SHIFTOUT2 => open,
            BITSLIP => logic0,
            CE1 => ce,
            CE2 => ce,
            CLK => dqs,
            CLKDIV => clk2x,
            D => d,
            DLYRST => dlysr,
            DLYCE => dlyce,
            DLYINC => dlyinc,
            OCLK => clk2x,
            REV => logic0,
            SHIFTIN1 => logic0,
            SHIFTIN2 => logic0,
            SR => sr);

end mixed;
