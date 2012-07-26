
--This file instantiates the Systolic Array, Surrounding block RAMS,
--and control multiplexors.
--
--Created by Shane Fleming as part of his masters thesis

------------------Libraries-----------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;
use IEEE.math_real.all;
USE IEEE.std_logic_misc.ALL;

LIBRARY work;
USE work.my_types.ALL;
USE work.ALL;
--------------------------------------------------------

--#####################################################
--ENTITY DECLARATION
--#####################################################
ENTITY GFMMM_ent IS
--Since this is a testbench there is no port mappings
--Generic mapping
	GENERIC(	matrix_size		:      	INTEGER:= my_types.matrix_size;
			field_size		:	INTEGER:= my_types.field_size);
				
	PORT(	 	clk 				:	IN		STD_LOGIC;
				cntrl				:	IN		STD_LOGIC;
				dummy_out		:	OUT	STD_LOGIC;
				start_bit		:	IN		STD_LOGIC
				);
				
END GFMMM_ent;
--#####################################################


--#####################################################
--ARCHITECTURE DECLARATION
--#####################################################
ARCHITECTURE GFMMM_behav OF GFMMM_ent IS

CONSTANT bit_width   : INTEGER := INTEGER(CEIL(LOG2(REAL(field_size+1))));
SIGNAL S_Update		: STD_LOGIC;

--Define all the wires that interface with ... THE GRID!!!
SIGNAL TopArray 			: 	Input_Wires := (OTHERS=>(OTHERS=>'0'));
SIGNAL LeftArray 			:	Input_Wires := (OTHERS=>(OTHERS=>'0'));
SIGNAL ResultArrayTop			:	Input_Wires := (OTHERS=>(OTHERS=>'0'));
SIGNAL ResultArrayLeft			:	Input_Wires := (OTHERS=>(OTHERS=>'0'));

SIGNAL X_we 									:	STD_LOGIC; --Write enable signals for the block rams
SIGNAL addr_in_reg, addr_in				:	INTEGER := 0; --address for all the block rams
SIGNAL addr_out_reg, addr_out				:	INTEGER := 0;
SIGNAL X_data_in, X_data_out				:	BRAM_word_width; --I/O for X block RAM
SIGNAL topS_data_in, topS_data_out			:	BRAM_word_width; --I/O for top S block RAM
SIGNAL leftS_data_in, leftS_data_out			:	BRAM_word_width; --I/O for left S block RAM

--------------------------------------------------------
						   BEGIN
--------------------------------------------------------
--Instantiate the systolic array
THE_GRID : ENTITY SA_ent GENERIC MAP	( matrix_size, field_size)
								 PORT MAP 		( clk=>clk,
													  TopArray=>TopArray,
													  LeftArray=>LeftArray,
													  ResultArrayTop=>ResultArrayTop,
													  ResultArrayLeft=>ResultArrayLeft );
												
MAT_X	:  ENTITY bram_ent GENERIC MAP	( matrix_size, bit_width)
								 PORT MAP		( clk => clk,
													  w_e => X_we,
													  addr_in => addr_in,
													  addr_out => addr_out,
													  input_data => X_data_in,
													  output_data => X_data_out	);
													  
TOP_S : ENTITY bram_ent  GENERIC MAP	( matrix_size, bit_width)			
								 PORT MAP		(	clk => clk,
														w_e => S_Update,
														addr_in => addr_in,
														addr_out => addr_out,
														input_data => topS_data_in,
														output_data => topS_data_out	);
													
LEFT_S : ENTITY bram_ent GENERIC MAP 	( matrix_size, bit_width)
								 PORT MAP		(	clk => clk,
														w_e => S_Update,
   													addr_in => addr_in,
														addr_out => addr_out,
														input_data => leftS_data_in,
														output_data => leftS_data_out	);
													  
--Process that updates the data that is being fed into the BRAMs
update_RAM_data_in	:	PROCESS(ResultArrayTop, ResultArrayLeft, start_bit, cntrl)
BEGIN
	IF start_bit = '1' THEN
	   IF cntrl='1' THEN
			X_we <= '1';
		ELSE
			X_we <= '0';
		END IF;
		
		S_Update <= '1';
		
		FOR i IN 0 TO matrix_size-1 LOOP
				X_data_in((((i*bit_width) + bit_width)-1) DOWNTO (i*bit_width)) <= ResultArrayTop(i+1);
				--Always update the S values
				topS_data_in((((i*bit_width) + bit_width)-1) DOWNTO (i*bit_width)) <= ResultArrayTop(i+1);
				leftS_data_in((((i*bit_width) + bit_width)-1) DOWNTO (i*bit_width)) <= ResultArrayLeft(i+1);		
		END LOOP;
	ELSE
			S_Update <= '0';
			X_we <= '0';
			
			X_data_in <= (OTHERS=>'0');
			topS_data_in <= (OTHERS=>'0');
			leftS_data_in <= (OTHERS=>'0');
	END IF;
END PROCESS update_RAM_data_in;

--Process that updates the BRAM address so that it acts like a circular buffer.
update_RAM_addr	:	PROCESS(clk)

BEGIN
	IF (clk='1' AND clk'event) THEN
		IF start_bit = '1' THEN
				IF (addr_out = ((2*matrix_size)-1) ) THEN
					addr_out_reg <= 0;
				ELSE
					addr_out_reg <= addr_out_reg + 1; --increment the BRAM address
				END IF;
				
				IF (addr_in = ((2*matrix_size)-1)) THEN
					addr_in_reg <= 0;
				ELSE
					addr_in_reg <= addr_in_reg + 1; --increment the output address
				END IF;
		ELSE
				addr_out_reg <= 0;
				addr_in_reg <= ((2*matrix_size)-1);
		END IF;
	END IF;
END PROCESS update_RAM_addr;

--Assign the addr signal with the register value
addr_in <= addr_in_reg;
addr_out <= addr_out_reg;

--Feeds the systolic array with the outputs from the block RAMs
feed_the_grid : PROCESS (leftS_data_out, topS_data_out, X_data_out)
BEGIN

			FOR k IN 0 TO matrix_size-1 LOOP
				IF start_bit = '1' THEN
					IF cntrl = '1' THEN
						TopArray(k+1) <= X_data_out((((k*bit_width) + bit_width)-1) DOWNTO (k*bit_width));
					ELSE
						TopArray(k+1) <= topS_data_out((((k*bit_width) + bit_width)-1) DOWNTO (k*bit_width));
					END IF;
					
					LeftArray(k+1) <= leftS_data_out((((k*bit_width) + bit_width)-1) DOWNTO (k*bit_width));
				ELSE
					TopArray(k+1) <= (OTHERS=>'0');
					LeftArray(k+1) <= (OTHERS=>'0');
				END IF;
			END LOOP;

END PROCESS feed_the_grid;


--------------------------------------------------------
						END GFMMM_behav;
--------------------------------------------------------
