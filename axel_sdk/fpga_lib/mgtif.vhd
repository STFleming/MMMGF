-- Module MGT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library work;
use work.admxrc5t2_common.all;

entity MGTIF is
generic
(
    SIM_MODE                        : string    := "FAST";
    SIM_GTPRESET_SPEEDUP            : integer   := 1;
    SIM_PLL_PERDIV2                 : bit_vector:= x"140"
);
port
(
    -- user interface
    MGT_CLK                         : out  std_logic;
    MGT_RDY                         : out  std_logic;
    MGT_TXD                         : in   gtp_data_t(3 downto 0);
    MGT_TXK                         : in   std_logic_vector(7 downto 0);
    MGT_RXD                         : out  gtp_data_t(3 downto 0);
    MGT_RXK                         : out  std_logic_vector(7 downto 0);
    MGT_ALIGNED                     : out  std_logic_vector(3 downto 0);
    -- system interface
    TILE0_REFCLK_PAD_N_IN           : in   std_logic;
    TILE0_REFCLK_PAD_P_IN           : in   std_logic;
    MGTRESET_IN                     : in   std_logic;
    RXN_IN                          : in   std_logic_vector(3 downto 0);
    RXP_IN                          : in   std_logic_vector(3 downto 0);
    TXN_OUT                         : out  std_logic_vector(3 downto 0);
    TXP_OUT                         : out  std_logic_vector(3 downto 0)

);
end MGTIF;
    
architecture RTL of MGTIF is

component SERIALLINK 
generic
(
    -- Simulation attributes
    WRAPPER_SIM_MODE                : string    := "FAST"; -- Set to Fast Functional Simulation Model    
    WRAPPER_SIM_GTPRESET_SPEEDUP    : integer   := 0; -- Set to 1 to speed up sim reset
    WRAPPER_SIM_PLL_PERDIV2         : bit_vector:= x"140" -- Set to the VCO Unit Interval time
);
port
(
    
    --_________________________________________________________________________
    --_________________________________________________________________________
    --TILE0  (Location)

    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    TILE0_RXCHARISK0_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_RXCHARISK1_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_RXDISPERR0_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_RXDISPERR1_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_RXNOTINTABLE0_OUT                 : out  std_logic_vector(1 downto 0);
    TILE0_RXNOTINTABLE1_OUT                 : out  std_logic_vector(1 downto 0);
    ------------------- Receive Ports - Clock Correction Ports -----------------
    TILE0_RXCLKCORCNT0_OUT                  : out  std_logic_vector(2 downto 0);
    TILE0_RXCLKCORCNT1_OUT                  : out  std_logic_vector(2 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    TILE0_RXBYTEISALIGNED0_OUT              : out  std_logic;
    TILE0_RXBYTEISALIGNED1_OUT              : out  std_logic;
    TILE0_RXENMCOMMAALIGN0_IN               : in   std_logic;
    TILE0_RXENMCOMMAALIGN1_IN               : in   std_logic;
    TILE0_RXENPCOMMAALIGN0_IN               : in   std_logic;
    TILE0_RXENPCOMMAALIGN1_IN               : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    TILE0_RXDATA0_OUT                       : out  std_logic_vector(15 downto 0);
    TILE0_RXDATA1_OUT                       : out  std_logic_vector(15 downto 0);
    TILE0_RXRESET0_IN                       : in   std_logic;
    TILE0_RXRESET1_IN                       : in   std_logic;
    TILE0_RXUSRCLK0_IN                      : in   std_logic;
    TILE0_RXUSRCLK1_IN                      : in   std_logic;
    TILE0_RXUSRCLK20_IN                     : in   std_logic;
    TILE0_RXUSRCLK21_IN                     : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    TILE0_RXN0_IN                           : in   std_logic;
    TILE0_RXN1_IN                           : in   std_logic;
    TILE0_RXP0_IN                           : in   std_logic;
    TILE0_RXP1_IN                           : in   std_logic;
    --------------------- Shared Ports - Tile and PLL Ports --------------------
    TILE0_CLKIN_IN                          : in   std_logic;
    TILE0_GTPRESET_IN                       : in   std_logic;
    TILE0_PLLLKDET_OUT                      : out  std_logic;
    TILE0_REFCLKOUT_OUT                     : out  std_logic;
    TILE0_RESETDONE0_OUT                    : out  std_logic;
    TILE0_RESETDONE1_OUT                    : out  std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    TILE0_TXCHARISK0_IN                     : in   std_logic_vector(1 downto 0);
    TILE0_TXCHARISK1_IN                     : in   std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    TILE0_TXDATA0_IN                        : in   std_logic_vector(15 downto 0);
    TILE0_TXDATA1_IN                        : in   std_logic_vector(15 downto 0);
    TILE0_TXOUTCLK0_OUT                     : out  std_logic;
    TILE0_TXOUTCLK1_OUT                     : out  std_logic;
    TILE0_TXUSRCLK0_IN                      : in   std_logic;
    TILE0_TXUSRCLK1_IN                      : in   std_logic;
    TILE0_TXUSRCLK20_IN                     : in   std_logic;
    TILE0_TXUSRCLK21_IN                     : in   std_logic;
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    TILE0_TXDIFFCTRL0_IN                    : in   std_logic_vector(2 downto 0);
    TILE0_TXDIFFCTRL1_IN                    : in   std_logic_vector(2 downto 0);
    TILE0_TXN0_OUT                          : out  std_logic;
    TILE0_TXN1_OUT                          : out  std_logic;
    TILE0_TXP0_OUT                          : out  std_logic;
    TILE0_TXP1_OUT                          : out  std_logic;
    TILE0_TXPREEMPHASIS0_IN                 : in   std_logic_vector(2 downto 0);
    TILE0_TXPREEMPHASIS1_IN                 : in   std_logic_vector(2 downto 0);


    
    --_________________________________________________________________________
    --_________________________________________________________________________
    --TILE1  (Location)

    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    TILE1_RXCHARISK0_OUT                    : out  std_logic_vector(1 downto 0);
    TILE1_RXCHARISK1_OUT                    : out  std_logic_vector(1 downto 0);
    TILE1_RXDISPERR0_OUT                    : out  std_logic_vector(1 downto 0);
    TILE1_RXDISPERR1_OUT                    : out  std_logic_vector(1 downto 0);
    TILE1_RXNOTINTABLE0_OUT                 : out  std_logic_vector(1 downto 0);
    TILE1_RXNOTINTABLE1_OUT                 : out  std_logic_vector(1 downto 0);
     ------------------- Receive Ports - Clock Correction Ports -----------------
     TILE1_RXCLKCORCNT0_OUT                  : out  std_logic_vector(2 downto 0);
     TILE1_RXCLKCORCNT1_OUT                  : out  std_logic_vector(2 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    TILE1_RXBYTEISALIGNED0_OUT              : out  std_logic;
    TILE1_RXBYTEISALIGNED1_OUT              : out  std_logic;
    TILE1_RXENMCOMMAALIGN0_IN               : in   std_logic;
    TILE1_RXENMCOMMAALIGN1_IN               : in   std_logic;
    TILE1_RXENPCOMMAALIGN0_IN               : in   std_logic;
    TILE1_RXENPCOMMAALIGN1_IN               : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    TILE1_RXDATA0_OUT                       : out  std_logic_vector(15 downto 0);
    TILE1_RXDATA1_OUT                       : out  std_logic_vector(15 downto 0);
    TILE1_RXRESET0_IN                       : in   std_logic;
    TILE1_RXRESET1_IN                       : in   std_logic;
    TILE1_RXUSRCLK0_IN                      : in   std_logic;
    TILE1_RXUSRCLK1_IN                      : in   std_logic;
    TILE1_RXUSRCLK20_IN                     : in   std_logic;
    TILE1_RXUSRCLK21_IN                     : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    TILE1_RXN0_IN                           : in   std_logic;
    TILE1_RXN1_IN                           : in   std_logic;
    TILE1_RXP0_IN                           : in   std_logic;
    TILE1_RXP1_IN                           : in   std_logic;
    --------------------- Shared Ports - Tile and PLL Ports --------------------
    TILE1_CLKIN_IN                          : in   std_logic;
    TILE1_GTPRESET_IN                       : in   std_logic;
    TILE1_PLLLKDET_OUT                      : out  std_logic;
    TILE1_REFCLKOUT_OUT                     : out  std_logic;
    TILE1_RESETDONE0_OUT                    : out  std_logic;
    TILE1_RESETDONE1_OUT                    : out  std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    TILE1_TXCHARISK0_IN                     : in   std_logic_vector(1 downto 0);
    TILE1_TXCHARISK1_IN                     : in   std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    TILE1_TXDATA0_IN                        : in   std_logic_vector(15 downto 0);
    TILE1_TXDATA1_IN                        : in   std_logic_vector(15 downto 0);
    TILE1_TXOUTCLK0_OUT                     : out  std_logic;
    TILE1_TXOUTCLK1_OUT                     : out  std_logic;
    TILE1_TXUSRCLK0_IN                      : in   std_logic;
    TILE1_TXUSRCLK1_IN                      : in   std_logic;
    TILE1_TXUSRCLK20_IN                     : in   std_logic;
    TILE1_TXUSRCLK21_IN                     : in   std_logic;
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    TILE1_TXDIFFCTRL0_IN                    : in   std_logic_vector(2 downto 0);
    TILE1_TXDIFFCTRL1_IN                    : in   std_logic_vector(2 downto 0);
    TILE1_TXN0_OUT                          : out  std_logic;
    TILE1_TXN1_OUT                          : out  std_logic;
    TILE1_TXP0_OUT                          : out  std_logic;
    TILE1_TXP1_OUT                          : out  std_logic;
    TILE1_TXPREEMPHASIS0_IN                 : in   std_logic_vector(2 downto 0);
    TILE1_TXPREEMPHASIS1_IN                 : in   std_logic_vector(2 downto 0)


);
end component;


component MGT_USRCLK_SOURCE 
generic
(
    FREQUENCY_MODE   : string   := "LOW";    
    PERFORMANCE_MODE : string   := "MAX_SPEED"    
);
port
(
    DIV1_OUT                : out std_logic;
    DIV2_OUT                : out std_logic;
    DCM_LOCKED_OUT          : out std_logic;
    CLK_IN                  : in  std_logic;
    DCM_RESET_IN            : in  std_logic

);
end component;


--***********************************Parameter Declarations********************

    constant DLY : time := 1 ns;
    
--**************************** Wire Declarations ******************************

    -------------------------- MGT Wrapper Wires ------------------------------
    --________________________________________________________________________
    --________________________________________________________________________
    --TILE0   (X0Y6)

    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    signal  tile0_rxcharisk0_i              : std_logic_vector(1 downto 0);
    signal  tile0_rxcharisk1_i              : std_logic_vector(1 downto 0);
    signal  tile0_rxdisperr0_i              : std_logic_vector(1 downto 0);
    signal  tile0_rxdisperr1_i              : std_logic_vector(1 downto 0);
    signal  tile0_rxnotintable0_i           : std_logic_vector(1 downto 0);
    signal  tile0_rxnotintable1_i           : std_logic_vector(1 downto 0);
     ------------------- Receive Ports - Clock Correction Ports -----------------
     signal  tile0_rxclkcorcnt0_i            : std_logic_vector(2 downto 0);
     signal  tile0_rxclkcorcnt1_i            : std_logic_vector(2 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    signal  tile0_rxbyteisaligned0_i        : std_logic;
    signal  tile0_rxbyteisaligned1_i        : std_logic;
    signal  tile0_rxenmcommaalign0_i        : std_logic;
    signal  tile0_rxenmcommaalign1_i        : std_logic;
    signal  tile0_rxenpcommaalign0_i        : std_logic;
    signal  tile0_rxenpcommaalign1_i        : std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    signal  tile0_rxdata0_i                 : std_logic_vector(15 downto 0);
    signal  tile0_rxdata1_i                 : std_logic_vector(15 downto 0);
    --------------------- Shared Ports - Tile and PLL Ports --------------------
    signal  tile0_gtpreset_i                : std_logic;
    signal  tile0_plllkdet_i                : std_logic;
    signal  tile0_refclkout_i               : std_logic;
    signal  tile0_resetdone0_i              : std_logic;
    signal  tile0_resetdone1_i              : std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    signal  tile0_txcharisk0_i              : std_logic_vector(1 downto 0);
    signal  tile0_txcharisk1_i              : std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  tile0_txdata0_i                 : std_logic_vector(15 downto 0);
    signal  tile0_txdata1_i                 : std_logic_vector(15 downto 0);
    signal  tile0_txoutclk0_i               : std_logic;
    signal  tile0_txoutclk1_i               : std_logic;
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    signal  tile0_txdiffctrl0_i             : std_logic_vector(2 downto 0);
    signal  tile0_txdiffctrl1_i             : std_logic_vector(2 downto 0);
    signal  tile0_txpreemphasis0_i          : std_logic_vector(2 downto 0);
    signal  tile0_txpreemphasis1_i          : std_logic_vector(2 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --TILE1   (X0Y7)

    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    signal  tile1_rxcharisk0_i              : std_logic_vector(1 downto 0);
    signal  tile1_rxcharisk1_i              : std_logic_vector(1 downto 0);
    signal  tile1_rxdisperr0_i              : std_logic_vector(1 downto 0);
    signal  tile1_rxdisperr1_i              : std_logic_vector(1 downto 0);
    signal  tile1_rxnotintable0_i           : std_logic_vector(1 downto 0);
    signal  tile1_rxnotintable1_i           : std_logic_vector(1 downto 0);
     ------------------- Receive Ports - Clock Correction Ports -----------------
     signal  tile1_rxclkcorcnt0_i            : std_logic_vector(2 downto 0);
     signal  tile1_rxclkcorcnt1_i            : std_logic_vector(2 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    signal  tile1_rxbyteisaligned0_i        : std_logic;
    signal  tile1_rxbyteisaligned1_i        : std_logic;
    signal  tile1_rxenmcommaalign0_i        : std_logic;
    signal  tile1_rxenmcommaalign1_i        : std_logic;
    signal  tile1_rxenpcommaalign0_i        : std_logic;
    signal  tile1_rxenpcommaalign1_i        : std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    signal  tile1_rxdata0_i                 : std_logic_vector(15 downto 0);
    signal  tile1_rxdata1_i                 : std_logic_vector(15 downto 0);
    --------------------- Shared Ports - Tile and PLL Ports --------------------
    signal  tile1_gtpreset_i                : std_logic;
    signal  tile1_plllkdet_i                : std_logic;
    signal  tile1_refclkout_i               : std_logic;
    signal  tile1_resetdone0_i              : std_logic;
    signal  tile1_resetdone1_i              : std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    signal  tile1_txcharisk0_i              : std_logic_vector(1 downto 0);
    signal  tile1_txcharisk1_i              : std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  tile1_txdata0_i                 : std_logic_vector(15 downto 0);
    signal  tile1_txdata1_i                 : std_logic_vector(15 downto 0);
    signal  tile1_txoutclk0_i               : std_logic;
    signal  tile1_txoutclk1_i               : std_logic;
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    signal  tile1_txdiffctrl0_i             : std_logic_vector(2 downto 0);
    signal  tile1_txdiffctrl1_i             : std_logic_vector(2 downto 0);
    signal  tile1_txpreemphasis0_i          : std_logic_vector(2 downto 0);
    signal  tile1_txpreemphasis1_i          : std_logic_vector(2 downto 0);


    ------------------------------- Global Signals -----------------------------
    signal  all_reset_done                  : std_logic;
    signal  tile0_rxreset0_i                : std_logic;
    signal  tile0_rxreset1_i                : std_logic;
    signal  tile1_rxreset0_i                : std_logic;
    signal  tile1_rxreset1_i                : std_logic;
    signal  tied_to_ground_i                : std_logic;
    signal  tied_to_ground_vec_i            : std_logic_vector(63 downto 0);
    signal  tied_to_vcc_i                   : std_logic;
    signal  tied_to_vcc_vec_i               : std_logic_vector(7 downto 0);
    
    
    ----------------------------- User Clocks ---------------------------------
    signal  tile0_txusrclk0_i               : std_logic;
    signal  tile0_txusrclk20_i              : std_logic;
    signal  txoutclk_dcm0_locked_i          : std_logic;
    signal  txoutclk_dcm0_reset_i           : std_logic;
    signal  tile0_txoutclk0_to_dcm_i        : std_logic;
    signal  tile0_refclk_i                  : std_logic;


--**************************** Main Body of Code *******************************
begin

    -- MGT REFCLK from X0Y6 position, shared with X0Y7
    tile0_refclk_ibufds_i : IBUFDS
    port map
    (
        O                               =>      tile0_refclk_i,
        I                               =>      TILE0_REFCLK_PAD_P_IN,
        IB                              =>      TILE0_REFCLK_PAD_N_IN
    );

    ----------------------------------- User Clocks ---------------------------
    -- Generate TX/RX user clocks from X0Y6.txoutclk0

    txoutclk_dcm0_bufg_i : BUFG
    port map
    (
        I                               =>      tile0_txoutclk0_i,
        O                               =>      tile0_txoutclk0_to_dcm_i
    );

    txoutclk_dcm0_reset_i                   <= not tile0_plllkdet_i;
    txoutclk_dcm0_i : MGT_USRCLK_SOURCE
    generic map
    (
        FREQUENCY_MODE                  =>      "HIGH",
        PERFORMANCE_MODE                =>      "MAX_SPEED"
    )
    port map
    (
        DIV1_OUT                        =>      tile0_txusrclk0_i,
        DIV2_OUT                        =>      tile0_txusrclk20_i,
        DCM_LOCKED_OUT                  =>      txoutclk_dcm0_locked_i,
        CLK_IN                          =>      tile0_txoutclk0_to_dcm_i,
        DCM_RESET_IN                    =>      txoutclk_dcm0_reset_i
    );

    ----------------------------- The GTP Wrapper -----------------------------
    
    MGT_CLK <= tile0_txusrclk20_i;

    mgt_rxd(0) <= tile0_rxdata0_i;
    mgt_rxd(1) <= tile0_rxdata1_i;
    mgt_rxd(2) <= tile1_rxdata0_i;
    mgt_rxd(3) <= tile1_rxdata1_i;
    mgt_rxk(1 downto 0) <= tile0_rxcharisk0_i;
    mgt_rxk(3 downto 2) <= tile0_rxcharisk1_i;
    mgt_rxk(5 downto 4) <= tile1_rxcharisk0_i;
    mgt_rxk(7 downto 6) <= tile1_rxcharisk1_i;

    mgt_aligned(0) <= tile0_rxbyteisaligned0_i;
    mgt_aligned(1) <= tile0_rxbyteisaligned1_i;
    mgt_aligned(2) <= tile1_rxbyteisaligned0_i;
    mgt_aligned(3) <= tile1_rxbyteisaligned1_i;

    tile0_txdata0_i <= mgt_txd(0);
    tile0_txdata1_i <= mgt_txd(1);
    tile1_txdata0_i <= mgt_txd(2);
    tile1_txdata1_i <= mgt_txd(3);
    tile0_txcharisk0_i <= mgt_txk(1 downto 0);
    tile0_txcharisk1_i <= mgt_txk(3 downto 2);
    tile1_txcharisk0_i <= mgt_txk(5 downto 4);
    tile1_txcharisk1_i <= mgt_txk(7 downto 6);


    -- Wire all PLLLKDET signals to the top level as output ports
    all_reset_done <= tile0_resetdone0_i and 
                      tile0_resetdone1_i and 
                      tile1_resetdone0_i and 
                      tile1_resetdone1_i;
    MGT_RDY <= all_reset_done;


    -- Hold the RX in reset till the RX user clocks are stable
  
    tile0_rxreset0_i                    <= not txoutclk_dcm0_locked_i;
  
    tile0_rxreset1_i                    <= not txoutclk_dcm0_locked_i;
  
    tile1_rxreset0_i                    <= not txoutclk_dcm0_locked_i;
  
    tile1_rxreset1_i                    <= not txoutclk_dcm0_locked_i;

    -- set positive and negative COMMA alignment

    process (tile0_txusrclk20_i, all_reset_done)
    begin
      if rising_edge(tile0_txusrclk20_i) then
        if all_reset_done = '0' then
          tile0_rxenmcommaalign0_i <= '0';
          tile0_rxenmcommaalign1_i <= '0';
          tile0_rxenpcommaalign0_i <= '0';
          tile0_rxenpcommaalign1_i <= '0';
          tile1_rxenmcommaalign0_i <= '0';
          tile1_rxenmcommaalign1_i <= '0';
          tile1_rxenpcommaalign0_i <= '0';
          tile1_rxenpcommaalign1_i <= '0';
        else
          tile0_rxenmcommaalign0_i <= '1';
          tile0_rxenmcommaalign1_i <= '1';
          tile0_rxenpcommaalign0_i <= '1';
          tile0_rxenpcommaalign1_i <= '1';
          tile1_rxenmcommaalign0_i <= '1';
          tile1_rxenmcommaalign1_i <= '1';
          tile1_rxenpcommaalign0_i <= '1';
          tile1_rxenpcommaalign1_i <= '1';
        end if;
      end if;
    end process;


    seriallink_i : SERIALLINK
    generic map
    (
        WRAPPER_SIM_MODE                =>      SIM_MODE,   
        WRAPPER_SIM_GTPRESET_SPEEDUP    =>      SIM_GTPRESET_SPEEDUP,
        WRAPPER_SIM_PLL_PERDIV2         =>      SIM_PLL_PERDIV2
    )
    port map
    (
    --_____________________________________________________________________
    --_____________________________________________________________________
    --TILE0  (X0Y6)

    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    TILE0_RXCHARISK0_OUT            =>      tile0_rxcharisk0_i,
    TILE0_RXCHARISK1_OUT            =>      tile0_rxcharisk1_i,
    TILE0_RXDISPERR0_OUT            =>      tile0_rxdisperr0_i,
    TILE0_RXDISPERR1_OUT            =>      tile0_rxdisperr1_i,
    TILE0_RXNOTINTABLE0_OUT         =>      tile0_rxnotintable0_i,
    TILE0_RXNOTINTABLE1_OUT         =>      tile0_rxnotintable1_i,
    ------------------- Receive Ports - Clock Correction Ports -----------------
    TILE0_RXCLKCORCNT0_OUT          =>      tile0_rxclkcorcnt0_i,
    TILE0_RXCLKCORCNT1_OUT          =>      tile0_rxclkcorcnt1_i,
    --------------- Receive Ports - Comma Detection and Alignment --------------
    TILE0_RXBYTEISALIGNED0_OUT      =>      tile0_rxbyteisaligned0_i,
    TILE0_RXBYTEISALIGNED1_OUT      =>      tile0_rxbyteisaligned1_i,
    TILE0_RXENMCOMMAALIGN0_IN       =>      tile0_rxenmcommaalign0_i,
    TILE0_RXENMCOMMAALIGN1_IN       =>      tile0_rxenmcommaalign1_i,
    TILE0_RXENPCOMMAALIGN0_IN       =>      tile0_rxenpcommaalign0_i,
    TILE0_RXENPCOMMAALIGN1_IN       =>      tile0_rxenpcommaalign1_i,
    ------------------- Receive Ports - RX Data Path interface -----------------
    TILE0_RXDATA0_OUT               =>      tile0_rxdata0_i,
    TILE0_RXDATA1_OUT               =>      tile0_rxdata1_i,
    TILE0_RXRESET0_IN               =>      tile0_rxreset0_i,
    TILE0_RXRESET1_IN               =>      tile0_rxreset1_i,
    TILE0_RXUSRCLK0_IN              =>      tile0_txusrclk0_i,
    TILE0_RXUSRCLK1_IN              =>      tile0_txusrclk0_i,
    TILE0_RXUSRCLK20_IN             =>      tile0_txusrclk20_i,
    TILE0_RXUSRCLK21_IN             =>      tile0_txusrclk20_i,
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    TILE0_RXN0_IN                   =>      RXN_IN(0),
    TILE0_RXN1_IN                   =>      RXN_IN(1),
    TILE0_RXP0_IN                   =>      RXP_IN(0),
    TILE0_RXP1_IN                   =>      RXP_IN(1),
    --------------------- Shared Ports - Tile and PLL Ports --------------------
    TILE0_CLKIN_IN                  =>      tile0_refclk_i,
    TILE0_GTPRESET_IN               =>      tile0_gtpreset_i,
    TILE0_PLLLKDET_OUT              =>      tile0_plllkdet_i,
    TILE0_REFCLKOUT_OUT             =>      tile0_refclkout_i,
    TILE0_RESETDONE0_OUT            =>      tile0_resetdone0_i,
    TILE0_RESETDONE1_OUT            =>      tile0_resetdone1_i,
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    TILE0_TXCHARISK0_IN             =>      tile0_txcharisk0_i,
    TILE0_TXCHARISK1_IN             =>      tile0_txcharisk1_i,
    ------------------ Transmit Ports - TX Data Path interface -----------------
    TILE0_TXDATA0_IN                =>      tile0_txdata0_i,
    TILE0_TXDATA1_IN                =>      tile0_txdata1_i,
    TILE0_TXOUTCLK0_OUT             =>      tile0_txoutclk0_i,
    TILE0_TXOUTCLK1_OUT             =>      tile0_txoutclk1_i,
    TILE0_TXUSRCLK0_IN              =>      tile0_txusrclk0_i,
    TILE0_TXUSRCLK1_IN              =>      tile0_txusrclk0_i,
    TILE0_TXUSRCLK20_IN             =>      tile0_txusrclk20_i,
    TILE0_TXUSRCLK21_IN             =>      tile0_txusrclk20_i,
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    TILE0_TXDIFFCTRL0_IN            =>      tile0_txdiffctrl0_i,
    TILE0_TXDIFFCTRL1_IN            =>      tile0_txdiffctrl1_i,
    TILE0_TXN0_OUT                  =>      TXN_OUT(0),
    TILE0_TXN1_OUT                  =>      TXN_OUT(1),
    TILE0_TXP0_OUT                  =>      TXP_OUT(0),
    TILE0_TXP1_OUT                  =>      TXP_OUT(1),
    TILE0_TXPREEMPHASIS0_IN         =>      tile0_txpreemphasis0_i,
    TILE0_TXPREEMPHASIS1_IN         =>      tile0_txpreemphasis1_i,

    --_____________________________________________________________________
    --_____________________________________________________________________
    --TILE1  (X0Y7)

    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    TILE1_RXCHARISK0_OUT            =>      tile1_rxcharisk0_i,
    TILE1_RXCHARISK1_OUT            =>      tile1_rxcharisk1_i,
    TILE1_RXDISPERR0_OUT            =>      tile1_rxdisperr0_i,
    TILE1_RXDISPERR1_OUT            =>      tile1_rxdisperr1_i,
    TILE1_RXNOTINTABLE0_OUT         =>      tile1_rxnotintable0_i,
    TILE1_RXNOTINTABLE1_OUT         =>      tile1_rxnotintable1_i,
    ------------------- Receive Ports - Clock Correction Ports -----------------
    TILE1_RXCLKCORCNT0_OUT          =>      tile1_rxclkcorcnt0_i,
    TILE1_RXCLKCORCNT1_OUT          =>      tile1_rxclkcorcnt1_i,
    --------------- Receive Ports - Comma Detection and Alignment --------------
    TILE1_RXBYTEISALIGNED0_OUT      =>      tile1_rxbyteisaligned0_i,
    TILE1_RXBYTEISALIGNED1_OUT      =>      tile1_rxbyteisaligned1_i,
    TILE1_RXENMCOMMAALIGN0_IN       =>      tile1_rxenmcommaalign0_i,
    TILE1_RXENMCOMMAALIGN1_IN       =>      tile1_rxenmcommaalign1_i,
    TILE1_RXENPCOMMAALIGN0_IN       =>      tile1_rxenpcommaalign0_i,
    TILE1_RXENPCOMMAALIGN1_IN       =>      tile1_rxenpcommaalign1_i,
    ------------------- Receive Ports - RX Data Path interface -----------------
    TILE1_RXDATA0_OUT               =>      tile1_rxdata0_i,
    TILE1_RXDATA1_OUT               =>      tile1_rxdata1_i,
    TILE1_RXRESET0_IN               =>      tile1_rxreset0_i,
    TILE1_RXRESET1_IN               =>      tile1_rxreset1_i,
    TILE1_RXUSRCLK0_IN              =>      tile0_txusrclk0_i,
    TILE1_RXUSRCLK1_IN              =>      tile0_txusrclk0_i,
    TILE1_RXUSRCLK20_IN             =>      tile0_txusrclk20_i,
    TILE1_RXUSRCLK21_IN             =>      tile0_txusrclk20_i,
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    TILE1_RXN0_IN                   =>      RXN_IN(2),
    TILE1_RXN1_IN                   =>      RXN_IN(3),
    TILE1_RXP0_IN                   =>      RXP_IN(2),
    TILE1_RXP1_IN                   =>      RXP_IN(3),
    --------------------- Shared Ports - Tile and PLL Ports --------------------
    TILE1_CLKIN_IN                  =>      tile0_refclk_i,
    TILE1_GTPRESET_IN               =>      tile1_gtpreset_i,
    TILE1_PLLLKDET_OUT              =>      tile1_plllkdet_i,
    TILE1_REFCLKOUT_OUT             =>      tile1_refclkout_i,
    TILE1_RESETDONE0_OUT            =>      tile1_resetdone0_i,
    TILE1_RESETDONE1_OUT            =>      tile1_resetdone1_i,
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    TILE1_TXCHARISK0_IN             =>      tile1_txcharisk0_i,
    TILE1_TXCHARISK1_IN             =>      tile1_txcharisk1_i,
    ------------------ Transmit Ports - TX Data Path interface -----------------
    TILE1_TXDATA0_IN                =>      tile1_txdata0_i,
    TILE1_TXDATA1_IN                =>      tile1_txdata1_i,
    TILE1_TXOUTCLK0_OUT             =>      tile1_txoutclk0_i,
    TILE1_TXOUTCLK1_OUT             =>      tile1_txoutclk1_i,
    TILE1_TXUSRCLK0_IN              =>      tile0_txusrclk0_i,
    TILE1_TXUSRCLK1_IN              =>      tile0_txusrclk0_i,
    TILE1_TXUSRCLK20_IN             =>      tile0_txusrclk20_i,
    TILE1_TXUSRCLK21_IN             =>      tile0_txusrclk20_i,
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    TILE1_TXDIFFCTRL0_IN            =>      tile1_txdiffctrl0_i,
    TILE1_TXDIFFCTRL1_IN            =>      tile1_txdiffctrl1_i,
    TILE1_TXN0_OUT                  =>      TXN_OUT(2),
    TILE1_TXN1_OUT                  =>      TXN_OUT(3),
    TILE1_TXP0_OUT                  =>      TXP_OUT(2),
    TILE1_TXP1_OUT                  =>      TXP_OUT(3),
    TILE1_TXPREEMPHASIS0_IN         =>      tile1_txpreemphasis0_i,
    TILE1_TXPREEMPHASIS1_IN         =>      tile1_txpreemphasis1_i
    );

    -- Drive GTP reset signal from the top level ports
    tile0_gtpreset_i                        <= MGTRESET_IN;
    tile1_gtpreset_i                        <= MGTRESET_IN;

    tile0_txdiffctrl0_i                     <= tied_to_ground_vec_i(2 downto 0);
    tile0_txpreemphasis0_i                  <= tied_to_ground_vec_i(2 downto 0);
    tile0_txdiffctrl1_i                     <= tied_to_ground_vec_i(2 downto 0);
    tile0_txpreemphasis1_i                  <= tied_to_ground_vec_i(2 downto 0);
    tile1_txdiffctrl0_i                     <= tied_to_ground_vec_i(2 downto 0);
    tile1_txpreemphasis0_i                  <= tied_to_ground_vec_i(2 downto 0);
    tile1_txdiffctrl1_i                     <= tied_to_ground_vec_i(2 downto 0);
    tile1_txpreemphasis1_i                  <= tied_to_ground_vec_i(2 downto 0);
end RTL;

