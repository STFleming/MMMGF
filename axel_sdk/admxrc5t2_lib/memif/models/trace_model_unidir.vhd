--
-- trace_model_unidir.vhd - Simple model of a unidirectional delay
--
-- NOT SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

entity trace_model_unidir is
    generic(
        delay           : in    time);
    port(
        a               : in    std_logic;
        b               : out   std_logic);
end entity;

architecture behav of trace_model_unidir is

begin

    b <= transport a after delay;

end architecture;
