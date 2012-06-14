LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library work;                           --XST
use work.standby_pkg.all;                   --XST

ENTITY detector IS
  GENERIC (
    COMPNAME : string := "default"
  );
  PORT (
    FACLK  : IN std_logic;
    CLK    : IN std_logic;
    ACTIVE : OUT std_logic
  );
END detector;

ARCHITECTURE rtl OF detector IS

  ------------------------------------------------------------------------------
  -- Attribute Declaration
  ------------------------------------------------------------------------------

  ATTRIBUTE ASYNC_REG : string;
  ATTRIBUTE HU_SET : string;
  ATTRIBUTE RLOC : string;

  ATTRIBUTE ASYNC_REG OF  RINST0 : LABEL IS "TRUE";
  ATTRIBUTE HU_SET OF  RINST0 : LABEL IS COMPNAME&"EDGES";
  ATTRIBUTE RLOC OF  RINST0 : LABEL IS "X0Y0";

  ATTRIBUTE HU_SET OF  RINST1 : LABEL IS COMPNAME&"EDGES";
  ATTRIBUTE RLOC OF  RINST1 : LABEL IS "X0Y0";  

  ATTRIBUTE ASYNC_REG OF  FINST0 : LABEL IS "TRUE";
  ATTRIBUTE HU_SET OF  FINST0 : LABEL IS COMPNAME&"EDGES";
  ATTRIBUTE RLOC OF  FINST0 : LABEL IS "X0Y1";

  ATTRIBUTE HU_SET OF  FINST1 : LABEL IS COMPNAME&"EDGES";
  ATTRIBUTE RLOC OF  FINST1 : LABEL IS "X0Y1";  

  ATTRIBUTE ASYNC_REG OF EINST0 : LABEL IS "TRUE";
  ATTRIBUTE HU_SET OF  EINST0 : LABEL IS COMPNAME&"EDGES";
  ATTRIBUTE RLOC OF  EINST0 : LABEL IS "X0Y2";

  ATTRIBUTE HU_SET OF  EINST1 : LABEL IS COMPNAME&"EDGES";
  ATTRIBUTE RLOC OF  EINST1 : LABEL IS "X0Y2";
  
  ------------------------------------------------------------------------------
  -- Constant Declaration
  ------------------------------------------------------------------------------
  SIGNAL one : std_logic := '1';
    
  ------------------------------------------------------------------------------
  -- Signal Declaration
  ------------------------------------------------------------------------------
  
  ------------------------------------------------------------------------------
  -- Two shift registers, asynchronously reset by clock active condition.
  ------------------------------------------------------------------------------

  SIGNAL  REDGE_DETO : std_logic;
  SIGNAL  REDGE_DET1 : std_logic;

  SIGNAL  FEDGE_DETO : std_logic;
  SIGNAL  FEDGE_DET1 : std_logic;

  ----------------------------------------------------------------------------
  -- Synchronizer for output active indicator.
  ----------------------------------------------------------------------------

  SIGNAL EDGE : std_logic;
  SIGNAL EDGE_DETO : std_logic;
  SIGNAL EDGE_DET1 : std_logic;

  -- internal signal
  SIGNAL ACTIVE_int : std_logic;
  
BEGIN

  ACTIVE <= ACTIVE_int;
  
  ----------------------------------------------------------------------------
  -- Two shift registers, asynchronously reset by clock active condition.
  ----------------------------------------------------------------------------
  RINST0: FDC PORT MAP ( D => one, C => FACLK, Q => REDGE_DETO, CLR => ACTIVE_int);
  RINST1: FDC PORT MAP ( D => REDGE_DETO, C => FACLK, Q => REDGE_DET1, CLR => ACTIVE_int);

  FINST0: FDC_1 PORT MAP ( D => one, C => FACLK, Q => FEDGE_DETO, CLR => ACTIVE_int);
  FINST1: FDC_1 PORT MAP ( D => FEDGE_DETO, C => FACLK, Q => FEDGE_DET1, CLR => ACTIVE_int);

  ----------------------------------------------------------------------------
  -- Synchronizer for output active indicator.
  ----------------------------------------------------------------------------

  EDGE       <= REDGE_DET1 AND FEDGE_DET1;
  ACTIVE_int <= EDGE_DET1;

  EINST0: FD PORT MAP ( D => EDGE, C => CLK, Q => EDGE_DETO);
  EINST1: FD PORT MAP ( D => EDGE_DETO, C => CLK, Q => EDGE_DET1);
  
END rtl;
