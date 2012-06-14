--
-- cmd_fifo.vhd
--
-- Module for buffering commands to memory interface.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
library std;
use std.textio.all;
-- synopsys translate_on

library work;
use work.memif.all;
use work.dpmem.all;

entity cmd_fifo is
    generic(
        width         : in  natural);
    port(
        clk           : in  std_logic;
        rst           : in  std_logic;
        sr            : in  std_logic;
        w             : in  std_logic;
        d             : in  std_logic_vector(width - 1 downto 0);
        r             : in  std_logic;
        q             : out std_logic_vector(width - 1 downto 0);
        ready         : out std_logic;
        empty         : out std_logic);
end;

architecture mixed of cmd_fifo is

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

    -- synopsys translate_off
    function conv_string(
        val : in time)
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

    component RAM16X1D
        generic(
            INIT : in bit_vector(15 downto 0) := X"0000");
        port(
            DPO : out std_logic;
            SPO : out std_logic;
            A0 : in std_logic;
            A1 : in std_logic;
            A2 : in std_logic;
            A3 : in std_logic;
            D : in std_logic;
            DPRA0 : in std_logic;
            DPRA1 : in std_logic;
            DPRA2 : in std_logic;
            DPRA3 : in std_logic;
            WCLK : in std_logic;
            WE : in std_logic);
    end component;
    attribute syn_black_box : boolean;
    attribute syn_black_box of RAM16X1D : component is true;

    signal dpo : std_logic_vector(width - 1 downto 0);
    signal ra : std_logic_vector(3 downto 0);
    signal wa : std_logic_vector(3 downto 0);
    signal count : std_logic_vector(3 downto 0);
    signal inc_ra : std_logic;
    signal push : std_logic;
    signal i_empty : std_logic;
    signal i_nempty : std_logic;
    signal i_ready : std_logic;

    signal logic0, logic1 : std_logic;

begin

    logic0 <= '0';
    logic1 <= '1';

    empty <= i_empty;
    ready <= i_ready;

    gen_wa : process(rst, clk)
    begin
        if rst = '1' then
            wa <= (others => '0');
        elsif clk'event and clk = '1' then
            if sr = '1' then
                wa <= (others => '0');
            else
                if w = '1' then
                    wa <= wa + 1;
                end if;
            end if;
        end if;
    end process;

    gen_mem : for i in 0 to width - 1 generate
        U0 : RAM16X1D
            port map(
                DPO => dpo(i),
                SPO => open,
                A0 => wa(0),
                A1 => wa(1),
                A2 => wa(2),
                A3 => wa(3),
                D => d(i),
                DPRA0 => ra(0),
                DPRA1 => ra(1),
                DPRA2 => ra(2),
                DPRA3 => ra(3),
                WCLK => clk,
                WE => w);
    end generate;

    inc_ra <= push or (r and not i_nempty);

    reg_mem : process(rst, clk)
    begin
        if rst = '1' then
            q <= (others => '-');
            ra <= (others => '0');
        elsif clk'event and clk = '1' then
            if sr = '1' then
                ra <= (others => '0');
            else
                if inc_ra = '1' then
                    ra <= ra + 1;
                end if;
            end if;

            if push = '1' or r = '1' then
                q <= dpo;
            end if;
        end if;
    end process;

    gen_count : process(rst, clk)
        variable xxx : std_logic_vector(1 downto 0);
    begin
        if rst = '1' then
            count <= (others => '0');
        elsif clk'event and clk = '1' then
            if sr = '1' then
                count <= (others => '0');
            else
                xxx := w & r;
                case xxx is
                    when "00" | "11" =>
                        null;
                    when "01" =>
                        count <= count - 1;
                    when "10" =>
                        count <= count + 1;
                    when others =>
                        count <= (others => '-');
                end case;
            end if;
        end if;
    end process;

    push <= OR_reduce(count) and i_empty;

    gen_empty : process(rst, clk)
    begin
        if rst = '1' then
            i_empty <= '1';
            i_nempty <= '1';
            i_ready <= '1';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                i_empty <= '1';
                i_nempty <= '1';
                i_ready <= '1';
            else
                if i_ready = '1' then
                    if count = "0111" and w = '1' then
                        i_ready <= '0';
                    end if;
                else
                    if count(3 downto 2) = "00" then
                        i_ready <= '1';
                    end if;
                end if;

                if i_nempty = '1' then
                    if count = 1 and w = '1' and r = '0' then
                        i_nempty <= '0';
                    end if;
                else
                    if count = 2 and w = '0' and r = '1' then
                        i_nempty <= '1';
                    end if;
                end if;

                if i_empty = '1' then
                    if push = '1' then
                        i_empty <= '0';
                    end if;
                else
                    if count(3 downto 1) = "000" and r = '1' then
                        i_empty <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- synopsys translate_off
    checks : process(rst, clk)
    begin
        if rst = '1' then
            null;
        elsif clk'event and clk = '1' then
            if sr = '1' then
                null;
            else
                if w = '1' and count >= 15 then
                    assert false
                        report conv_string(now) & " cmd_fifo: overflow detected (w asserted and count >= 15)"
                        severity warning;
                end if;

                if r = '1' and i_empty = '1' then
                    assert false
                        report conv_string(now) & " cmd_fifo: underflow detected (r and i_empty both asserted)"
                        severity warning;
                end if;

                if (wa - ra) > 9 then
                    assert false
                        report conv_string(now) & " cmd_fifo: suspicious values of ra (" &
                            conv_string(conv_integer(ra)) & ") wa (" & conv_string(conv_integer(wa)) & ")"
                        severity warning;
                end if;
            end if;
        end if;
    end process;
    -- synopsys translate_on

end mixed;
