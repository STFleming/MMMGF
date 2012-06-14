LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

 LIBRARY work;                           --XST
 USE work.standby_pkg.ALL;                   --XST

ENTITY count2tc_sync IS
  GENERIC (
    CNTRBITS : integer := 6
  );
  PORT (
    CLK : IN std_logic;
    RST : IN std_logic;
    TC  : OUT std_logic
  );
END count2tc_sync;

ARCHITECTURE rtl OF count2tc_sync IS

  SIGNAL COUNT  : std_logic_vector(CNTRBITS-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL TC_int : std_logic;
  
BEGIN
  TC <= TC_int;
  
  cntr:PROCESS (CLK, RST)
  BEGIN
    IF CLK'EVENT AND CLK='1' THEN
      IF (RST = '1') THEN
        COUNT <= (OTHERS => '0') AFTER TFF;
      ELSIF (TC_int = '0')  THEN
        COUNT <= COUNT + '1' AFTER TFF;
      END IF;    
    END IF;          
  END PROCESS cntr;

  TC_int <= COUNT(CNTRBITS-1);
  
END rtl;
