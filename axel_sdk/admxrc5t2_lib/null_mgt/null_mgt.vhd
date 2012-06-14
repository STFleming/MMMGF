--
-- null_mgt.vhd - This file should be included in a Virtex-4FX design
--                so that the workarounds for Virtex-4 MGT errata are
--                present in the bitstream.
--
-- (C) Copyright Alpha Data Parallel Systems Ltd. 2006-2008
--
-- Library code for:
--
--   o ADM-XRC-4FX
--   o ADPE-XRC-4FX
--
-- Instantiates a number of NULL_PAIR macros, one per MGT pair. Makes use of
-- core 'NULL_PAIR.NGC'.
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

architecture struct of null_mgt is

    component NULL_PAIR
        port(
            GREFCLK_IN       : in    std_logic;   
            RX1N_IN          : in    std_logic_vector(1 downto 0);
            RX1P_IN          : in    std_logic_vector(1 downto 0);
            TX1N_OUT         : out   std_logic_vector(1 downto 0);
            TX1P_OUT         : out   std_logic_vector(1 downto 0));
    end component;

    attribute BOX_TYPE : string;
    attribute BOX_TYPE of NULL_PAIR : component is "user_black_box";

begin

    --
    -- MGT bank A
    --

    gen_a : for i in 0 to 3 generate
        U0 : NULL_PAIR
      	    port map(
                GREFCLK_IN => clka,
                RX1N_IN    => rxa_n((2 * i + 1) downto 2 * i),
                RX1P_IN    => rxa_p((2 * i + 1) downto 2 * i),
                TX1N_OUT   => txa_n((2 * i + 1) downto 2 * i), 
                TX1P_OUT   => txa_p((2 * i + 1) downto 2 * i));
    end generate;

    --
    -- MGT bank B
    --

    gen_b : for i in 0 to 3 generate
        U0 : NULL_PAIR
            port map(
                GREFCLK_IN => clkb,
                RX1N_IN    => rxb_n((2 * i + 1) downto 2 * i),
                RX1P_IN    => rxb_p((2 * i + 1) downto 2 * i),
                TX1N_OUT   => txb_n((2 * i + 1) downto 2 * i), 
                TX1P_OUT   => txb_p((2 * i + 1) downto 2 * i));
    end generate;

end struct;
