--This is a testbench file that feeds data into the systolic array and simulates 
--commuication with the axel host
--Shane Fleming 2012

--------------------Libraries--------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;
use IEEE.math_real.all;

LIBRARY std;
USE std.textio.ALL;

LIBRARY work;
USE work.ALL;
-------------------------------------------------------

--#####################################################
--ENTITY DECLARATION
--#####################################################
ENTITY testbench_ent IS
--Testbenches require no I/O typically
END testbench_ent;
--#####################################################


--#####################################################
-- Testbench ARCHITECTURE
--#####################################################
ARCHITECTURE testbench_behav OF testbench_ent IS

-----------------SIGNAL DECLARATIONS-------------------
SIGNAL		clk			:	STD_LOGIC := '1'; --clock signal
SIGNAL          end_of_sim              :       STD_LOGIC := '0'; --signal used to stop the clock

-------------------------------------------------------
			BEGIN
-------------------------------------------------------

-----------------------------
--Clock Generation
clk <= NOT(clk) AFTER 5 ns WHEN (end_of_sim='0');
-----------------------------


-------------------------------------------------------
		END testbench_behav;
------------------------------------------------------- 
--#####################################################
