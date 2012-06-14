--
-- port_repl.vhd - replicator for data written to a memory port
--
-- SYNTHESIZABLE
--
-- If 'partial' is false, then the 'last' input is ignored. Only
-- a write of the final segment in a word will cause 'valid' to be
-- asserted.
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

entity port_repl is
    generic(
        order      : in    natural;
        in_width   : in    natural;
        out_width  : in    natural;
        partial    : in    boolean);  -- If false, 'final' is ignored
    port(
        rst        : in    std_logic;
        clk        : in    std_logic;
        init       : in    std_logic;
        addr       : in    std_logic_vector(order - 1 downto 0);
        wr         : in    std_logic;
        last       : in    std_logic;
        din        : in    std_logic_vector(in_width - 1 downto 0);
        bein       : in    std_logic_vector(in_width / 8 - 1 downto 0);
        dout       : out   std_logic_vector(out_width - 1 downto 0);
        beout      : out   std_logic_vector(out_width / 8 - 1 downto 0);
        valid      : out   std_logic;
        final      : out   std_logic);
end entity;

architecture rtl of port_repl is

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
    constant in_be_width : natural := in_width / 8;

    signal sel : std_logic_vector(n - 1 downto 0);

begin

    -- synopsys translate_off
    assert out_width = n * in_width
        report "*** port_mux: out_width (" & conv_string(out_width) & ") is not equal to 2**order (" & conv_string(n) &
               ") * in_width (" & conv_string(in_width) & ")"
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
                if wr = '1' then
                    if n > 1 then
                        sel(n - 1 downto 1) <= sel(n - 2 downto 0);
                    end if;
                    sel(0) <= sel(n - 1);
                end if;
            end if;
        end if;
    end process;

    gen_dout : process(rst, clk)
    begin
        if rst = '1' then
            dout <= (others => '0');
        elsif clk'event and clk = '1' then
            for i in 0 to n - 1 loop
                if wr = '1' and sel(i) = '1' then
                    dout(in_width * (i + 1) - 1 downto in_width * i) <= din;
                end if;
            end loop;
        end if;
    end process;

    gen_beout_partial : if partial generate
        gen_beout : process(rst, clk)
        begin
            if rst = '1' then
                beout <= (others => '0');
            elsif clk'event and clk = '1' then
                if init = '1' then
                    beout <= (others => '0');
                else
                    if wr = '1' then
                        if sel(0) = '1' then
                            beout(in_be_width - 1 downto 0) <= bein;
                        end if;
                        for i in 1 to n - 1 loop
                            if sel(0) = '1' then
                                beout(in_be_width * (i + 1) - 1 downto in_be_width * i) <= (others => '0');
                            else
                                if sel(i) = '1' then
                                    beout(in_be_width * (i + 1) - 1 downto in_be_width * i) <= bein;
                                end if;
                            end if;
                        end loop;
                    end if;
                end if;
            end if;
        end process;
    end generate;

    gen_beout_not_partial : if not partial generate
        beout <= (others => '1');
    end generate;

    gen_valid : process(rst, clk)
    begin
        if rst = '1' then
            valid <= '0';
            final <= '0';
        elsif clk'event and clk = '1' then
            if partial then
                valid <= wr and (sel(n - 1) or last);
            else
                valid <= wr and sel(n - 1);
            end if;
            final <= last;
        end if;
    end process;

end architecture;
