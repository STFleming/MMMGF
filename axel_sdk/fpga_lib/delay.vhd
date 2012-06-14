-- delay.vhdl
-- by Brittle 2009

library IEEE;
use IEEE.std_logic_1164.all;

entity delay is
generic(
  w : positive := 32;
  l : positive := 8);
port (
  clk  : in  std_logic;
  sclr : in  std_logic;
  ce   : in  std_logic;
  di   : in  std_logic_vector (w-1 downto 0);
  do   : out std_logic_vector (w-1 downto 0) );
end entity delay;

architecture behavior of delay is

  type reg_array is array(0 to w-1) of std_logic_vector(l-1 downto 0);
  signal delay : reg_array;

begin

  U_DLY: for i in w-1 downto 0 generate
  begin

    process (clk)
    begin
      if rising_edge(clk) then
        if sclr = '1' then
          delay(i) <= (others => '0');
        elsif ce = '1' then
          delay(i) <= di(i) & delay(i)(l-1 downto 1);
        end if;
      end if;
    end process;

    do(i) <= delay(i)(0);

  end generate;

end architecture behavior;
