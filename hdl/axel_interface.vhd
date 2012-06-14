--VHDL entity designed to interface with axel and feed the systolic array.

library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

LIBRARY work;
USE work.my_types.ALL;
USE work.ALL; 

entity axel_interface_ent is
generic (
			DATA_WIDTH : integer := 128 --width of memory data bus (bits), it must be greater or equal than the bin depth 
		);
port (
		clk 		: in std_logic;
		reset 		: in std_logic;
		
		--First Memory Bank----------------------- BANK ZERO
		full0		: in std_logic;			--'0' indicates the memory interface is ready for a write
		wr0		: out std_logic;		--assert '1' to write a word to the fifo
		data_out0 	: out std_logic_vector(DATA_WIDTH-1 DOWNTO 0);	--external memory data bus
		data_in0	: in std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
		vld0		: in std_logic;	-- This is used to tell when data is ready to be read
		rd0		: out std_logic;
		
		--Second Memory Bank---------------------  BANK ONE
		full1  		: in std_logic;
		wr1		: out std_logic;
		data_out1	: out std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
		data_in1	: in std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
		vld1		: in std_logic;
		rd1		: out std_logic
);
end axel_interface_ent;

ARCHITECTURE rtl of axel_interface_ent IS
TYPE Tstate IS (read_config, Sload, read_data, pack_and_commit, word_ready,test3, read_data1, pack_and_commit1, word_ready1, Sload1); --posible states
SIGNAL ss, ss_next 					: Tstate; --state signals
SIGNAL val_reg, val_temp 				: STD_LOGIC_VECTOR (my_types.bit_width - 1 DOWNTO 0); --This is a temp storage for the read value
SIGNAL count, count_next 				: UNSIGNED (DATA_WIDTH-1 DOWNTO 0);
SIGNAL expo, expo_reg	 				: UNSIGNED (DATA_WIDTH-1 DOWNTO 0); --Stores the exponent of the operation
SIGNAL read_counter, read_counter_reg			: INTEGER; --These are used to count the number of BRAM entries that have already been committed 
SIGNAL memory_word_in_top, memory_word_in_top_reg	: BRAM_word_width; --These signals are used to send each ram entry to the BRAMs
SIGNAL memory_word_in_left, memory_word_in_left_reg	: BRAM_word_width; 
SIGNAL commit_count, commit_count_reg			: INTEGER; --Used to keep track of what point a word is ready to be committed. 

--For BANK ONE
SIGNAL read_counter1, read_counter_reg1			: INTEGER;
SIGNAL commit_count1, commit_count_reg1			: INTEGER;

--###############################################################################
--FUNCTION FOR CALCULATING THE DEFAULT VALUE OF THE BRAM WORD
-------------------------------------------------------------
-- Fill all b segements of each BRAM entry with the value p
-------------------------------------------------------------
IMPURE FUNCTION default_entry RETURN BRAM_word_width IS

CONSTANT        RESET_VALUE             :       STD_LOGIC_VECTOR((my_types.bit_width-1) DOWNTO 0) 
						:= STD_LOGIC_VECTOR(TO_UNSIGNED(my_types.field_size, my_types.bit_width));

VARIABLE	A			:	BRAM_word_width;	

BEGIN
        pack : FOR i IN 1 TO ((A'LENGTH)/my_types.bit_width) LOOP
                A( ((i*my_types.bit_width)-1) DOWNTO ((i-1)*my_types.bit_width) ) := RESET_VALUE;
        END LOOP pack;

        RETURN A;
END default_entry;
--###############################################################################

BEGIN

STATE_PROC: --Combinitorial state update and output process
PROCESS(ss, full0, count, data_in0, vld0, val_reg, vld1, full1, data_in1)
BEGIN

--------------------------DEFAULT VALUES!------------------------------------
wr0 <= '0'; rd0 <= '0';				--default no write
wr1 <= '0'; rd1 <= '0';
 
data_out0 <= (OTHERS => '0');	--default clear data
data_out1 <= (OTHERS => '0');

count_next <= count;			--default retain count
val_temp <= val_reg; --Default is the register value
expo <= expo_reg;
read_counter <= read_counter_reg;
read_counter1 <= read_counter_reg1;
commit_count <= commit_count_reg;
commit_count1 <= commit_count_reg1;
memory_word_in_top <= memory_word_in_top_reg;
memory_word_in_left <= memory_word_in_left_reg;
-----------------------------------------------------------------------------

CASE ss is
	-------------READ CONFIG & IDLE STATE----------------
	--This state is the resting state of the device 
	--It waits for the first read available signal and then loads in the
	--config data. Once this has occurred it then moves into the state required
	--to read in the matrix data.	
	WHEN read_config =>
		IF (vld0 = '1') THEN
			expo <= UNSIGNED(data_in0); --Load in the exponent data from the memory bank
			rd0 <= '1';
			ss_next <= read_data;
		ELSE
			ss_next <= read_config;
		END IF;
	-----------------------------------------------------	

	---------------READ DATA & PACK THE DATA-------------
	--This state gets data from the host and packs it together into
	--one single BRAM entry. This is more complicated than it sounds
	--since the BRAM entries need to be staggered with reset signals.
	--For this reason two counters are required to keep track of where
	--we are.
	WHEN read_data => --Read in the data in this state
			IF (vld0 = '1') THEN
				val_temp <= data_in0((my_types.bit_width - 1) DOWNTO 0); --In this case we are not using the full 128 bits
				ss_next <= pack_and_commit;
	
			ELSE
				ss_next <= read_data;
			END IF;
	
	WHEN pack_and_commit =>  --This state packs the data into the triangular manner with the reset signals 
				IF commit_count_reg <= (my_types.matrix_size - 1) THEN 
					--Here we pack the values in from the MSB down (i.e. left to right)
					IF read_counter_reg <= commit_count_reg THEN
						--In this case we push another entry onto the BRAM word
						--and then increment the read counter
						memory_word_in_top( ((memory_word_in_top'LENGTH - 1) - my_types.bit_width) DOWNTO 0) 
						<= memory_word_in_top_reg((memory_word_in_top'LENGTH - 1) DOWNTO my_types.bit_width); --shift the data
						--Push the new value onto the word
						memory_word_in_top( (memory_word_in_top'LENGTH - 1) DOWNTO (memory_word_in_top'LENGTH - my_types.bit_width))
						<= val_reg; 	
						read_counter <= read_counter_reg + 1; --Increment the read counter
						ss_next <= read_data; rd0<='1'; --Read next data item.
					ELSE
						ss_next <= word_ready; --Go to the state to collect the next memory value	
					END IF;
	
				ELSIF commit_count_reg < (2*my_types.matrix_size - 1) THEN
					--Here we pack the values from the LSB up (i.e. right to left)
				               IF read_counter_reg <= ( ( ((2*my_types.matrix_size) - 1 ) - commit_count_reg) - 1 ) THEN
					   	--In this case we push another entry onto the BRAM word
                                                --and then increment the read counter
                                                memory_word_in_top( (memory_word_in_top'LENGTH - 1) DOWNTO my_types.bit_width) 
                                                <= memory_word_in_top_reg( ((memory_word_in_top'LENGTH - 1) - my_types.bit_width) DOWNTO 0);--shift the data
                                                --Push the new value onto the word
                                                memory_word_in_top( (my_types.bit_width - 1) DOWNTO 0 )
                                                <= val_reg;
                                                read_counter <= read_counter_reg + 1; --Increment the read counter
                                                ss_next <= read_data; rd0<='1'; --Read next data item.
                                        ELSE
						--Need to do it in the other direction in this case...
                                                ss_next <= word_ready; --Go to the state to collect the next memory value        
                                        END IF;
				ELSE 
					--We have finished packing the array and we can leave this state
					ss_next <= read_data1; rd1 <= '1';
				END IF;
	------------------------------------------------------
	WHEN word_ready => rd0 <='1';
                                memory_word_in_top <= default_entry; --Fill the entry with all p values for each segment
                                commit_count <= commit_count_reg + 1; --Update the commit count

                                IF (commit_count_reg + 1 <= (my_types.matrix_size - 1)) THEN
                                 --Push the first value into the BRAM word
                                	memory_word_in_top((memory_word_in_top'LENGTH - 1) DOWNTO (memory_word_in_top'LENGTH - my_types.bit_width))
                                        <= val_reg;
                                ELSE
                                 --Push the value in from the other direction
                                 	memory_word_in_top( (my_types.bit_width - 1) DOWNTO 0 )
                                  	<= val_reg;
                                END IF;

                                read_counter <= 1; --Reset the read counter back to one
				ss_next <= read_data;

				REPORT  "TOP: " &--INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in_top(15 DOWNTO 12)))) & " " &
                                        INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in_top_reg(11 DOWNTO 8)))) & "  " 
                                      & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in_top_reg(7 DOWNTO 4)))) & "  " 
                                      & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in_top_reg(3 DOWNTO 0)))); 
	WHEN read_data1	=>
                       IF (vld1 = '1') THEN
                                val_temp <= data_in1((my_types.bit_width - 1) DOWNTO 0); --In this case we are not using the full 128 bits
                                ss_next <= pack_and_commit1; 
                        ELSE
                                ss_next <= read_data1;
                        END IF; 

	WHEN pack_and_commit1 => 
                                IF commit_count_reg1 <= (my_types.matrix_size - 1) THEN
                                        --Here we pack the values in from the MSB down (i.e. left to right)
                                        IF read_counter_reg1 <= commit_count_reg1 THEN
                                                --In this case we push another entry onto the BRAM word
                                                --and then increment the read counter
                                                memory_word_in_left( ((memory_word_in_left'LENGTH - 1) - my_types.bit_width) DOWNTO 0)
                                                <= memory_word_in_left_reg((memory_word_in_left'LENGTH - 1) DOWNTO my_types.bit_width); --shift the data
                                                --Push the new value onto the word
                                                memory_word_in_left((memory_word_in_left'LENGTH - 1)DOWNTO(memory_word_in_left'LENGTH - my_types.bit_width))
                                                <= val_reg;
                                                read_counter1 <= read_counter_reg1 + 1; --Increment the read counter
                                                ss_next <= read_data1; rd1<='1'; --Read next data item.
                                        ELSE
                                                ss_next <= word_ready1; --Go to the state to collect the next memory value       
                                        END IF;

                                ELSIF commit_count_reg1 < (2*my_types.matrix_size - 1) THEN
                                        --Here we pack the values from the LSB up (i.e. right to left)
                                               IF read_counter_reg1 <= ( ( ((2*my_types.matrix_size) - 1 ) - commit_count_reg1) - 1 ) THEN
                                                --In this case we push another entry onto the BRAM word
                                                --and then increment the read counter
                                                memory_word_in_left( (memory_word_in_left'LENGTH - 1) DOWNTO my_types.bit_width)
                                                <= memory_word_in_left_reg(((memory_word_in_left'LENGTH -1) - my_types.bit_width)DOWNTO 0);--shift the data
                                                --Push the new value onto the word
                                                memory_word_in_left( (my_types.bit_width -1) DOWNTO 0 )
                                                <= val_reg;
                                                read_counter1 <= read_counter_reg1 + 1; --Increment the read counter
                                                ss_next <= read_data1; rd1<='1'; --Read next data item.
                                        ELSE
                                                --Need to do it in the other direction in this case...
                                                ss_next <= word_ready1; --Go to the state to collect the next memory value        
                                        END IF;
                                ELSE
                                        --We have finished packing the array and we can leave this state
                                        ss_next <= test3;
                                END IF;
        ------------------------------------------------------
	WHEN word_ready1 => rd1 <='1';
                                memory_word_in_left <= default_entry; --Fill the entry with all p values for each segment
                                commit_count1 <= commit_count_reg1 + 1; --Update the commit count

                                IF (commit_count_reg1 + 1 <= (my_types.matrix_size - 1)) THEN
                                 --Push the first value into the BRAM word
                                        memory_word_in_left((memory_word_in_left'LENGTH - 1) DOWNTO (memory_word_in_left'LENGTH - my_types.bit_width))
                                        <= val_reg;
                                ELSE
                                 --Push the value in from the other direction
                                        memory_word_in_left( (my_types.bit_width - 1) DOWNTO 0 )
                                        <= val_reg;
                                END IF;

                                read_counter1 <= 1; --Reset the read counter back to one
                                ss_next <= read_data1;

                                REPORT  "LEFT: " &--INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in_top(15 DOWNTO 12)))) & " " &
                                        INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in_left_reg(11 DOWNTO 8)))) & "  "
                                      & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in_left_reg(7 DOWNTO 4)))) & "  "
                                      & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in_left_reg(3 DOWNTO 0))));


	WHEN test3 => ss_next <= Sload; --REPORT "Temp test state."
	WHEN Sload =>
		IF (full0= '0') THEN 					 		--output data if controler ready
			--REPORT "Writing out data";
			wr0 <= '1';							--initiate write 
			data_out0(my_types.bit_width-1 DOWNTO 0) <= STD_LOGIC_VECTOR(val_reg);--STD_LOGIC_VECTOR(count);--write out the current count
			count_next <= count+TO_UNSIGNED(1,DATA_WIDTH); --increase the data
			ss_next <= Sload;
		ELSE
			ss_next <= Sload; --REPORT "Waiting to write data"; 
		END IF;
	WHEN OTHERS =>
		ss_next <= read_config; --should never execute
END CASE;		
END PROCESS STATE_PROC;


SS_PROC: --state update and syncronous reset process
PROCESS 
BEGIN
	WAIT UNTIL clk'EVENT AND clk='1';
		ss <= ss_next;				--update state
		count <= count_next;		--update count
		val_reg <= val_temp;
		expo_reg <= expo;

		--BANK ZERO
		read_counter_reg <= read_counter; --register for counting the number of reads that have been performed inbetween a BRAM word commit.
		commit_count_reg <= commit_count; --register used to keep track of the total number of commits that have been made to BRAM

		--BANK ONE
		read_counter_reg1 <= read_counter1;
		commit_count_reg1 <= commit_count1;
			
		memory_word_in_top_reg <= memory_word_in_top; --register used to keep the current partial word created to be commited to BRAM	
		memory_word_in_left_reg <= memory_word_in_left;

	IF reset = '1' THEN
		ss <= read_config; 				--sync reset state
		expo_reg <= (OTHERS => '0');
		count <= TO_UNSIGNED(0, DATA_WIDTH);
		read_counter_reg <= 0; --Default all the counters to zero
		commit_count_reg <= 0;
		read_counter_reg1 <= 0;
		commit_count_reg1 <= 0;
		memory_word_in_top_reg <= default_entry; --Fill each segment with the reset value.
		memory_word_in_left_reg <= default_entry;
	END IF;
END PROCESS SS_PROC;

END ARCHITECTURE rtl;
