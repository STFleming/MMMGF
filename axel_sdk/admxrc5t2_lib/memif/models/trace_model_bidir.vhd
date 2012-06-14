--
-- trace_model_bidir.vhd - Simple model of a bidirectional delay
--
-- NOT SYNTHESIZABLE
--
-- VHDL lacks any construct for simulating a bidirectional delay line.
-- Therefore, we have to provide a 'reverse' input, and the delay model
-- is far from ideal.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

entity trace_model_bidir is
    generic(
        delay           : in    time);
    port(
        drive_a         : in    std_logic;
        drive_b         : in    std_logic;
        a               : inout std_logic;
        b               : inout std_logic);
end entity;

architecture behav of trace_model_bidir is

    signal oe_a, oe_b : std_logic;

begin

    oe_a <= transport drive_a after delay;
    oe_b <= drive_b;

    to_a : process(oe_a, b)
    begin
        if oe_a = '1' then
            a <= transport b after delay;
        else
            a <= transport 'Z' after delay;
        end if;
    end process;

    to_b : process(oe_b, a)
    begin
        if oe_b = '1' then
            b <= transport a after delay;
        else
            b <= transport 'Z' after delay;
        end if;
    end process;

end architecture;
