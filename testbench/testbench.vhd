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
generic (
                        DATA_WIDTH : integer := 128 --width of memory data bus (bits), it must be greater or equal than the bin depth 
                );
END testbench_ent;
--#####################################################


--#####################################################
-- Testbench ARCHITECTURE
--#####################################################
ARCHITECTURE testbench_behav OF testbench_ent IS

-----------------SIGNAL DECLARATIONS-------------------
SIGNAL		clk			:	STD_LOGIC := '1'; --clock signal
SIGNAL          end_of_sim              :       STD_LOGIC := '0'; --signal used to stop the clock
SIGNAL		reset			:	STD_LOGIC := '1'; --The reset signal
SIGNAL		address_count		:	INTEGER := 0; --This keeps track of the current 128-bit word held at data in

----------------------------------
--Signals connected to the memory interface
----------------------------------
SIGNAL 		fullm			:	STD_LOGIC := '0'; --This is set high when that memory bank is full
SIGNAL		wr			:	STD_LOGIC; --The interface asserts this when it is writing data
SIGNAL		data_out		:	STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0); --This is the data coming out of the device
SIGNAL		data_in			:	STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0); --Data being fed into the device
SIGNAL		vldm			:	STD_LOGIC := '0'; --This is asserted when data is available to be read on the device
SIGNAL 		rdm			:	STD_LOGIC; --The interface sets this when it requires the next data value.			

-------------------------------------------------------
			BEGIN
-------------------------------------------------------

-----------------------------
--Clock Generation
clk <= NOT(clk) AFTER 5 ns WHEN (end_of_sim='0');
-----------------------------


----------------Device Under Test-----------------------
axel_interface	:	ENTITY axel_interface_ent
			PORT MAP (	
			clk => clk,
			reset => reset,
			fullm => fullm,
			wr => wr,
			data_out => data_out,
			data_in => data_in,
			vldm => vldm,
			rdm => rdm
			);
--------------------------------------------------------
							
-------------------------------------------------------
		END testbench_behav;
------------------------------------------------------- 
--#####################################################
