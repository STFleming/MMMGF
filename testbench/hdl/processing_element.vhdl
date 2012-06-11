--Processing element VHDL architecture by Shane Fleming
--	This file contains an entity that is the building block of a processing element
--	for the systolic array architecture used to implement fast matrix-matrix multiplication
--	over finite fields.

--It is part of a thesis for electronic & information engineering at imperial college london.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.ALL;

--Define the entity for the processing element here.
ENTITY PE_ent IS

--Need to include generic parameters to adjust how processing is done in code body
GENERIC	(
		bit_width : INTEGER := 2; --This is bit width of the system is set
		field_size : INTEGER := 7 --This is the numerical size of the field GF(field_size)
	);

--include the port mappings
PORT	(
		clk	 :	 IN STD_LOGIC; --The clock input for this module

		--The Process Elements inputs
		left_in	 :	 IN STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0); --The two inputs to the PE, the size of the finite field
		top_in	 :	 IN STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
		--The Process Elements outputs
		right_out	:	OUT STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
		bottom_out	:	OUT STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
		--Wires for passing the answer out to the top
		pass_up_in		:	IN	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
		pass_up_out	:	OUT 	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
		--Wires for passing the answer out to the left
		pass_across_in	:	IN STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
		pass_across_out : OUT STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0)
	);

END PE_ent;

--Define the architecture for the entity here.  
ARCHITECTURE PE_behav OF PE_ent IS
--define the implementation of the processing element.

SIGNAL running_sum      :       	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0); --This variable is used to keep track of the running sum.
SIGNAL bottom_out_reg	:			STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
SIGNAL right_out_reg		:			STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
SIGNAL pass_up_in_reg	:			STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
SIGNAL pass_across_in_reg : 		STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);

SIGNAL combined_in_mult       :       STD_LOGIC_VECTOR((2*bit_width) -1 DOWNTO 0); --This contains the concatenated inputs
SIGNAL combined_in_add        :       STD_LOGIC_VECTOR((2*bit_width) -1 DOWNTO 0); --This contains the concatenated inputs
SIGNAL GF_mult                :       STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
SIGNAL add_result	      		:	     STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);

CONSTANT ROM_SIZE	:	INTEGER	:= TO_INTEGER(UNSIGNED(STD_LOGIC_VECTOR(TO_UNSIGNED(field_size, bit_width)) 
					   & STD_LOGIC_VECTOR(TO_UNSIGNED(field_size, bit_width)))); 
					--for a field_size x field_size LUT we need 2*field_size elements

--Define the ROM for the multiplication and addition Look up tables
TYPE ROM_TYPE IS ARRAY (0 TO ROM_SIZE) OF STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
SIGNAL MULT_ROM		:	ROM_TYPE;
SIGNAL ADD_ROM		:	ROM_TYPE;

-------------------------------------------------------------------------------
--Define functions for the processing element up here
--addition_calc caluclates the addition of two numbers modulo the finite field size 
--for the addition LUT
IMPURE FUNCTION addition_calc
			 (NUM_ONE, NUM_TWO	:	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0)) 
			 RETURN	INTEGER IS

CONSTANT ADD_TEMP	:	INTEGER 
			:=	TO_INTEGER(UNSIGNED(NUM_ONE)) + TO_INTEGER(UNSIGNED(NUM_TWO));
BEGIN
	IF ((TO_INTEGER(UNSIGNED(NUM_ONE)) = field_size) OR (TO_INTEGER(UNSIGNED(NUM_TWO)) = field_size)) THEN
		RETURN 0; --reset to zero if the reset signal is seen
	ELSE
		RETURN (ADD_TEMP MOD field_size); --Other wise return the addition
	END IF;		
END FUNCTION addition_calc;

--Multiplication calculation for storage into Look Up Table
IMPURE FUNCTION multiply_calc
                         (NUM_ONE, NUM_TWO      :       STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0))
                         RETURN INTEGER IS

CONSTANT MULT_TEMP       :       INTEGER
                        :=      TO_INTEGER(UNSIGNED(NUM_ONE)) * TO_INTEGER(UNSIGNED(NUM_TWO));
BEGIN
IF ((TO_INTEGER(UNSIGNED(NUM_ONE)) = field_size) OR (TO_INTEGER(UNSIGNED(NUM_TWO)) = field_size)) THEN
        RETURN field_size; --reset to zero if the reset signal is seen
ELSE
        RETURN (MULT_TEMP MOD field_size); --Other wise return the addition
END IF;
END FUNCTION multiply_calc;
--------------------------------------------------------------------------------
BEGIN --Indicates the start of the VHDL processing
--The following statements are used to dynamically generate the field multiplication and addition LUTs at compile time
--------------------------------------------------------------------------------
GENROM:
	FOR i IN 0 TO ROM_SIZE GENERATE  
	CONSTANT FULL_ADDRESS   :  	STD_LOGIC_VECTOR((2*bit_width-1) DOWNTO 0)
	                        := 	STD_LOGIC_VECTOR(TO_UNSIGNED(i, (bit_width * 2)));--This converts i into a STD_LOGIC_VECTOR
	CONSTANT TOP_HALF	:	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0)
				:= 	FULL_ADDRESS((2*bit_width - 1) DOWNTO bit_width); --Extract the first half of i for the first number
	CONSTANT BOTTOM_HALF	:	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0)
				:=	FULL_ADDRESS((bit_width - 1) DOWNTO 0); --Extract the second half of the first address
			
	CONSTANT ADD_RESULT	: 	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0)
				:=	STD_LOGIC_VECTOR(TO_UNSIGNED(addition_calc(TOP_HALF, BOTTOM_HALF), bit_width));
	
	CONSTANT MULT_RESULT 	: 	STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0)
				:=	STD_LOGIC_VECTOR(TO_UNSIGNED(multiply_calc(TOP_HALF, BOTTOM_HALF), bit_width));

	BEGIN

		MULT_ROM(i) <= MULT_RESULT; --save the multiply result in the appropriate mem location
		ADD_ROM(i)  <= ADD_RESULT; --save the add result in the appropriate mem location
		
END GENERATE GENROM;


--Process Responsible for passing up the data
passing_data_up : PROCESS(running_sum, pass_up_in, left_in)
CONSTANT reset_value            :       STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0) :=
                                                                            STD_LOGIC_VECTOR(TO_UNSIGNED(field_size, bit_width));
BEGIN
               IF (left_in = reset_value) THEN
                    pass_up_out <= running_sum;
               ELSE
                    pass_up_out <= pass_up_in_reg;
               END IF;
END PROCESS passing_data_up;

--Process Responsible for passing across the data
passing_data_across : PROCESS(running_sum, pass_across_in, top_in)
CONSTANT reset_value            :       STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0) :=
                                                                            STD_LOGIC_VECTOR(TO_UNSIGNED(field_size, bit_width));
BEGIN
               IF (top_in = reset_value) THEN
                    pass_across_out <= running_sum;
               ELSE
						  pass_across_out <= pass_across_in_reg;
               END IF;
END PROCESS passing_data_across;

pass_values_reg : PROCESS(clk)
BEGIN
	IF clk='1' AND clk'EVENT THEN
		pass_across_in_reg <= pass_across_in;
		pass_up_in_reg <= pass_up_in;
	END IF;
END PROCESS pass_values_reg;
--Combinational Process for calculating the multiplication
GF_MULT_CALC : PROCESS(top_in, left_in, GF_mult, MULT_ROM, ADD_ROM, running_sum, combined_in_mult, combined_in_add)

BEGIN
        -----------------Calculate the GF multiplication----------------------------    
                combined_in_mult <= left_in & top_in;
                GF_mult <= MULT_ROM(TO_INTEGER(UNSIGNED(combined_in_mult)));
        ----------------------------------------------------------------------------

        ----------------Calculate the GF addition-----------------------------------
                combined_in_add <= GF_mult & running_sum;
					 add_result <= ADD_ROM(TO_INTEGER(UNSIGNED(combined_in_add)));
        ----------------------------------------------------------------------------
END PROCESS GF_MULT_CALC;

---------------------------------------------------------------------------------
RunningSum : PROCESS(clk) --Clocked process used to keep track of the running sum
--VARIABLE combined_in_mult   	:       STD_LOGIC_VECTOR((2*bit_width) -1 DOWNTO 0); --This contains the concatenated inputs
--VARIABLE combined_in_add       	:       STD_LOGIC_VECTOR((2*bit_width) -1 DOWNTO 0); --This contains the concatenated inputs
--VARIABLE GF_mult		:       STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0);
CONSTANT reset_value   	 	:       STD_LOGIC_VECTOR((bit_width-1) DOWNTO 0) :=
                                                                            STD_LOGIC_VECTOR(TO_UNSIGNED(field_size, bit_width));
BEGIN
        IF (clk'EVENT AND clk='1') THEN

--Variables are used in this process to ensure that it is using the current data for this clock cycle
		
        -----------------Calculate the GF multiplication----------------------------    
            --    combined_in_mult := left_in & top_in;
            --    GF_mult := MULT_ROM(TO_INTEGER(UNSIGNED(combined_in_mult)));
        ----------------------------------------------------------------------------

        ----------------Calculate the GF addition-----------------------------------
            --    combined_in_add := GF_mult & running_sum;
            --    running_sum <= ADD_ROM(TO_INTEGER(UNSIGNED(combined_in_add)));
        ----------------------------------------------------------------------------
	
		  running_sum <= add_result; --Put the result into the register.	
	
	----------------------------------------------------------------------------
        bottom_out_reg <= top_in;
        right_out_reg <= left_in;
	----------------------------------------------------------------------------

        ELSE
                --asynchronus processing goes here
        END IF;

END PROCESS RunningSum;
---------------------------------------------------------------------------------

bottom_out <= bottom_out_reg;
right_out <= right_out_reg;

END PE_behav;
