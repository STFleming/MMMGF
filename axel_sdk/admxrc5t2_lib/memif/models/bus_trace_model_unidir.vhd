--
-- bus_trace_model_unidir.vhd - model of a unidirectional bus with PCB trace delay
--
-- NOT SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

library work;
use work.memif_sim.all;

entity bus_trace_model_unidir is
    generic(
        delay         : in    time;
        width         : in    natural);
    port(
        a             : in    std_logic_vector(width - 1 downto 0);
        b             : out   std_logic_vector(width - 1 downto 0));
end entity;

architecture struct of bus_trace_model_unidir is

begin

    gen_inst : for i in 0 to width - 1 generate
        U0 : trace_model_unidir
            generic map(
                delay => delay)
            port map(
                a => a(i),
                b => b(i));
    end generate;

end architecture;
