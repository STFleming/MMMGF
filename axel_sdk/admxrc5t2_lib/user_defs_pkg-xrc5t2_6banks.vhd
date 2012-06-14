--
-- user_defs_pkg-xrc5t2.vhd - Model-specific definitions for 'user_app' implementation that
--                            tests onboard memory.
--
-- SYNTHESIZABLE
--
-- (C) Copyright Alpha Data 2008
--
-- Targets models:
--
--   o ADM-XRC-5T2 with 5VLX330T / 5VFX200T / 5VSX240T
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

library work;
use work.admxrc5t2_common.all;

package user_defs is

    type natural_vector_t is array(0 to max_num_bank - 1) of natural;
    type boolean_vector_t is array(0 to max_num_bank - 1) of boolean;

    -- Widths in logical bits of memory port data
    constant bank_width : natural_vector_t :=
        (0 => 128, 1 => 128, 2 => 128, 3 => 128, 4 => 64, 5 => 64, others => 0);

    -- Widths in logical bits of memory port byte enables
    constant bank_be_width : natural_vector_t :=
        (0 => 16, 1 => 16, 2 => 16, 3 => 16, 4 => 8, 5 => 8, others => 0);

    -- Each element should be true if the corresponding memory bank is physically present
    -- Allows banks to be skipped when a device is fitted that doesn't have enough I/O
    -- pins to support all banks of memory
    constant bank_present : boolean_vector_t :=
        (0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, others => false);

    -- Width in bits of physical memory port data busses
    constant rd_width : natural_vector_t :=
        (0 => 32, 1 => 32, 2 => 32, 3 => 32, 4 => 16, 5 => 16, others => 0);

end;
