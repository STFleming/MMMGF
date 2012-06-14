--
-- port_mux.vhd - multiplexor for data read from a memory port
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library work;
use work.memif.all;

-- synopsys translate_off
library std;
use std.textio.all;
-- synopsys translate_on

entity port_mux is
    generic(
        order      : in    natural;
        in_width   : in    natural;
        out_width  : in    natural);
    port(
        rst        : in    std_logic;
        clk        : in    std_logic;
        init       : in    std_logic;
        addr       : in    std_logic_vector(order - 1 downto 0);
        adv        : in    std_logic;
        din        : in    std_logic_vector(in_width - 1 downto 0);
        dout       : out   std_logic_vector(out_width - 1 downto 0);
        last       : out   std_logic);
end entity;

architecture rtl of port_mux is

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

    constant n : natural := 2**order;

    signal sel : std_logic_vector(n - 1 downto 0);

begin

    -- synopsys translate_off
    assert in_width = n * out_width
        report "*** port_mux: in_width (" & conv_string(in_width) & ") is not equal to 2**order (" & conv_string(n) &
               ") * out_width (" & conv_string(out_width) & ")"
        severity failure;
    -- synopsys translate_on

    gen_sel : process(rst, clk)
    begin
        if rst = '1' then
            sel <= (others => '0');
        elsif clk'event and clk = '1' then
            if init = '1' then
                for i in 0 to n - 1 loop
                    if addr = i then
                        sel(i) <= '1';
                    else
                        sel(i) <= '0';
                    end if;
                end loop;
            else
                if adv = '1' then
                    if n > 1 then
                        sel(n - 1 downto 1) <= sel(n - 2 downto 0);
                    end if;
                    sel(0) <= sel(n - 1);
                end if;
            end if;
        end if;
    end process;

    gen_dout : process(sel, din)
        variable x : std_logic_vector(out_width - 1 downto 0);
    begin
        x := (others => '0');
        for i in 0 to n - 1 loop
            if sel(i) = '1' then
                x := x or din(out_width * (i + 1) - 1 downto out_width * i);
            end if;
        end loop;
        dout <= x;
    end process;

    last <= sel(n - 1);

end architecture;
