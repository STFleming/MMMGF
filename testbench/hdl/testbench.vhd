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

--BANK ZERO
SIGNAL 		full0			:	STD_LOGIC := '0'; --This is asserted when the memory bank is wr0itten to
SIGNAL		wr0			:	STD_LOGIC; --The interface asserts this when it is writing data
SIGNAL		data_out0		:	STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0); --This is the data coming out of the device
SIGNAL		data_in0		:	STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0); --Data being fed into the device
SIGNAL		vld0			:	STD_LOGIC := '0'; --This is asserted when data is available to be read on the device
SIGNAL 		rd0			:	STD_LOGIC; --The interface sets this when it requires the next data value.			

--BANK ONE
SIGNAL		full1			:	STD_LOGIC := '0';
SIGNAL		wr1			:	STD_LOGIC;
SIGNAL		data_out1		:	STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0);
SIGNAL 		data_in1		:	STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0);
SIGNAL		vld1			:	STD_LOGIC := '0';
SIGNAL		rd1			:	STD_LOGIC;

----------------------------------
--Internal testbench counters
----------------------------------
SIGNAL		transmit_value0		:	INTEGER := 0; --This increments with every data transimission
SIGNAL		transmit_counter0	:	INTEGER := 0; --This keeps track so that only N values are sent
SIGNAL		receive_counter0	:	INTEGER := 0; --This keeps track of the number of wr0ites that the device has committed
SIGNAL		transmit_value1		:	INTEGER := 0;
SIGNAL		transmit_counter1	:	INTEGER := 0;
SIGNAL		receive_counter1	:	INTEGER := 0;

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
	
			--BANK ZERO
			full0 => full0,
			wr0 => wr0,
			data_out0 => data_out0,
			data_in0 => data_in0,
			vld0 => vld0,
			rd0 => rd0,

			--BANK ONE
			full1 => full1,
			wr1 => wr1,
			data_out1 => data_out1,
			data_in1 => data_in1,
			vld1 => vld1,
			rd1 => rd1
			);
--------------------------------------------------------


---------------------------------------
--SIMULATE: data transmission to device -- BANK ZERO
---------------------------------------
--This process simulates how the memory controller feeds data into the device.
--The controller asserts vld0 whenever data is ready to be read.
--Whenever it detects that rd0 is asserted by the device it updates the data being outputted
--with the next memory location of data.
--------------------------------------- 
transmit_data_bank0 : PROCESS
BEGIN
--This has to be a clocked process
WAIT UNTIL clk'EVENT AND clk='1';

--The initial data value when the device is first started
IF (transmit_counter0 = 0) THEN
	data_in0 <= STD_LOGIC_VECTOR(TO_UNSIGNED(transmit_value0, DATA_WIDTH));
	reset <= '0'; --Turn the reset signal off
END IF;


vld0 <= '1'; --Data is safe to read
IF ((rd0 = '1') AND (transmit_counter0 < matrix_size*matrix_size)) THEN --This means that a new value has been requested
	vld0 <= '0'; --Data is unstable as it is changing, NOT AUTHORISED TO READ
	transmit_value0 <= transmit_value0 + 1; --Increment the value
	transmit_counter0 <= transmit_counter0 + 1; --Increment counter
	data_in0 <= STD_LOGIC_VECTOR(TO_UNSIGNED(transmit_value0, DATA_WIDTH));

	--Test output to determine that the correct data is being fed into the array
	--REPORT "Feeding the data: " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_in0))) & "  count:  " & INTEGER'IMAGE(transmit_counter0);	
END IF; 

END PROCESS transmit_data_bank0;
----------------------------------------

---------------------------------------
--SIMULATE: data transmission to device -- BANK ONE
---------------------------------------
--This process simulates how the memory controller feeds data into the device.
--The controller asserts vld1 whenever data is ready to be read.
--Whenever it detects that rd1 is asserted by the device it updates the data being outputted
--with the next memory location of data.
--------------------------------------- 
transmit_data_bank1 : PROCESS
BEGIN
--This has to be a clocked process
WAIT UNTIL clk'EVENT AND clk='1';

--The initial data value when the device is first started
IF (transmit_counter1 = 0) THEN
        data_in1 <= STD_LOGIC_VECTOR(TO_UNSIGNED(transmit_value1, DATA_WIDTH));
        reset <= '0'; --Turn the reset signal off
END IF;

vld1 <= '1'; --Data is safe to read
IF ((rd1 = '1') AND (transmit_counter1 < matrix_size*matrix_size)) THEN --This means that a new value has been requested
        vld1 <= '0'; --Data is unstable as it is changing, NOT AUTHORISED TO READ
        transmit_value1 <= transmit_value1 + 1; --Increment the value
        transmit_counter1 <= transmit_counter1 + 1; --Increment counter
        data_in1 <= STD_LOGIC_VECTOR(TO_UNSIGNED(transmit_value1, DATA_WIDTH));

        --Test output to determine that the correct data is being fed into the array
        --REPORT "Feeding the data: " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_in1))) & "  count:  " & INTEGER'IMAGE(transmit_counter1);        
END IF; 

END PROCESS transmit_data_bank1;
----------------------------------------
						
---------------------------------------
--SIMULATE: data acquisition from device --BANK ZERO
---------------------------------------
receive_data0 : PROCESS
BEGIN
WAIT UNTIL clk'EVENT AND clk='1'; --clocked process

full0 <= '0'; --The host is ready to receive the data
IF (wr0 = '1') THEN
	full0 <= '1'; --The host is busy, NO DATA ALLOWED.
	receive_counter0 <= receive_counter0 + 1;
	
	--Outputs the data from the array :)... or at least hopefully it does
	REPORT "Got some data: " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_out0))) & "    count:  " & INTEGER'IMAGE(receive_counter0);		
END IF;

IF (receive_counter0 >= matrix_size*matrix_size) THEN
	end_of_sim <= '1'; --end the simulation
END IF;

END PROCESS receive_data0;
	

---------------------------------------
--SIMULATE: data acquisition from device --BANK ONE
---------------------------------------
receive_data1 : PROCESS
BEGIN
WAIT UNTIL clk'EVENT AND clk='1'; --clocked process

full1 <= '0'; --The host is ready to receive the data
IF (wr1 = '1') THEN
        full1 <= '1'; --The host is busy, NO DATA ALLOWED.
        receive_counter1 <= receive_counter1 + 1;

        --Outputs the data from the array :)... or at least hopefully it does
        REPORT "Got some data: " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_out1))) & "    count:  " & INTEGER'IMAGE(receive_counter1);
END IF;

END PROCESS receive_data1;

-------------------------------------------------------
		END testbench_behav;
------------------------------------------------------- 
--#####################################################
