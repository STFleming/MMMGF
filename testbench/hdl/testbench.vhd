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
			matrix_size 	: INTEGER := my_types.matrix_size; --Only send a 3 by 3 matrix 
                        DATA_WIDTH 	: integer := 128 --width of memory data bus (bits), it must be greater or equal than the bin depth 
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
SIGNAL 		fullm			:	STD_LOGIC := '0'; --This is asserted when the memory bank is written to
SIGNAL		wr			:	STD_LOGIC; --The interface asserts this when it is writing data
SIGNAL		data_out		:	STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0); --This is the data coming out of the device
SIGNAL		data_in			:	STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0); --Data being fed into the device
SIGNAL		vldm			:	STD_LOGIC := '0'; --This is asserted when data is available to be read on the device
SIGNAL 		rdm			:	STD_LOGIC; --The interface sets this when it requires the next data value.			

----------------------------------
--Internal testbench counters
----------------------------------
SIGNAL		transmit_value		:	INTEGER := 0; --This increments with every data transimission
SIGNAL		transmit_counter	:	INTEGER := 0; --This keeps track so that only N values are sent
SIGNAL		receive_counter		:	INTEGER := 0; --This keeps track of the number of writes that the device has committed

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


---------------------------------------
--SIMULATE: data transmission to device
---------------------------------------
--This process simulates how the memory controller feeds data into the device.
--The controller asserts vldm whenever data is ready to be read.
--Whenever it detects that rdm is asserted by the device it updates the data being outputted
--with the next memory location of data.
--------------------------------------- 
transmit_data : PROCESS
BEGIN
--This has to be a clocked process
WAIT UNTIL clk'EVENT AND clk='1';

--The initial data value when the device is first started
IF (transmit_counter = 0) THEN
	data_in <= STD_LOGIC_VECTOR(TO_UNSIGNED(transmit_value, DATA_WIDTH));
	reset <= '0'; --Turn the reset signal off
END IF;


vldm <= '1'; --Data is safe to read
IF ((rdm = '1') AND (transmit_counter < matrix_size*matrix_size)) THEN --This means that a new value has been requested
	vldm <= '0'; --Data is unstable as it is changing, NOT AUTHORISED TO READ
	transmit_value <= transmit_value + 1; --Increment the value
	transmit_counter <= transmit_counter + 1; --Increment counter
	data_in <= STD_LOGIC_VECTOR(TO_UNSIGNED(transmit_value, DATA_WIDTH));

	--Test output to determine that the correct data is being fed into the array
	REPORT "Feeding the data: " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_in))) & "  count:  " & INTEGER'IMAGE(transmit_counter);	
END IF; 

END PROCESS transmit_data;
----------------------------------------
						
---------------------------------------
--SIMULATE: data acquisition from device
---------------------------------------
receive_data : PROCESS
BEGIN
WAIT UNTIL clk'EVENT AND clk='1'; --clocked process

fullm <= '0'; --The host is ready to receive the data
IF (wr = '1') THEN
	fullm <= '1'; --The host is busy, NO DATA ALLOWED.
	receive_counter <= receive_counter + 1;
	
	--Outputs the data from the array :)... or at least hopefully it does
	REPORT "Got some data: " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_out))) & "    count:  " & INTEGER'IMAGE(receive_counter);		
END IF;

IF (receive_counter >= matrix_size*matrix_size) THEN
	end_of_sim <= '1'; --end the simulation
END IF;

END PROCESS receive_data;
	
-------------------------------------------------------
		END testbench_behav;
------------------------------------------------------- 
--#####################################################
