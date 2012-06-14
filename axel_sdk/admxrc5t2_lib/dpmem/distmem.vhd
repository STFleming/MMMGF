--
-- distmem.vhd - entity "distmem"
--
-- Parameterisable dual port RAM block implemented using distributed RAM.
--
-- 1. The length of 'init' must be (2**order * width)
--
-- 2. 'order' must represent a distributed RAM size that is between 1 and the
--    largest supported for the specified FPGA family, inclusive.
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

library work;
use work.dpmem.all;

entity distmem is
    generic(
        order       : in  natural;          -- Number of address bits
        width       : in  natural;          -- Width of port
        -- synopsys translate_off
        init        : in  std_logic_vector; -- Initial contents of RAM
        -- synopsys translate_on
        family      : in  family_t);        -- FPGA family to target
    port(
        rst : in  std_logic;
        k0  : in  std_logic;
        sr0 : in  std_logic;
        en0 : in  std_logic;
        w0  : in  std_logic;
        a0  : in  std_logic_vector(order - 1 downto 0);
        d0  : in  std_logic_vector(width - 1 downto 0);
        q0  : out std_logic_vector(width - 1 downto 0);
        k1  : in  std_logic;
        sr1 : in  std_logic;
        en1 : in  std_logic;
        a1  : in  std_logic_vector(order - 1 downto 0);
        q1  : out std_logic_vector(width - 1 downto 0));
end;

architecture struct of distmem is

    constant this_module : string := "dpmem.distmem";

    -- synopsys translate_off
    function conv_string(
        val : in integer)
    return string is
        variable l : line;
        variable len : integer;
        variable s : string(1 to 64);
    begin
        write(l, val);
        len := l'length;
        read(l, s(1 to len));
        return s(1 to len);
    end;
    -- synopsys translate_on

    function max(
        a : in integer;
        b : in integer)
    return integer is
    begin
        if a > b then
            return a;
        else
            return b;
        end if;
    end;

    constant order_ext : natural := max(4, order);
 
    signal a0_ext : std_logic_vector(order_ext - 1 downto 0);
    signal a1_ext : std_logic_vector(order_ext - 1 downto 0);

begin

    -- synopsys translate_off
    assert order >= 1
        report "** " & this_module & ": order (" & conv_string(order) & ") not valid"
        severity failure;
    -- synopsys translate_on

    a0_ext <= EXT(a0, order_ext);
    a1_ext <= EXT(a1, order_ext);

    distmem0_0 : distmem0
        generic map(
            order => order,
            width => width,
            -- synopsys translate_off
            init => init,
            -- synopsys translate_on
            family => family)
        port map(
            rst => rst,
            k0 => k0,
            sr0 => sr0,
            en0 => en0,
            w0 => w0,
            a0 => a0_ext,
            d0 => d0,
            q0 => q0,
            k1 => k1,
            sr1 => sr1,
            en1 => en1,
            a1 => a1_ext,
            q1 => q1);

end;
