--
-- mclk_gtp_wrap_sim.vhd - Fake version of module 'mclk_gtp_wrap' for simulation
--                         where SmartModel license is not available.
--
-- Modules defined:
--
--    mclk_gtp_wrap        Fake GTP_DUAL wrapper providing output clock
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mclk_gtp_wrap is
    port(
        clkin  : in    std_logic;
        clkout : out   std_logic);
end entity;

architecture fake of mclk_gtp_wrap is

begin

    clkout <= clkin;

end architecture;
