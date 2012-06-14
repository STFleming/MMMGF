--
-- dpbram.vhd - entity "dpbram"
--
-- SYNTHESIZABLE
--
-- Parameterisable dual port RAM block implemented using
-- Virtex/Virtex-II/Virtex-IIPro/Virtex-4/Virtex 5 BlockRAMs
--
-- The length of 'init' must be the larger of (2**order0 * width0) and
-- (2**order1 * width1).
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library work;
use work.dpmem.all;

-- synopsys translate_off
library std;
use std.textio.all;
-- synopsys translate_on

entity dpbram is
    generic(
        order0      : in  natural;          -- number of address bits
        width0      : in  natural;          -- width of port
        order1      : in  natural;          -- number of address bits
        width1      : in  natural;          -- width of port
        -- synopsys translate_off
        init        : in  std_logic_vector; -- initial contents of RAM
        -- synopsys translate_on
        family      : in  family_t;         -- FPGA family to target
        depth_waste : in  boolean);         -- TRUE to allow locations to be wasted (vertical waste)
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

architecture struct of dpbram is

    constant this_module : string := "dpmem.dpbram";

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

    function extend(
        a : in std_logic_vector;
        b : in natural)
    return std_logic_vector is
        variable x : std_logic_vector(a'length - 1 downto 0);
    begin
        x := a;
        if b > x'length then
            return CONV_STD_LOGIC_VECTOR(0, b - x'length) & x;
        else
            return x(x'low + b - 1 downto x'low);
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

    function min(
        a : in integer;
        b : in integer)
    return integer is
    begin
        if a > b then
            return b;
        else
            return a;
        end if;
    end;

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
    constant order_min : natural := log2up(blockram_min_depth(family));
    constant order_max : natural := log2up(blockram_max_depth(family));

    -- Adjust the port address widths so that they are realisable using BlockRAMs
    constant order0_adj : natural :=
        choice(order0, max(order_min, order0), depth_waste);
    constant order1_adj : natural :=
        choice(order1, max(order_min, order1), depth_waste);

    -- Make port A the narrower port
    constant a_width : natural := choice(width1, width0, order1_adj < order0_adj);
    constant a_order : natural := choice(order1_adj, order0_adj, order1_adj < order0_adj);
    constant a_order_nadj : natural := choice(order1, order0, order1_adj < order0_adj);
    constant b_width : natural := choice(width0, width1, order1_adj < order0_adj);
    constant b_order : natural := choice(order0_adj, order1_adj, order1_adj < order0_adj);
    constant b_order_nadj : natural := choice(order0, order1, order1_adj < order0_adj);

    constant a_depth              : natural := 2**a_order;
    constant a_depth_nadj         : natural := 2**a_order_nadj;
    constant a_inst_data_width    : natural :=
        min(blockram_data_size(family) / a_depth, blockram_max_data_width(family));
    constant a_inst_parity_width  : natural := a_inst_data_width / blockram_parity_ratio(family);
    constant a_inst_width         : natural := a_inst_data_width + a_inst_parity_width;
    constant a_num_inst           : natural := (a_width + a_inst_width - 1) / a_inst_width;
    constant a_array_width        : natural := a_num_inst * a_inst_width;

    constant b_depth              : natural := 2**b_order;
    constant b_depth_nadj         : natural := 2**b_order_nadj;
    constant b_inst_data_width    : natural :=
        min(blockram_data_size(family) / b_depth, blockram_max_data_width(family));
    constant b_inst_parity_width  : natural := b_inst_data_width / blockram_parity_ratio(family);
    constant b_inst_width         : natural := b_inst_data_width + b_inst_parity_width;
    constant b_num_inst           : natural := (b_width + b_inst_width - 1) / b_inst_width;
    constant b_array_width        : natural := b_num_inst * b_inst_width;

    constant inst_init_length     : natural := b_depth * b_inst_width;

    function generate_n(
        f : in family_t;
        x : in natural;
        y : in natural)
    return integer is
    begin
        if f = family and x = a_inst_width and y = b_inst_width then
            return a_num_inst;
        else
            return 0;
        end if;
    end;

    function get_init_slice(
        idx  : in natural;
        init : in std_logic_vector)
    return std_logic_vector is
        variable x    : std_logic_vector(inst_init_length - 1 downto 0);
        variable k, l : natural;
        variable tmp  : std_logic;
    begin
        k := idx * b_inst_width;
        for i in 0 to b_depth - 1 loop
            for j in 0 to b_inst_width - 1 loop
                l := j + k;
                if l < b_width and i < b_depth_nadj then
                    tmp := init(i * b_width + l);
                else
                    tmp := '0';
                end if;
                x(i * b_inst_width + j) := tmp;
            end loop;
        end loop;

        return x;
    end;

    signal dpbram0_a0  : std_logic_vector(a_order - 1 downto 0);
    signal dpbram0_d0  : std_logic_vector(a_array_width - 1 downto 0);
    signal dpbram0_q0  : std_logic_vector(a_array_width - 1 downto 0);
    signal dpbram0_en0 : std_logic;
    signal dpbram0_k0  : std_logic;
    signal dpbram0_w0  : std_logic;
    signal dpbram0_sr0 : std_logic;
    signal dpbram0_a1  : std_logic_vector(b_order - 1 downto 0);
    signal dpbram0_d1  : std_logic_vector(b_array_width - 1 downto 0);
    signal dpbram0_q1  : std_logic_vector(b_array_width - 1 downto 0);
    signal dpbram0_en1 : std_logic;
    signal dpbram0_k1  : std_logic;
    signal dpbram0_w1  : std_logic;
    signal dpbram0_sr1 : std_logic;

begin

    -- synopsys translate_off

    -- Check that address with for port 0 is in bounds
    assert depth_waste or order0 >= order_min
        report "*** " & this_module & ": order0 (" & conv_string(order0) & ") too low"
        severity failure;
    assert order0 <= order_max
        report "*** " & this_module & ": order0 (" & conv_string(order0) & ") too high"
        severity failure;

    -- Check that address with for port 1 is in bounds
    assert depth_waste or order1 >= order_min
        report "*** " & this_module & ": order1 (" & conv_string(order1) & ") too low"
        severity failure;
    assert order1 <= order_max
        report "*** " & this_module & ": order1 (" & conv_string(order1) & ") too high"
        severity failure;

    -- Check that number of BlockRAMs required for ports 0 and 1 are the same
    assert a_num_inst = b_num_inst
        report "*** " & this_module & ": a_num_inst (" & conv_string(a_num_inst) &
               ") is not equal to b_num_inst (" & conv_string(b_num_inst) & ")"
        severity failure;

    -- Check that 'init' is of the required dimension
    assert init'length = b_depth_nadj * b_width
        report "*** " & this_module & ": init'length (" & conv_string(init'length) &
               ") does not match b_depth_nadj (" & conv_string(b_depth_nadj) & ") and b_width (" &
               conv_string(b_width) & ")"
        severity failure;

    -- synopsys translate_on

    dpbram0_a0  <= extend(a0, a_order)        when order1_adj <= order0_adj else extend(a1, a_order);
    dpbram0_d0  <= extend(d0, a_array_width)  when order1_adj <= order0_adj else extend(d1, a_array_width);
    dpbram0_en0 <= en0                        when order1_adj <= order0_adj else en1;
    dpbram0_k0  <= k0                         when order1_adj <= order0_adj else k1;
    dpbram0_w0  <= w0                         when order1_adj <= order0_adj else w1;
    dpbram0_sr0 <= sr0                        when order1_adj <= order0_adj else sr1;
    q0          <= extend(dpbram0_q0, width0) when order1_adj <= order0_adj else extend(dpbram0_q1, width0);
    dpbram0_a1  <= extend(a1, b_order)        when order1_adj <= order0_adj else extend(a0, b_order);
    dpbram0_d1  <= extend(d1, b_array_width)  when order1_adj <= order0_adj else extend(d0, b_array_width);
    dpbram0_en1 <= en1                        when order1_adj <= order0_adj else en0;
    dpbram0_k1  <= k1                         when order1_adj <= order0_adj else k0;
    dpbram0_w1  <= w1                         when order1_adj <= order0_adj else w0;
    dpbram0_sr1 <= sr1                        when order1_adj <= order0_adj else sr0;
    q1          <= extend(dpbram0_q1, width1) when order1_adj <= order0_adj else extend(dpbram0_q0, width1);

    generate_dpbram0 : for i in 0 to a_num_inst - 1 generate
        dpbram0_0 : dpbram0
            generic map(
                order0    => a_order,
                width0    => a_inst_width,
                order1    => b_order,
                width1    => b_inst_width,
                -- synopsys translate_off
                init      => get_init_slice(i, init),
                -- synopsys translate_on
                family    => family)
            port map(
                rst       => rst,
                k0        => dpbram0_k0,
                sr0       => dpbram0_sr0,
                en0       => dpbram0_en0,
                w0        => dpbram0_w0,
                a0        => dpbram0_a0(a_order - 1 downto 0),
                d0        => dpbram0_d0(a_inst_width * (i + 1) - 1 downto a_inst_width * i),
                q0        => dpbram0_q0(a_inst_width * (i + 1) - 1 downto a_inst_width * i),
                k1        => dpbram0_k1,
                sr1       => dpbram0_sr1,
                en1       => dpbram0_en1,
                w1        => dpbram0_w1,
                a1        => dpbram0_a1(b_order - 1 downto 0),
                d1        => dpbram0_d1(b_inst_width * (i + 1) - 1 downto b_inst_width * i),
                q1        => dpbram0_q1(b_inst_width * (i + 1) - 1 downto b_inst_width * i));
    end generate;

end;
