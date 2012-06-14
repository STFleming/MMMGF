library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

ENTITY ringosc IS
  GENERIC(
    COMPNAME : string := "default";
    RTLSIM : boolean := FALSE);
  PORT(
    CLK : OUT std_logic) ;
END ringosc;

-- If these parameters are changed, the
-- period constraints should also change.
-- OSCCLKDIV = 0 --> Divide by 2
-- OSCCLKDIV = 1 --> Divide by 2
-- OSCCLKDIV = 2 --> Divide by 2
-- OSCCLKDIV = 3 --> Divide by 4
-- OSCCLKDIV = 4 --> Divide by 6
-- OSCCLKDIV = 5 --> Divide by 8
-- OSCCLKDIV = 6 --> Divide by 10
-- OSCCLKDIV = 7 --> Divide by 12

ARCHITECTURE RINGOSC OF ringosc IS

  ------------------------------------------------------------------------------
  -- Constant declaration.
  ------------------------------------------------------------------------------
  CONSTANT SIMCLKT : time := 10 ns;
  CONSTANT OSCCLKDIV : integer := 6 ;

  ------------------------------------------------------------------------------
  -- Signal declaration.
  ------------------------------------------------------------------------------

  signal  CLKWIRE : std_logic := '1';
  signal  DELAYED      : std_logic;
  signal  BUFCON0      : std_logic;
  signal  BUFCON1      : std_logic;
  signal  BUFCON2      : std_logic;
  signal  BUFCON3      : std_logic;
  signal  DELAYED_N    : std_logic;
  signal  BUFCON1_N    : std_logic;
  signal  BUFCON2_N    : std_logic;
  signal  BUFCON3_N    : std_logic;

  signal  TOGGLE       : std_logic;
  signal  TOGGLE_CE    : std_logic;
  signal  TOGGLE_DIN   : std_logic;
  signal  CE_SRL       : std_logic;
  signal  SHIFTOUT     : std_logic;
  signal  SHIFTSEL     : std_logic_vector(3 downto 0);

  -------------------------------------------------------------------------------
  --  Attribute Declaration
  -------------------------------------------------------------------------------

  -- synthesis attribute BUFFER_TYPE of CLKWIRE is NONE;
  -- synthesis attribute PERIOD of CLKWIRE is "3";
  -- synthesis attribute BUFFER_TYPE of TOGGLE is NONE;
  -- synthesis attribute PERIOD of TOGGLE is "30";

   attribute CLOCK_SIGNAL        : string;
   attribute RLOC                : string;
   attribute HU_SET              : string;
   attribute USE_CLOCK_ENABLE    : string;
   attribute KEEP            : string ;

   attribute CLOCK_SIGNAL of CLKWIRE     : signal is "NO";
   attribute CLOCK_SIGNAL of TOGGLE      : signal is "NO";
   attribute KEEP of TOGGLE          : signal is "TRUE" ;




   attribute HU_SET of SHIFTSRL  : LABEL is CompName&"CLK_WIRE";
   attribute HU_SET of SHIFTFD   : LABEL is CompName&"CLK_WIRE";
   attribute HU_SET of FLOP5     : LABEL is CompName&"CLK_WIRE";
 
   attribute RLOC of SHIFTSRL    : LABEL is "X2Y1";
   attribute RLOC of SHIFTFD     : LABEL is "X2Y1";
   attribute RLOC of FLOP5       : LABEL is "X2Y1";


BEGIN

  ------------------------------------------------------------------------------
  -- Flops and an output mux form the ring oscillator circuit.  This is
  -- placed together to ensure performance is not placement dependent.
  ------------------------------------------------------------------------------

  SIM: IF RTLSIM GENERATE
  BEGIN
     CLKWIRE<= NOT CLKWIRE AFTER SIMCLKT/2;
  END GENERATE;

HW : if NOT RTLSIM GENERATE

   attribute RLOC   : string;
   attribute HU_SET   : string;

   attribute HU_SET of FLOP1  :   LABEL is CompName&"CLK_WIRE";  --XCC
   attribute HU_SET of FLOP2  :   LABEL is CompName&"CLK_WIRE";  --XCC
   attribute HU_SET of FLOP3  :   LABEL is CompName&"CLK_WIRE";  --XCC
   attribute HU_SET of FLOP4  :   LABEL is CompName&"CLK_WIRE";  --XCC
   attribute HU_SET of OMUX   :   LABEL is CompName&"CLK_WIRE";  --XCC
 
 
   attribute RLOC of FLOP1 :  LABEL is "X0Y0"; --XCC
   attribute RLOC of FLOP2 :  LABEL is "X0Y1"; --XCC
   attribute RLOC of FLOP3 :  LABEL is "X1Y0"; --XCC
   attribute RLOC of FLOP4 :  LABEL is "X1Y1"; --XCC
   attribute RLOC of OMUX  :  LABEL is "X1Y1"; --XCC

BEGIN

   DELAYED <= BUFCON0 after 5 ns;
   DELAYED_N <= NOT DELAYED ;
   BUFCON1_N  <= NOT BUFCON1 after 100 ps ;
   BUFCON2_N  <= NOT BUFCON2 after 100 ps    ;
   BUFCON3_N  <= NOT BUFCON3 after 100 ps ;



   FLOP1 : FDCPE
        PORT MAP (
               Q         => BUFCON1,
               CLR       => DELAYED,
               PRE       => DELAYED_N,
               C         => '0',
               CE        => '0',
               D         => '0' ) ;

 
   FLOP2 : FDCPE
         PORT MAP (
                Q       => BUFCON2,
                CLR     => BUFCON1_N,
                PRE     => BUFCON1,
                C       => '0',
                CE      => '0',
                D       => '0');

 
   FLOP3 : FDCPE
         PORT MAP (
               Q        => BUFCON3,
               CLR      => BUFCON2_N,
               PRE      => BUFCON2,
               C        => '0',
               CE       => '0',
               D        => '0' ) ;

   FLOP4 : FDCPE
         PORT MAP (
               Q        => BUFCON0,
               CLR     => BUFCON3_N,
               PRE     => BUFCON3,
               C       => '0',
               CE      => '0',
               D       => '0' ); 

   OMUX  :  MUXF5
         PORT MAP (
               O        =>  CLKWIRE,
               S        =>  BUFCON0,
               I1       =>  '0',
               I0       =>  '1') ;

  END GENERATE; 


  -----------------------------------------------------------------------------
  -- Clock divider made with SRL and FD so that CLKWIRE drives only one slice.
  ------------------------------------------------------------------------------

 -- assign SHIFTSEL = OSCCLKDIV - 3;
 -- assign TOGGLE_CE = (OSCCLKDIV <= 2) ? 1'b1 : CE_SRL;
 -- assign TOGGLE_DIN = TOGGLE_CE ^ TOGGLE;
 -- assign CLK = TOGGLE;


   CLK  <= TOGGLE ;
   TOGGLE_DIN <= TOGGLE_CE XOR TOGGLE ;
   SHIFTSEL   <= conv_std_logic_vector(OSCCLKDIV-3, 4) ;
   TOGGLE_CE <= '1' when (OSCCLKDIV <= 2) else CE_SRL ;

  SHIFTSRL : SRL16
         PORT MAP (
               Q               => SHIFTOUT,
               A0              => SHIFTSEL(0),
               A1              => SHIFTSEL(1),
               A2              => SHIFTSEL(2),
               A3              => SHIFTSEL(3),
               CLK             => CLKWIRE,
               D               => CE_SRL );

  SHIFTFD : FDP
          PORT MAP (
               Q      => CE_SRL,
               C      => CLKWIRE,
               D      => SHIFTOUT,
               PRE    => '0' ) ;


  FLOP5 : FDP
         PORT MAP  (
             Q         => TOGGLE,
             C         => CLKWIRE,
             D         => TOGGLE_DIN,
             PRE       => '0') ;



end RINGOSC ;


