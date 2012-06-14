--
-- dpbram0.vhd - entity "dpbram0"
--
-- SYNTHESIZABLE
--
-- Parameterisable dual port BlockRAM
--
-- Constraints on parameters
-- =========================
--
-- 1.  'width0' must be less than or equal to 'width1'
-- 2.  'width0' and 'width1' must be valid port data widths for a BlockRAM
--     of the specified family
-- 3.  'order0' and 'order1' must be valid port address widths for a 
--     BlockRAM of the specified family
-- 4.  The number of bits of BlockRAM storage required by the wider of the
--     two ports must be valid for a BlockRAM of the specified family.
-- 5.  The length of 'init' must the same as the number of bits of BlockRAM
--     sotrage required by the wider of the two ports.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library work;
use work.dpmem.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
library std;
use std.textio.all;
-- synopsys translate_on

entity dpbram0 is
    generic(
        order0      : in  natural;           -- number of address bits in port 0
        width0      : in  natural;           -- width of port 0
        order1      : in  natural;           -- number of address bits in port 1
        width1      : in  natural;           -- width of port 1
        -- synopsys translate_off
        init        : in  std_logic_vector;  -- initial contents of RAM
        -- synopsys translate_on
        family      : in  family_t);         -- FPGA family to target
    port(
        rst : in  std_logic;
        k0  : in  std_logic;
        sr0 : in  std_logic;
        en0 : in  std_logic;
        w0  : in  std_logic;
        a0  : in  std_logic_vector(order0 - 1 downto 0);
        d0  : in  std_logic_vector(width0 - 1 downto 0);
        q0  : out std_logic_vector(width0 - 1 downto 0);
        k1  : in  std_logic;
        sr1 : in  std_logic;
        en1 : in  std_logic;
        w1  : in  std_logic;
        a1  : in  std_logic_vector(order1 - 1 downto 0);
        d1  : in  std_logic_vector(width1 - 1 downto 0);
        q1  : out std_logic_vector(width1 - 1 downto 0));
end;

architecture struct of dpbram0 is

    constant this_module : string := "dpmem.dpbram0";

    function choice(
        a : in integer;
        b : in integer;
        m : in boolean)
    return integer is
    begin
        if m then
            return b;
        else
            return a;
        end if;
    end;

    function log2up(
        n : in integer)
    return integer is begin
        assert n > 0
            report "*** log2up: n > 0 violated"
            severity failure;

        for i in 0 to 30 loop
            if 2**i >= n then
                return i;
            end if;
        end loop;

        assert false
            report "*** log2up: n out of range"
            severity failure;
        return -1;
    end;

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

    -- Minimum/maximum number of address bits for BlockRAMs of specified FPGA family
    constant order_min        : natural := log2up(blockram_min_depth(family));
    constant order_max        : natural := log2up(blockram_max_depth(family));
    constant data_width_max   : natural := blockram_max_data_width(family);
    constant parity_width_max : natural := data_width_max / blockram_parity_ratio(family);
    constant width_max        : natural := data_width_max + parity_width_max;

    -- Make port A the narrower port
    constant a_width : natural := choice(width1, width0, order1 < order0);
    constant a_order : natural := choice(order1, order0, order1 < order0);
    constant b_width : natural := choice(width0, width1, order1 < order0);
    constant b_order : natural := choice(order0, order1, order1 < order0);

    constant a_depth              : natural := 2**a_order;
    constant a_inst_data_width    : natural := blockram_data_size(family) / a_depth;
    constant a_inst_parity_width  : natural := a_inst_data_width / blockram_parity_ratio(family);
    constant a_inst_width         : natural := a_inst_data_width + a_inst_parity_width;

    constant b_depth              : natural := 2**b_order;
    constant b_inst_data_width    : natural := blockram_data_size(family) / b_depth;
    constant b_inst_parity_width  : natural := b_inst_data_width / blockram_parity_ratio(family);
    constant b_inst_width         : natural := b_inst_data_width + b_inst_parity_width;

    constant str_write_mode_a     : string := "READ_FIRST";
    constant str_write_mode_b     : string := "READ_FIRST";

    function generate_n(
        f : in family_t;
        x : in natural;
        y : in natural)
    return integer is
        variable match : boolean;
    begin
        case f is
            when family_virtex2 =>
                case family is
                    when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                        match := true;
                    when family_virtex =>
                        match := false;
                end case;

            when family_virtex =>
                case family is
                    when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                        match := false;
                    when family_virtex =>
                        match := true;
                end case;

            when others =>
                match := false;
        end case;

        if match and x = a_inst_width and y = b_inst_width then
            return 1;
        else
            return 0;
        end if;
    end;

    function get_init_slice(
        idx  : in natural;
        init : in std_logic_vector)
    return bit_vector is
        variable x : bit_vector(255 downto 0);
        variable tmp : std_logic;
        variable offs : natural;
        variable j, k, l, m : natural;
    begin
        offs := 256 * idx;
        for i in 255 downto 0 loop
            j := offs + i;
            k := j /   b_inst_data_width;
            l := j rem b_inst_data_width;
            m := k * b_inst_width + l;
            if m < init'length then
                tmp := init(m);
            else
                tmp := '0';
                end if;
            if tmp = '1' then
                x(i) := '1';
            else
                x(i) := '0';
            end if;
        end loop;

        return x;
    end;

    function get_initp_slice(
        idx  : in natural;
        init : in std_logic_vector)
    return bit_vector is
        variable x : bit_vector(255 downto 0);
        variable tmp : std_logic;
        variable offs : natural;
        variable j, k, l, m : natural;
    begin
        if b_inst_parity_width = 0 then
            x := (others => '0');
        else
            offs := 256 * idx;
            for i in 255 downto 0 loop
                j := offs + i;
                k := j /   b_inst_parity_width;
                l := j rem b_inst_parity_width;
                m := k * b_inst_width + l + b_inst_data_width;
                if m < init'length then
                    tmp := init(m);
                else
                    tmp := '0';
                end if;
                if tmp = '1' then
                    x(i) := '1';
                else
                    x(i) := '0';
                end if;
            end loop;
        end if;

        return x;
    end;

    signal ram_addra : std_logic_vector(a_order - 1 downto 0);
    signal ram_dia   : std_logic_vector(a_inst_width - 1 downto 0);
    signal ram_doa   : std_logic_vector(a_inst_width - 1 downto 0);
    signal ram_ena   : std_logic;
    signal ram_clka  : std_logic;
    signal ram_wea   : std_logic;
    signal ram_ssra  : std_logic;
    signal ram_addrb : std_logic_vector(b_order - 1 downto 0);
    signal ram_dib   : std_logic_vector(b_inst_width - 1 downto 0);
    signal ram_dob   : std_logic_vector(b_inst_width - 1 downto 0);
    signal ram_enb   : std_logic;
    signal ram_clkb  : std_logic;
    signal ram_web   : std_logic;
    signal ram_ssrb  : std_logic;

    attribute syn_black_box : boolean;

    --
    -- Virtex/Virtex-E/Virtex-EM BlockRAM components
    --

    component RAMB4_S1_S1
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (0 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (11 downto 0);
            DIB   : in std_logic_vector (0 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S1_S1 : component is true;

    component RAMB4_S1_S2
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (10 downto 0);
            DIB   : in std_logic_vector (1 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S1_S2 : component is true;

    component RAMB4_S1_S4
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (9 downto 0);
            DIB   : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S1_S4 : component is true;

    component RAMB4_S1_S8
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (7 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (7 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S1_S8: component is true;

    component RAMB4_S1_S16
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (7 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S1_S16 : component is true;

    component RAMB4_S2_S2
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (10 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (10 downto 0);
            DIB   : in std_logic_vector (1 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S2_S2 : component is true;

    component RAMB4_S2_S4
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (10 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (9 downto 0);
            DIB   : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S2_S4 : component is true;

    component RAMB4_S2_S8
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (7 downto 0);
            ADDRA : in std_logic_vector (10 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (7 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S2_S8 : component is true;

    component RAMB4_S2_S16
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            ADDRA : in std_logic_vector (10 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (7 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S2_S16 : component is true;

    component RAMB4_S4_S4
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (3 downto 0);
            DOB   : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (9 downto 0);
            DIA   : in std_logic_vector (3 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (9 downto 0);
            DIB   : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S4_S4 : component is true;

    component RAMB4_S4_S8
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (3 downto 0);
            DOB   : out std_logic_vector (7 downto 0);
            ADDRA : in std_logic_vector (9 downto 0);
            DIA   : in std_logic_vector (3 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (7 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S4_S8 : component is true;

    component RAMB4_S4_S16
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (3 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            ADDRA : in std_logic_vector (9 downto 0);
            DIA   : in std_logic_vector (3 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (7 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S4_S16 : component is true;

    component RAMB4_S8_S8
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (7 downto 0);
            DOB   : out std_logic_vector (7 downto 0);
            ADDRA : in std_logic_vector (8 downto 0);
            DIA   : in std_logic_vector (7 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (7 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S8_S8 : component is true;

    component RAMB4_S8_S16
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (7 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            ADDRA : in std_logic_vector (8 downto 0);
            DIA   : in std_logic_vector (7 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (7 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S8_S16 : component is true;

    component RAMB4_S16_S16
        -- synopsys translate_off
        generic(
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (15 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            ADDRA : in std_logic_vector (7 downto 0);
            DIA   : in std_logic_vector (15 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            RSTA  : in std_ulogic;
            ADDRB : in std_logic_vector (7 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            RSTB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB4_S16_S16 : component is true;

    --
    -- Virtex-II BlockRAM components
    --

    component RAMB16_S1_S1
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (0 downto 0);
            ADDRA : in std_logic_vector (13 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (13 downto 0);
            DIB   : in std_logic_vector (0 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S1_S1 : component is true;

    component RAMB16_S1_S2
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (13 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (12 downto 0);
            DIB   : in std_logic_vector (1 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S1_S2 : component is true;

    component RAMB16_S1_S4
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (13 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (11 downto 0);
            DIB   : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S1_S4 : component is true;

    component RAMB16_S1_S9
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (7 downto 0);
            DOPB  : out std_logic_vector (0 downto 0);
            ADDRA : in std_logic_vector (13 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (10 downto 0);
            DIB   : in std_logic_vector (7 downto 0);
            DIPB  : in std_logic_vector (0 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S1_S9 : component is true;

    component RAMB16_S1_S18
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            DOPB  : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (13 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (9 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            DIPB  : in std_logic_vector (1 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S1_S18 : component is true;

    component RAMB16_S1_S36
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (31 downto 0);
            DOPB  : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (13 downto 0);
            DIA   : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (31 downto 0);
            DIPB  : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S1_S36 : component is true;

    component RAMB16_S2_S2
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (12 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (12 downto 0);
            DIB   : in std_logic_vector (1 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S2_S2 : component is true;

    component RAMB16_S2_S4
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (12 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (11 downto 0);
            DIB   : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S2_S4 : component is true;

    component RAMB16_S2_S9
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (7 downto 0);
            DOPB  : out std_logic_vector (0 downto 0);
            ADDRA : in std_logic_vector (12 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (10 downto 0);
            DIB   : in std_logic_vector (7 downto 0);
            DIPB  : in std_logic_vector (0 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S2_S9 : component is true;

    component RAMB16_S2_S18
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            DOPB  : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (12 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (9 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            DIPB  : in std_logic_vector (1 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S2_S18 : component is true;

    component RAMB16_S2_S36
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (31 downto 0);
            DOPB  : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (12 downto 0);
            DIA   : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (31 downto 0);
            DIPB  : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S2_S36 : component is true;

    component RAMB16_S4_S4
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (3 downto 0);
            DOB   : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (3 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (11 downto 0);
            DIB   : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S4_S4 : component is true;

    component RAMB16_S4_S9
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (3 downto 0);
            DOB   : out std_logic_vector (7 downto 0);
            DOPB  : out std_logic_vector (0 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (3 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (10 downto 0);
            DIB   : in std_logic_vector (7 downto 0);
            DIPB  : in std_logic_vector (0 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S4_S9 : component is true;

    component RAMB16_S4_S18
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (3 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            DOPB  : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (3 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (9 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            DIPB  : in std_logic_vector (1 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S4_S18 : component is true;

    component RAMB16_S4_S36
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (3 downto 0);
            DOB   : out std_logic_vector (31 downto 0);
            DOPB  : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (11 downto 0);
            DIA   : in std_logic_vector (3 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (31 downto 0);
            DIPB  : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S4_S36 : component is true;

    component RAMB16_S9_S9
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (7 downto 0);
            DOPA  : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (7 downto 0);
            DOPB  : out std_logic_vector (0 downto 0);
            ADDRA : in std_logic_vector (10 downto 0);
            DIA   : in std_logic_vector (7 downto 0);
            DIPA  : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (10 downto 0);
            DIB   : in std_logic_vector (7 downto 0);
            DIPB  : in std_logic_vector (0 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S9_S9 : component is true;

    component RAMB16_S9_S18
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (7 downto 0);
            DOPA  : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            DOPB  : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (10 downto 0);
            DIA   : in std_logic_vector (7 downto 0);
            DIPA  : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (9 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            DIPB  : in std_logic_vector (17 downto 16);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S9_S18 : component is true;

    component RAMB16_S9_S36
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (7 downto 0);
            DOPA  : out std_logic_vector (0 downto 0);
            DOB   : out std_logic_vector (31 downto 0);
            DOPB  : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (10 downto 0);
            DIA   : in std_logic_vector (7 downto 0);
            DIPA  : in std_logic_vector (0 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (31 downto 0);
            DIPB  : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S9_S36 : component is true;

    component RAMB16_S18_S18
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (15 downto 0);
            DOPA  : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            DOPB  : out std_logic_vector (1 downto 0);
            ADDRA : in std_logic_vector (9 downto 0);
            DIA   : in std_logic_vector (15 downto 0);
            DIPA  : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (9 downto 0);
            DIB   : in std_logic_vector (15 downto 0);
            DIPB  : in std_logic_vector (1 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S18_S18 : component is true;

    component RAMB16_S18_S36
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (15 downto 0);
            DOPA  : out std_logic_vector (1 downto 0);
            DOB   : out std_logic_vector (31 downto 0);
            DOPB  : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (9 downto 0);
            DIA   : in std_logic_vector (15 downto 0);
            DIPA  : in std_logic_vector (1 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (31 downto 0);
            DIPB  : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S18_S36 : component is true;

    component RAMB16_S36_S36
        -- synopsys translate_off
        generic(
            WRITE_MODE_A : string := "WRITE_FIRST";
            WRITE_MODE_B : string := "WRITE_FIRST";
            INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000");
        -- synopsys translate_on
        port(
            DOA   : out std_logic_vector (31 downto 0);
            DOPA  : out std_logic_vector (3 downto 0);
            DOB   : out std_logic_vector (31 downto 0);
            DOPB  : out std_logic_vector (3 downto 0);
            ADDRA : in std_logic_vector (8 downto 0);
            DIA   : in std_logic_vector (31 downto 0);
            DIPA  : in std_logic_vector (3 downto 0);
            ENA   : in std_ulogic;
            CLKA  : in std_ulogic;
            WEA   : in std_ulogic;
            SSRA  : in std_ulogic;
            ADDRB : in std_logic_vector (8 downto 0);
            DIB   : in std_logic_vector (31 downto 0);
            DIPB  : in std_logic_vector (3 downto 0);
            ENB   : in std_ulogic;
            CLKB  : in std_ulogic;
            WEB   : in std_ulogic;
            SSRB  : in std_ulogic);
    end component;
    attribute syn_black_box of RAMB16_S36_S36 : component is true;

begin

    -- synopsys translate_off

    -- Check that port A is the narrower port
    assert width0 <= width1
        report "*** " & this_module & ": width0 (" & conv_string(width0) &
        ") is greater than width1 (" & conv_string(width1) & ")"
        severity failure;

    -- Check that address with for port 0 is in bounds
    -- synopsys translate_off
    assert order0 >= order_min
        report "*** " & this_module & ": order0 (" & conv_string(order0) & ") too low"
        severity failure;
    assert order0 <= order_max
        report "*** " & this_module & ": order0(" & conv_string(order0) & ") too high"
        severity failure;

    -- Check that address with for port 1 is in bounds
    assert order1 >= order_min
        report "*** " & this_module & ": order1(" & conv_string(order1) & ") too low"
        severity failure;
    assert order1 <= order_max
        report "*** " & this_module & ": order1(" & conv_string(order1) & ") too high"
        severity failure;

    -- Check that 'init' is of the required dimension
    assert init'length = b_depth * b_width
        report "*** " & this_module & ": init'length (" & conv_string(init'length) &
               ") does not match b_depth (" & conv_string(b_depth) & ") and b_width (" &
               conv_string(b_width) & ")"
        severity failure;

    -- synopsys translate_on

    ram_addra <= a0      when order1 <= order0 else a1;
    ram_dia   <= d0      when order1 <= order0 else d1;
    ram_ena   <= en0     when order1 <= order0 else en1;
    ram_clka  <= k0      when order1 <= order0 else k1;
    ram_wea   <= w0      when order1 <= order0 else w1;
    ram_ssra  <= sr0     when order1 <= order0 else sr1;
    ram_addrb <= a1      when order1 <= order0 else a0;
    ram_dib   <= d1      when order1 <= order0 else d0;
    ram_enb   <= en1     when order1 <= order0 else en0;
    ram_clkb  <= k1      when order1 <= order0 else k0;
    ram_web   <= w1      when order1 <= order0 else w0;
    ram_ssrb  <= sr1     when order1 <= order0 else sr0;
    q0        <= ram_doa when order1 <= order0 else ram_dob;
    q1        <= ram_dob when order1 <= order0 else ram_doa;

    gen_rams_virtex_1_1 : for i in 0 to generate_n(family_virtex, 1, 1) - 1 generate
        ram0 : RAMB4_S1_S1
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_1_2 : for i in 0 to generate_n(family_virtex, 1, 2) - 1 generate
        ram0 : RAMB4_S1_S2
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_1_4 : for i in 0 to generate_n(family_virtex, 1, 4) - 1 generate
        ram0 : RAMB4_S1_S4
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_1_8 : for i in 0 to generate_n(family_virtex, 1, 8) - 1 generate
        ram0 : RAMB4_S1_S8
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_1_16 : for i in 0 to generate_n(family_virtex, 1, 16) - 1 generate
        ram0 : RAMB4_S1_S16
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_2_2 : for i in 0 to generate_n(family_virtex, 2, 2) - 1 generate
        ram0 : RAMB4_S2_S2
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_2_4 : for i in 0 to generate_n(family_virtex, 2, 4) - 1 generate
        ram0 : RAMB4_S2_S4
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_2_8 : for i in 0 to generate_n(family_virtex, 2, 8) - 1 generate
        ram0 : RAMB4_S2_S8
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_2_16 : for i in 0 to generate_n(family_virtex, 2, 16) - 1 generate
        ram0 : RAMB4_S2_S16
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_4_4 : for i in 0 to generate_n(family_virtex, 4, 4) - 1 generate
        ram0 : RAMB4_S4_S4
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_4_8 : for i in 0 to generate_n(family_virtex, 4, 8) - 1 generate
        ram0 : RAMB4_S4_S8
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_4_16 : for i in 0 to generate_n(family_virtex, 4, 16) - 1 generate
        ram0 : RAMB4_S4_S16
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_8_8 : for i in 0 to generate_n(family_virtex, 8, 8) - 1 generate
        ram0 : RAMB4_S8_S8
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_8_16 : for i in 0 to generate_n(family_virtex, 8, 16) - 1 generate
        ram0 : RAMB4_S8_S16
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex_16_16 : for i in 0 to generate_n(family_virtex, 16, 16) - 1 generate
        ram0 : RAMB4_S16_S16
            -- synopsys translate_off
            generic map(
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                rsta  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                rstb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_1_1 : for i in 0 to generate_n(family_virtex2, 1, 1) - 1 generate
        ram0 : RAMB16_S1_S1
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_1_2 : for i in 0 to generate_n(family_virtex2, 1, 2) - 1 generate
        ram0 : RAMB16_S1_S2
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_1_4 : for i in 0 to generate_n(family_virtex2, 1, 4) - 1 generate
        ram0 : RAMB16_S1_S4
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_1_9 : for i in 0 to generate_n(family_virtex2, 1, 9) - 1 generate
        ram0 : RAMB16_S1_S9
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_1_18 : for i in 0 to generate_n(family_virtex2, 1, 18) - 1 generate
        ram0 : RAMB16_S1_S18
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_1_36 : for i in 0 to generate_n(family_virtex2, 1, 36) - 1 generate
        ram0 : RAMB16_S1_S36
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_2_2 : for i in 0 to generate_n(family_virtex2, 2, 2) - 1 generate
        ram0 : RAMB16_S2_S2
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_2_4 : for i in 0 to generate_n(family_virtex2, 2, 4) - 1 generate
        ram0 : RAMB16_S2_S4
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_2_9 : for i in 0 to generate_n(family_virtex2, 2, 9) - 1 generate
        ram0 : RAMB16_S2_S9
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_2_18 : for i in 0 to generate_n(family_virtex2, 2, 18) - 1 generate
        ram0 : RAMB16_S2_S18
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_2_36 : for i in 0 to generate_n(family_virtex2, 2, 36) - 1 generate
        ram0 : RAMB16_S2_S36
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_4_4 : for i in 0 to generate_n(family_virtex2, 4, 4) - 1 generate
        ram0 : RAMB16_S4_S4
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_4_9 : for i in 0 to generate_n(family_virtex2, 4, 9) - 1 generate
        ram0 : RAMB16_S4_S9
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_4_18 : for i in 0 to generate_n(family_virtex2, 4, 18) - 1 generate
        ram0 : RAMB16_S4_S18
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_4_36 : for i in 0 to generate_n(family_virtex2, 4, 36) - 1 generate
        ram0 : RAMB16_S4_S36
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_9_9 : for i in 0 to generate_n(family_virtex2, 9, 9) - 1 generate
        ram0 : RAMB16_S9_S9
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dipa  => ram_dia(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dopa  => ram_doa(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_9_18 : for i in 0 to generate_n(family_virtex2, 9, 18) - 1 generate
        ram0 : RAMB16_S9_S18
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dipa  => ram_dia(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dopa  => ram_doa(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_9_36 : for i in 0 to generate_n(family_virtex2, 9, 36) - 1 generate
        ram0 : RAMB16_S9_S36
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dipa  => ram_dia(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dopa  => ram_doa(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_18_18 : for i in 0 to generate_n(family_virtex2, 18, 18) - 1 generate
        ram0 : RAMB16_S18_S18
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dipa  => ram_dia(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dopa  => ram_doa(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_18_36 : for i in 0 to generate_n(family_virtex2, 18, 36) - 1 generate
        ram0 : RAMB16_S18_S36
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dipa  => ram_dia(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dopa  => ram_doa(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

    gen_rams_virtex2_36_36 : for i in 0 to generate_n(family_virtex2, 36, 36) - 1 generate
        ram0 : RAMB16_S36_S36
            -- synopsys translate_off
            generic map(
                write_mode_a => str_write_mode_a,
                write_mode_b => str_write_mode_b,
                init_00 => get_init_slice(0, init),
                init_01 => get_init_slice(1, init),
                init_02 => get_init_slice(2, init),
                init_03 => get_init_slice(3, init),
                init_04 => get_init_slice(4, init),
                init_05 => get_init_slice(5, init),
                init_06 => get_init_slice(6, init),
                init_07 => get_init_slice(7, init),
                init_08 => get_init_slice(8, init),
                init_09 => get_init_slice(9, init),
                init_0a => get_init_slice(10, init),
                init_0b => get_init_slice(11, init),
                init_0c => get_init_slice(12, init),
                init_0d => get_init_slice(13, init),
                init_0e => get_init_slice(14, init),
                init_0f => get_init_slice(15, init),
                init_10 => get_init_slice(16, init),
                init_11 => get_init_slice(17, init),
                init_12 => get_init_slice(18, init),
                init_13 => get_init_slice(19, init),
                init_14 => get_init_slice(20, init),
                init_15 => get_init_slice(21, init),
                init_16 => get_init_slice(22, init),
                init_17 => get_init_slice(23, init),
                init_18 => get_init_slice(24, init),
                init_19 => get_init_slice(25, init),
                init_1a => get_init_slice(26, init),
                init_1b => get_init_slice(27, init),
                init_1c => get_init_slice(28, init),
                init_1d => get_init_slice(29, init),
                init_1e => get_init_slice(30, init),
                init_1f => get_init_slice(31, init),
                init_20 => get_init_slice(32, init),
                init_21 => get_init_slice(33, init),
                init_22 => get_init_slice(34, init),
                init_23 => get_init_slice(35, init),
                init_24 => get_init_slice(36, init),
                init_25 => get_init_slice(37, init),
                init_26 => get_init_slice(38, init),
                init_27 => get_init_slice(39, init),
                init_28 => get_init_slice(40, init),
                init_29 => get_init_slice(41, init),
                init_2a => get_init_slice(42, init),
                init_2b => get_init_slice(43, init),
                init_2c => get_init_slice(44, init),
                init_2d => get_init_slice(45, init),
                init_2e => get_init_slice(46, init),
                init_2f => get_init_slice(47, init),
                init_30 => get_init_slice(48, init),
                init_31 => get_init_slice(49, init),
                init_32 => get_init_slice(50, init),
                init_33 => get_init_slice(51, init),
                init_34 => get_init_slice(52, init),
                init_35 => get_init_slice(53, init),
                init_36 => get_init_slice(54, init),
                init_37 => get_init_slice(55, init),
                init_38 => get_init_slice(56, init),
                init_39 => get_init_slice(57, init),
                init_3a => get_init_slice(58, init),
                init_3b => get_init_slice(59, init),
                init_3c => get_init_slice(60, init),
                init_3d => get_init_slice(61, init),
                init_3e => get_init_slice(62, init),
                init_3f => get_init_slice(63, init),
                initp_00 => get_initp_slice(0, init),
                initp_01 => get_initp_slice(1, init),
                initp_02 => get_initp_slice(2, init),
                initp_03 => get_initp_slice(3, init),
                initp_04 => get_initp_slice(4, init),
                initp_05 => get_initp_slice(5, init),
                initp_06 => get_initp_slice(6, init),
                initp_07 => get_initp_slice(7, init))
            -- synopsys translate_on
            port map(
                addra => ram_addra(a_order - 1 downto 0),
                dia   => ram_dia(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dipa  => ram_dia(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                doa   => ram_doa(a_inst_width * i + a_inst_data_width - 1 downto a_inst_width * i),
                dopa  => ram_doa(a_inst_width * i + a_inst_width - 1 downto a_inst_width * i + a_inst_data_width),
                ena   => ram_ena,
                clka  => ram_clka,
                wea   => ram_wea,
                ssra  => ram_ssra,
                addrb => ram_addrb(b_order - 1 downto 0),
                dib   => ram_dib(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dipb  => ram_dib(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                dob   => ram_dob(b_inst_width * i + b_inst_data_width - 1 downto b_inst_width * i),
                dopb  => ram_dob(b_inst_width * i + b_inst_width - 1 downto b_inst_width * i + b_inst_data_width),
                enb   => ram_enb,
                clkb  => ram_clkb,
                web   => ram_web,
                ssrb  => ram_ssrb);
    end generate;

end;
