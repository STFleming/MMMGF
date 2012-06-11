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
		clk 	: in std_logic;
		reset 	: in std_logic;
		fullm 	: in std_logic;			--'0' indicates the memory interface is ready for a write
		wr	: out std_logic;		--assert '1' to write a word to the fifo
		data_out : out std_logic_vector(DATA_WIDTH-1 DOWNTO 0);	--external memory data bus
		data_in	: in std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
		vldm	: in std_logic;	-- This is used to tell when data is ready to be read
		rdm	: out std_logic
);
end axel_interface_ent;

ARCHITECTURE rtl of axel_interface_ent IS
TYPE Tstate IS (read_config, Sload, read_data, pack_and_commit, test3); --posible states
SIGNAL ss, ss_next 				: Tstate; --state signals
SIGNAL val_reg, val_temp 			: UNSIGNED (DATA_WIDTH-1 DOWNTO 0); --This is a temp storage for the read value
SIGNAL count, count_next 			: UNSIGNED (DATA_WIDTH-1 DOWNTO 0);
SIGNAL expo, expo_reg	 			: UNSIGNED (DATA_WIDTH-1 DOWNTO 0); --Stores the exponent of the operation
SIGNAL read_counter, read_counter_reg		: INTEGER; --These are used to count the number of BRAM entries that have already been committed 0 - 2N 
SIGNAL memory_word_in, memory_word_in_reg	: BRAM_word_width; --These signals are used to send each ram entry to the BRAMs 
SIGNAL commit_count, commit_count_reg		: INTEGER; --Used to keep track of what point a word is ready to be committed. 

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
PROCESS(ss, fullm, count, data_in, vldm, val_reg)
BEGIN

--------------------------DEFAULT VALUES!------------------------------------
wr <= '0'; rdm <= '0';				--default no write 
data_out <= (OTHERS => '0');	--default clear data
count_next <= count;			--default retain count
val_temp <= val_reg; --Default is the register value
expo <= expo_reg;
read_counter <= read_counter_reg;
commit_count <= commit_count_reg;
memory_word_in <= memory_word_in_reg;
-----------------------------------------------------------------------------

CASE ss is
	-------------READ CONFIG & IDLE STATE----------------
	--This state is the resting state of the device 
	--It waits for the first read available signal and then loads in the
	--config data. Once this has occurred it then moves into the state required
	--to read in the matrix data.	
	WHEN read_config =>
		IF (vldm = '1') THEN
			expo <= UNSIGNED(data_in); --Load in the exponent data from the memory bank
			rdm <= '1';
			ss_next <= read_data;
			--REPORT "Read config data!";
		ELSE
			ss_next <= read_config;
			--REPORT "Waiting for config data.";
		END IF;
	-----------------------------------------------------	

	---------------READ DATA & PACK THE DATA-------------
	--This state gets data from the host and packs it together into
	--one single BRAM entry. This is more complicated than it sounds
	--since the BRAM entries need to be staggered with reset signals.
	--For this reason two counters are required to keep track of where
	--we are.
	WHEN read_data => --Read in the data in this state
			IF (vldm = '1') THEN
				val_temp <= UNSIGNED(data_in) + 10;
				ss_next <= pack_and_commit;
			ELSE
				ss_next <= read_data;
			END IF;

	
	WHEN pack_and_commit => 
				ss_next <= test3; rdm<='1'; 
				memory_word_in <= default_entry; --fill it with the default value 
				REPORT "BRAM default:  " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(memory_word_in)));
	------------------------------------------------------

	WHEN test3 => ss_next <= Sload; --REPORT "Temp test state.";
	WHEN Sload =>
		IF (fullm = '0') THEN 					 		--output data if controler ready
			--REPORT "Writing out data";
			wr <= '1';							--initiate write 
			data_out <= STD_LOGIC_VECTOR(val_reg);--STD_LOGIC_VECTOR(count);--write out the current count
			count_next <= count+TO_UNSIGNED(1,DATA_WIDTH); --increase the data
			ss_next <= read_data;
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

		read_counter_reg <= read_counter; --register for counting the number of reads that have been performed inbetween a BRAM word commit.
		commit_count_reg <= commit_count; --register used to keep track of the total number of commits that have been made to BRAM		
		memory_word_in_reg <= memory_word_in; --register used to keep the current partial word created to be commited to BRAM	
	

	IF reset = '1' THEN
		ss <= read_config; 				--sync reset state
		expo_reg <= (OTHERS => '0');
		count <= TO_UNSIGNED(0, DATA_WIDTH);
		read_counter_reg <= 0; --Default all the counters to zero
		commit_count_reg <= 0;
		memory_word_in_reg <= (OTHERS => '0');
	END IF;
END PROCESS SS_PROC;

END ARCHITECTURE rtl;
