--
-- mclk_gtx_wrap.vhd - Wrapper for a GTX_DUAL instance that bypasses the
--                     GTX_DUAL and provides just the clock out from the
--                     instance, given an MGT reference clock input
--                     signal.
--
-- Modules defined:
--
--    mclk_gtp_wrap       GTX_DUAL wrapper providing output clock
--
-- This module can be used to input MCLKA and/or MCLKB and serves a similar
-- purpose to an IBUFG on the following model(s):
--
--   o ADM-XRC-5T1 with FXT device
--   o ADM-XRC-5T2 with FXT device
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- synopsys translate_off
library unisim;               
use unisim.vcomponents.all;   
-- synopsys translate_on

library work;

entity mclk_gtp_wrap is
    port(
        clkin  : in    std_logic;
        clkout : out   std_logic);
end entity;

architecture virtex5_fxt of mclk_gtp_wrap is

    component GTX_DUAL
        generic(
            AC_CAP_DIS_0 : boolean := TRUE;
            AC_CAP_DIS_1 : boolean := TRUE;
            ALIGN_COMMA_WORD_0 : integer := 1;
            ALIGN_COMMA_WORD_1 : integer := 1;
            CB2_INH_CC_PERIOD_0 : integer := 8;
            CB2_INH_CC_PERIOD_1 : integer := 8;
            CDR_PH_ADJ_TIME : bit_vector := "01010";
            CHAN_BOND_1_MAX_SKEW_0 : integer := 7;
            CHAN_BOND_1_MAX_SKEW_1 : integer := 7;
            CHAN_BOND_2_MAX_SKEW_0 : integer := 7;
            CHAN_BOND_2_MAX_SKEW_1 : integer := 7;
            CHAN_BOND_KEEP_ALIGN_0 : boolean := FALSE;
            CHAN_BOND_KEEP_ALIGN_1 : boolean := FALSE;
            CHAN_BOND_LEVEL_0 : integer := 0;
            CHAN_BOND_LEVEL_1 : integer := 0;
            CHAN_BOND_MODE_0 : string := "OFF";
            CHAN_BOND_MODE_1 : string := "OFF";
            CHAN_BOND_SEQ_1_1_0 : bit_vector := "0101111100";
            CHAN_BOND_SEQ_1_1_1 : bit_vector := "0101111100";
            CHAN_BOND_SEQ_1_2_0 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_1_2_1 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_1_3_0 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_1_3_1 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_1_4_0 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_1_4_1 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_1_ENABLE_0 : bit_vector := "0001";
            CHAN_BOND_SEQ_1_ENABLE_1 : bit_vector := "0001";
            CHAN_BOND_SEQ_2_1_0 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_2_1_1 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_2_2_0 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_2_2_1 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_2_3_0 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_2_3_1 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_2_4_0 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_2_4_1 : bit_vector := "0000000000";
            CHAN_BOND_SEQ_2_ENABLE_0 : bit_vector := "0000";
            CHAN_BOND_SEQ_2_ENABLE_1 : bit_vector := "0000";
            CHAN_BOND_SEQ_2_USE_0 : boolean := FALSE;
            CHAN_BOND_SEQ_2_USE_1 : boolean := FALSE;
            CHAN_BOND_SEQ_LEN_0 : integer := 1;
            CHAN_BOND_SEQ_LEN_1 : integer := 1;
            CLK25_DIVIDER : integer := 10;
            CLKINDC_B : boolean := TRUE;
            CLKRCV_TRST : boolean := TRUE;
            CLK_CORRECT_USE_0 : boolean := TRUE;
            CLK_CORRECT_USE_1 : boolean := TRUE;
            CLK_COR_ADJ_LEN_0 : integer := 1;
            CLK_COR_ADJ_LEN_1 : integer := 1;
            CLK_COR_DET_LEN_0 : integer := 1;
            CLK_COR_DET_LEN_1 : integer := 1;
            CLK_COR_INSERT_IDLE_FLAG_0 : boolean := FALSE;
            CLK_COR_INSERT_IDLE_FLAG_1 : boolean := FALSE;
            CLK_COR_KEEP_IDLE_0 : boolean := FALSE;
            CLK_COR_KEEP_IDLE_1 : boolean := FALSE;
            CLK_COR_MAX_LAT_0 : integer := 20;
            CLK_COR_MAX_LAT_1 : integer := 20;
            CLK_COR_MIN_LAT_0 : integer := 18;
            CLK_COR_MIN_LAT_1 : integer := 18;
            CLK_COR_PRECEDENCE_0 : boolean := TRUE;
            CLK_COR_PRECEDENCE_1 : boolean := TRUE;
            CLK_COR_REPEAT_WAIT_0 : integer := 0;
            CLK_COR_REPEAT_WAIT_1 : integer := 0;
            CLK_COR_SEQ_1_1_0 : bit_vector := "0100011100";
            CLK_COR_SEQ_1_1_1 : bit_vector := "0100011100";
            CLK_COR_SEQ_1_2_0 : bit_vector := "0000000000";
            CLK_COR_SEQ_1_2_1 : bit_vector := "0000000000";
            CLK_COR_SEQ_1_3_0 : bit_vector := "0000000000";
            CLK_COR_SEQ_1_3_1 : bit_vector := "0000000000";
            CLK_COR_SEQ_1_4_0 : bit_vector := "0000000000";
            CLK_COR_SEQ_1_4_1 : bit_vector := "0000000000";
            CLK_COR_SEQ_1_ENABLE_0 : bit_vector := "0001";
            CLK_COR_SEQ_1_ENABLE_1 : bit_vector := "0001";
            CLK_COR_SEQ_2_1_0 : bit_vector := "0000000000";
            CLK_COR_SEQ_2_1_1 : bit_vector := "0000000000";
            CLK_COR_SEQ_2_2_0 : bit_vector := "0000000000";
            CLK_COR_SEQ_2_2_1 : bit_vector := "0000000000";
            CLK_COR_SEQ_2_3_0 : bit_vector := "0000000000";
            CLK_COR_SEQ_2_3_1 : bit_vector := "0000000000";
            CLK_COR_SEQ_2_4_0 : bit_vector := "0000000000";
            CLK_COR_SEQ_2_4_1 : bit_vector := "0000000000";
            CLK_COR_SEQ_2_ENABLE_0 : bit_vector := "0000";
            CLK_COR_SEQ_2_ENABLE_1 : bit_vector := "0000";
            CLK_COR_SEQ_2_USE_0 : boolean := FALSE;
            CLK_COR_SEQ_2_USE_1 : boolean := FALSE;
            CM_TRIM_0 : bit_vector := "10";
            CM_TRIM_1 : bit_vector := "10";
            COMMA_10B_ENABLE_0 : bit_vector := "0001111111";
            COMMA_10B_ENABLE_1 : bit_vector := "0001111111";
            COMMA_DOUBLE_0 : boolean := FALSE;
            COMMA_DOUBLE_1 : boolean := FALSE;
            COM_BURST_VAL_0 : bit_vector := "1111";
            COM_BURST_VAL_1 : bit_vector := "1111";
            DEC_MCOMMA_DETECT_0 : boolean := TRUE;
            DEC_MCOMMA_DETECT_1 : boolean := TRUE;
            DEC_PCOMMA_DETECT_0 : boolean := TRUE;
            DEC_PCOMMA_DETECT_1 : boolean := TRUE;
            DEC_VALID_COMMA_ONLY_0 : boolean := TRUE;
            DEC_VALID_COMMA_ONLY_1 : boolean := TRUE;
            DFE_CAL_TIME : bit_vector := "00110";
            DFE_CFG_0 : bit_vector := "1101111011";
            DFE_CFG_1 : bit_vector := "1101111011";
            GEARBOX_ENDEC_0 : bit_vector := "000";
            GEARBOX_ENDEC_1 : bit_vector := "000";
            MCOMMA_10B_VALUE_0 : bit_vector := "1010000011";
            MCOMMA_10B_VALUE_1 : bit_vector := "1010000011";
            MCOMMA_DETECT_0 : boolean := TRUE;
            MCOMMA_DETECT_1 : boolean := TRUE;
            OOBDETECT_THRESHOLD_0 : bit_vector := "110";
            OOBDETECT_THRESHOLD_1 : bit_vector := "110";
            OOB_CLK_DIVIDER : integer := 6;
            OVERSAMPLE_MODE : boolean := FALSE;
            PCI_EXPRESS_MODE_0 : boolean := FALSE;
            PCI_EXPRESS_MODE_1 : boolean := FALSE;
            PCOMMA_10B_VALUE_0 : bit_vector := "0101111100";
            PCOMMA_10B_VALUE_1 : bit_vector := "0101111100";
            PCOMMA_DETECT_0 : boolean := TRUE;
            PCOMMA_DETECT_1 : boolean := TRUE;
            PLL_COM_CFG : bit_vector := X"21680a";
            PLL_CP_CFG : bit_vector := X"00";
            PLL_DIVSEL_FB : integer := 2;
            PLL_DIVSEL_REF : integer := 1;
            PLL_FB_DCCEN : boolean := FALSE;
            PLL_LKDET_CFG : bit_vector := "101";
            PLL_RXDIVSEL_OUT_0 : integer := 1;
            PLL_RXDIVSEL_OUT_1 : integer := 1;
            PLL_SATA_0 : boolean := FALSE;
            PLL_SATA_1 : boolean := FALSE;
            PLL_TDCC_CFG : bit_vector := "000";
            PLL_TXDIVSEL_OUT_0 : integer := 1;
            PLL_TXDIVSEL_OUT_1 : integer := 1;
            PMA_CDR_SCAN_0 : bit_vector := X"6404035";
            PMA_CDR_SCAN_1 : bit_vector := X"6404035";
            PMA_COM_CFG : bit_vector := X"000000000000000000";
            PMA_RXSYNC_CFG_0 : bit_vector := X"00";
            PMA_RXSYNC_CFG_1 : bit_vector := X"00";
            PMA_RX_CFG_0 : bit_vector := X"0f44089";
            PMA_RX_CFG_1 : bit_vector := X"0f44089";
            PMA_TX_CFG_0 : bit_vector := X"80082";
            PMA_TX_CFG_1 : bit_vector := X"80082";
            PRBS_ERR_THRESHOLD_0 : bit_vector := X"00000001";
            PRBS_ERR_THRESHOLD_1 : bit_vector := X"00000001";
            RCV_TERM_GND_0 : boolean := FALSE;
            RCV_TERM_GND_1 : boolean := FALSE;
            RCV_TERM_VTTRX_0 : boolean := FALSE;
            RCV_TERM_VTTRX_1 : boolean := FALSE;
            RXGEARBOX_USE_0 : boolean := FALSE;
            RXGEARBOX_USE_1 : boolean := FALSE;
            RX_BUFFER_USE_0 : boolean := TRUE;
            RX_BUFFER_USE_1 : boolean := TRUE;
            RX_DECODE_SEQ_MATCH_0 : boolean := TRUE;
            RX_DECODE_SEQ_MATCH_1 : boolean := TRUE;
            RX_EN_IDLE_HOLD_CDR : boolean := FALSE;
            RX_EN_IDLE_HOLD_DFE_0 : boolean := TRUE;
            RX_EN_IDLE_HOLD_DFE_1 : boolean := TRUE;
            RX_EN_IDLE_RESET_BUF_0 : boolean := TRUE;
            RX_EN_IDLE_RESET_BUF_1 : boolean := TRUE;
            RX_EN_IDLE_RESET_FR : boolean := TRUE;
            RX_EN_IDLE_RESET_PH : boolean := TRUE;
            RX_IDLE_HI_CNT_0 : bit_vector := "1000";
            RX_IDLE_HI_CNT_1 : bit_vector := "1000";
            RX_IDLE_LO_CNT_0 : bit_vector := "0000";
            RX_IDLE_LO_CNT_1 : bit_vector := "0000";
            RX_LOSS_OF_SYNC_FSM_0 : boolean := FALSE;
            RX_LOSS_OF_SYNC_FSM_1 : boolean := FALSE;
            RX_LOS_INVALID_INCR_0 : integer := 1;
            RX_LOS_INVALID_INCR_1 : integer := 1;
            RX_LOS_THRESHOLD_0 : integer := 4;
            RX_LOS_THRESHOLD_1 : integer := 4;
            RX_SLIDE_MODE_0 : string := "PCS";
            RX_SLIDE_MODE_1 : string := "PCS";
            RX_STATUS_FMT_0 : string := "PCIE";
            RX_STATUS_FMT_1 : string := "PCIE";
            RX_XCLK_SEL_0 : string := "RXREC";
            RX_XCLK_SEL_1 : string := "RXREC";
            SATA_BURST_VAL_0 : bit_vector := "100";
            SATA_BURST_VAL_1 : bit_vector := "100";
            SATA_IDLE_VAL_0 : bit_vector := "100";
            SATA_IDLE_VAL_1 : bit_vector := "100";
            SATA_MAX_BURST_0 : integer := 7;
            SATA_MAX_BURST_1 : integer := 7;
            SATA_MAX_INIT_0 : integer := 22;
            SATA_MAX_INIT_1 : integer := 22;
            SATA_MAX_WAKE_0 : integer := 7;
            SATA_MAX_WAKE_1 : integer := 7;
            SATA_MIN_BURST_0 : integer := 4;
            SATA_MIN_BURST_1 : integer := 4;
            SATA_MIN_INIT_0 : integer := 12;
            SATA_MIN_INIT_1 : integer := 12;
            SATA_MIN_WAKE_0 : integer := 4;
            SATA_MIN_WAKE_1 : integer := 4;
            SIM_GTXRESET_SPEEDUP : integer := 1;
            SIM_PLL_PERDIV2 : bit_vector := X"140";
            SIM_RECEIVER_DETECT_PASS_0 : boolean := TRUE;
            SIM_RECEIVER_DETECT_PASS_1 : boolean := TRUE;
            TERMINATION_CTRL : bit_vector := "10100";
            TERMINATION_IMP_0 : integer := 50;
            TERMINATION_IMP_1 : integer := 50;
            TERMINATION_OVRD : boolean := FALSE;
            TRANS_TIME_FROM_P2_0 : bit_vector := X"03c";
            TRANS_TIME_FROM_P2_1 : bit_vector := X"03c";
            TRANS_TIME_NON_P2_0 : bit_vector := X"19";
            TRANS_TIME_NON_P2_1 : bit_vector := X"19";
            TRANS_TIME_TO_P2_0 : bit_vector := X"064";
            TRANS_TIME_TO_P2_1 : bit_vector := X"064";
            TXGEARBOX_USE_0 : boolean := FALSE;
            TXGEARBOX_USE_1 : boolean := FALSE;
            TXRX_INVERT_0 : bit_vector := "011";
            TXRX_INVERT_1 : bit_vector := "011";
            TX_BUFFER_USE_0 : boolean := TRUE;
            TX_BUFFER_USE_1 : boolean := TRUE;
            TX_DETECT_RX_CFG_0 : bit_vector := X"1832";
            TX_DETECT_RX_CFG_1 : bit_vector := X"1832";
            TX_IDLE_DELAY_0 : bit_vector := "010";
            TX_IDLE_DELAY_1 : bit_vector := "010";
            TX_XCLK_SEL_0 : string := "TXOUT";
            TX_XCLK_SEL_1 : string := "TXOUT");
	port(
            DFECLKDLYADJMONITOR0 : out std_logic_vector(5 downto 0);
            DFECLKDLYADJMONITOR1 : out std_logic_vector(5 downto 0);
            DFEEYEDACMONITOR0 : out std_logic_vector(4 downto 0);
            DFEEYEDACMONITOR1 : out std_logic_vector(4 downto 0);
            DFESENSCAL0 : out std_logic_vector(2 downto 0);
            DFESENSCAL1 : out std_logic_vector(2 downto 0);
            DFETAP1MONITOR0 : out std_logic_vector(4 downto 0);
            DFETAP1MONITOR1 : out std_logic_vector(4 downto 0);
            DFETAP2MONITOR0 : out std_logic_vector(4 downto 0);
            DFETAP2MONITOR1 : out std_logic_vector(4 downto 0);
            DFETAP3MONITOR0 : out std_logic_vector(3 downto 0);
            DFETAP3MONITOR1 : out std_logic_vector(3 downto 0);
            DFETAP4MONITOR0 : out std_logic_vector(3 downto 0);
            DFETAP4MONITOR1 : out std_logic_vector(3 downto 0);
            DO : out std_logic_vector(15 downto 0);
            DRDY : out std_ulogic;
            PHYSTATUS0 : out std_ulogic;
            PHYSTATUS1 : out std_ulogic;
            PLLLKDET : out std_ulogic;
            REFCLKOUT : out std_ulogic;
            RESETDONE0 : out std_ulogic;
            RESETDONE1 : out std_ulogic;
            RXBUFSTATUS0 : out std_logic_vector(2 downto 0);
            RXBUFSTATUS1 : out std_logic_vector(2 downto 0);
            RXBYTEISALIGNED0 : out std_ulogic;
            RXBYTEISALIGNED1 : out std_ulogic;
            RXBYTEREALIGN0 : out std_ulogic;
            RXBYTEREALIGN1 : out std_ulogic;
            RXCHANBONDSEQ0 : out std_ulogic;
            RXCHANBONDSEQ1 : out std_ulogic;
            RXCHANISALIGNED0 : out std_ulogic;
            RXCHANISALIGNED1 : out std_ulogic;
            RXCHANREALIGN0 : out std_ulogic;
            RXCHANREALIGN1 : out std_ulogic;
            RXCHARISCOMMA0 : out std_logic_vector(3 downto 0);
            RXCHARISCOMMA1 : out std_logic_vector(3 downto 0);
            RXCHARISK0 : out std_logic_vector(3 downto 0);
            RXCHARISK1 : out std_logic_vector(3 downto 0);
            RXCHBONDO0 : out std_logic_vector(3 downto 0);
            RXCHBONDO1 : out std_logic_vector(3 downto 0);
            RXCLKCORCNT0 : out std_logic_vector(2 downto 0);
            RXCLKCORCNT1 : out std_logic_vector(2 downto 0);
            RXCOMMADET0 : out std_ulogic;
            RXCOMMADET1 : out std_ulogic;
            RXDATA0 : out std_logic_vector(31 downto 0);
            RXDATA1 : out std_logic_vector(31 downto 0);
            RXDATAVALID0 : out std_ulogic;
            RXDATAVALID1 : out std_ulogic;
            RXDISPERR0 : out std_logic_vector(3 downto 0);
            RXDISPERR1 : out std_logic_vector(3 downto 0);
            RXELECIDLE0 : out std_ulogic;
            RXELECIDLE1 : out std_ulogic;
            RXHEADER0 : out std_logic_vector(2 downto 0);
            RXHEADER1 : out std_logic_vector(2 downto 0);
            RXHEADERVALID0 : out std_ulogic;
            RXHEADERVALID1 : out std_ulogic;
            RXLOSSOFSYNC0 : out std_logic_vector(1 downto 0);
            RXLOSSOFSYNC1 : out std_logic_vector(1 downto 0);
            RXNOTINTABLE0 : out std_logic_vector(3 downto 0);
            RXNOTINTABLE1 : out std_logic_vector(3 downto 0);
            RXOVERSAMPLEERR0 : out std_ulogic;
            RXOVERSAMPLEERR1 : out std_ulogic;
            RXPRBSERR0 : out std_ulogic;
            RXPRBSERR1 : out std_ulogic;
            RXRECCLK0 : out std_ulogic;
            RXRECCLK1 : out std_ulogic;
            RXRUNDISP0 : out std_logic_vector(3 downto 0);
            RXRUNDISP1 : out std_logic_vector(3 downto 0);
            RXSTARTOFSEQ0 : out std_ulogic;
            RXSTARTOFSEQ1 : out std_ulogic;
            RXSTATUS0 : out std_logic_vector(2 downto 0);
            RXSTATUS1 : out std_logic_vector(2 downto 0);
            RXVALID0 : out std_ulogic;
            RXVALID1 : out std_ulogic;
            TXBUFSTATUS0 : out std_logic_vector(1 downto 0);
            TXBUFSTATUS1 : out std_logic_vector(1 downto 0);
            TXGEARBOXREADY0 : out std_ulogic;
            TXGEARBOXREADY1 : out std_ulogic;
            TXKERR0 : out std_logic_vector(3 downto 0);
            TXKERR1 : out std_logic_vector(3 downto 0);
            TXN0 : out std_ulogic;
            TXN1 : out std_ulogic;
            TXOUTCLK0 : out std_ulogic;
            TXOUTCLK1 : out std_ulogic;
            TXP0 : out std_ulogic;
            TXP1 : out std_ulogic;
            TXRUNDISP0 : out std_logic_vector(3 downto 0);
            TXRUNDISP1 : out std_logic_vector(3 downto 0);
            CLKIN : in std_ulogic;
            DADDR : in std_logic_vector(6 downto 0);
            DCLK : in std_ulogic;
            DEN : in std_ulogic;
            DFECLKDLYADJ0 : in std_logic_vector(5 downto 0);
            DFECLKDLYADJ1 : in std_logic_vector(5 downto 0);
            DFETAP10 : in std_logic_vector(4 downto 0);
            DFETAP11 : in std_logic_vector(4 downto 0);
            DFETAP20 : in std_logic_vector(4 downto 0);
            DFETAP21 : in std_logic_vector(4 downto 0);
            DFETAP30 : in std_logic_vector(3 downto 0);
            DFETAP31 : in std_logic_vector(3 downto 0);
            DFETAP40 : in std_logic_vector(3 downto 0);
            DFETAP41 : in std_logic_vector(3 downto 0);
            DI : in std_logic_vector(15 downto 0);
            DWE : in std_ulogic;
            GTXRESET : in std_ulogic;
            GTXTEST : in std_logic_vector(13 downto 0);
            INTDATAWIDTH : in std_ulogic;
            LOOPBACK0 : in std_logic_vector(2 downto 0);
            LOOPBACK1 : in std_logic_vector(2 downto 0);
            PLLLKDETEN : in std_ulogic;
            PLLPOWERDOWN : in std_ulogic;
            PRBSCNTRESET0 : in std_ulogic;
            PRBSCNTRESET1 : in std_ulogic;
            REFCLKPWRDNB : in std_ulogic;
            RXBUFRESET0 : in std_ulogic;
            RXBUFRESET1 : in std_ulogic;
            RXCDRRESET0 : in std_ulogic;
            RXCDRRESET1 : in std_ulogic;
            RXCHBONDI0 : in std_logic_vector(3 downto 0);
            RXCHBONDI1 : in std_logic_vector(3 downto 0);
            RXCOMMADETUSE0 : in std_ulogic;
            RXCOMMADETUSE1 : in std_ulogic;
            RXDATAWIDTH0 : in std_logic_vector(1 downto 0);
            RXDATAWIDTH1 : in std_logic_vector(1 downto 0);
            RXDEC8B10BUSE0 : in std_ulogic;
            RXDEC8B10BUSE1 : in std_ulogic;
            RXENCHANSYNC0 : in std_ulogic;
            RXENCHANSYNC1 : in std_ulogic;
            RXENEQB0 : in std_ulogic;
            RXENEQB1 : in std_ulogic;
            RXENMCOMMAALIGN0 : in std_ulogic;
            RXENMCOMMAALIGN1 : in std_ulogic;
            RXENPCOMMAALIGN0 : in std_ulogic;
            RXENPCOMMAALIGN1 : in std_ulogic;
            RXENPMAPHASEALIGN0 : in std_ulogic;
            RXENPMAPHASEALIGN1 : in std_ulogic;
            RXENPRBSTST0 : in std_logic_vector(1 downto 0);
            RXENPRBSTST1 : in std_logic_vector(1 downto 0);
            RXENSAMPLEALIGN0 : in std_ulogic;
            RXENSAMPLEALIGN1 : in std_ulogic;
            RXEQMIX0 : in std_logic_vector(1 downto 0);
            RXEQMIX1 : in std_logic_vector(1 downto 0);
            RXEQPOLE0 : in std_logic_vector(3 downto 0);
            RXEQPOLE1 : in std_logic_vector(3 downto 0);
            RXGEARBOXSLIP0 : in std_ulogic;
            RXGEARBOXSLIP1 : in std_ulogic;
            RXN0 : in std_ulogic;
            RXN1 : in std_ulogic;
            RXP0 : in std_ulogic;
            RXP1 : in std_ulogic;
            RXPMASETPHASE0 : in std_ulogic;
            RXPMASETPHASE1 : in std_ulogic;
            RXPOLARITY0 : in std_ulogic;
            RXPOLARITY1 : in std_ulogic;
            RXPOWERDOWN0 : in std_logic_vector(1 downto 0);
            RXPOWERDOWN1 : in std_logic_vector(1 downto 0);
            RXRESET0 : in std_ulogic;
            RXRESET1 : in std_ulogic;
            RXSLIDE0 : in std_ulogic;
            RXSLIDE1 : in std_ulogic;
            RXUSRCLK0 : in std_ulogic;
            RXUSRCLK1 : in std_ulogic;
            RXUSRCLK20 : in std_ulogic;
            RXUSRCLK21 : in std_ulogic;
            TXBUFDIFFCTRL0 : in std_logic_vector(2 downto 0);
            TXBUFDIFFCTRL1 : in std_logic_vector(2 downto 0);
            TXBYPASS8B10B0 : in std_logic_vector(3 downto 0);
            TXBYPASS8B10B1 : in std_logic_vector(3 downto 0);
            TXCHARDISPMODE0 : in std_logic_vector(3 downto 0);
            TXCHARDISPMODE1 : in std_logic_vector(3 downto 0);
            TXCHARDISPVAL0 : in std_logic_vector(3 downto 0);
            TXCHARDISPVAL1 : in std_logic_vector(3 downto 0);
            TXCHARISK0 : in std_logic_vector(3 downto 0);
            TXCHARISK1 : in std_logic_vector(3 downto 0);
            TXCOMSTART0 : in std_ulogic;
            TXCOMSTART1 : in std_ulogic;
            TXCOMTYPE0 : in std_ulogic;
            TXCOMTYPE1 : in std_ulogic;
            TXDATA0 : in std_logic_vector(31 downto 0);
            TXDATA1 : in std_logic_vector(31 downto 0);
            TXDATAWIDTH0 : in std_logic_vector(1 downto 0);
            TXDATAWIDTH1 : in std_logic_vector(1 downto 0);
            TXDETECTRX0 : in std_ulogic;
            TXDETECTRX1 : in std_ulogic;
            TXDIFFCTRL0 : in std_logic_vector(2 downto 0);
            TXDIFFCTRL1 : in std_logic_vector(2 downto 0);
            TXELECIDLE0 : in std_ulogic;
            TXELECIDLE1 : in std_ulogic;
            TXENC8B10BUSE0 : in std_ulogic;
            TXENC8B10BUSE1 : in std_ulogic;
            TXENPMAPHASEALIGN0 : in std_ulogic;
            TXENPMAPHASEALIGN1 : in std_ulogic;
            TXENPRBSTST0 : in std_logic_vector(1 downto 0);
            TXENPRBSTST1 : in std_logic_vector(1 downto 0);
            TXHEADER0 : in std_logic_vector(2 downto 0);
            TXHEADER1 : in std_logic_vector(2 downto 0);
            TXINHIBIT0 : in std_ulogic;
            TXINHIBIT1 : in std_ulogic;
            TXPMASETPHASE0 : in std_ulogic;
            TXPMASETPHASE1 : in std_ulogic;
            TXPOLARITY0 : in std_ulogic;
            TXPOLARITY1 : in std_ulogic;
            TXPOWERDOWN0 : in std_logic_vector(1 downto 0);
            TXPOWERDOWN1 : in std_logic_vector(1 downto 0);
            TXPREEMPHASIS0 : in std_logic_vector(3 downto 0);
            TXPREEMPHASIS1 : in std_logic_vector(3 downto 0);
            TXRESET0 : in std_ulogic;
            TXRESET1 : in std_ulogic;
            TXSEQUENCE0 : in std_logic_vector(6 downto 0);
            TXSEQUENCE1 : in std_logic_vector(6 downto 0);
            TXSTARTSEQ0 : in std_ulogic;
            TXSTARTSEQ1 : in std_ulogic;
            TXUSRCLK0 : in std_ulogic;
            TXUSRCLK1 : in std_ulogic;
            TXUSRCLK20 : in std_ulogic;
            TXUSRCLK21 : in std_ulogic);
    end component;

    signal eqmix : std_logic_vector(1 downto 0);
    signal logic0 : std_logic;
    signal logic1 : std_logic;
    signal zeroes : std_logic_vector(31 downto 0);
    signal ones : std_logic_vector(31 downto 0);

begin

    eqmix <= "10";
    logic0 <= '0';
    logic1 <= '1';
    zeroes <= (others => '0');
    ones <= (others => '1');

    GTX_inst : GTX_DUAL 
        port map (
            DFECLKDLYADJMONITOR0 => open,
            DFECLKDLYADJMONITOR1 => open,
            DFEEYEDACMONITOR0 => open,
            DFEEYEDACMONITOR1 => open,
            DFESENSCAL0 => open,
            DFESENSCAL1 => open,
            DFETAP1MONITOR0 => open,
            DFETAP1MONITOR1 => open,
            DFETAP2MONITOR0 => open,
            DFETAP2MONITOR1 => open,
            DFETAP3MONITOR0 => open,
            DFETAP3MONITOR1 => open,
            DFETAP4MONITOR0 => open,
            DFETAP4MONITOR1 => open,
            DO => open,
            DRDY => open,
            PHYSTATUS0 => open,
            PHYSTATUS1 => open,
            PLLLKDET => open,
            REFCLKOUT => clkout,
            RESETDONE0 => open,
            RESETDONE1 => open,
            RXBUFSTATUS0 => open,
            RXBUFSTATUS1 => open,
            RXBYTEISALIGNED0 => open,
            RXBYTEISALIGNED1 => open,
            RXBYTEREALIGN0 => open,
            RXBYTEREALIGN1 => open,
            RXCHANBONDSEQ0 => open,
            RXCHANBONDSEQ1 => open,
            RXCHANISALIGNED0 => open,
            RXCHANISALIGNED1 => open,
            RXCHANREALIGN0 => open,
            RXCHANREALIGN1 => open,
            RXCHARISCOMMA0 => open,
            RXCHARISCOMMA1 => open,
            RXCHARISK0 => open,
            RXCHARISK1 => open,
            RXCHBONDO0 => open,
            RXCHBONDO1 => open,
            RXCLKCORCNT0 => open,
            RXCLKCORCNT1 => open,
            RXCOMMADET0 => open,
            RXCOMMADET1 => open,
            RXDATA0 => open,
            RXDATA1 => open,
            RXDATAVALID0 => open,
            RXDATAVALID1 => open,
            RXDISPERR0 => open,
            RXDISPERR1 => open,
            RXELECIDLE0 => open,
            RXELECIDLE1 => open,
            RXHEADER0 => open,
            RXHEADER1 => open,
            RXHEADERVALID0 => open,
            RXHEADERVALID1 => open,
            RXLOSSOFSYNC0 => open,
            RXLOSSOFSYNC1 => open,
            RXNOTINTABLE0 => open,
            RXNOTINTABLE1 => open,
            RXOVERSAMPLEERR0 => open,
            RXOVERSAMPLEERR1 => open,
            RXPRBSERR0 => open,
            RXPRBSERR1 => open,
            RXRECCLK0 => open,
            RXRECCLK1 => open,
            RXRUNDISP0 => open,
            RXRUNDISP1 => open,
            RXSTARTOFSEQ0 => open,
            RXSTARTOFSEQ1 => open,
            RXSTATUS0 => open,
            RXSTATUS1 => open,
            RXVALID0 => open,
            RXVALID1 => open,
            TXBUFSTATUS0 => open,
            TXBUFSTATUS1 => open,
            TXGEARBOXREADY0 => open,
            TXGEARBOXREADY1 => open,
            TXKERR0 => open,
            TXKERR1 => open,
            TXN0 => open,
            TXN1 => open,
            TXOUTCLK0 => open,
            TXOUTCLK1 => open,
            TXP0 => open,
            TXP1 => open,
            TXRUNDISP0 => open,
            TXRUNDISP1 => open,
            -- inputs
            CLKIN => clkin,
            DADDR => zeroes(6 downto 0),
            DCLK => logic0,
            DEN => logic0,
            DFECLKDLYADJ0 => zeroes(5 downto 0),
            DFECLKDLYADJ1 => zeroes(5 downto 0),
            DFETAP10 => zeroes(4 downto 0),
            DFETAP11 => zeroes(4 downto 0),
            DFETAP20 => zeroes(4 downto 0),
            DFETAP21 => zeroes(4 downto 0),
            DFETAP30 => zeroes(3 downto 0),
            DFETAP31 => zeroes(3 downto 0),
            DFETAP40 => zeroes(3 downto 0),
            DFETAP41 => zeroes(3 downto 0),
            DI => zeroes(15 downto 0),
            DWE => logic0,
            GTXRESET => logic0,
            GTXTEST => zeroes(13 downto 0),
            INTDATAWIDTH => logic1,
            LOOPBACK0 => zeroes(2 downto 0),
            LOOPBACK1 => zeroes(2 downto 0),
            PLLLKDETEN => logic1,
            PLLPOWERDOWN => logic1,
            PRBSCNTRESET0 => logic0,
            PRBSCNTRESET1 => logic0,
            REFCLKPWRDNB => logic1,
            RXBUFRESET0 => logic0,
            RXBUFRESET1 => logic0,
            RXCDRRESET0 => logic0,
            RXCDRRESET1 => logic0,
            RXCHBONDI0 => zeroes(3 downto 0),
            RXCHBONDI1 => zeroes(3 downto 0),
            RXCOMMADETUSE0 => logic1,
            RXCOMMADETUSE1 => logic1,
            RXDATAWIDTH0 => zeroes(1 downto 0),
            RXDATAWIDTH1 => zeroes(1 downto 0),
            RXDEC8B10BUSE0 => logic1,
            RXDEC8B10BUSE1 => logic1,
            RXENCHANSYNC0 => logic0,
            RXENCHANSYNC1 => logic0,
            RXENEQB0 => logic1,
            RXENEQB1 => logic1,
            RXENMCOMMAALIGN0 => logic1,
            RXENMCOMMAALIGN1 => logic1,
            RXENPCOMMAALIGN0 => logic1,
            RXENPCOMMAALIGN1 => logic1,
            RXENPMAPHASEALIGN0 => logic1,
            RXENPMAPHASEALIGN1 => logic1,
            RXENPRBSTST0 => zeroes(1 downto 0),
            RXENPRBSTST1 => zeroes(1 downto 0),
            RXENSAMPLEALIGN0 => logic0,
            RXENSAMPLEALIGN1 => logic0,
            RXEQMIX0 => eqmix,
            RXEQMIX1 => eqmix,
            RXEQPOLE0 => zeroes(3 downto 0),
            RXEQPOLE1 => zeroes(3 downto 0),
            RXGEARBOXSLIP0 => logic0,
            RXGEARBOXSLIP1 => logic0,
            RXN0 => logic1,
            RXN1 => logic1,
            RXP0 => logic0,
            RXP1 => logic0,
            RXPMASETPHASE0 => logic0,
            RXPMASETPHASE1 => logic0,
            RXPOLARITY0 => logic0,
            RXPOLARITY1 => logic0,
            RXPOWERDOWN0 => ones(1 downto 0),
            RXPOWERDOWN1 => ones(1 downto 0),
            RXRESET0 => logic0,
            RXRESET1 => logic0,
            RXSLIDE0 => logic0,
            RXSLIDE1 => logic0,
            RXUSRCLK0 => logic0,
            RXUSRCLK1 => logic0,
            RXUSRCLK20 => logic0,
            RXUSRCLK21 => logic0,
            TXBUFDIFFCTRL0 => zeroes(2 downto 0),
            TXBUFDIFFCTRL1 => zeroes(2 downto 0),
            TXBYPASS8B10B0 => zeroes(3 downto 0),
            TXBYPASS8B10B1 => zeroes(3 downto 0),
            TXCHARDISPMODE0 => zeroes(3 downto 0),
            TXCHARDISPMODE1 => zeroes(3 downto 0),
            TXCHARDISPVAL0 => zeroes(3 downto 0),
            TXCHARDISPVAL1 => zeroes(3 downto 0),
            TXCHARISK0 => zeroes(3 downto 0),
            TXCHARISK1 => zeroes(3 downto 0),
            TXCOMSTART0 => logic0,
            TXCOMSTART1 => logic0,
            TXCOMTYPE0 => logic0,
            TXCOMTYPE1 => logic0,
            TXDATA0 => zeroes(31 downto 0),
            TXDATA1 => zeroes(31 downto 0),
            TXDATAWIDTH0 => zeroes(1 downto 0),
            TXDATAWIDTH1 => zeroes(1 downto 0),
            TXDETECTRX0 => logic0,
            TXDETECTRX1 => logic0,
            TXDIFFCTRL0 => zeroes(2 downto 0),
            TXDIFFCTRL1 => zeroes(2 downto 0),
            TXELECIDLE0 => logic0,
            TXELECIDLE1 => logic0,
            TXENC8B10BUSE0 => logic1,
            TXENC8B10BUSE1 => logic1,
            TXENPMAPHASEALIGN0 => logic0,
            TXENPMAPHASEALIGN1 => logic0,
            TXENPRBSTST0 => zeroes(1 downto 0),
            TXENPRBSTST1 => zeroes(1 downto 0),
            TXHEADER0 => zeroes(2 downto 0),
            TXHEADER1 => zeroes(2 downto 0),
            TXINHIBIT0 => logic0,
            TXINHIBIT1 => logic0,
            TXPMASETPHASE0 => logic0,
            TXPMASETPHASE1 => logic0,
            TXPOLARITY0 => logic0,
            TXPOLARITY1 => logic0,
            TXPOWERDOWN0 => ones(1 downto 0),
            TXPOWERDOWN1 => ones(1 downto 0),
            TXPREEMPHASIS0 => ones(3 downto 0),
            TXPREEMPHASIS1 => ones(3 downto 0),
            TXRESET0 => logic0,
            TXRESET1 => logic0,
            TXSEQUENCE0 => zeroes(6 downto 0),
            TXSEQUENCE1 => zeroes(6 downto 0),
            TXSTARTSEQ0 => logic0,
            TXSTARTSEQ1 => logic0,
            TXUSRCLK0 => logic0,
            TXUSRCLK1 => logic0,
            TXUSRCLK20 => logic0,
            TXUSRCLK21 => logic0);

end architecture;
