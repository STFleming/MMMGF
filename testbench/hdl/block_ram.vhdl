
--TThis file contains a block ram for use in a systolic array
--
--Created by Shane Fleming as part of his masters thesis

------------------Libraries-----------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;
use IEEE.math_real.all;

LIBRARY work;
USE work.my_types.ALL;
USE work.ALL;
--------------------------------------------------------

--#####################################################
--ENTITY DECLARATION
--#####################################################
ENTITY bram_ent IS
--Since this is a testbench there is no port mappings
--Generic mapping
	GENERIC(	matrix_size		:      	INTEGER:= 2;
				bit_width		:			INTEGER:= 3 );
				
	PORT(	 	clk 				:	IN		STD_LOGIC;
				w_e			:	IN		STD_LOGIC; --Write enable input
				addr_in			:	IN		INTEGER; --Address for the BRAM
				addr_out		:	IN		INTEGER;
				input_data		:	IN		BRAM_word_width;
				output_data		:	OUT		BRAM_word_width	);
				
END bram_ent;
--#####################################################


--#####################################################
--ARCHITECTURE DECLARATION
--#####################################################
ARCHITECTURE bram_behav OF bram_ent IS

TYPE ram_type IS ARRAY (0 TO (2*matrix_size)-1) OF BRAM_word_width;
SIGNAL ram : ram_type := (OTHERS=>(OTHERS=>'0'));

--------------------------------------------------------
						   BEGIN
--------------------------------------------------------
read_write_proc : PROCESS(clk)
BEGIN
	IF clk='1' AND clk'event THEN
			IF (w_e = '1') THEN
				ram(addr_in) <= input_data;
			END IF;
			output_data <= ram(addr_out);
	END IF;
END PROCESS read_write_proc;
--------------------------------------------------------
						END bram_behav;
--------------------------------------------------------
