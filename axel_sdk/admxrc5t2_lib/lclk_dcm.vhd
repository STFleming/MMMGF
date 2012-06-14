--
-- lclk_dcm.vhd - generate local bus clock for distribution within FPGA
--                using a DCM.
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

entity lclk_dcm is
    port(
        rst           : in    std_logic;
        refclk        : in    std_logic;
        lclk          : in    std_logic;
        clk           : out   std_logic;
        locked        : out   std_logic);
end entity;

architecture struct of lclk_dcm is

    signal lclk_ibufg : std_logic;
    signal lclk_unbuf : std_logic;
    signal lclk_bufg : std_logic;

    signal count : std_logic_vector(5 downto 0);
    signal dllrst : std_logic;

    signal logic0, logic1 : std_logic;

    component DCM
        port(
            CLKIN         : in  std_logic;
            CLKFB         : in  std_logic;
            DSSEN         : in  std_logic;
            PSINCDEC      : in  std_logic;
            PSEN          : in  std_logic;
            PSCLK         : in  std_logic;
            RST           : in  std_logic;
            CLK0          : out std_logic;
            CLK90         : out std_logic;
            CLK180        : out std_logic;
            CLK270        : out std_logic;
            CLK2X         : out std_logic;
            CLK2X180      : out std_logic;
            CLKDV         : out std_logic;
            CLKFX         : out std_logic;
            CLKFX180      : out std_logic;
            LOCKED        : out std_logic;
            PSDONE        : out std_logic;
            STATUS        : out std_logic_vector(7 downto 0));
    end component;

    component IBUFG
        port(
            I : in  std_logic;
            O : out std_logic);
    end component;
    
    component BUFG
        port(
            I : in  std_logic;
            O : out std_logic);
    end component;
    
    attribute DLL_FREQUENCY_MODE : string;
    attribute DUTY_CYCLE_CORRECTION : string;
    attribute STARTUP_WAIT : string;
    attribute CLK_FEEDBACK : string;

    attribute DLL_FREQUENCY_MODE of dll_lclk : label is "LOW";
    attribute DUTY_CYCLE_CORRECTION of dll_lclk : label is "TRUE";
    attribute STARTUP_WAIT of dll_lclk : label is "FALSE";
    attribute CLK_FEEDBACK of dll_lclk : label is "1X";
    
begin
    
    logic0 <= '0';
    logic1 <= '1';

    gen_count : process(rst, refclk)
    begin
        if rst = '1' then
            count <= (others => '0');
        elsif refclk'event and refclk = '1' then
            if count(count'high) = '0' then
                count <= count + 1;
            end if;
        end if;
    end process;

    dllrst <= count(count'high - 1);

    clk <= lclk_bufg;

    ibufg_lclk : IBUFG
        port map(
            I => lclk,
            O => lclk_ibufg);

    dll_lclk : dcm
        port map(
            CLKIN => lclk_ibufg,
            CLKFB => lclk_bufg,
            DSSEN => logic0,
            PSINCDEC => logic0,
            PSEN => logic0,
            PSCLK => logic0,
            RST => dllrst,
            CLK0 => lclk_unbuf,
            CLK90 => open,
            CLK180 => open,
            CLK270 => open,
            CLK2X => open,
            CLK2X180 => open,
            CLKDV => open,
            CLKFX => open,
            CLKFX180 => open,
            LOCKED => locked,
            PSDONE => open,
            STATUS => open);

    bufg_lclk : BUFG
        port map(
            I => lclk_unbuf,
            O => lclk_bufg);

end architecture;
