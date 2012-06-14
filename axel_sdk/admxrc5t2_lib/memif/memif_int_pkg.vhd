--
-- memif_int_pkg.vhd - Internal defitions for memory interface package
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

-- synopsys translate_off
library std;
use std.textio.all;
-- synopsys translate_on

package memif_int is

    component cmd_fifo
        generic(
            width           : in  natural);
        port(
            clk             : in  std_logic;
            rst             : in  std_logic;
            sr              : in  std_logic;
            w               : in  std_logic;
            d               : in  std_logic_vector(width - 1 downto 0);
            r               : in  std_logic;
            q               : out std_logic_vector(width - 1 downto 0);
            ready           : out std_logic;
            empty           : out std_logic);
    end component;

end;

package body memif_int is

end;
