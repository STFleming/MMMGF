LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

 library work;                           --XST
 use work.standby_pkg.all;                   --XST

ENTITY DRP_ROBOT IS
  PORT (
    DRP_DO    : IN std_logic_vector(15 DOWNTO 0);
    DRP_DRDY  : IN std_logic;
    DRP_DADDR : OUT std_logic_vector(6 DOWNTO 0);
    DRP_DEN   : OUT std_logic;
    DRP_DI    : OUT std_logic_vector(15 DOWNTO 0);
    DRP_DWE   : OUT std_logic;

    SAV_START : IN std_logic;
    SAV_DONE  : OUT std_logic;
    EXE_START : IN std_logic;
    EXE_DCMGO : OUT std_logic := '0';
    EXE_DONE  : OUT std_logic;
    CLK       : IN  std_logic
    );
END DRP_ROBOT;
  
ARCHITECTURE mixed OF DRP_ROBOT IS
  ----------------------------------------------------------------------------
  -- Implementation of the DRP_ROBOT finite state machine.
  ----------------------------------------------------------------------------
  -- Do not change these parameters.
  -- Do not change encoding.
  -- State bits are used as outputs.
  -- DRP_STATE[4] is the DRP_DWE signal.
  -- DRP_STATE[3] is the RAM_WE signal.
  -- DRP_STATE[2:0] is the RAM_ADDR bus.

  subtype drp_state_type IS std_logic_vector(5 DOWNTO 0);
  -- idle, no write enabled and ram address 0
  CONSTANT RST_IDLE : drp_state_type := B"0_0_1000";
  -- save drp word at 0x42 into ram address 1
  CONSTANT SAV_0x42 : drp_state_type := B"0_1_1001";
  -- save drp word at 0x51 into ram address 2
  CONSTANT SAV_0x51 : drp_state_type := B"0_1_1010";
  -- save drp word at 0x4E into ram address 3
  CONSTANT SAV_0x4E : drp_state_type := B"0_1_1011";
  -- write drp word at 0x4E frm ram address 0
  CONSTANT EXE_0x4E : drp_state_type := B"1_0_1000";
  -- write drp word at 0x42 frm ram address 4
  CONSTANT EXE_0x42a: drp_state_type := B"1_0_1100";
  -- write drp word at 0x51 frm ram address 5 
  CONSTANT EXE_0x51a: drp_state_type := B"1_0_1101";
  -- write drp word at 0x42 frm ram address 6  
  CONSTANT EXE_0x42b: drp_state_type := B"1_0_1110";
  -- write drp word at 0x51 frm ram address 7
  CONSTANT EXE_0x51b: drp_state_type := B"1_0_1111";
  -- write drp word at 0x42 frm ram address 1 
  CONSTANT WRT_0x42 : drp_state_type := B"1_0_1001";
  -- write drp word at 0x51 frm ram address 2
  CONSTANT WRT_0x51 : drp_state_type := B"1_0_1010";
  -- write drp word at 0x4E frm ram address 3
  CONSTANT WRT_0x4E : drp_state_type := B"1_0_1011"; 
  -- read drp at drp address 9  
  CONSTANT READS_0x00 : drp_state_type := B"0_1_0001";  
  CONSTANT READW_0x00 : drp_state_type := B"0_1_0010";  

  SIGNAL DRP_STATE : drp_state_type := RST_IDLE;

  ATTRIBUTE FSM_ENCODING : string;
  ATTRIBUTE FSM_ENCODING OF DRP_STATE : SIGNAL IS "USER";
  -- synthesis attribute FSM_ENCODING of DRP_STATE is "USER"; 
  
  SIGNAL DRP_WAIT  : STD_LOGIC := '0';
  SIGNAL DRP_EN    : STD_LOGIC;

  SIGNAL RAM_ADDR  : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL RAM_WE    : STD_LOGIC;

  ----------------------------------------------------------------------------
  -- Output logic for EXE_DCMGO, EXE_DONE, and SAV_DONE.
  ----------------------------------------------------------------------------
  -- internal signal for output logic
  SIGNAL EXE_DCMGO_int : STD_LOGIC := '0' ;
  SIGNAL DRP_DEN_int   : STD_LOGIC;
  SIGNAL DRP_DI1_int   : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL DRP_DI2_int   : STD_LOGIC_VECTOR(7 DOWNTO 0);
  
  
  SIGNAL one       : STD_LOGIC := '1';

  ----------------------------------------------------------------------------
  -- Component Declaration
  ----------------------------------------------------------------------------
--component RAM16X8S
--	generic
--	(
--		INIT_00 : bit_vector(15 downto 0) := X"0000";
--		INIT_01 : bit_vector(15 downto 0) := X"0000";
--		INIT_02 : bit_vector(15 downto 0) := X"0000";
--		INIT_03 : bit_vector(15 downto 0) := X"0000";
--		INIT_04 : bit_vector(15 downto 0) := X"0000";
--		INIT_05 : bit_vector(15 downto 0) := X"0000";
--		INIT_06 : bit_vector(15 downto 0) := X"0000";
--		INIT_07 : bit_vector(15 downto 0) := X"0000"
--	);
--	port
--	(
--		O : out std_logic_vector ( 7 downto 0);
--		A0 : in std_ulogic;
--		A1 : in std_ulogic;
--		A2 : in std_ulogic;
--		A3 : in std_ulogic;
--		D : in std_logic_vector ( 7 downto 0);
--		WCLK : in std_ulogic;
--		WE : in std_ulogic
--	);
--end component;
    
BEGIN
  ----------------------------------------------------------------------------
  -- Implementation of the DRP_ROBOT finite state machine.
  ----------------------------------------------------------------------------
  
  DRP_EN  <= DRP_STATE(5) OR DRP_STATE(4);
  DRP_DWE <= DRP_STATE(5); 
  RAM_WE  <= DRP_STATE(4);
  RAM_ADDR<= DRP_STATE(3 DOWNTO 0);
  
  ra:PROCESS (RAM_ADDR)
  BEGIN
    CASE RAM_ADDR IS
      WHEN "1000"   => DRP_DADDR <= B"100_1110";  --X"4e";
      WHEN "1001"   => DRP_DADDR <= B"100_0010";  --X"42";
      WHEN "1010"   => DRP_DADDR <= B"101_0001";  --X"51";
      WHEN "1011"   => DRP_DADDR <= B"100_1110";  --X"4e";                   
      WHEN "1100"   => DRP_DADDR <= B"100_0010";  --X"42";
      WHEN "1101"   => DRP_DADDR <= B"101_0001";  --X"51";
      WHEN "1110"   => DRP_DADDR <= B"100_0010";  --X"42";
      WHEN "1111"   => DRP_DADDR <= B"101_0001";  --X"51";
      WHEN OTHERS  => DRP_DADDR <= (OTHERS => '0'); --X"00";
    END CASE;
  END PROCESS ra;

  st:PROCESS (CLK)
  BEGIN
    IF (CLK'event AND CLK = '1') THEN
    CASE DRP_STATE IS
      WHEN RST_IDLE  =>
        IF (SAV_START='1') THEN DRP_STATE <= SAV_0x42 AFTER TFF;
        ELSIF (EXE_START='1') THEN DRP_STATE <= EXE_0x4E AFTER TFF;
        ELSE DRP_STATE <= RST_IDLE AFTER TFF;
        END IF;
          
      WHEN SAV_0x42  =>
        IF (DRP_DRDY='1') THEN DRP_STATE <= SAV_0x51 AFTER TFF;
        ELSE DRP_STATE <= SAV_0x42 AFTER TFF;          
        END IF;
        
      WHEN SAV_0x51  =>
        IF (DRP_DRDY='1') THEN DRP_STATE <= SAV_0x4E AFTER TFF;
        ELSE DRP_STATE <= SAV_0x51 AFTER TFF;
        END IF;
             
      WHEN SAV_0x4E  =>
        IF (DRP_DRDY='1') THEN DRP_STATE <= READS_0x00 AFTER TFF;
        ELSE DRP_STATE <= SAV_0x4E AFTER TFF;     
        END IF;
        
      WHEN READS_0x00  =>
        IF (DRP_DRDY='1') THEN DRP_STATE <= RST_IDLE AFTER TFF;
        ELSE DRP_STATE <= READS_0x00 AFTER TFF;     
        END IF;

      WHEN EXE_0x4E  =>
        IF (DRP_DRDY='1') THEN
          IF (EXE_START='1') THEN DRP_STATE <= EXE_0x42a AFTER TFF; 
          ELSE DRP_STATE <= WRT_0x4E AFTER TFF;
          END IF;     
        ELSE DRP_STATE <= EXE_0x4E AFTER TFF;
        END IF;

      --Begin of exercise cycle
      WHEN EXE_0x42a =>
        if (DRP_DRDY='1') THEN DRP_STATE <= EXE_0x51a AFTER TFF;
        else DRP_STATE <= EXE_0x42a AFTER TFF;
        END IF;
     
      WHEN EXE_0x51a =>
        if (DRP_DRDY='1') THEN DRP_STATE <= EXE_0x42b AFTER TFF;
        else DRP_STATE <= EXE_0x51a AFTER TFF;     
        END IF;
        
      WHEN EXE_0x42b =>
        if (DRP_DRDY='1') THEN DRP_STATE <= EXE_0x51b AFTER TFF;
        else DRP_STATE <= EXE_0x42b AFTER TFF;        
        END IF;
        
      WHEN EXE_0x51b =>
        if (DRP_DRDY='1') THEN
          if (EXE_START='1') THEN DRP_STATE <= EXE_0x42a AFTER TFF;
          else DRP_STATE <= WRT_0x42 AFTER TFF;
          END IF;
        else DRP_STATE <= EXE_0x51b AFTER TFF;             
        END IF;
               
      --End of excercise cycle
      WHEN WRT_0x42  =>
        if (DRP_DRDY='1') THEN DRP_STATE <= WRT_0x51 AFTER TFF;
        else DRP_STATE <= WRT_0x42 AFTER TFF;
        END IF;
               
      WHEN WRT_0x51  =>
        if (DRP_DRDY='1') THEN DRP_STATE <= WRT_0x4E AFTER TFF;
        else DRP_STATE <= WRT_0x51 AFTER TFF;
        END IF;
               
      WHEN WRT_0x4E  =>
        if (DRP_DRDY='1') THEN DRP_STATE <= READW_0x00 AFTER TFF;
        else DRP_STATE <= WRT_0x4E AFTER TFF;
        END IF;
     
      WHEN READW_0x00 =>
        if (DRP_DRDY='1') THEN
          if (SAV_START='1') THEN DRP_STATE <= SAV_0x42 AFTER TFF;
          elsif (EXE_START='1') THEN DRP_STATE <= EXE_0x4E AFTER TFF;
          else DRP_STATE <= RST_IDLE AFTER TFF;
          END IF;     
        else DRP_STATE <= READW_0x00 AFTER TFF;
        END IF;
          
      WHEN OTHERS   =>
        DRP_STATE <= RST_IDLE AFTER TFF;
    END CASE;             
    END IF;    
  END PROCESS st;
  
  ----------------------------------------------------------------------------
  -- Output logic for EXE_DCMGO, EXE_DONE, and SAV_DONE.
  ----------------------------------------------------------------------------
  EXE_DCMGO <= EXE_DCMGO_int;
  
  dpst: PROCESS(CLK)
  BEGIN
    IF (CLK'EVENT AND CLK='1') THEN
      CASE DRP_STATE IS
        WHEN EXE_0x4E =>
          -- Set the flag on entry to EXE_0x42a
          IF (DRP_DRDY='1') THEN
            IF (EXE_START='1') THEN EXE_DCMGO_int <= '1' AFTER TFF;
            ELSE EXE_DCMGO_int <= '0' AFTER TFF;
            END IF;            
          ELSE EXE_DCMGO_int <= '0' AFTER TFF;
          END IF;
    
        WHEN EXE_0x51b =>
          -- Clear the flag on entry to WRT_0x42
          IF (DRP_DRDY='1') THEN
            IF (EXE_START='1') THEN EXE_DCMGO_int <= '1' AFTER TFF;
            ELSE EXE_DCMGO_int <= '0' AFTER TFF;
            END IF;       
          ELSE EXE_DCMGO_int <= '1' AFTER TFF;               
          END IF;       
          
        WHEN OTHERS =>
          EXE_DCMGO_int <= EXE_DCMGO_int AFTER TFF;
          
      END CASE;
    END IF;
  END PROCESS dpst;

  as: PROCESS(DRP_STATE, DRP_DRDY)
  BEGIN
    IF (DRP_STATE = READS_0x00) AND (DRP_DRDY='1') THEN
      SAV_DONE <= '1';
    ELSE
      SAV_DONE <= '0';
    END IF;

    IF (DRP_STATE = READW_0x00) AND (DRP_DRDY='1') THEN
      EXE_DONE <= '1';
    ELSE
      EXE_DONE <= '0';
    END IF;  
  END PROCESS as;

  ----------------------------------------------------------------------------
  -- Wait State Logic
  ----------------------------------------------------------------------------  
  dpw: PROCESS(CLK)
  BEGIN
    IF (CLK'EVENT AND CLK='1') THEN
      IF (DRP_WAIT='1')  THEN
        DRP_WAIT <= NOT(DRP_DRDY) AFTER TFF;
      ELSE
        DRP_WAIT <= DRP_DEN_int AFTER TFF;
      END IF;
    END IF;
  END PROCESS dpw;

  DRP_DEN_int <= DRP_EN AND NOT(DRP_WAIT);
  DRP_DEN     <= DRP_DEN_int;

  ----------------------------------------------------------------------------
  -- RAM instances for DRP data words.
  -- ram address 0 --> drp word at 0x4E (static,  0x0000)
  -- ram address 1 --> drp word at 0x42 (dynamic, 0x0000)
  -- ram address 2 --> drp word at 0x51 (dynamic, 0x0000)
  -- ram address 3 --> drp word at 0x4E (dynamic, 0x0000)
  -- ram address 4 --> drp word at 0x42 (static,  0x0040)
  -- ram address 5 --> drp word at 0x51 (static,  0x0008)
  -- ram address 6 --> drp word at 0x42 (static,  0x0060)
  -- ram address 7 --> drp word at 0x51 (static,  0x0000)
  -- Since one address is constant, it is tied to logic
  -- one which prevents warnings during mapping.
  ----------------------------------------------------------------------------
  RAM0: RAM16X8S
    GENERIC MAP (
      INIT_00 => X"0000",
      INIT_01 => X"0000",
      INIT_02 => X"0000",
      INIT_03 => X"2000",
      INIT_04 => X"0000",
      INIT_05 => X"4000",
      INIT_06 => X"5000",
      INIT_07 => X"0000"      
    )
    PORT MAP (
    O  => DRP_DI1_int,
    A0 => RAM_ADDR(0),
    A1 => RAM_ADDR(1),
    A2 => RAM_ADDR(2),
    A3 => RAM_ADDR(3),
    D  => DRP_DO(7 DOWNTO 0),
    WCLK => CLK,
    WE   => RAM_WE
    );

  DRP_DI(7 DOWNTO 0) <= DRP_DI1_int;

  -- synthesis attribute INIT_00 of RAM0 is "0000";
  -- synthesis attribute INIT_01 of RAM0 is "0000";
  -- synthesis attribute INIT_02 of RAM0 is "0000";
  -- synthesis attribute INIT_03 of RAM0 is "2000";
  -- synthesis attribute INIT_04 of RAM0 is "0000";
  -- synthesis attribute INIT_05 of RAM0 is "4000";
  -- synthesis attribute INIT_06 of RAM0 is "5000";
  -- synthesis attribute INIT_07 of RAM0 is "0000";
  -- synthesis translate_off
  -- address from high to low fedcba98xxxxxxxx
  --defparam RAM0.INIT_00 = 16'b0000000000000000; -- bit 0
  --defparam RAM0.INIT_01 = 16'b0000000000000000; -- bit 1
  --defparam RAM0.INIT_02 = 16'b0000000000000000; -- bit 2
  --defparam RAM0.INIT_03 = 16'b0010000000000000; -- bit 3
  --defparam RAM0.INIT_04 = 16'b0000000000000000; -- bit 4
  --defparam RAM0.INIT_05 = 16'b0100000000000000; -- bit 5
  --defparam RAM0.INIT_06 = 16'b0101000000000000; -- bit 6
  --defparam RAM0.INIT_07 = 16'b0000000000000000; -- bit 7
  -- synthesis translate_on
  
  RAM1: RAM16X8S
    GENERIC MAP (
      INIT_00 => X"0000",
      INIT_01 => X"0000",
      INIT_02 => X"0000",
      INIT_03 => X"0000",
      INIT_04 => X"0000",
      INIT_05 => X"0000",
      INIT_06 => X"0000",
      INIT_07 => X"0000"      
    )
    PORT MAP (
    O  => DRP_DI2_int,
    A0 => RAM_ADDR(0),
    A1 => RAM_ADDR(1),
    A2 => RAM_ADDR(2),
    A3 => RAM_ADDR(3),
    D  => DRP_DO(15 DOWNTO 8),
    WCLK => CLK,
    WE   => RAM_WE
    );
  
  DRP_DI(15 DOWNTO 8) <= DRP_DI2_int;
  
  -- synthesis attribute INIT_00 of RAM1 is "0000";
  -- synthesis attribute INIT_01 of RAM1 is "0000";
  -- synthesis attribute INIT_02 of RAM1 is "0000";
  -- synthesis attribute INIT_03 of RAM1 is "0000";
  -- synthesis attribute INIT_04 of RAM1 is "0000";
  -- synthesis attribute INIT_05 of RAM1 is "0000";
  -- synthesis attribute INIT_06 of RAM1 is "0000";
  -- synthesis attribute INIT_07 of RAM1 is "0000";
  -- synthesis translate_off
  -- synthesis translate_off
  -- address from high to low fedcba98xxxxxxxx
  --defparam RAM1.INIT_00 = 16'b0000000000000000; -- bit 8
  --defparam RAM1.INIT_01 = 16'b0000000000000000; -- bit 9
  --defparam RAM1.INIT_02 = 16'b0000000000000000; -- bit a
  --defparam RAM1.INIT_03 = 16'b0000000000000000; -- bit b
  --defparam RAM1.INIT_04 = 16'b0000000000000000; -- bit c
  --defparam RAM1.INIT_05 = 16'b0000000000000000; -- bit d
  --defparam RAM1.INIT_06 = 16'b0000000000000000; -- bit e
  --defparam RAM1.INIT_07 = 16'b0000000000000000; -- bit f
  -- synthesis translate_on
    
END mixed;

