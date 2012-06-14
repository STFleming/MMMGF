--
-- null_mgt_sim.vhd - This file is a dummy version of null_mgt module, provided
--                    for simulation ONLY.
--
-- (C) Copyright Alpha Data  2007-2008
--
-- Library code for:
--
--   o ADM-XRC-4FX
--   o ADPE-XRC-4FX
--
-- NOT SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;

entity null_mgt is
    port(
        clka             : in    std_logic;
        rxa_p            : in    std_logic_vector(7 downto 0);
        rxa_n            : in    std_logic_vector(7 downto 0);
        txa_p            : out   std_logic_vector(7 downto 0);
        txa_n            : out   std_logic_vector(7 downto 0);
        clkb             : in    std_logic;
        rxb_p            : in    std_logic_vector(7 downto 0);
        rxb_n            : in    std_logic_vector(7 downto 0);
        txb_p            : out   std_logic_vector(7 downto 0);
        txb_n            : out   std_logic_vector(7 downto 0));
end entity;

architecture simulation of null_mgt is

begin

    txa_p <= (others => '0');
    txa_n <= (others => '1');
    txb_p <= (others => '0');
    txb_n <= (others => '1');
           
end simulation;
