--test entity for getting data communication working

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY work;
USE work.my_types.ALL;
USE work.ALL;

entity axel_interface_ent is
generic (
                        DATA_WIDTH : integer := 128 --width of memory data bus (bits), it must be greater or equal than the bin depth 
                );
port (
                clk             : in std_logic;
                reset           : in std_logic;

                --First Memory Bank----------------------- BANK ZERO
                full0           : in std_logic;                 --'0' indicates the memory interface is ready for a write
                wr0             : out std_logic;                --assert '1' to write a word to the fifo
                data_out0       : out std_logic_vector(DATA_WIDTH-1 DOWNTO 0);  --external memory data bus
                data_in0        : in std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
                vld0            : in std_logic; -- This is used to tell when data is ready to be read
                rd0             : out std_logic;

                --Second Memory Bank---------------------  BANK ONE
                full1           : in std_logic;
                wr1             : out std_logic;
                data_out1       : out std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
                data_in1        : in std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
                vld1            : in std_logic;
                rd1             : out std_logic
);
END axel_interface_ent;

ARCHITECTURE rtl of axel_interface_ent IS

TYPE Tstate IS
(start_state, read_bank0, read_bank1, process_state, write_state, final_state); --posible states
SIGNAL ss, ss_next                                      : Tstate; --state signals

SIGNAL count, count_next                                : INTEGER;

BEGIN

--This architecture contains a FSM for the communication of data between the device and the host

STATE_PROC: --Combinitorial state update and output process
PROCESS(ss, full0, count, data_in0, vld0, vld1, full1, data_in1)
BEGIN
--------------------------DEFAULT VALUES!------------------------------------
wr0 <= '0'; rd0 <= '0';                         --default no write
wr1 <= '0'; rd1 <= '0';

data_out0 <= (OTHERS => '0');   --default clear data
data_out1 <= (OTHERS => '0');

count_next <= count;                    --default retain count
-----------------------------------------------------------------------------

CASE ss IS
	WHEN start_state => 	IF vld0 = '1' THEN
					ss_next <= read_bank0;
			  	END IF;

	WHEN read_bank0 => 	IF vld0 = '1' THEN
					ss_next <= read_bank1; 
					REPORT "Bank0: " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_in0))); -- report the data read @ Bank0
					rd1 <= '1'; --Request a read for bank1
					count_next <= count + 1; --Update the data counter
				END IF;

	WHEN read_bank1 => 	IF vld1 = '1' THEN 
					REPORT "Bank1: " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(data_in1))); --report the data read @ bank1
					rd0<='1';
					count_next <= count + 1;
					IF count < 18 THEN
						ss_next <= read_bank0;
					ELSE
						ss_next <= process_state;
					END IF;
				END IF;

	WHEN process_state => 
				count_next <= count + 1;
				IF count < 40 THEN
					ss_next <= process_state;
				ELSE
					ss_next <= write_state;
				END IF;

	WHEN write_state => 	
				IF (full0 = '0') THEN
					wr0 <= '1';
					data_out0 <= STD_LOGIC_VECTOR(TO_UNSIGNED(count, DATA_WIDTH));
					count_next <= count + 1;
				END IF;
				
				IF (count < 50) THEN
					ss_next <= write_state;
				ELSE
					ss_next <= final_state;
				END IF;
 
	WHEN final_state => ss_next <= final_state; 
	WHEN OTHERS => ss_next <= start_state; 
END CASE;

END PROCESS STATE_PROC;

SS_PROC: --state update and syncronous reset process
PROCESS
BEGIN

	WAIT UNTIL clk'EVENT AND clk='1';
	ss <= ss_next; 
	count <= count_next;	

	IF reset = '1' THEN
		ss <= start_state; 
		count <= 0;
	END IF;

END PROCESS SS_PROC;


END ARCHITECTURE rtl;

