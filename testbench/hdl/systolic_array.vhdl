--Systolic Array implementation, creates a grid of n-by-n processing elements.
--Created by Shane Fleming as part of his masters thesis

--#####################################################
-- Package for input wire types
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

PACKAGE my_types IS
	CONSTANT matrix_size:INTEGER:=135;
	CONSTANT field_size:INTEGER:=2;
	CONSTANT bit_width   : INTEGER := INTEGER(CEIL(LOG2(REAL(field_size+1))));
        TYPE Input_Wires IS ARRAY ( matrix_size DOWNTO 1 )OF STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
	SUBTYPE BRAM_word_width IS STD_LOGIC_VECTOR((matrix_size*bit_width)-1 DOWNTO 0); --type for the BRAM word
END PACKAGE my_types;
------------------------------------------------------

------------------Libraries-----------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;
use IEEE.math_real.all;

LIBRARY work;
USE work.ALL;
USE work.my_types.ALL;
--------------------------------------------------------

--#####################################################
--ENTITY DECLARATION
--#####################################################
ENTITY SA_ent IS
--Since this is a testbench there is no port mappings
--Generic mapping
GENERIC(matrix_size             :       INTEGER:= 2;
        field_size              :       INTEGER:= 7 );
		  
PORT(	clk 		   		: 	IN STD_LOGIC;
	   TopArray 			: 	IN Input_Wires;
	   LeftArray 			: 	IN Input_Wires;
	   ResultArrayTop		:	OUT Input_Wires;
	   ResultArrayLeft	        :	OUT Input_Wires
	);

END SA_ent;
--#####################################################

--#####################################################
-- Systolic Array ARCHITECTURE
--#####################################################
ARCHITECTURE SA_behav OF SA_ent IS

---------------------------------
--	Signal Declarations
---------------------------------
CONSTANT        RESET_VALUE             :       STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0) :=
                                                                            STD_LOGIC_VECTOR(TO_UNSIGNED(field_size, bit_width));


 TYPE	sub_PE_Wires IS ARRAY (matrix_size DOWNTO 0) OF STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
 TYPE sub_PU_Wires IS ARRAY (matrix_size+1 DOWNTO 0) OF STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
 TYPE PE_Wires IS ARRAY (matrix_size DOWNTO 0) OF sub_PE_Wires;
 TYPE PU_Wires IS ARRAY (matrix_size DOWNTO 0) OF sub_PU_Wires;
 --TYPE PE_Wires IS ARRAY ( matrix_size DOWNTO 0, (matrix_size) DOWNTO 0) OF STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
 --TYPE PU_Wires IS ARRAY ( matrix_size DOWNTO 0, (matrix_size+1) DOWNTO 0) OF STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
 SIGNAL X_PE_Wires : PE_Wires := (OTHERS=>(OTHERS=>(OTHERS=>'0'))); --The x-direction of wires used to connect top_in and bottom_out of each PE
 SIGNAL PU_PE_Wires : PU_Wires:= (OTHERS=>(OTHERS=>(OTHERS=>'0'))); --This is the array of wires used for the pass up value.
 SIGNAL PA_PE_Wires : PU_Wires := (OTHERS=>(OTHERS=>(OTHERS=>'0'))); --This is the array out wires for passing the output across
 SIGNAL Y_PE_Wires : PE_Wires := (OTHERS=>(OTHERS=>(OTHERS=>'0'))); --The y-direction of wires used to connect left_in and right_out of each PE


 SIGNAL test_RESET_SIGNAL	:	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
 ATTRIBUTE KEEP : STRING;
 ATTRIBUTE KEEP OF test_RESET_SIGNAL : SIGNAL IS "TRUE";

---------------------------------
             BEGIN
---------------------------------
test_RESET_SIGNAL <= STD_LOGIC_VECTOR(TO_UNSIGNED(field_size, bit_width));
------------------------------------------
--Instantiate Processing Element Entities
------------------------------------------
--Processing element port mapping
-- (clk, left_in, top_in, right_out, bottom_out, pass_up_in, pass_up_out)
------
   UNROLL_X : FOR x IN 1 TO matrix_size GENERATE
            UNROLL_Y : FOR y IN 1 TO matrix_size GENERATE
				
						LEFT_EDGE : IF x = 1 AND y > 1 AND y < matrix_size GENERATE 
                         PROC_ELE_LEFT  : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
                                                    PORT MAP  ( clk=>clk,
                                                                left_in=>LeftArray(y),
                                                                top_in=>Y_PE_Wires(x)(y-1),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>PU_PE_Wires(x)(y+1),
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=>PA_PE_Wires(x+1)(y),
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
						END GENERATE LEFT_EDGE;
						
						STANDARD : IF x > 1 AND y > 1 AND y < matrix_size AND x < matrix_size GENERATE
									PROC_ELE  : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
                                                    PORT MAP  ( clk=>clk,
                                                                left_in=>X_PE_Wires(x-1)(y),
                                                                top_in=>Y_PE_Wires(x)(y-1),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>PU_PE_Wires(x)(y+1),
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=>PA_PE_Wires(x+1)(y),
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
					   END GENERATE STANDARD;

						TOP_EDGE : IF y = 1  AND x > 1 AND x < matrix_size GENERATE
									PROC_ELE_BOTTOM  : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
                                                    PORT MAP  ( clk=>clk,
                                                                left_in=>X_PE_Wires(x-1)(y),
                                                                top_in=>TopArray(x),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>PU_PE_Wires(x)(y+1),
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=>PA_PE_Wires(x+1)(y),
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
						END GENERATE TOP_EDGE;

						RIGHT_EDGE : IF x = matrix_size AND y > 1 AND y < matrix_size GENERATE
									PROCE_ELE_RIGHT : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
																    PORT MAP  ( clk=>clk,
                                                                left_in=>X_PE_Wires(x-1)(y),
                                                                top_in=>Y_PE_Wires(x)(y-1),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>PU_PE_Wires(x)(y+1),
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=> RESET_VALUE,
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
						END GENERATE RIGHT_EDGE;
						
						TOP_RIGHT_CORNER : IF x = matrix_size AND y = 1 GENERATE
									PROCE_ELE_TOP_RIGHT : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
														          PORT MAP  ( clk=>clk,
                                                                left_in=>X_PE_Wires(x-1)(y),
                                                                top_in=>TopArray(x),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>PU_PE_Wires(x)(y+1),
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=> RESET_VALUE,
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
					   END GENERATE TOP_RIGHT_CORNER;

						TOP_CORNER : IF y = 1  AND x = 1 GENERATE
									PROC_ELE_CORNER  : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
                                                    PORT MAP  ( clk=>clk,
                                                                left_in=>LeftArray(1),
                                                                top_in=>TopArray(1),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>PU_PE_Wires(x)(y+1),
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=>PA_PE_Wires(x+1)(y),
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
						END GENERATE TOP_CORNER;
																				 
						BOTTOM_EDGE : IF x > 1 AND y = matrix_size AND x < matrix_size GENERATE
									PROC_ELE_CORNER  : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
                                                    PORT MAP  ( clk=>clk,
                                                                left_in=>X_PE_Wires(x-1)(y),
                                                                top_in=>Y_PE_Wires(x)(y-1),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>RESET_VALUE,
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=>PA_PE_Wires(x+1)(y),
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
						END GENERATE BOTTOM_EDGE;

						BOTTOM_LEFT_CORNER : IF x = 1 AND y = matrix_size GENERATE
									PROC_ELE_LEFT_CORNER  : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
                                                    PORT MAP  ( clk=>clk,
                                                                left_in=>LeftArray(y),
                                                                top_in=>Y_PE_Wires(x)(y-1),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>RESET_VALUE,
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=>PA_PE_Wires(x+1)(y),
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
						END GENERATE BOTTOM_LEFT_CORNER;
						
						BOTTOM_RIGHT_CORNER : IF x = matrix_size AND y = matrix_size GENERATE
									PROC_ELE_RIGHT_CORNER  : ENTITY PE_ent GENERIC MAP (bit_width, field_size)
                                                    PORT MAP  ( clk=>clk,
                                                                left_in=>X_PE_Wires(x-1)(y),
                                                                top_in=>Y_PE_Wires(x)(y-1),
                                                                right_out=>X_PE_Wires(x)(y),
                                                                bottom_out=>Y_PE_Wires(x)(y),
                                                                pass_up_in=>RESET_VALUE,
                                                                pass_up_out=>PU_PE_Wires(x)(y),
																					 pass_across_in=> RESET_VALUE,
																					 pass_across_out=>PA_PE_Wires(x)(y)
                                                              );
						END GENERATE BOTTOM_RIGHT_CORNER;


                       END GENERATE UNROLL_Y;
           END GENERATE UNROLL_X;
------------------------------------------

--Feed the input data in TopArray and LeftArray into the edges of the SA
MAP_TO_IO : PROCESS(LeftArray, TopArray, PU_PE_Wires, PA_PE_Wires)
BEGIN 
	FOR k IN 1 TO matrix_size LOOP
			--X_PE_Wires(0)(k) <= LeftArray(k);
			--Y_PE_Wires(k)(0) <= TopArray(k); --Try creating a right edge GENERATE and a TOP EDGE GENERATE to remove this process
			ResultArrayTop(k) <= PU_PE_Wires(k)(1);
			ResultArrayLeft(k) <= PA_PE_Wires(1)(k); --Get the across outputs
	END LOOP;
END PROCESS MAP_TO_IO;

---------------------------------
	END SA_behav;
---------------------------------
--####################################################################
