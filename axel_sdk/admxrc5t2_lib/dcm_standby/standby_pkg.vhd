library IEEE;
use IEEE.STD_LOGIC_1164.all;

package standby_pkg is
  ------------------------------------------------------------------------------------
  -- Declare XST attributes
  ------------------------------------------------------------------------------------
  attribute IOB		      	: string;
  attribute RLOC		: string;
  attribute HU_SET	      	: string;
  attribute USE_SYNC_SET	: string;	
  attribute USE_SYNC_RESET   	: string;
  attribute RAM_STYLE	      	: string;
  attribute CLOCK_SIGNAL 	: string;
  attribute ENUM_ENCODING	: string;
  attribute DCM_AUTOCALIBRATION : string;

  ------------------------------------------------------------------------------------
  -- Declare constants
  ------------------------------------------------------------------------------------
  --USER CONSTANTS: These are in top level for easy modification
  --constant clkinto		: integer	:= 1000000;
  --constant clkfbto		: integer	:= 1000020;
  --constant psfixed		: boolean       := TRUE;
  --constant fb_clk0  		: boolean	:= TRUE;
  --constant dblclksm		: boolean	:= FALSE;

  ------------------------------------------------------------------------------------
  --DONT TOUCH CONSTANTS (In this package to keep them safe)
  --NEED VERIFICATION!
  ------------------------------------------------------------------------------------
  --drp rd/wr addresses
  constant drp_daddr0	: std_logic_vector(6 DOWNTO 0) 	:="0000000"; 	--??
  constant drp_daddr1	: std_logic_vector(6 DOWNTO 0) 	:="1000010";  
  constant drp_daddr2	: std_logic_vector(6 DOWNTO 0) 	:="1010001";  
  constant drp_daddr3	: std_logic_vector(6 DOWNTO 0) 	:="1001110";  
  constant drp_daddr4	: std_logic_vector(6 DOWNTO 0) 	:="1001110"; 	--?? 
  constant drp_daddr00	: std_logic_vector(6 DOWNTO 0) 	:="0000000";	--Idealy a null drp address  
  --drpexe addresses: 
  constant drp_daddr9	: std_logic_vector(6 DOWNTO 0) 	:="1000010";  
  constant drp_daddr10	: std_logic_vector(6 DOWNTO 0) 	:="1010001";  
  constant drp_daddr11	: std_logic_vector(6 DOWNTO 0) 	:="1000010";  
  constant drp_daddr12	: std_logic_vector(6 DOWNTO 0) 	:="1010001";
  --drpexe data:   
  constant drp_datas0	: std_logic_vector(15 DOWNTO 0)	:="0000000001000000";  
  constant drp_datas1	: std_logic_vector(15 DOWNTO 0)	:="0000000000001000"; 
  constant drp_datas2	: std_logic_vector(15 DOWNTO 0)	:="0000000001100000"; 
  constant drp_datas3	: std_logic_vector(15 DOWNTO 0)	:="0000000000000000";

  constant TFF : time := 500 ps;
  ------------------------------------------------------------------------------------
  -- Define ROM drp_daddr could be accessed as a ROM table (not used)
  ------------------------------------------------------------------------------------
  type drp_daddrom is array(0 to 15) of std_logic_vector(6 downto 0);
  constant drp_daddr_rom : drp_daddrom	:= (0 => drp_daddr0, 
                                           1 => drp_daddr1, 
                                           2 => drp_daddr2, 
                                           3 => drp_daddr3, 
                                           4 => drp_daddr4, 
                                           9 => drp_daddr9, 
                                          10 => drp_daddr10, 
                                          11 => drp_daddr11, 
                                          12 => drp_daddr12, 
                                      others => drp_daddr0); 	--Find an empty port?

  ------------------------------------------------------------------------------------
  -- Define RAM array and intial RAM contents
  -- GETINIT function will turn this into INIT strings from RAM instances
  ------------------------------------------------------------------------------------
  type array16x16 is array (0 to 15) of std_logic_vector(15 downto 0); 
  constant drp_data_init : array16x16 := (9 => drp_datas0, 
                                         10 => drp_datas1, 
                                         11 => drp_datas2, 
                                         12 => drp_datas3, 
                                     others => drp_datas0);
 
  ------------------------------------------------------------------------------------
  -- Declare functions and procedure
  ------------------------------------------------------------------------------------
  function GETLOG2 (Int	:in integer) return integer;		
  function GETINIT (Int	:in integer; mem :in array16x16) return bit_vector;
		
end standby_pkg ;

package body standby_pkg is
  ------------------------------------------------------------------------------------
  -- getlog2 determines minium power of 2 required to express the integer input
  ------------------------------------------------------------------------------------
  function GETLOG2 (Int :in integer) return integer is
  begin
    if (Int <= 2) then
      return 1;
    else 
      return GETLOG2((INT/2) + (INT rem 2)) + 1;
    end if;
  end GETLOG2;

  ------------------------------------------------------------------------------------
  -- getinit returns bitvector intitialization string for the Int memory bit
  ------------------------------------------------------------------------------------
  function GETINIT (Int	:in integer; mem :in array16x16) return bit_vector is
  variable tmp : bit_vector(15 downto 0) := "0000000000000000";
  variable wrd : std_logic_vector(15 downto 0);
  begin
    for i in 0 to 15 loop
      wrd := mem(i);
    if (wrd(INT) = '1') then
        tmp(i) := '1';
      else 
        tmp(i) := '0';
      end if;
    end loop;
    return tmp;
  end GETINIT;

end standby_pkg;
