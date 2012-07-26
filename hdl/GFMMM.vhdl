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
        GENERIC(        matrix_size             :       INTEGER:= my_types.matrix_size;
                        field_size              :       INTEGER:= my_types.field_size);

        PORT(           clk                             :       IN              STD_LOGIC;
                                op                   	:       IN              STD_LOGIC;
				write_word		:	IN		STD_LOGIC;
                                data_out	        :       OUT     	BRAM_word_width;
                                data_in               	:       IN              BRAM_word_width
                                );

END GFMMM_ent;
--###################################################


--#####################################################
--ARCHITECTURE DECLARATION
--#####################################################
ARCHITECTURE GFMMM_behav OF GFMMM_ent IS
SIGNAL TopArray                         :       Input_Wires := (OTHERS=>(OTHERS=>'0'));
SIGNAL LeftArray                        :       Input_Wires := (OTHERS=>(OTHERS=>'0'));

--------------------------------------------------------
                       BEGIN
--------------------------------------------------------
fetch_data_from_axel	:	PROCESS(write_word, data_in)
BEGIN
	IF (write_word = '1') THEN
                FOR i IN 0 TO matrix_size-1 LOOP
                    --REPORT "Inside: " &  INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_in((((i*bit_width) + bit_width)-1) DOWNTO (i*bit_width)))));
                END LOOP;
	
	END IF;
END PROCESS fetch_data_from_axel;

--------------------------------------------------------
                  END GFMMM_behav;
--------------------------------------------------------
