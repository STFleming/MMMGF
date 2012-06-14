--
-- pe.vhd -- Processing Element
--
--  Project   : <<<APPLICATION_NAME>>>
--  Programmer: <<<EMAIL>>>
--  Date      : <<<DATE>>>

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_misc.ALL;
USE ieee.std_logic_unsigned.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;
-- synthesis translate_on

library unisim;
use unisim.vcomponents.all;

library work;
use work.admxrc5t2_common.all;
use work.user_defs.all;

ENTITY pe IS
  PORT (
  debug : out std_logic_vector(31 downto 0);
  -- global interface
  clk   : in  std_logic;
  rst   : in  std_logic;
  en    : in  std_logic;
  -- parameter interface
  <<<REG_PORT>>>
  -- ram interface
  <<<MEM_PORT>>>
  -- control interface
  start : in  std_logic;
  done  : out std_logic);
END pe;

ARCHITECTURE structural of pe IS

BEGIN

  -- Debug Signals
  debug <= (others => '0');

END structural;
