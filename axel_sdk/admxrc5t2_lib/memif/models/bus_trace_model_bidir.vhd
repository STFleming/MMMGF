--
-- bus_trace_model_unidir.vhd - model of a unidirectional bus with PCB trace delay
--
-- NOT SYNTHESIZABLE
--
-- VHDL lacks any construct for simulating a bidirectional delay line.
-- Therefore, we have to provide a 'reverse' input, and the delay model
-- is far from ideal.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

library work;
use work.memif_sim.all;

entity bus_trace_model_bidir is
    generic(
        delay           : in    time;
        width           : in    natural);
    port(
        drive_a         : in    std_logic;
        drive_b         : in    std_logic;
        a               : inout std_logic_vector(width - 1 downto 0);
        b               : inout std_logic_vector(width - 1 downto 0));
end entity;

architecture struct of bus_trace_model_bidir is

begin

    gen_inst : for i in 0 to width - 1 generate
        U0 : trace_model_bidir
            generic map(
                delay => delay)
            port map(
                drive_a => drive_a,
                drive_b => drive_b,
                a => a(i),
                b => b(i));
    end generate;

end architecture;
