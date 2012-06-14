-- icore_pkg.vhd
-- by Brittle 2010

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE icore IS

  component mult16 is
    port (
      ce : in STD_LOGIC := 'X'; 
      clk : in STD_LOGIC := 'X'; 
      a : in STD_LOGIC_VECTOR ( 15 downto 0 ); 
      b : in STD_LOGIC_VECTOR ( 15 downto 0 ); 
      p : out STD_LOGIC_VECTOR ( 31 downto 0 ) 
    );
  end component;

  component div32 is
    port (
      rfd : out STD_LOGIC; 
      clk : in STD_LOGIC := 'X'; 
      dividend : in STD_LOGIC_VECTOR ( 31 downto 0 ); 
      quotient : out STD_LOGIC_VECTOR ( 31 downto 0 ); 
      divisor : in STD_LOGIC_VECTOR ( 15 downto 0 ); 
      fractional : out STD_LOGIC_VECTOR ( 15 downto 0 ) 
    );
  end component;

END;
