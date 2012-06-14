--
-- distmem0.vhd - entity "distmem0"
--
-- Parameterisable dual port RAM block implemented using distributed RAM.
--
-- 1. The length of 'init' must be (2**order * width)
--
-- 2. 'order' must represent a distributed RAM size that is supported for
--    the specified FPGA family.
--
-- SYNTHESIZABLE
--
-- TO DO
-- =====
--
-- 1. The 'init' generic is currently ignored, but should not be.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

-- synopsys translate_off
library std;
use std.textio.all;
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

library work;
use work.dpmem.all;

entity distmem0 is
    generic(
        order       : in  natural;          -- number of address bits
        width       : in  natural;          -- width of port
        -- synopsys translate_off
        init        : in  std_logic_vector; -- initial contents of RAM
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

architecture struct of distmem0 is

    constant this_module : string := "dpmem.distmem0";

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

    function get_width(
        constant o : in natural)
    return natural is
    begin
        if order = o then
            return width;
        else
            return 0;
        end if;
    end;
    
    signal write0 : std_logic;
    signal q0d : std_logic_vector(width - 1 downto 0);
    signal q1d : std_logic_vector(width - 1 downto 0);

    attribute syn_black_box : boolean;

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
    attribute syn_black_box of RAM16X1D : component is true;

    component RAM32X1D
        generic(
            INIT : in bit_vector(31 downto 0) := X"00000000");
        port(
            DPO : out std_logic;
            SPO : out std_logic;
            A0 : in std_logic;
            A1 : in std_logic;
            A2 : in std_logic;
            A3 : in std_logic;
            A4 : in std_logic;
            D : in std_logic;
            DPRA0 : in std_logic;
            DPRA1 : in std_logic;
            DPRA2 : in std_logic;
            DPRA3 : in std_logic;
            DPRA4 : in std_logic;
            WCLK : in std_logic;
            WE : in std_logic);
    end component;
    attribute syn_black_box of RAM32X1D : component is true;

    component RAM64X1D
        generic(
            INIT : in bit_vector(63 downto 0) := X"0000000000000000");
        port(
            DPO : out std_logic;
            SPO : out std_logic;
            A0 : in std_logic;
            A1 : in std_logic;
            A2 : in std_logic;
            A3 : in std_logic;
            A4 : in std_logic;
            A5 : in std_logic;
            D : in std_logic;
            DPRA0 : in std_logic;
            DPRA1 : in std_logic;
            DPRA2 : in std_logic;
            DPRA3 : in std_logic;
            DPRA4 : in std_logic;
            DPRA5 : in std_logic;
            WCLK : in std_logic;
            WE : in std_logic);
    end component;
    attribute syn_black_box of RAM64X1D : component is true;

    component RAM128X1D
        generic(
            INIT : in bit_vector(127 downto 0) := X"00000000000000000000000000000000");
        port(
            DPO : out std_logic;
            SPO : out std_logic;
            A : in std_logic_vector(6 downto 0);
            D : in std_logic;
            DPRA : in std_logic_vector(6 downto 0);
            WCLK : in std_logic;
            WE : in std_logic);
    end component;
    attribute syn_black_box of RAM128X1D : component is true;

begin

    -- synopsys translate_off
    assert (family = family_virtex and order = 4) or
           (family = family_virtex2 and (order >= 4 and order <= 6)) or
           (family = family_virtex2p and (order >= 4 and order <= 6)) or
           (family = family_virtex4 and order = 4) or
           (family = family_virtex5 and (order >= 4 and order <= 7))
        report "** " & this_module & ": order (" & conv_string(order) & ") not valid " &
               " for specified FPGA family (" & conv_string(family) & ")"
        severity failure;
    -- synopsys translate_on

    write0 <= w0 and en0;

    -- Virtex, Virtex-II, Virtex-IIPro and Virtex-5 support RAM32X1D
    generate_mem4 : for i in 0 to get_width(4) - 1 generate
        U0 : RAM16X1D
            port map(
                DPO => q1d(i),
                SPO => q0d(i),
                A0 => a0(0),
                A1 => a0(1),
                A2 => a0(2),
                A3 => a0(3),
                D => d0(i),
                DPRA0 => a1(0),
                DPRA1 => a1(1),
                DPRA2 => a1(2),
                DPRA3 => a1(3),
                WCLK => k0,
                WE => write0);
    end generate;

    -- Virtex-II, Virtex-IIPro and Virtex-5 support RAM32X1D
    generate_mem5 : for i in 0 to get_width(5) - 1 generate
        U0 : RAM32X1D
            port map(
                DPO => q1d(i),
                SPO => q0d(i),
                A0 => a0(0),
                A1 => a0(1),
                A2 => a0(2),
                A3 => a0(3),
                A4 => a0(4),
                D => d0(i),
                DPRA0 => a1(0),
                DPRA1 => a1(1),
                DPRA2 => a1(2),
                DPRA3 => a1(3),
                DPRA4 => a1(4),
                WCLK => k0,
                WE => write0);
    end generate;

    -- Virtex-II, Virtex-IIPro and Virtex-5 support RAM64X1D
    generate_mem6 : for i in 0 to get_width(6) - 1 generate
        U0 : RAM64X1D
            port map(
                DPO => q1d(i),
                SPO => q0d(i),
                A0 => a0(0),
                A1 => a0(1),
                A2 => a0(2),
                A3 => a0(3),
                A4 => a0(4),
                A5 => a0(5),
                D => d0(i),
                DPRA0 => a1(0),
                DPRA1 => a1(1),
                DPRA2 => a1(2),
                DPRA3 => a1(3),
                DPRA4 => a1(4),
                DPRA5 => a1(5),
                WCLK => k0,
                WE => write0);
    end generate;

    -- Virtex-5 supports RAM128X1D
    generate_mem7 : for i in 0 to get_width(7) - 1 generate
        U0 : RAM128X1D
            port map(
                DPO => q1d(i),
                SPO => q0d(i),
                A => a0(6 downto 0),
                D => d0(i),
                DPRA => a1(6 downto 0),
                WCLK => k0,
                WE => write0);
    end generate;

    generate_q0 : process(rst, k0)
    begin
        if rst = '1' then
            q0 <= (others => '0');
        elsif k0'event and k0 = '1' then
            if en0 = '1' then
                q0 <= q0d;
            end if;
        end if;
    end process;

    generate_q1 : process(rst, k1)
    begin
        if rst = '1' then
            q1 <= (others => '0');
        elsif k1'event and k1 = '1' then
            if en1 = '1' then
                q1 <= q1d;
            end if;
        end if;
    end process;

end;
