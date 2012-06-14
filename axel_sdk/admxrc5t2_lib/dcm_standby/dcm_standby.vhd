library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library work;                           --XST
use work.standby_pkg.all;               --XST

ENTITY dcm_standby IS
   GENERIC (
      COMPNAME                : string := "TEST"
   );
   PORT (
        CLK0             : OUT std_logic;
        CLK180           : OUT std_logic;
        CLK270           : OUT std_logic;
        CLK2X            : OUT std_logic;
        CLK2X180         : OUT std_logic;
        CLK90            : OUT std_logic;
        CLKDV            : OUT std_logic;
        CLKFX            : OUT std_logic;
        CLKFX180         : OUT std_logic;
        LOCKED           : OUT std_logic;
        DO               : OUT std_logic_vector(15 DOWNTO 0);
        PSDONE           : OUT std_logic;
        CLKFB            : IN  std_logic;
        CLKIN            : IN  std_logic;
        PSCLK            : IN  std_logic;
        PSEN             : IN  std_logic;
        PSINCDEC         : IN  std_logic;
        RST              : IN std_logic);
END dcm_standby;

ARCHITECTURE dcm_standby OF dcm_standby IS

  ------------------USER EDITABLE CONSTANTS---------------------------------------
  constant  USE_FX_SYNCLK     : integer   := 0;          
  constant  TIMEOUT_SCALE     : integer   := 6;       

 -- parameter     USE_FX_SYNCLK = 0;
 -- parameter     TIMEOUT_SCALE = 6;

  --------------------------------------------------------------------------------
  -- Internal Signals
  --------------------------------------------------------------------------------
  signal   CLK      : std_logic;
  signal   CLK0_NUB : std_logic;
  signal   S0       : std_logic;
  signal   S1       : std_logic;
  signal   I1       : std_logic;

  ------------------------------------------------------------------------------
  -- Component declaration
  ------------------------------------------------------------------------------

 COMPONENT RINGOSC
   GENERIC(
     COMPNAME : string;
     RTLSIM : boolean := FALSE);
   PORT(     
     CLK : out std_logic);
 END COMPONENT ;


 COMPONENT STANDBY
   GENERIC (COMPNAME : string);
       PORT (
            CLK0        : out std_logic ;
            CLK180      : out std_logic ;
            CLK270      : out std_logic ;
            CLK2X       : out std_logic ;
            CLK2X180    : out std_logic ;
            CLK90       : out std_logic ;
            CLKDV       : out std_logic ;
            CLKFX       : out std_logic ;
            CLKFX180    : out std_logic ; 
            LOCKED      : out std_logic ;
            DO          : out std_logic_vector(15 DOWNTO 0);
            PSDONE      : out std_logic ;
            CLKFB       : in  std_logic ;
            CLKIN       : in  std_logic ;
            PSCLK       : in  std_logic ;
            PSEN        : in  std_logic ;
            PSINCDEC    : in  std_logic ;
            S0          : out std_logic ; 
            S1          : out std_logic ;
            I1          : out std_logic ;
            CLK         : in std_logic ;
            RST         : in std_logic
            );
END COMPONENT;

BEGIN

  ------------------------------------------------------------------------------
  -- Fabric based oscillator.
  ------------------------------------------------------------------------------

  RINGOSC_INST : RINGOSC
      GENERIC MAP (
          -- synopsys translate_off
          RTLSIM => true,
          -- synopsys translate_on
          COMPNAME => COMPNAME)
      PORT MAP (
          CLK => CLK);

  ------------------------------------------------------------------------------
  -- Instantiate the standby controller including the DCM_ADV.
  ------------------------------------------------------------------------------

  STANDBY_INST : STANDBY 
        GENERIC MAP (COMPNAME => COMPNAME)

         PORT MAP (
              CLK0              => CLK0_NUB,
              CLK180            => CLK180,
              CLK270            => CLK270,
              CLK2X             => CLK2X,
              CLK2X180          => CLK2X180,
              CLK90             => CLK90,
              CLKDV             => CLKDV,
              CLKFX             => CLKFX,
              CLKFX180          => CLKFX180,
              LOCKED            => LOCKED,
              DO                => DO,
              PSDONE            => PSDONE,
              CLKFB             => CLKFB,
              CLKIN             => CLKIN,
              PSCLK             => PSCLK,
              PSEN              => PSEN,
              PSINCDEC          => PSINCDEC,
              S0                => S0,
              S1                => S1,
              I1                => I1,
              CLK               => CLK,
              RST               => RST
                );
  -- defparam STANDBY_INST.TIMEOUT_SCALE = TIMEOUT_SCALE;
  -- defparam STANDBY_INST.USE_FX_SYNCLK = USE_FX_SYNCLK;

  ------------------------------------------------------------------------------
  -- Global buffer for compatibility with previous version.
  ------------------------------------------------------------------------------

  BUFGCTRL_INST : BUFGCTRL
          PORT MAP (
               O              => CLK0,
               I0             => CLK0_NUB,
               I1             => I1,
               S0             => S0,
               S1             => S1,
               CE0            => '1',
               CE1            => '1',
               IGNORE0        => '1',
               IGNORE1        => '1');

end dcm_standby ;


