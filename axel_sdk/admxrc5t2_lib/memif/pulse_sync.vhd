--
-- pulse_sync.vhd - pulse retimer module
--
-- SYNTHESIZABLE
--
-- This entity retimes pulses input from one clock domain into pulses for
-- another clock domain.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

entity pulse_sync is
    port(
        ar : in  std_logic;
        ik : in  std_logic;
        i  : in  std_logic;
        ok : in  std_logic;
        o  : out std_logic);
end;

architecture rtl of pulse_sync is

    signal rst, x, xy, y, yz, z : std_logic;
    
    signal logic1 : std_logic;

    component FDCE
        port(
            CLR : in  std_logic;
            C   : in  std_logic;
            D   : in  std_logic;
            CE  : in  std_logic;
            Q   : out std_logic);
    end component;

begin

    logic1 <= '1';

    o <= z;

    rst <= ar or z;

    gen_x : FDCE
        port map(
--            CLR => rst,
            CLR => z,
            C => ik,
            D => logic1,
            CE => i,
            Q => x);

    xy <= x and not z;

    gen_y : FDCE
        port map(
            CLR => ar,
            C => ok,
            D => xy,
            CE => logic1,
            Q => y);

    yz <= y and not z;

    gen_z : FDCE
        port map(
            CLR => ar,
            C => ok,
            D => yz,
            CE => logic1,
            Q => z);

end;
