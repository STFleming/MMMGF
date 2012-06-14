-- reg.vhd
-- by Brittle 2009

library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
generic(
  w : positive := 32);
port (
  clk  : in  std_logic;
  ce   : in  std_logic;
  d    : in  std_logic_vector (w-1 downto 0);
  q    : out std_logic_vector (w-1 downto 0) );
end entity reg;

architecture behavior of reg is

begin


  process (clk)
  begin
    if rising_edge(clk) then
      if ce = '1' then
        q <= d;
      end if;
    end if;
  end process;

end architecture behavior;
