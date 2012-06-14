--
-- ddr2sdram_port.vhd - DDR-II SDRAM memory interface
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
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

library work;
use work.memif.all;
use work.memif_int.all;
--use work.ilap.all;

entity ddr2sdram_port is
    generic(
        auto_train      : in    boolean := true;
        pinout          : in    ddr2sdram_pinout_t;
        timing          : in    ddr2sdram_timing_t;
        ra_width        : in    natural;
        rc_width        : in    natural;
        rd_width        : in    natural;
        a_width         : in    natural;
        d_width         : in    natural;
        tag_width       : in    natural);
    port(
        -- To/from DDR-II SDRAM infrastructure
        clk0            : in    std_logic;      -- Interface clock
        clk45           : in    std_logic;      -- As 'clk2x90' but divided by 2
        clk2x0          : in    std_logic;      -- As 'clk0' but double frequency
        clk2x90         : in    std_logic;      -- As 'clk2x0' but -90 deg. phase shift
        rst             : in    std_logic;      -- Reset
        -- To/from application
        sr              : in    std_logic;                                   -- Synchronous reset
        ce              : in    std_logic;                                   -- Command enable, qualified by 'ready'
        tag             : in    std_logic_vector(tag_width - 1 downto 0);    -- Tag, qualified by 'ce and not w')
        w               : in    std_logic;                                   -- 1 => write, qualified by 'ce')
        a               : in    std_logic_vector(a_width - 1 downto 0);      -- Address, qualified by 'ce'
        d               : in    std_logic_vector(d_width - 1 downto 0);      -- Write data, qualified by 'ce and w'
        be              : in    std_logic_vector(d_width / 8 - 1 downto 0);  -- Write byte enables, qualified by 'ce and w'
        q               : out   std_logic_vector(d_width - 1 downto 0);      -- Read data, qualified by 'valid'
        qtag            : out   std_logic_vector(tag_width - 1 downto 0);    -- Read tag, qualified by 'valid'
        valid           : out   std_logic;                                   -- 1 => 'q' and 'qtag' are valid
        ready           : out   std_logic;                                   -- When low, indicates that 'ce' is ignored
        -- Sideband control signals (inputs must be stable during operation)
        row             : in    std_logic_vector(1 downto 0);                -- row addr width: 00 => 12, ... , 11 => 15
        col             : in    std_logic_vector(1 downto 0);                -- col addr width: 00 => row - 4, ... , 11 => row - 1
        bank            : in    std_logic_vector(1 downto 0);                -- bank addr width: 00 => 0, ... , 11 => 3
        pbank           : in    std_logic_vector(1 downto 0);                -- num. phys banks: 00 => 1, ... , 11 => 8
        trained         : out   std_logic;                                   -- 1 => training was successful
        -- To/from memories
        ra              : out   std_logic_vector(ra_width - 1 downto 0);
        rc              : inout std_logic_vector(rc_width - 1 downto 0);
        rd              : inout std_logic_vector(rd_width - 1 downto 0));
end;

architecture mixed of ddr2sdram_port is

    constant this_module : string := "ddr2sdram_port";

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

    function max(
        a, b : in integer)
    return integer is
    begin
        if a > b then
            return a;
        else
            return b;
        end if;
    end;

    function choice(
        a, b : in integer;
        p : in boolean)
    return integer is
    begin
        if p then
            return b;
        else
            return a;
        end if;
    end;

    component IBUF is
        port(
            I   : in    std_logic;
            O   : out   std_logic);
    end component;

    component IBUFDS is
        port(
            I   : in    std_logic;
            IB  : in    std_logic;
            O   : out   std_logic);
    end component;

    component IOBUF is
        port(
            I   : in    std_logic;
            IO  : inout std_logic;
            O   : out   std_logic;
            T   : in    std_logic);
    end component;

    component IOBUFDS
        port(
            I   : in    std_logic;
            IO  : inout std_logic;
            IOB : inout std_logic;
            O   : out   std_logic;
            T   : in    std_logic);
    end component;

    component OBUF is
        port(
            I   : in    std_logic;
            O   : out   std_logic);
    end component;

    component OBUFDS is
        port(
            I   : in    std_logic;
            O   : out   std_logic;
            OB  : out   std_logic);
    end component;

    component OBUFT is
        port(
            I   : in    std_logic;
            O   : out   std_logic;
            T   : in    std_logic);
    end component;

    component ddr2sdram_clkfw
        generic(
            num_clock       : in  natural);
        port (
            clk2x           : in  std_logic;
            rst             : in  std_logic;
            ddr_clk         : out std_logic_vector(num_clock - 1 downto 0);
            ddr_clk_l       : out std_logic_vector(num_clock - 1 downto 0));
    end component;

    component ddr2sdram_ctrl
        generic(
            rowcol_width    : in  natural;
            bank_width      : in  natural;
            num_phys_bank   : in  natural;
            num_clock_en    : in  natural);
        port(
            clk             : in  std_logic;
            rst             : in  std_logic;
            sr              : in  std_logic;
            mux_col         : in  std_logic;
            mux_special     : in  std_logic;
            row_addr        : in  std_logic_vector(rowcol_width - 1 downto 0);
            col_addr        : in  std_logic_vector(rowcol_width - 1 downto 0);
            special_addr    : in  std_logic_vector(rowcol_width + bank_width - 1 downto 0);
            bank_addr       : in  std_logic_vector(bank_width - 1 downto 0);
            pbank_addr_1h   : in  std_logic_vector(num_phys_bank - 1 downto 0);
            cke             : in  std_logic;
            command         : in  std_logic_vector(4 downto 0);
            ddr_cke_o       : out std_logic_vector(num_clock_en - 1 downto 0);
            ddr_cs_o_l      : out std_logic_vector(num_phys_bank - 1 downto 0);
            ddr_we_o_l      : out std_logic;
            ddr_ras_o_l     : out std_logic;
            ddr_cas_o_l     : out std_logic;
            ddr_addr_o      : out std_logic_vector(rowcol_width - 1 downto 0);
            ddr_ba_o        : out std_logic_vector(bank_width - 1 downto 0));
    end component;

    component ddr2sdram_dm
        generic(
            be_width        : in  natural;
            dm_width        : in  natural);
        port(
            clk0            : in  std_logic;
            clk45           : in  std_logic;
            clk2x0          : in  std_logic;
            clk2x90         : in  std_logic;
            sr              : in  std_logic_vector(dm_width - 1 downto 0);
            ce              : in  std_logic_vector(dm_width - 1 downto 0);
            oe_l            : in  std_logic_vector(dm_width - 1 downto 0);
            be_l            : in  std_logic_vector(be_width - 1 downto 0);
            dm_o            : out std_logic_vector(dm_width - 1 downto 0);
            dm_t            : out std_logic_vector(dm_width - 1 downto 0));
    end component;

    component ddr2sdram_dq_in
        generic(
            dqs_width       : in  natural;
            dq_width        : in  natural;
            d_width         : in  natural;
            tag_width       : in  natural);
        port( 
            clk0            : in  std_logic;
            clk45           : in  std_logic;
            clk2x0          : in  std_logic;
            clk2x90         : in  std_logic;
            sr              : in  std_logic_vector(dq_width - 1 downto 0);
            ce              : in  std_logic_vector(dq_width - 1 downto 0);
            dlysr           : in  std_logic_vector(dq_width - 1 downto 0);
            dlyce           : in  std_logic_vector(dq_width - 1 downto 0);
            dlyinc          : in  std_logic_vector(dq_width - 1 downto 0);
            qce             : in  std_logic_vector(dq_width - 1 downto 0);
            qdelay          : in  std_logic_vector(dq_width * 2 - 1 downto 0);
            vdelay          : in  std_logic_vector(3 downto 0);
            rd              : in  std_logic;
            init_done       : in  std_logic;
            tag             : in  std_logic_vector(tag_width - 1 downto 0);
            dqs_i           : in  std_logic_vector(dqs_width - 1 downto 0);
            dq_i            : in  std_Logic_vector(dq_width - 1 downto 0);
            q               : out std_logic_vector(d_width - 1 downto 0);
            qtag            : out std_logic_vector(tag_width - 1 downto 0);
            valid           : out std_logic;
            init_valid      : out std_logic);
    end component;

    component ddr2sdram_dq_in_dc
        generic(
            dqs_width       : in  natural;
            dq_width        : in  natural;
            d_width         : in  natural;
            tag_width       : in  natural);
        port( 
            clk0            : in  std_logic;
            clk45           : in  std_logic;
            clk2x0          : in  std_logic;
            clk2x90         : in  std_logic;
            sr              : in  std_logic_vector(dq_width - 1 downto 0);
            ce              : in  std_logic_vector(dq_width - 1 downto 0);
            dlysr           : in  std_logic_vector(dq_width - 1 downto 0);
            dlyce           : in  std_logic_vector(dq_width - 1 downto 0);
            dlyinc          : in  std_logic_vector(dq_width - 1 downto 0);
            qce             : in  std_logic_vector(dq_width - 1 downto 0);
            qdelay          : in  std_logic_vector(dq_width * 2 - 1 downto 0);
            vdelay          : in  std_logic_vector(3 downto 0);
            rd              : in  std_logic;
            init_done       : in  std_logic;
            tag             : in  std_logic_vector(tag_width - 1 downto 0);
            dq_i            : in  std_Logic_vector(dq_width - 1 downto 0);
            q               : out std_logic_vector(d_width - 1 downto 0);
            dq              : out std_logic_vector(dq_width - 1 downto 0);
            qtag            : out std_logic_vector(tag_width - 1 downto 0);
            valid           : out std_logic;
            init_valid      : out std_logic);
    end component;

    component ddr2sdram_dq_out
        generic(
            dq_width        : in  natural;
            d_width         : in  natural);
        port( 
            clk0            : in  std_logic;
            clk45           : in  std_logic;
            clk2x0          : in  std_logic;
            clk2x90         : in  std_logic;
            sr              : in  std_logic_vector(dq_width - 1 downto 0);
            ce              : in  std_logic_vector(dq_width - 1 downto 0);
            oe_l            : in  std_logic_vector(dq_width - 1 downto 0);
            d               : in  std_logic_vector(d_width - 1 downto 0);
            dq_o            : out std_logic_vector(dq_width - 1 downto 0);
            dq_t            : out std_Logic_vector(dq_width - 1 downto 0));
    end component;

    component ddr2sdram_dqs_in
        generic(
            dqs_width       : in  natural);
        port(
            rst             : in  std_logic;
            clk             : in  std_logic;
            dlysr           : in  std_logic_vector(dqs_width - 1 downto 0);
            dlyce           : in  std_logic_vector(dqs_width - 1 downto 0);
            dlyinc          : in  std_logic_vector(dqs_width - 1 downto 0);
            dqs_i           : in  std_logic_vector(dqs_width - 1 downto 0);
            dqs_idelay      : out std_logic_vector(dqs_width - 1 downto 0));
    end component;

    component ddr2sdram_dqs_out
        generic(
            dqs_width       : in  natural);
        port(
            clk             : in  std_logic;
            clk2x           : in  std_logic;
            sr              : in  std_logic_vector(dqs_width - 1 downto 0);
            ce              : in  std_logic_vector(dqs_width - 1 downto 0);
            oe_l            : in  std_logic_vector(dqs_width - 1 downto 0);
            wr              : in  std_logic;
            dqs_o           : out std_logic_vector(dqs_width - 1 downto 0);
            dqs_o_l         : out std_logic_vector(dqs_width - 1 downto 0);
            dqs_t           : out std_logic_vector(2 * dqs_width - 1 downto 0));
    end component;

    component ddr2sdram_init
        generic(
            auto_train      : in    boolean;
            direct_clocking : in    boolean;
            dq_width        : in    natural;
            dqs_width       : in    natural;
            rowcol_width    : in    natural;
            bank_width      : in    natural;
            cas_latency     : in    natural;
            t_refresh       : in    natural;
            t_act           : in    natural;
            t_mrd           : in    natural;
            t_dllr          : in    natural;
            t_rtp           : in    natural;
            t_wtp           : in    natural;
            t_rp            : in    natural;
            t_rfc           : in    natural);
        port(
            clk             : in    std_logic;
            rst             : in    std_logic;
            sr              : in    std_logic;
            ref_done        : in    std_logic;
            dq_i            : in    std_logic_vector(4 * dq_width - 1 downto 0);
            valid           : in    std_logic;
            ref_req         : out   std_logic;
            cke             : out   std_logic;
            done            : out   std_logic;
            command         : out   std_logic_vector(4 downto 0);
            addr            : out   std_logic_vector(rowcol_width + bank_width - 1 downto 0);
            dq_o            : out   std_logic_vector(4 * dq_width - 1 downto 0);
            rd              : out   std_logic;
            wr              : out   std_logic;
            trained         : out   std_logic;
            dlysr_dq        : out   std_logic_vector(dq_width - 1 downto 0);
            dlyce_dq        : out   std_logic_vector(dq_width - 1 downto 0);
            dlyinc_dq       : out   std_logic_vector(dq_width - 1 downto 0);
            dlysr_dqs       : out   std_logic_vector(dqs_width - 1 downto 0);
            dlyce_dqs       : out   std_logic_vector(dqs_width - 1 downto 0);
            dlyinc_dqs      : out   std_logic_vector(dqs_width - 1 downto 0);
            qce             : out   std_logic_vector(dq_width - 1 downto 0);
            qdelay          : out   std_logic_vector(dq_width * 2 - 1 downto 0);
            vdelay          : out   std_logic_vector(3 downto 0));
    end component;

    component ddr2sdram_odt
        generic(
            num_odt         : in    natural);
        port(
            clk             : in    std_logic;
            wr              : in    std_logic;
            odt_o           : out   std_logic_vector(num_odt - 1 downto 0));
    end component;

    -- Calculate counter lengths required for various timing parameters
    constant log2_t_refresh : natural := log2up(timing.t_refresh);
    constant log2_t_mrd : natural := log2up(timing.t_mrd);
    constant log2_t_rp : natural := log2up(timing.t_rp);
    constant log2_t_rfc : natural := log2up(timing.t_rfc);
    constant log2_t_act : natural := log2up(timing.t_act);
    constant log2_t_wtr : natural := log2up(timing.t_wtr);
    constant log2_t_rtw : natural := log2up(timing.t_rtw);
    constant log2_t_rtp : natural := log2up(timing.t_rtp);
    constant log2_t_wtp : natural := log2up(timing.t_wtp);
    constant log2_t_ras : natural := log2up(timing.t_ras);

    constant be_width : natural := d_width / 8;
    constant cmd_width : natural := d_width + be_width + a_width + 1 + tag_width;
    constant dqs_width : natural := rd_width / 8;
    constant dm_width : natural := rd_width / 8;

    constant cas_latency : natural := 4;
    constant max_rowcol_width : natural := pinout.num_addr_bits;
    constant max_bank_width : natural := pinout.num_bank_bits;
    constant max_num_phys_bank : natural := pinout.num_phys_bank;
    constant max_phys_bank_width : natural := log2up(max_num_phys_bank);
    constant max_page_width : natural := max_phys_bank_width + max_bank_width + max_rowcol_width;
    constant num_clock : natural := pinout.ck_width;
    constant num_clock_en : natural := pinout.cke_width;
    constant num_odt : natural := pinout.odt_width;

    constant direct_clocking : boolean := true;

    --
    -- Zero-extend without returning undefined values in extended bits if
    -- a lower bit is undefined.
    --
    function zextend(
        val          : in  std_logic_vector;
        n            : in  natural)
    return std_logic_vector is
        variable tmp : std_logic_vector(val'length - 1 downto 0);
        variable ret : std_logic_vector(n - 1 downto 0);
    begin
        tmp := val;
        if tmp'length < n then
            ret(tmp'high downto 0) := val;
            ret(n - 1 downto tmp'length) := (others => '0');
        else
            ret(n - 1 downto 0) := tmp(n - 1 downto 0);
        end if;
        return ret;
    end;

    --
    -- Split incoming address 'addr' into components: row, column, bank and
    -- physical bank. 'page' is concatenation of physical bank, bank and row.
    --
    procedure split_addr(
        addr         : in  std_logic_vector(a_width - 1 downto 0);
        row_sel      : in  std_logic_vector(1 downto 0);
        col_sel      : in  std_logic_vector(1 downto 0);
        bank_sel     : in  std_logic_vector(1 downto 0);
        pbank_sel    : in  std_logic_vector(1 downto 0);
        addr_row     : out std_logic_vector(max_rowcol_width - 1 downto 0);
        addr_col     : out std_logic_vector(max_rowcol_width - 1 downto 0);
        addr_bank    : out std_logic_vector(max_bank_width - 1 downto 0);
        addr_pbank1h : out std_logic_vector(max_num_phys_bank - 1 downto 0);
        page         : out std_logic_vector(a_width - 7 downto 0))
    is
        variable remaining : std_logic_vector(addr'range);
        variable sel : std_logic_vector(3 downto 0);
        variable addr_pbank : std_logic_vector(2 downto 0);
    begin
        sel := row_sel & col_sel;
        case sel is
            when "0000" => -- 12 rows / 8 cols
                addr_col := EXT(addr(5 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(17 downto 6), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 18), remaining'length);
                page := EXT(addr(addr'high downto 6), a_width - 6);
            when "0001" => -- 12 rows / 9 cols
                addr_col := EXT(addr(6 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(18 downto 7), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 19), remaining'length);
                page := EXT(addr(addr'high downto 7), a_width - 6);
            when "0010" => -- 12 rows / 10 cols
                addr_col := EXT(addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(19 downto 8), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 20), remaining'length);
                page := EXT(addr(addr'high downto 8), a_width - 6);
            when "0011" => -- 12 rows / 11 cols
                addr_col := EXT(addr(8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(20 downto 9), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 21), remaining'length);
                page := EXT(addr(addr'high downto 9), a_width - 6);
            when "0100" => -- 13 rows / 9 cols
                addr_col := EXT(addr(6 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(19 downto 7), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 20), remaining'length);
                page := EXT(addr(addr'high downto 7), a_width - 6);
            when "0101" => -- 13 rows / 10 cols
                addr_col := EXT(addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(20 downto 8), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 21), remaining'length);
                page := EXT(addr(addr'high downto 8), a_width - 6);
            when "0110" => -- 13 rows / 11 cols
                addr_col := EXT(addr(8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(21 downto 9), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 22), remaining'length);
                page := EXT(addr(addr'high downto 9), a_width - 6);
            when "0111" => -- 13 rows / 12 cols
                addr_col := EXT(addr(9 downto 8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(22 downto 10), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 23), remaining'length);
                page := EXT(addr(addr'high downto 10), a_width - 6);
            when "1000" => -- 14 rows / 10 cols
                addr_col := EXT(addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(21 downto 8), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 22), remaining'length);
                page := EXT(addr(addr'high downto 8), a_width - 6);
            when "1001" => -- 14 rows / 11 cols
                addr_col := EXT(addr(8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(22 downto 9), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 23), remaining'length);
                page := EXT(addr(addr'high downto 9), a_width - 6);
            when "1010" => -- 14 rows / 12 cols
                addr_col := EXT(addr(9 downto 8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(23 downto 10), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 24), remaining'length);
                page := EXT(addr(addr'high downto 10), a_width - 6);
            when "1011" => -- 14 rows / 13 cols
                addr_col := EXT(addr(10 downto 8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(24 downto 11), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 25), remaining'length);
                page := EXT(addr(addr'high downto 11), a_width - 6);
            when "1100" => -- 15 rows / 11 cols
                addr_col := EXT(addr(8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(23 downto 9), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 24), remaining'length);
                page := EXT(addr(addr'high downto 9), a_width - 6);
            when "1101" => -- 15 rows / 12 cols
                addr_col := EXT(addr(9 downto 8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(24 downto 10), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 25), remaining'length);
                page := EXT(addr(addr'high downto 10), a_width - 6);
            when "1110" => -- 15 rows / 13 cols
                addr_col := EXT(addr(10 downto 8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(25 downto 11), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 26), remaining'length);
                page := EXT(addr(addr'high downto 11), a_width - 6);
            when "1111" => -- 15 rows / 14 cols
                addr_col := EXT(addr(11 downto 8) & "0" & addr(7 downto 0) & "00", max_rowcol_width);
                addr_row := EXT(addr(26 downto 12), max_rowcol_width);
                remaining := EXT(addr(addr'high downto 27), remaining'length);
                page := EXT(addr(addr'high downto 12), a_width - 6);
            when others =>
                addr_col := (others => '-');
                addr_row := (others => '-');
                remaining := (others => '-');
                page := (others => '-');
        end case;

        sel := pbank_sel & bank_sel;
        case sel is
            when "0000" =>
                addr_bank := EXT("0", max_bank_width);
                addr_pbank := EXT("0", 3);
            when "0001" =>
                addr_bank := EXT(remaining(0 downto 0), max_bank_width);
                addr_pbank := EXT("0", 3);
            when "0010" =>
                addr_bank := EXT(remaining(1 downto 0), max_bank_width);
                addr_pbank := EXT("0", 3);
            when "0011" =>
                addr_bank := EXT(remaining(2 downto 0), max_bank_width);
                addr_pbank := EXT("0", 3);
            when "0100" =>
                addr_bank := EXT("0", max_bank_width);
                addr_pbank := EXT(remaining(0 downto 0), 3);
            when "0101" =>
                addr_bank := EXT(remaining(0 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(1 downto 1), 3);
            when "0110" =>
                addr_bank := EXT(remaining(1 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(2 downto 2), 3);
            when "0111" =>
                addr_bank := EXT(remaining(2 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(3 downto 3), 3);
            when "1000" =>
                addr_bank := EXT("0", max_bank_width);
                addr_pbank := EXT(remaining(1 downto 0), 3);
            when "1001" =>
                addr_bank := EXT(remaining(0 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(2 downto 1), 3);
            when "1010" =>
                addr_bank := EXT(remaining(1 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(3 downto 2), 3);
            when "1011" =>
                addr_bank := EXT(remaining(2 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(4 downto 3), 3);
            when "1100" =>
                addr_bank := EXT("0", max_bank_width);
                addr_pbank := EXT(remaining(2 downto 0), 3);
            when "1101" =>
                addr_bank := EXT(remaining(0 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(3 downto 1), 3);
            when "1110" =>
                addr_bank := EXT(remaining(1 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(4 downto 2), 3);
            when "1111" =>
                addr_bank := EXT(remaining(2 downto 0), max_bank_width);
                addr_pbank := EXT(remaining(5 downto 3), 3);
            when others =>
                addr_bank := (others => '-');
                addr_pbank := (others => '-');
        end case;

        for i in addr_pbank1h'range loop
            if addr_pbank = i then
                addr_pbank1h(i) := '1';
            else
                addr_pbank1h(i) := '0';
            end if;
        end loop;
    end;

    -- Order (4 downto 0) is (csall, cs#, ras#, cas#, we#)
    constant DDRCMD_NOP    : std_logic_vector(4 downto 0) := "-1111"; -- Deselect
    constant DDRCMD_ACT    : std_logic_vector(4 downto 0) := "00011"; -- Activate
    constant DDRCMD_READ   : std_logic_vector(4 downto 0) := "00101"; -- Read
    constant DDRCMD_WRITE  : std_logic_vector(4 downto 0) := "00100"; -- Write
    constant DDRCMD_PRE    : std_logic_vector(4 downto 0) := "10010"; -- Precharge
    constant DDRCMD_REF    : std_logic_vector(4 downto 0) := "10001"; -- Refresh

    signal lsrcnt : std_logic_vector(7 downto 0);
    signal lsr0 : std_logic;
    signal lsr1 : std_logic;

    signal ce0_dq, ce1_dq : std_logic;
    signal ce_dq : std_logic_vector(rd_width - 1 downto 0);
    signal ce_dm : std_logic_vector(dqs_width - 1 downto 0);
    signal sr0_dq : std_logic;
    signal sr_dq : std_logic_vector(rd_width - 1 downto 0);
    signal sr_dm : std_logic_vector(dqs_width - 1 downto 0);
    signal ce0_dqs, ce1_dqs : std_logic;
    signal ce_dqs : std_logic_vector(dqs_width - 1 downto 0);
    signal sr0_dqs : std_logic;
    signal sr_dqs : std_logic_vector(dqs_width - 1 downto 0);

    -- Signals to/from command FIFO (i.e. stage 0 of command pipeline)
    signal cmd_d : std_logic_vector(cmd_width - 1 downto 0);
    signal cmd_q : std_logic_vector(cmd_width - 1 downto 0);
    signal cmd_q_d : std_logic_vector(d_width - 1 downto 0);
    signal cmd_q_be : std_logic_vector(d_width / 8 - 1 downto 0);
    signal cmd_q_a : std_logic_vector(a_width - 1 downto 0);
    signal cmd_q_w : std_logic;
    signal cmd_q_tag : std_logic_vector(tag_width - 1 downto 0);
    signal cmd_empty : std_logic;
    signal cmd_read : std_logic;

    signal ddr_clk_o : std_logic_vector(num_clock - 1 downto 0);
    signal ddr_clk_o_l : std_logic_vector(num_clock - 1 downto 0);
    signal ddr_cs_o_l : std_logic_vector(max_num_phys_bank - 1 downto 0);
    signal ddr_ras_o_l : std_logic;
    signal ddr_cas_o_l : std_logic;
    signal ddr_we_o_l : std_logic;
    signal ddr_odt_o : std_logic_vector(num_odt - 1 downto 0);
    signal ddr_cke_o : std_logic_vector(num_clock_en - 1 downto 0);
    signal ddr_addr_o : std_logic_vector(max_rowcol_width - 1 downto 0);
    signal ddr_ba_o : std_logic_vector(max_bank_width - 1 downto 0);
    signal ddr_dm_o : std_logic_vector(dm_width - 1 downto 0);
    signal ddr_dm_t : std_logic_vector(dm_width - 1 downto 0);
    signal ddr_dq_i : std_logic_vector(rd_width - 1 downto 0);
    signal ddr_dq_o : std_logic_vector(rd_width - 1 downto 0);
    signal ddr_dq_t : std_logic_vector(rd_width - 1 downto 0);
    signal ddr_dqs_i : std_logic_vector(dqs_width - 1 downto 0);
    signal ddr_dqs_idelay : std_logic_vector(dqs_width - 1 downto 0);
    signal ddr_dqs_o : std_logic_vector(dqs_width - 1 downto 0);
    signal ddr_dqs_o_l : std_logic_vector(dqs_width - 1 downto 0);
    signal ddr_dqs_t : std_logic_vector(2 * dqs_width - 1 downto 0);

    -- IDELAY control signals for DQ and DQS
    signal i_dlysr_dq : std_logic_vector(rd_width - 1 downto 0);
    signal i_dlysr_dqs : std_logic_vector(dqs_width - 1 downto 0);
    signal i_dlyce_dq : std_logic_vector(rd_width - 1 downto 0);
    signal i_dlyce_dqs : std_logic_vector(dqs_width - 1 downto 0);
    signal i_dlyinc_dq : std_logic_vector(rd_width - 1 downto 0);
    signal i_dlyinc_dqs : std_logic_vector(dqs_width - 1 downto 0);
    signal i_qce : std_logic_vector(rd_width - 1 downto 0);
    signal i_qdelay : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal i_vdelay : std_logic_vector(3 downto 0);

    -- Command pipeline stage 1: splits address into row, column, bank, page etc.
    signal ce_split_addr : std_logic;
    signal a_col : std_logic_vector(max_rowcol_width - 1 downto 0);
    signal a_row : std_logic_vector(max_rowcol_width - 1 downto 0);
    signal a_bank : std_logic_vector(max_bank_width - 1 downto 0);
    signal a_pbank1h : std_logic_vector(max_num_phys_bank - 1 downto 0);
    signal a_page : std_logic_vector(a_width - 7 downto 0);
    signal cmd_q1_d : std_logic_vector(d_width - 1 downto 0);
    signal cmd_q1_be_l : std_logic_vector(d_width / 8 - 1 downto 0);
    signal cmd_q1_w : std_logic;
    signal cmd_q1_tag : std_logic_vector(tag_width - 1 downto 0);
    signal full_addr : std_logic;

    -- Command pipeline stage 2: generates 'page_hit'
    signal ce_page_hit : std_logic;
    signal page_hit : std_logic;
    signal a_col_q, a_col_qq : std_logic_vector(max_rowcol_width - 1 downto 0);
    signal a_row_q, a_row_qq : std_logic_vector(max_rowcol_width - 1 downto 0);
    signal a_bank_q, a_bank_qq : std_logic_vector(max_bank_width - 1 downto 0);
    signal a_pbank1h_q, a_pbank1h_qq : std_logic_vector(max_num_phys_bank - 1 downto 0);
    signal a_page_q : std_logic_vector(a_width - 7 downto 0);
    signal cmd_q2_d : std_logic_vector(d_width - 1 downto 0);
    signal cmd_q2_be_l : std_logic_vector(d_width / 8 - 1 downto 0);
    signal cmd_q2_w : std_logic;
    signal cmd_q2_tag : std_logic_vector(tag_width - 1 downto 0);
    signal req_cycle : std_logic;
    alias req_cycle_w is cmd_q2_w;

    -- Signals delayed by additional cycle, to match delay on 'ddr_wr'
    signal cmd_q3_d : std_logic_vector(d_width - 1 downto 0);
    signal cmd_q4_d : std_logic_vector(d_width - 1 downto 0);
    signal cmd_q5_d : std_logic_vector(d_width - 1 downto 0);
    signal cmd_q3_be_l : std_logic_vector(d_width / 8 - 1 downto 0);
    signal cmd_q4_be_l : std_logic_vector(d_width / 8 - 1 downto 0);
    signal cmd_q5_be_l : std_logic_vector(d_width / 8 - 1 downto 0);
    signal cmd_q3_tag : std_logic_vector(tag_width - 1 downto 0);
    signal cmd_q4_tag : std_logic_vector(tag_width - 1 downto 0);
    signal cmd_q5_tag : std_logic_vector(tag_width - 1 downto 0);

    -- Signals to and from init logic
    signal init_done : std_logic;
    signal init_addr : std_logic_vector(max_rowcol_width + max_bank_width - 1 downto 0);
    signal cke : std_logic;
    signal req_ref : std_logic;
    signal init_ddrcmd : std_logic_vector(4 downto 0);
    signal init_dq_o : std_logic_vector(4 * rd_width - 1 downto 0);
    signal init_ddr_rd : std_logic;
    signal init_ddr_wr : std_logic;
    signal init_valid : std_logic;

    -- Permissions for DDR commands
    signal allow_act : std_logic;
    signal allow_ref : std_logic;
    signal allow_pre : std_logic;

    -- Refresh command period timer
    signal done_ref : std_logic;
    signal count_rfc : std_logic_vector(log2_t_rfc downto 0);

    -- Tras(min) timer (minimum RAS assertion time)
    signal count_ras : std_logic_vector(log2_t_ras downto 0);
    signal allow_pre1 : std_logic;

    -- Twtp timer (write to precharge delay)
    signal count_twtp : std_logic_vector(log2_t_wtp downto 0);
    signal allow_pre2 : std_logic;

    -- Trtp timer (read to precharge delay)
    signal count_trtp : std_logic_vector(log2_t_rtp downto 0);
    signal allow_pre3 : std_logic;

    -- ACT command timer (ACT command period)
    signal done_act : std_logic;
    signal count_act : std_logic_vector(log2_t_act downto 0);
    signal curr_page : std_logic_vector(a_width - 7 downto 0);

    -- PRE command timer (PRE command period)
    signal done_pre : std_logic;
    signal count_pre : std_logic_vector(log2_t_rp downto 0);

    -- Twtr timer (write to read delay)
    signal count_wtr : std_logic_vector(log2_t_wtr downto 0);
    signal allow_read : std_logic;

    -- Trtw timer (read to write delay)
    signal count_rtw : std_logic_vector(log2_t_rtw downto 0);
    signal allow_write : std_logic;

    -- Main state machine; generates DDR commands
    type state1_type is (
        s1_initializing,
        s1_closed,
        s1_refreshing,
        s1_activating,
        s1_open,
        s1_precharging);
    signal state1, n_state1 : state1_type;
    signal n_ddrcmd, ddrcmd : std_logic_vector(4 downto 0);
    signal n_ddr_ready : std_logic;
    signal n_mux_col, mux_col : std_logic;
    signal n_mux_special, mux_special : std_logic;
    signal ddr_wr, n_ddr_wr : std_logic;
    signal ddr_wr_q : std_logic;
    signal ddr_wr_qq : std_logic;
    signal ddr_rd, n_ddr_rd : std_logic;
    signal ddr_rd_q : std_logic;

    signal n_special_addr, special_addr : std_logic_vector(max_rowcol_width + max_bank_width - 1 downto 0);
    -- Address (including bank) for 'precharge all banks'
    signal const_pre_addr : std_logic_vector(max_rowcol_width + max_bank_width - 1 downto 0);

    signal i_q : std_logic_vector(d_width - 1 downto 0);
    signal i_qtag : std_logic_vector(tag_width - 1 downto 0);
    signal i_valid : std_logic;
    signal i_ready : std_logic;
    signal i_trained : std_logic;

    signal dqs_oe_l : std_logic_vector(dqs_width - 1 downto 0);
    signal dm_oe_l : std_logic_vector(dqs_width - 1 downto 0);
    signal dq_oe_l : std_logic_vector(rd_width - 1 downto 0);

    signal ra_o : std_logic_vector(ra_width - 1 downto 0);
    signal rd_i : std_logic_vector(rd_width - 1 downto 0);

    signal logic0, logic1 : std_logic;

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of dq_oe_l : signal is "no";
    attribute equivalent_register_removal of dm_oe_l : signal is "no";
    attribute equivalent_register_removal of dqs_oe_l : signal is "no";
    attribute equivalent_register_removal of ce_dm : signal is "no";
    attribute equivalent_register_removal of ce_dq : signal is "no";
    attribute equivalent_register_removal of ce_dqs : signal is "no";
    attribute equivalent_register_removal of sr_dm : signal is "no";
    attribute equivalent_register_removal of sr_dq : signal is "no";
    attribute equivalent_register_removal of sr_dqs : signal is "no";

    attribute register_duplication : string;
    attribute register_duplication of lsr0 : signal is "no";
    attribute register_duplication of lsr1 : signal is "no";

    --
    -- Chipscope stuff
    --
--    signal trig0 : std_logic_vector(254 downto 0);
--    signal trig_out : std_logic;
--    attribute keep : string;
--    attribute keep of trig_out : signal is "true";

begin

    -- synopsys translate_off
    assert cas_latency <= 7
        report "*** " & this_module & ": illegal value " & conv_string(cas_latency) & " for cas_latency : greater than 7 cycles"
        severity failure;

    assert cas_latency >= 3
        report "*** " & this_module & ": illegal value " & conv_string(cas_latency) & " for cas_latency : less than 3 cycles"
        severity failure;

    assert timing.t_rp >= 2
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_rp) & " for t_rp : less than 2"
        severity failure;

    assert timing.t_rp <= 31
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_rp) & " for t_rp : greater than 31"
        severity failure;

    assert timing.t_rfc >= 2
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_rfc) & " for t_rfc : less than 2"
        severity failure;

    assert timing.t_rfc <= 63
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_rfc) & " for t_rfc : greater than 31"
        severity failure;

    assert timing.t_act >= 2
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_act) & " for t_act : less than 2"
        severity failure;

    assert timing.t_act <= 31
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_act) & " for t_act : greater than 31"
        severity failure;

    assert timing.t_wtr >= 2
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_wtr) & " for t_wtr : less than 2"
        severity failure;

    assert timing.t_rtw >= 2
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_rtw) & " for t_rtw : less than 2"
        severity failure;

    assert timing.t_rtp >= 1
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_rtp) & " for t_rtp : less than 1"
        severity failure;

    assert timing.t_wtp >= 2
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_wtp) & " for t_wtp : less than 2"
        severity failure;

    assert timing.t_ras >= 2
        report "*** " & this_module & ": illegal value " & conv_string(timing.t_ras) & " for t_ras : less than 2"
        severity failure;

    assert timing.t_act < timing.t_ras
        report "*** " & this_module & ": illegal values of t_act " & conv_string(timing.t_act) & " and t_ras " &
               conv_string(timing.t_ras) & " : t_act must be less than t_ras"
        severity failure;
    -- synopsys translate_on

    logic0 <= '0';
    logic1 <= '1';

    valid <= i_valid;
    q <= i_q;
    qtag <= i_qtag;
    ready <= i_ready;
    trained <= i_trained;

    --
    -- Output DDR-II SDRAM address bus
    --

    ra_o <= ddr_ba_o & ddr_addr_o;

    iobuf_ra : for i in 0 to ra_width - 1 generate
        U0 : OBUF
            port map(
                I => ra_o(i),
                O => ra(i));
    end generate;

    --
    -- Input/output DDR-II SDRAM control bus
    --

    iobuf_dm : for i in 0 to dm_width - 1 generate
        U0 : OBUFT
            port map(
                I => ddr_dm_o(i),
                O => rc(i),
                T => ddr_dm_t(i));
    end generate;

    iobuf_dqs : for i in 0 to dqs_width - 1 generate
        U0 : OBUFT
            port map(
                I => ddr_dqs_o(i),
                O => rc(i + dm_width),
                T => ddr_dqs_t(i));

        U1 : OBUFT
            port map(
                I => ddr_dqs_o_l(i),
                O => rc(i + dm_width + dqs_width),
                T => ddr_dqs_t(i + dqs_width));
    end generate;

    iobuf_clk : for i in 0 to num_clock - 1 generate
        U0 : OBUF
            port map(
                I => ddr_clk_o(i),
                O => rc(i + dm_width + 2 * dqs_width));

        U1 : OBUF
            port map(
                I => ddr_clk_o_l(i),
                O => rc(i + dm_width + 2 * dqs_width + num_clock));
    end generate;

    iobuf_cke : for i in 0 to num_clock_en - 1 generate
        U0 : OBUF
            port map(
                I => ddr_cke_o(i),
                O => rc(i + dm_width + 2 * dqs_width + 2 * num_clock));
    end generate;

    iobuf_odt : for i in 0 to num_odt - 1 generate
        U0 : OBUF
            port map(
                I => ddr_odt_o(i),
                O => rc(dm_width + 2 * dqs_width + 2 * num_clock + num_clock_en + i));
    end generate;

    iobuf_we : OBUF
        port map(
            I => ddr_we_o_l,
            O => rc(dm_width + 2 * dqs_width + 2 * num_clock + num_clock_en + num_odt));

    iobuf_cas : OBUF
        port map(
            I => ddr_cas_o_l,
            O => rc(dm_width + 2 * dqs_width + 2 * num_clock + num_clock_en + num_odt + 1));

    iobuf_ras : OBUF
        port map(
            I => ddr_ras_o_l,
            O => rc(dm_width + 2 * dqs_width + 2 * num_clock + num_clock_en + num_odt + 2));

    iobuf_cs : for i in 0 to max_num_phys_bank - 1 generate
        U0 : OBUF
            port map(
                I => ddr_cs_o_l(i),
                O => rc(i + dm_width + 2 * dqs_width + 2 * num_clock + num_clock_en + num_odt + 3));
    end generate;

    --
    -- Input/output DDR-II SDRAM data bus
    --

    rd_iobs : for i in 0 to rd_width - 1 generate
        U0 : IOBUF
            port map(
                I => ddr_dq_o(i),
                IO => rd(i),
                O => ddr_dq_i(i),
                T => ddr_dq_t(i));
    end generate;

    --
    -- Generate local reset for module
    --

    local_reset : process(clk0, rst)
    begin
        if rst = '1' then
            lsrcnt <= (others => '0');
            lsr0 <= '1';
            lsr1 <= '1';
        elsif clk0'event and clk0 = '1' then
            if sr = '1' then
                lsrcnt <= (others => '0');
                lsr0 <= '1';
                lsr1 <= '1';
            else
                if lsr0 = '1' then
                    lsrcnt <= lsrcnt + 1;
                    if AND_reduce(lsrcnt) = '1' then
                        lsr0 <= '0';
                    end if;
                    if AND_reduce(lsrcnt(lsrcnt'high - 1 downto 0)) = '1' then
                        lsr1 <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;

    --
    -- Generate local reset and clock enables for ISERDES and OSERDES primitives for DQ / DM pins
    --

    local_reset_dq : process(clk45, rst)
    begin
        if rst = '1' then
            ce0_dq <= '0';
            ce1_dq <= '0';
            ce_dm <= (others => '0');
            ce_dq <= (others => '0');
            sr0_dq <= '1';
            sr_dm <= (others => '1');
            sr_dq <= (others => '1');
        elsif clk45'event and clk45 = '1' then
            if lsr0 = '1' then
                ce0_dq <= '0';
                ce1_dq <= '0';
                ce_dm <= (others => '0');
                ce_dq <= (others => '0');
            else
                ce0_dq <= '1';
                ce1_dq <= ce0_dq;
                ce_dm <= (others => ce1_dq);
                ce_dq <= (others => ce1_dq);
            end if;

            if lsr1 = '1' then
                sr0_dq <= '1';
                sr_dm <= (others => '1');
                sr_dq <= (others => '1');
            else
                sr0_dq <= '0';
                sr_dm <= (others => sr0_dq);
                sr_dq <= (others => sr0_dq);
            end if;
        end if;
    end process;

    --
    -- Generate local reset and clock enables for OSERDES primitives for DQS pins
    --

    local_reset_dqs : process(clk0, rst)
    begin
        if rst = '1' then
            ce0_dqs <= '0';
            ce1_dqs <= '0';
            ce_dqs <= (others => '0');
            sr0_dqs <= '1';
            sr_dqs <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            if lsr0 = '1' then
                ce0_dqs <= '0';
                ce1_dqs <= '0';
                ce_dqs <= (others => '0');
            else
                ce0_dqs <= '1';
                ce1_dqs <= ce0_dqs;
                ce_dqs <= (others => ce1_dqs);
            end if;

            if lsr1 = '1' then
                sr0_dqs <= '1';
                sr_dqs <= (others => '1');
            else
                sr0_dqs <= '0';
                sr_dqs <= (others => sr0_dqs);
            end if;
        end if;
    end process;

    --
    -- Buffer incoming commands in command FIFO
    --

    cmd_d <= tag & w & a & be & d;
    cmd_read <= ce_split_addr;

    cmd_fifo_0 : cmd_fifo
        generic map(
            width => cmd_width)
        port map(
            clk => clk0,
            rst => logic0,
            sr => lsr1,
            w => ce,
            d => cmd_d,
            ready => i_ready,
            r => cmd_read,
            empty => cmd_empty,
            q => cmd_q);

    cmd_q_d <= cmd_q(d_width - 1 downto 0);
    cmd_q_be <= cmd_q(d_width + be_width - 1 downto d_width);
    cmd_q_a <= cmd_q(d_width + be_width + a_width - 1 downto d_width + be_width);
    cmd_q_w <= cmd_q(d_width + be_width + a_width );
    cmd_q_tag <= cmd_q(d_width + be_width + a_width + tag_width downto d_width + be_width + a_width + 1);

    --
    -- Split incoming address into column, row and bank.
    --

    ce_split_addr <= not cmd_empty and (not full_addr or not req_cycle or n_ddr_ready);

    split_cmd_q_a : process(clk0)
        variable c, r : std_logic_vector(max_rowcol_width - 1 downto 0);
        variable b : std_logic_vector(max_bank_width - 1 downto 0);
        variable pb1h : std_logic_vector(max_num_phys_bank - 1 downto 0);
        variable pg : std_logic_vector(a_width - 7 downto 0);
    begin
        if clk0'event and clk0 = '1' then
            if ce_split_addr = '1' then
                split_addr(cmd_q_a, row, col, bank, pbank, r, c, b, pb1h, pg);
                a_row <= r;
                a_col <= c;
                a_bank <= b;
                a_pbank1h <= pb1h;
                a_page <= pg;
                cmd_q1_d <= cmd_q_d;
                cmd_q1_be_l <= not cmd_q_be;
                cmd_q1_w <= cmd_q_w;
                cmd_q1_tag <= cmd_q_tag;
            end if;
        end if;
    end process;

    --
    -- Determine whether 'a_page' (page index) is the same as 'curr_page' (current page)
    --

    ce_page_hit <= full_addr and (not req_cycle or n_ddr_ready);

    check_page : process(clk0)
        variable xxx : std_logic_vector(1 downto 0);
    begin
        if clk0'event and clk0 = '1' then
            if ce_page_hit = '1' then
                a_row_q <= a_row;
                a_col_q <= a_col;
                a_bank_q <= a_bank;
                a_pbank1h_q <= a_pbank1h;
                a_page_q <= a_page;
                cmd_q2_d <= cmd_q1_d;
                cmd_q2_be_l <= cmd_q1_be_l;
                cmd_q2_w <= cmd_q1_w;
                cmd_q2_tag <= cmd_q1_tag;
            end if;

            if lsr0 = '1' then
                page_hit <= '0';
            else
                xxx := done_act & ce_page_hit;
                case xxx is
                    when "00" =>
                        null;
                    when "01" =>            
                        if state1 = s1_open then
                            page_hit <= AND_reduce(a_page xnor curr_page);
                        else
                            page_hit <= '0';
                        end if;
                    when "10" =>
                        page_hit <= '1';
                    when others =>
                        page_hit <= '-';
                end case;
            end if;

            a_row_qq <= a_row_q;
            a_col_qq <= a_col_q;
            a_bank_qq <= a_bank_q;
            if init_done = '1' then
                a_pbank1h_qq <= a_pbank1h_q;
            else
                a_pbank1h_qq <= EXT("1", a_pbank1h_qq'length);
            end if;

            -- synopsys translate_off
            assert done_act = '0' or ce_page_hit = '0'
                report "+++ check_page: done_act and ce_page_hit asserted in same cycle"
                severity warning;
            -- synopsys translate_on
        end if;
    end process;



    --
    -- Delay tag and data by one more cycle, to match delay on 'ddr_wr'
    --

    delay_wr : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if init_done = '1' then
                cmd_q3_d <= cmd_q2_d;
            else
                cmd_q3_d <= init_dq_o;
            end if;
            cmd_q4_d <= cmd_q3_d;
            cmd_q5_d <= cmd_q4_d;
            if init_done = '1' then
                cmd_q3_be_l <= cmd_q2_be_l;
            else
                cmd_q3_be_l <= (others => '0');
            end if;
            cmd_q4_be_l <= cmd_q3_be_l;
            cmd_q5_be_l <= cmd_q4_be_l;
            cmd_q3_tag <= cmd_q2_tag;
            cmd_q4_tag <= cmd_q3_tag;
            cmd_q5_tag <= cmd_q4_tag;
        end if;
    end process;

    --
    -- Generate address/write/be/tag/data pipeline state
    --

    cmd_pipe_state : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if lsr0 = '1' then
                full_addr <= '0';
                req_cycle <= '0';
            else
                full_addr <= not cmd_empty or (full_addr and req_cycle and not n_ddr_ready);
                req_cycle <= full_addr or (req_cycle and not n_ddr_ready);
            end if;
        end if;
    end process;

    --
    -- Main state machine; pulls commands out of command FIFO and generates commands
    -- for DDR-II SDRAM memories.
    --

    allow_act <= '1'; -- TO DO
    allow_ref <= '1'; -- TO DO

    gen_state1 : process(rst, clk0)
    begin
        if rst = '1' then
            state1 <= s1_initializing;
            ddrcmd <= DDRCMD_NOP;
            mux_col <= '-';
            mux_special <= '1';
            ddr_wr <= '0';
            ddr_wr_q <= '0';
            ddr_wr_qq <= '0';
            ddr_rd <= '0';
            ddr_rd_q <= '0';
        elsif clk0'event and clk0 = '1' then
            if lsr0 = '1' then
                state1 <= s1_initializing;
                ddrcmd <= DDRCMD_NOP;
                mux_col <= '-';
                mux_special <= '1';
                ddr_wr <= '0';
                ddr_wr_q <= '0';
                ddr_wr_qq <= '0';
                ddr_rd <= '0';
                ddr_rd_q <= '0';
            else
                state1 <= n_state1;
                ddrcmd <= n_ddrcmd;
                mux_col <= n_mux_col;
                mux_special <= n_mux_special;
                ddr_wr <= n_ddr_wr;
                ddr_wr_q <= ddr_wr;
                ddr_wr_qq <= ddr_wr_q;
                ddr_rd <= n_ddr_rd;
                ddr_rd_q <= ddr_rd;
            end if;
        end if;
    end process;

    gen_n_state1 : process(
        state1,
        init_done,
        allow_act,
        allow_pre,
        allow_read,
        allow_ref,
        allow_write,
        done_act,
        done_pre,
        done_ref,
        init_ddrcmd,
        init_ddr_rd,
        init_ddr_wr,
        page_hit,
        req_cycle,
        req_cycle_w,
        req_ref)
    begin
        case state1 is
            when s1_initializing =>
                if init_done = '1' then
                    n_state1 <= s1_closed;
                    n_ddrcmd <= DDRCMD_NOP;
                    n_mux_col <= '-';
                    n_mux_special <= '-';
                else
                    n_state1 <= s1_initializing;
                    n_ddrcmd <= init_ddrcmd;
                    n_mux_col <= '-';
                    n_mux_special <= '1';
                end if;
                n_ddr_ready <= '0';
                n_ddr_wr <= init_ddr_wr;
                n_ddr_rd <= init_ddr_rd;

            when s1_closed =>
                if req_ref = '1' then
                    if allow_ref = '1' then
                        n_state1 <= s1_refreshing;
                        n_ddrcmd <= DDRCMD_REF;
                        n_mux_col <= '-';
                        n_mux_special <= '-';
                    else
                        n_state1 <= s1_closed;
                        n_ddrcmd <= DDRCMD_NOP;
                        n_mux_col <= '-';
                        n_mux_special <= '-';
                    end if;
                else
                    if req_cycle = '1' and allow_act = '1' then
                        n_state1 <= s1_activating;
                        n_ddrcmd <= DDRCMD_ACT;
                        n_mux_col <= '0';
                        n_mux_special <= '0';
                    else
                        n_state1 <= s1_closed;
                        n_ddrcmd <= DDRCMD_NOP;
                        n_mux_col <= '-';
                        n_mux_special <= '-';
                    end if;
                end if;
                n_ddr_ready <= '0';
                n_ddr_wr <= '0';
                n_ddr_rd <= '0';

            when s1_refreshing =>
                if done_ref = '1' then
                    n_state1 <= s1_closed;
                    n_ddrcmd <= DDRCMD_NOP;
                    n_mux_col <= '-';
                    n_mux_special <= '-';
                else
                    n_state1 <= s1_refreshing;
                    n_ddrcmd <= DDRCMD_NOP;
                    n_mux_col <= '-';
                    n_mux_special <= '-';
                end if;
                n_ddr_ready <= '0';
                n_ddr_wr <= '0';
                n_ddr_rd <= '0';

            when s1_activating =>
                if done_act = '1' then
                    n_state1 <= s1_open;
                    n_ddrcmd <= DDRCMD_NOP;
                    n_mux_col <= '-';
                    n_mux_special <= '-';
                else
                    n_state1 <= s1_activating;
                    n_ddrcmd <= DDRCMD_NOP;
                    n_mux_col <= '-';
                    n_mux_special <= '-';
                end if;
                n_ddr_ready <= '0';
                n_ddr_wr <= '0';
                n_ddr_rd <= '0';

            when s1_open =>
                if req_ref = '1' then
                    if allow_pre = '1' then
                        n_state1 <= s1_precharging;
                        n_ddrcmd <= DDRCMD_PRE;
                        n_ddr_wr <= '0';
                        n_ddr_rd <= '0';
                        n_ddr_ready <= '0';
                        n_mux_col <= '-';
                        n_mux_special <= '1';
                   else
                        n_state1 <= s1_open;
                        n_ddrcmd <= DDRCMD_NOP;
                        n_ddr_wr <= '0';
                        n_ddr_rd <= '0';
                        n_ddr_ready <= '0';
                        n_mux_col <= '-';
                        n_mux_special <= '-';
                    end if;
                else
                    if req_cycle = '1' then
                        if page_hit = '1' then
                            if req_cycle_w = '1' then
                                if allow_write = '1' then
                                    n_state1 <= s1_open;
                                    n_ddrcmd <= DDRCMD_WRITE;
                                    n_ddr_wr <= '1';
                                    n_ddr_rd <= '0';
                                    n_ddr_ready <= '1';
                                    n_mux_col <= '1';
                                    n_mux_special <= '0';
                                else
                                    n_state1 <= s1_open;
                                    n_ddrcmd <= DDRCMD_NOP;
                                    n_ddr_wr <= '0';
                                    n_ddr_rd <= '0';
                                    n_ddr_ready <= '0';
                                    n_mux_col <= '-';
                                    n_mux_special <= '-';
                                end if;
                            else
                                if allow_read = '1' then
                                    n_state1 <= s1_open;
                                    n_ddrcmd <= DDRCMD_READ;
                                    n_ddr_wr <= '0';
                                    n_ddr_rd <= '1';
                                    n_ddr_ready <= '1';
                                    n_mux_col <= '1';
                                    n_mux_special <= '0';
                                else
                                    n_state1 <= s1_open;
                                    n_ddrcmd <= DDRCMD_NOP;
                                    n_ddr_wr <= '0';
                                    n_ddr_rd <= '0';
                                    n_ddr_ready <= '0';
                                    n_mux_col <= '-';
                                    n_mux_special <= '-';
                                end if;
                            end if;
                        else
                            if allow_pre = '1' then
                                n_state1 <= s1_precharging;
                                n_ddrcmd <= DDRCMD_PRE;
                                n_ddr_wr <= '0';
                                n_ddr_rd <= '0';
                                n_ddr_ready <= '0';
                                n_mux_col <= '-';
                                n_mux_special <= '1';
                           else
                                n_state1 <= s1_open;
                                n_ddrcmd <= DDRCMD_NOP;
                                n_ddr_wr <= '0';
                                n_ddr_rd <= '0';
                                n_ddr_ready <= '0';
                                n_mux_col <= '-';
                                n_mux_special <= '-';
                            end if;
                        end if;
                    else
                        n_state1 <= s1_open;
                        n_ddrcmd <= DDRCMD_NOP;
                        n_ddr_wr <= '0';
                        n_ddr_rd <= '0';
                        n_ddr_ready <= '0';
                        n_mux_col <= '-';
                        n_mux_special <= '-';
                    end if;
                end if;

            when s1_precharging =>
                if done_pre = '1' then
                    n_state1 <= s1_closed;
                    n_ddrcmd <= DDRCMD_NOP;
                    n_mux_col <= '-';
                    n_mux_special <= '-';
                else
                    n_state1 <= s1_precharging;
                    n_ddrcmd <= DDRCMD_NOP;
                    n_mux_col <= '-';
                    n_mux_special <= '-';
                end if;
                n_ddr_ready <= '0';
                n_ddr_wr <= '0';
                n_ddr_rd <= '0';
        end case;
    end process;

    --
    -- Implement refresh command period (Trfc) timer.
    --

    Trfc_timer : process(rst, clk0)
    begin
        if rst = '1' then
            done_ref <= '0';
            count_rfc <= (others => '-');
        elsif clk0'event and clk0 = '1' then
            if state1 = s1_refreshing then
                count_rfc <= count_rfc + 1;
                if count_rfc = timing.t_rfc - 3 then
                    done_ref <= '1';
                else
                    done_ref <= '0';
                end if;
            else
                done_ref <= '0';
                count_rfc <= (others => '0');
            end if;
        end if;
    end process;
    
    --
    -- Implement ACT to PRE (Tras,min) timer.
    --

    Trasmin_timer : process(rst, clk0)
    begin
        if rst = '1' then
            count_ras <= (others => '-');
            allow_pre1 <= '0';
        elsif clk0'event and clk0 = '1' then
            if state1 = s1_open then
                if allow_pre1 = '0' then
                    count_ras <= count_ras + 1;
                    if count_ras = timing.t_ras - 3 then
                        allow_pre1 <= '1';
                    end if;
                end if;
            else
                count_ras <= (others => '0');
                allow_pre1 <= '0';
            end if;
        end if;
    end process;

    --
    -- Implement WRITE to PRE (Twtp) timer.
    --

    Twtp_timer : process(rst, clk0)
    begin
        if rst = '1' then
            count_twtp <= (others => '0');
            allow_pre2 <= '0';
        elsif clk0'event and clk0 = '1' then
            if lsr0 = '1' then
                count_twtp <= (others => '0');
                allow_pre2 <= '0';
            else
                if n_ddr_wr = '0' then
                    if allow_pre2 = '0' then
                        count_twtp <= count_twtp + 1;
                        if count_twtp = timing.t_wtp - 2 then
                            allow_pre2 <= '1';
                        end if;
                    end if;
                else
                    count_twtp <= (others => '0');
                    allow_pre2 <= '0';
                end if;
            end if;
        end if;
    end process;

    --
    -- Implement READ to PRE (Trtp) timer.
    --

    gen_allow_pre3_trtp_1 : if timing.t_rtp = 1 generate
        count_trtp <= (others => '0');
        allow_pre3 <= '1';
    end generate;

    gen_allow_pre3_trtp_2 : if timing.t_rtp >= 2 generate
        Trtp_timer : process(rst, clk0)
        begin
            if rst = '1' then
                count_trtp <= (others => '0');
                allow_pre3 <= '0';
            elsif clk0'event and clk0 = '1' then
                if lsr0 = '1' then
                    count_trtp <= (others => '0');
                    allow_pre3 <= '0';
                else
                    if n_ddr_rd = '0' then
                        if allow_pre3 = '0' then
                            count_trtp <= count_trtp + 1;
                            if count_trtp = timing.t_rtp - 2 then
                                allow_pre3 <= '1';
                            end if;
                        end if;
                    else
                        count_trtp <= (others => '0');
                        allow_pre3 <= '0';
                    end if;
                end if;
            end if;
        end process;
    end generate;

    --
    -- Generate 'allow_pre' from above three timers
    --

    allow_pre <= allow_pre1 and allow_pre2 and allow_pre3;

    --
    -- Implement ACT to read/write (Tact) command timer
    --

    Tact_timer_2 : if timing.t_act = 2 generate
        done_act <= '1' when state1 = s1_activating else '0';

        gen_curr_page : process(clk0)
        begin
            if clk0'event and clk0 = '1' then
                if state1 = s1_activating then
                    curr_page <= a_page_q;
                end if;
            end if;
        end process;
    end generate;

    Tact_timer_3plus : if timing.t_act > 2 generate
        timer : process(clk0)
        begin
            if clk0'event and clk0 = '1' then
                if state1 = s1_activating then
                    count_act <= count_act + 1;
                    if count_act = timing.t_act - 3 then
                        done_act <= '1';
                    else
                        done_act <= '0';
                    end if;
                else
                    done_act <= '0';
                    count_act <= (others => '0');
                end if;

                if done_act = '1' then
                    curr_page <= a_page_q;
                end if;
            end if;
        end process;
    end generate;

    --
    -- Implement PRE (Trp) command timer
    --

    Tpre_timer_2 : if timing.t_rp = 2 generate
        done_pre <= '1' when state1 = s1_precharging else '0';
    end generate;

    Tpre_timer_3plus : if timing.t_rp > 2 generate
        timer : process(clk0)
        begin
            if clk0'event and clk0 = '1' then
                if state1 = s1_precharging then
                    count_pre <= count_pre + 1;
                    if count_pre = timing.t_rp - 3 then
                        done_pre <= '1';
                    else
                        done_pre <= '0';
                    end if;
                else
                    done_pre <= '0';
                    count_pre <= (others => '0');
                end if;
            end if;
        end process;
    end generate;

    --
    -- Implement WRITE to READ (Twtr) delay timer
    --

    Twtr_timer : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if n_ddr_wr = '0' then
                if allow_read = '0' then
                    count_wtr <= count_wtr + 1;
                    if count_wtr = timing.t_wtr - 2 then
                        allow_read <= '1';
                    end if;
                end if;
            else
                allow_read <= '0';
                count_wtr <= (others => '0');
            end if;
        end if;
    end process;

    --
    -- Implement READ TO WRITE (Trtw) delay timer
    --

    Trtw_timer : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if n_ddr_rd = '0' then
                if allow_write = '0'  then
                    count_rtw <= count_rtw + 1;
                    if count_rtw = timing.t_rtw - 2 then
                        allow_write <= '1';
                    end if;
                end if;
            else
                allow_write <= '0';
                count_rtw <= (others => '0');
            end if;
        end if;
    end process;

    --
    -- Instantiate initialization logic
    --

    init_0 : ddr2sdram_init
        generic map(
            auto_train => auto_train,
            direct_clocking => direct_clocking,
            dq_width => rd_width,
            dqs_width => dqs_width,
            rowcol_width => max_rowcol_width,
            bank_width => max_bank_width,
            cas_latency => cas_latency,
            t_refresh => timing.t_refresh,
            t_act => timing.t_act,
            t_mrd => timing.t_mrd,
            t_dllr => timing.t_dllr,
            t_rtp => timing.t_rtp,
            t_wtp => timing.t_wtp,
            t_rp => timing.t_rp,
            t_rfc => timing.t_rfc)
        port map(
            clk => clk0,
            rst => logic0,
            sr => lsr0,
            valid => init_valid,
            ref_done => done_ref,
            ref_req => req_ref,
            cke => cke,
            done => init_done,
            command => init_ddrcmd,
            addr => init_addr,
            dq_i => i_q,
            dq_o => init_dq_o,
            rd => init_ddr_rd,
            wr => init_ddr_wr,
            trained => i_trained,
            dlysr_dq => i_dlysr_dq,
            dlyce_dq => i_dlyce_dq,
            dlyinc_dq => i_dlyinc_dq,
            dlysr_dqs => i_dlysr_dqs,
            dlyce_dqs => i_dlyce_dqs,
            dlyinc_dqs => i_dlyinc_dqs,
            qce => i_qce,
            qdelay => i_qdelay,
            vdelay => i_vdelay);

    --
    -- Instantiate the control and address path
    --

    const_pre_addr(const_pre_addr'high downto 11) <= (others => '0');
    const_pre_addr(10) <= '1';
    const_pre_addr(9 downto 0) <= (others => '0');

    n_special_addr <= const_pre_addr when init_done = '1' else init_addr;

    gen_special_addr : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            special_addr <= n_special_addr;
        end if;
    end process;

    ctrlpath : ddr2sdram_ctrl
        generic map(
            rowcol_width => max_rowcol_width,
            bank_width => max_bank_width,
            num_phys_bank => max_num_phys_bank,
            num_clock_en => num_clock_en)
        port map(
            clk => clk0,
            rst => rst,
            sr => lsr0,
            mux_col => mux_col,
            mux_special => mux_special,
            row_addr => a_row_qq,
            col_addr => a_col_qq,
            special_addr => special_addr,
            bank_addr => a_bank_qq,
            pbank_addr_1h => a_pbank1h_qq,
            cke => cke,
            command => ddrcmd,
            ddr_cke_o => ddr_cke_o,
            ddr_cs_o_l => ddr_cs_o_l,
            ddr_we_o_l => ddr_we_o_l,
            ddr_ras_o_l => ddr_ras_o_l,
            ddr_cas_o_l => ddr_cas_o_l,
            ddr_addr_o => ddr_addr_o,
            ddr_ba_o => ddr_ba_o);

    --
    -- Instantiate ODT logic
    --

    odt_0 : ddr2sdram_odt
        generic map(
            num_odt => num_odt)
        port map(
            clk => clk0,
            wr => logic0,
            odt_o => ddr_odt_o);

    --
    -- Instantiate DQS output logic
    --

    gen_dqs_oe : process(rst, clk0)
    begin
        if rst = '1' then
            dqs_oe_l <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            dqs_oe_l <= (others => not (ddr_wr or n_ddr_wr));
        end if;
    end process;

    dqs_out_0 : ddr2sdram_dqs_out
        generic map(
            dqs_width => dqs_width)
        port map(
            clk => clk0,
            clk2x => clk2x0,
            sr => sr_dqs,
            ce => ce_dqs,
            oe_l => dqs_oe_l,
            wr => ddr_wr_q,
            dqs_o => ddr_dqs_o,
            dqs_o_l => ddr_dqs_o_l,
            dqs_t => ddr_dqs_t);

    --
    -- Instantiate DM output logic
    --

    dm_oe_l <= (others => '0');

    dm_0 : ddr2sdram_dm
        generic map(
            be_width => be_width,
            dm_width => dm_width)
        port map(
            clk0 => clk0,
            clk45 => clk45,
            clk2x0 => clk2x0,
            clk2x90 => clk2x90,
            sr => sr_dm,
            ce => ce_dm,
            oe_l => dm_oe_l,
            be_l => cmd_q4_be_l,
            dm_o => ddr_dm_o,
            dm_t => ddr_dm_t);

    --
    -- Instantiate DQ output logic
    --

    gen_dq_oe : process(rst, clk0)
    begin
        if rst = '1' then
            dq_oe_l <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            dq_oe_l <= (others => not (ddr_wr or n_ddr_wr));
        end if;
    end process;

    dq_out_0 : ddr2sdram_dq_out
        generic map(
            dq_width => rd_width,
            d_width => d_width)
        port map(
            clk0 => clk0,
            clk45 => clk45,
            clk2x0 => clk2x0,
            clk2x90 => clk2x90,
            sr => sr_dq,
            ce => ce_dq,
            oe_l => dq_oe_l,
            d => cmd_q4_d,
            dq_o => ddr_dq_o,
            dq_t => ddr_dq_t);

    --
    -- Instantiate DQ input logic
    --

    dq_in_serdes : if not direct_clocking generate
        dqs_in_0 : ddr2sdram_dqs_in
            generic map(
                dqs_width => dqs_width)
            port map(
                rst => rst,
                clk => clk0,
                dlysr => i_dlysr_dqs,
                dlyce => i_dlyce_dqs,
                dlyinc => i_dlyinc_dqs,
                dqs_i => ddr_dqs_i,
                dqs_idelay => ddr_dqs_idelay);

        dq_in_0 : ddr2sdram_dq_in
            generic map(
                dqs_width => dqs_width,
                dq_width => rd_width,
                d_width => d_width,
                tag_width => tag_width)
            port map(
                clk0 => clk0,
                clk45 => clk45,
                clk2x0 => clk2x0,
                clk2x90 => clk2x90,
                sr => sr_dq,
                ce => ce_dq,
                dlysr => i_dlysr_dq,
                dlyce => i_dlyce_dq,
                dlyinc => i_dlyinc_dq,
                qce => i_qce,
                qdelay => i_qdelay,
                vdelay => i_vdelay,
                rd => ddr_rd,
                init_done => init_done,
                tag => cmd_q3_tag,
                dqs_i => ddr_dqs_idelay,
                dq_i => ddr_dq_i,
                q => i_q,
                qtag => i_qtag,
                valid => i_valid,
                init_valid => init_valid);
    end generate;

    dq_in_dc : if direct_clocking generate
        dq_in_0 : ddr2sdram_dq_in_dc
            generic map(
                dqs_width => dqs_width,
                dq_width => rd_width,
                d_width => d_width,
                tag_width => tag_width)
            port map(
                clk0 => clk0,
                clk45 => clk45,
                clk2x0 => clk2x0,
                clk2x90 => clk2x90,
                sr => sr_dq,
                ce => ce_dq,
                dlysr => i_dlysr_dq,
                dlyce => i_dlyce_dq,
                dlyinc => i_dlyinc_dq,
                qce => i_qce,
                qdelay => i_qdelay,
                vdelay => i_vdelay,
                rd => ddr_rd,
                init_done => init_done,
                tag => cmd_q3_tag,
                dq_i => ddr_dq_i,
                q => i_q,
                dq => rd_i,
                qtag => i_qtag,
                valid => i_valid,
                init_valid => init_valid);
    end generate;

    --
    -- Generate forwarded clocks for DDR-II SDRAM memory
    -- 

    gen_ddr_clk : ddr2sdram_clkfw
        generic map(
            num_clock => num_clock)
        port map(
            clk2x => clk2x0,
            rst => rst,
            ddr_clk => ddr_clk_o,
            ddr_clk_l => ddr_clk_o_l);

--    trig0(127 downto 0) <= EXT(d, 128);
--    trig0(143 downto 128) <= EXT(be, 16);
--    trig0(175 downto 144) <= EXT(a, 32);
--    trig0(183 downto 176) <= EXT(tag, 8);
--    trig0(191 downto 184) <= EXT(i_qtag, 8);
--    trig0(192) <= ce;
--    trig0(193) <= w;
--    trig0(194) <= i_valid;
--    trig0(195) <= i_ready;
--    trig0(196) <= sr;
--    trig0(197) <= rst;
--    trig0(199 downto 198) <= row;
--    trig0(201 downto 200) <= col;
--    trig0(203 downto 202) <= bank;
--    trig0(205 downto 204) <= pbank;
--    trig0(207) <= i_trained;
--    trig0(254 downto 208) <= (others => '0');

--    ila0 : ilacombo
--        generic map(
--            dummy => true)
--        port map(
--            clk => clk0,
--            trig0 => trig0,
--            trig_out => trig_out);

end mixed;
