--  
-- afifo.vhd - asynchronous FIFO
--
-- SYNTHESIZABLE
--
-- Usage:
-- ======
--
-- 1. FIFO depth (number of words that can be held in the FIFO) is 2**order - 1.
--
-- 2. Programmable empty levels represent number of words (or less) in FIFO at which
--    corresponding empty flag is asserted.
--
-- 3. Programmable full levels represent number of free locations (or less) in FIFO
--    at which corresponding full flag is asserted.
--
-- 4. 'wk' and 'rk' are independent, and either may be stopped safely.
--
-- 5. When 'safety' is true:
--
--       - the FIFO ignores 'wadv' when 'wf' is asserted.
--       - the FIFO ignores 'radv' when 're' is asserted.
--       - the FIFO's maximum clock speed is lower.
--       - the FIFO's logic complexity when synthesised is higher.
--
--    When 'safety' is false:
--
--       - the FIFO can enter an undefined state if 'wadv' is asserted when
--         'wf' is asserted, or if 'radv' is asserted when 're' is asserted.
--       - the FIFO's maximum clock speed is higher.
--       - the FIFO's logic complexity when synthesised is lower.
--
-- 6. To target Virtex/-E/-EM, specify 'family_virtex' for the 'family'
--    parameter. To target Virtex-II, specify 'family_virtex2' for the
--    'family' parameter.
--
-- 7. To flush the FIFO, which can be done only from the reader side, the
--    'rflush' signal must be asserted. If 'fflush' is true, then the duration
--    of this pulse need only be 1 cycle. Otherwise, it is 2.
--
-- 8. To read an item of data, assert 'radv', which will cause next item
--    of data to be presented on 'rq' and the FIFO read pointer to be advanced.
--
-- 9. To write an item of data, assert 'wadv', which will cause the data on
--    'wd' to be entered into the FIFO and the FIFO write pointer to be advanced.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

-- synthesis translate_off
library std;
use std.textio.all;
-- synthesis translate_on

library work;
use work.dpmem.all;
use work.fifo.all;

entity afifo is
    generic(
        width  : in  natural;                              -- Width of FIFO
        order  : in  natural;                              -- FIFO depth is (2 ** order) - 1
        wpfl   : in  natural;                              -- Programmable full level
        wpfl2  : in  natural;                              -- Alternate programmable full level
        rpel   : in  natural;                              -- Programmable empty level
        family : in  work.fifo.family_t;                   -- FPGA family to target
        safety : in  boolean;                              -- true => protect against illegal inputs
        fflush : in  boolean);                             -- true => 'rflush' needs only 1 cycle assertion
    port(
        rst    : in  std_logic;                            -- Asynchronous reset
        -- 'wk' clock domain
        wk     : in  std_logic;                            -- (Write) clock
        wd     : in  std_logic_vector(width - 1 downto 0); -- (Write) data
        wadv   : in  std_logic;                            -- (Write) advance pointer
        we     : out std_logic;                            -- (Write) empty flag
        wpf    : out std_logic;                            -- (Write) programmable full flag
        wpf2   : out std_logic;                            -- (Write) alternate programmable full flag
        wf     : out std_logic;                            -- (Write) full flag
        wovf   : out std_logic;                            -- (Write) overflow flag
        wlevel : out std_logic_vector(15 downto 0);        -- (Write) FIFO level (no. free)
        -- 'rk' clock domain
        rk     : in  std_logic;                            -- (Read) clock
        rq     : out std_logic_vector(width - 1 downto 0); -- (Read) data
        radv   : in  std_logic;                            -- (Read) advance pointer
        rflush : in  std_logic;                            -- (Read) flush
        re     : out std_logic;                            -- (Read) empty flag
        rpe    : out std_logic;                            -- (Read) programmable empty flag
        rf     : out std_logic;                            -- (Read) full flag
        rudf   : out std_logic;                            -- (Read) underflow flag
        rlevel : out std_logic_vector(15 downto 0));       -- (Read) FIFO level (no. occupied)
end;

architecture mixed of afifo is

    constant depth      : natural := 2**order;
    -- synopsys translate_off
    constant dpmem_init : std_logic_vector(depth * width - 1 downto 0) := (others => '0');
    -- synopsys translate_on

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

    --
    -- Convert a fifo.family_t to a dpmem.family_t
    --

    function to_dpmem_family(
        family : in work.fifo.family_t)
    return work.dpmem.family_t is
    begin
        case family is
            when work.fifo.family_virtex =>
                return work.dpmem.family_virtex;
            when work.fifo.family_virtex2 =>
                return work.dpmem.family_virtex2;
            when work.fifo.family_virtex2p =>
                return work.dpmem.family_virtex2p;
            when work.fifo.family_virtex4 =>
                return work.dpmem.family_virtex4;
            when work.fifo.family_virtex5 =>
                return work.dpmem.family_virtex5;
        end case;
    end;

    --
    -- Determine whether to use BlockRAM or distributed RAM resources
    --

    function use_blockram(
        family : in work.fifo.family_t;
        order  : in natural)
    return boolean is
    begin
        case family is
            when work.fifo.family_virtex =>
                return (order > 4);
            when work.fifo.family_virtex2 | work.fifo.family_virtex2p =>
                return (order > 6);
            when work.fifo.family_virtex4 =>
                return (order > 4);
            when work.fifo.family_virtex5 =>
                return (order > 7);
        end case;
    end;

    --
    -- Convert a gray-coded number to its binary-coded representation
    --
    function gtob(
        gray : in std_logic_vector;
        wid  : in natural)
    return std_logic_vector is
        variable x : std_logic;
        variable f : std_logic_vector(wid - 1 downto 0);
    begin
        assert gray'length = wid
            report "*** failed: gray'length = wid in gtob()"
            severity warning;
        for i in wid - 1 downto 0 loop
            x := '0';
            for j in wid - 1 downto i loop
                x := x xor gray(j);
            end loop;
            f(i) := x;
        end loop;

        return f;
    end;

    --
    -- Convert a binary-coded number to its gray-coded representation
    --
    function btog(
        bin  : in std_logic_vector;
        wid  : in natural)
    return std_logic_vector is
        variable x : std_logic;
        variable f : std_logic_vector(wid - 1 downto 0);
    begin
        assert bin'length = wid
            report "*** failed: bin'length = wid in btog()"
            severity warning;

        if bin'length > 1 then
            return bin xor ("0" & bin(wid - 1 downto 1));
        else
            return bin;
        end if;
    end;

    function extend(
        a : in std_logic_vector;
        b : in natural)
    return std_logic_vector is
    begin
        if b > a'length then
            return CONV_STD_LOGIC_VECTOR(0, b - a'length) & a;
        else
            return a(a'low + b - 1 downto a'low);
        end if;
    end;

    --
    -- FIFO full level
    --
    constant full : natural := (2 ** order) - 1;

    --
    -- Read index in binary and gray forms
    --
    signal ridx_rb0 : std_logic_vector(order - 1 downto 0);
    signal ridx_rb  : std_logic_vector(order - 1 downto 0); -- 1 behind 'ridx_rb0'
    signal ridx_rg  : std_logic_vector(order - 1 downto 0); -- gray code version of 'ridx_rb'
    signal ridx_wg  : std_logic_vector(order - 1 downto 0); -- 'ridx_rg' sync'ed to 'wk'
    signal ridx_wb  : std_logic_vector(order - 1 downto 0); -- binary version of 'ridx_wg'

    --
    -- Write index in binary and gray forms
    --
    signal widx_wb0 : std_logic_vector(order - 1 downto 0);
    signal widx_wb  : std_logic_vector(order - 1 downto 0); -- 1 behind 'widx_wb'
    signal widx_wg  : std_logic_vector(order - 1 downto 0); -- gray code version of 'widx_wb'
    signal widx_rg  : std_logic_vector(order - 1 downto 0); -- 'widx_wg' sync'ed to 'rk'
    signal widx_rb  : std_logic_vector(order - 1 downto 0); -- binary version of 'widx_wg'

    --
    -- FIFO level in binary form
    --
    signal fcnt_w   : std_logic_vector(order - 1 downto 0); -- writer point of view
    signal fcnt_r   : std_logic_vector(order - 1 downto 0); -- reader point of view

    --
    -- 'Safe' versions of radv and wadv, ie. gated using 're' and 'wf' respectively
    --
    signal safe_radv, safe_wadv : std_logic;

    type write_state_type1 is (ws1_empty, ws1_not_empty);
    signal write_state1, n_write_state1 : write_state_type1;
    signal n_we_int, we_int : std_logic;

    type write_state_type2 is (ws2_not_almost_full, ws2_almost_full);
    signal write_state2, n_write_state2 : write_state_type2;
    signal n_wpf_int, wpf_int : std_logic;

    type write_state_type3 is (ws3_not_full, ws3_full);
    signal write_state3, n_write_state3 : write_state_type3;
    signal n_wf_int, wf_int : std_logic;

    type write_state_type4 is (ws4_not_almost_full, ws4_almost_full);
    signal write_state4, n_write_state4 : write_state_type4;
    signal n_wpf2_int, wpf2_int : std_logic;

    type read_state_type1 is (rs1_empty, rs1_push, rs1_not_empty);
    signal n_re_int, re_int : std_logic;
    signal dec_rd_idx, n_dec_rd_idx : std_logic;
    signal read_state1, n_read_state1 : read_state_type1;
    signal inhibit, n_inhibit : std_logic;
    signal push, n_push : std_logic;

    type read_state_type2 is (rs2_almost_empty, rs2_not_almost_empty);
    signal read_state2, n_read_state2 : read_state_type2;
    signal n_rpe_int, rpe_int : std_logic;

    type read_state_type3 is (rs3_not_full, rs3_full);
    signal read_state3, n_read_state3 : read_state_type3;
    signal n_rf_int, rf_int : std_logic;

    type read_state_type4 is (rs4_le_one, rs4_gt_one);
    signal read_state4, n_read_state4 : read_state_type4;
    signal n_r1e, r1e : std_logic;

    signal mem_rd    : std_logic;

    signal inc_rd_idx : std_logic;
    signal mem_rd_idx : std_logic_vector(order - 1 downto 0);

    signal logic0 : std_logic;
    signal logic1 : std_logic;
    signal d1_zeroes : std_logic_vector(width - 1 downto 0);

begin

    logic0 <= '0';
    logic1 <= '1';

    --
    -- Place some restrictions on the parameters
    --
    assert order >= 3 and order <= 16;

    --
    -- Checks for FIFO overflow and underflow
    --

    -- synthesis translate_off
    check_underflow : process(rst, rk)
    begin
        if rst = '1' then
            null;
        elsif rk'event and rk = '1' then
            if radv = '1' and re_int = '1' then
                assert false
                    report conv_string(now) & " afifo: underflow detected (radv and re both asserted)"
                    severity warning;
            end if;
        end if;
    end process;

    check_overflow : process(rst, wk)
    begin
        if rst = '1' then
            null;
        elsif wk'event and wk = '1' then
            if wadv = '1' and wf_int = '1' then
                assert false
                    report conv_string(now) & " afifo: overflow detected (wadv and wf both asserted)"
                    severity warning;
            end if;
        end if;
    end process;
    -- synthesis translate_on

    --
    -- Generate signals coming out of this module.
    --
    we   <= we_int;
    wpf  <= wpf_int;
    wpf2 <= wpf2_int;
    wf   <= wf_int;
    re   <= re_int;
    rpe  <= rpe_int;
    rf   <= rf_int;
    rlevel <= extend(fcnt_r, 16);
    wlevel <= extend(not fcnt_w, 16);

    --
    -- Generate safe versions of 'radv' and 'wadv'
    --
    safe_wadv <= wadv and not wf_int when safety else wadv;
    safe_radv <= radv and not re_int when safety else radv;

    --
    -- Generate overflow/underflow error flags
    --    
    gen_wovf : process(rst, wk)
    begin
        if rst = '1' then
            wovf <= '0';
        elsif wk'event and wk = '1' then
            if wadv = '1' and wf_int = '1' then
                wovf <= '1';
            end if;
        end if;
    end process;

    gen_rudf : process(rst, rk)
    begin
        if rst = '1' then
            rudf <= '0';
        elsif rk'event and rk = '1' then
            if radv = '1' and re_int = '1' then
                rudf <= '1';
            end if;
        end if;
    end process;

    --
    -- The master write index, gray-coded and binary coded
    --
    write_index: process(rst, wk) begin
        if rst = '1' then
            widx_wb0 <= CONV_STD_LOGIC_VECTOR(1, widx_wb0'length);
            widx_wb <= CONV_STD_LOGIC_VECTOR(0, widx_wb'length);
            widx_wg <= CONV_STD_LOGIC_VECTOR(0, widx_wg'length);
        elsif wk'event and wk = '1' then
            if safe_wadv = '1' then
                widx_wb0 <= widx_wb0 + 1;
                widx_wb <= widx_wb0;
                widx_wg <= btog(widx_wb0, widx_wb0'length);
            end if;
        end if;
    end process;

    --
    -- The master read index, gray-coded and binary coded
    --
    read_index: process(rst, rk) begin
        if rst = '1' then
            ridx_rb0 <= CONV_STD_LOGIC_VECTOR(1, ridx_rb0'length);
            ridx_rb <= CONV_STD_LOGIC_VECTOR(0, ridx_rb'length);
            ridx_rg <= CONV_STD_LOGIC_VECTOR(0, ridx_rg'length);
        elsif rk'event and rk = '1' then
            if rflush = '1' then
                ridx_rb0 <= widx_rb + 1;
                ridx_rb <= widx_rb;
                ridx_rg <= btog(widx_rb, ridx_rb0'length);
            else
                if safe_radv = '1' then
                    ridx_rb0 <= ridx_rb0 + 1;
                    ridx_rb <= ridx_rb0;
                    ridx_rg <= btog(ridx_rb0, ridx_rb0'length);
                end if;
            end if;
        end if;
    end process;

    -- generate gray coded version of read index, sync'ed to 'wk'
    gen_ridx_wg: process(rst, wk) begin
        if rst = '1' then
            ridx_wg <= CONV_STD_LOGIC_VECTOR(0, ridx_wg'length);
        elsif wk'event and wk = '1' then
            ridx_wg <= ridx_rg;
        end if;
    end process;

    -- generate binary coded version of read index, sync'ed to 'wk'
    gen_ridx_wb: process(rst, wk) begin
        if rst = '1' then
            ridx_wb <= CONV_STD_LOGIC_VECTOR(0, ridx_wb'length);
        elsif wk'event and wk = '1' then
            ridx_wb <= gtob(ridx_wg, ridx_wg'length);
        end if;
    end process;

    -- generate gray coded version of write index, sync'ed to 'rk'
    gen_widx_rg: process(rst, rk) begin
        if rst = '1' then
            widx_rg  <= CONV_STD_LOGIC_VECTOR(0, widx_rg'length);
            widx_rb  <= CONV_STD_LOGIC_VECTOR(0, widx_rb'length);
        elsif rk'event and rk = '1' then
            widx_rg  <= widx_wg;
            widx_rb <= gtob(widx_rg, widx_rg'length);
        end if;
    end process;

    -- generate FIFO level sync'ed to 'wk'
    gen_fcnt_w: process(rst, wk) begin
        if rst = '1' then
            fcnt_w <= (others => '0');
        elsif wk'event and wk = '1' then
            if safe_wadv = '1' then
                fcnt_w <= widx_wb0 - ridx_wb;
            else
                fcnt_w <= widx_wb - ridx_wb;
            end if;
        end if;
    end process;

    -- generate FIFO level sync'ed to 'rk'
    gen_fcnt_r: process(rst, rk) begin
        if rst = '1' then
            fcnt_r <= (others => '0');
        elsif rk'event and rk = '1' then
            if fflush then
                if rflush = '1' then
                    fcnt_r <= (others => '0');
                else
                    if safe_radv = '1' then
                        fcnt_r <= widx_rb - ridx_rb - 1;
                    else
                        fcnt_r <= widx_rb - ridx_rb;
                    end if;
                end if;
            else
                fcnt_r <= widx_rb - ridx_rb - safe_radv;
            end if;
        end if;
    end process;

    -- the synchronous part of the writer side state machine 1
    write_machine1_sync: process(rst, wk) begin
        if rst = '1' then
            write_state1 <= ws1_empty;
            we_int       <= '1';
        elsif wk'event and wk = '1' then
            write_state1 <= n_write_state1;
            we_int       <= n_we_int;
        end if;
    end process;

    -- the combinatorial part of the writer side state machine 1
    write_machine1_comb: process(
        write_state1,
        wadv,
        fcnt_w)
    begin
        case write_state1 is
            when ws1_empty =>
                if wadv = '1' then
                    n_write_state1 <= ws1_not_empty;
                    n_we_int <= '0';
                else
                    n_write_state1 <= ws1_empty;
                    n_we_int <= '1';
                end if;

            when ws1_not_empty =>
                if fcnt_w = 0 then
                    n_write_state1 <= ws1_empty;
                    n_we_int <= '1';
                else
                    n_write_state1 <= ws1_not_empty;
                    n_we_int <= '0';
                end if;
        end case;
    end process;

    -- the synchronous part of the writer side state machine 2
    write_machine2_sync: process(rst, wk) begin
        if rst = '1' then
            write_state2 <= ws2_not_almost_full;
            wpf_int <= '0';
        elsif wk'event and wk = '1' then
            write_state2 <= n_write_state2;
            wpf_int <= n_wpf_int;
        end if;
    end process;

    -- the combinatorial part of the writer side state machine 2
    write_machine2_comb: process(
        write_state2,
        wadv,
        fcnt_w)
    begin
        case write_state2 is
            when ws2_not_almost_full =>
                if fcnt_w = (full - wpfl - 1) and wadv = '1' then
                    n_write_state2 <= ws2_almost_full;
                    n_wpf_int <= '1';
                else
                    n_write_state2 <= ws2_not_almost_full;
                    n_wpf_int <= '0';
                end if;

            when ws2_almost_full =>
                if fcnt_w < (full - wpfl) and not (fcnt_w = (full - wpfl - 1) and wadv = '1') then
                    n_write_state2 <= ws2_not_almost_full;
                    n_wpf_int <= '0';
                else
                    n_write_state2 <= ws2_almost_full;
                    n_wpf_int <= '1';
                end if;
        end case;
    end process;

    -- the synchronous part of the writer side state machine 3
    write_machine3_sync: process(rst, wk) begin
        if rst = '1' then
            write_state3 <= ws3_not_full;
            wf_int       <= '0';
        elsif wk'event and wk = '1' then
            write_state3 <= n_write_state3;
            wf_int       <= n_wf_int;
        end if;
    end process;

    -- the combinatorial part of the writer side state machine 3
    write_machine3_comb: process(
        write_state3,
        wadv,
        fcnt_w)
    begin
        case write_state3 is
            when ws3_not_full =>
                if fcnt_w = (full - 1) and wadv = '1' then
                    n_write_state3 <= ws3_full;
                    n_wf_int <= '1';
                else
                    n_write_state3 <= ws3_not_full;
                    n_wf_int <= '0';
                end if;

            when ws3_full =>
                if fcnt_w /= full then
                    n_write_state3 <= ws3_not_full;
                    n_wf_int <= '0';
                else
                    n_write_state3 <= ws3_full;
                    n_wf_int <= '1';
                end if;
        end case;
    end process;

    -- the synchronous part of the writer side state machine 4
    write_machine4_sync: process(rst, wk) begin
        if rst = '1' then
            write_state4 <= ws4_not_almost_full;
            wpf2_int <= '0';
        elsif wk'event and wk = '1' then
            write_state4 <= n_write_state4;
            wpf2_int <= n_wpf2_int;
        end if;
    end process;

    -- the combinatorial part of the writer side state machine 4
    write_machine4_comb: process(
        write_state4,
        wadv,
        fcnt_w)
    begin
        case write_state4 is
            when ws4_not_almost_full =>
                if fcnt_w = (full - wpfl2 - 1) and wadv = '1' then
                    n_write_state4 <= ws4_almost_full;
                    n_wpf2_int <= '1';
                else
                    n_write_state4 <= ws4_not_almost_full;
                    n_wpf2_int <= '0';
                end if;

            when ws4_almost_full =>
                if fcnt_w < (full - wpfl2) and not (fcnt_w = (full - wpfl2 - 1) and wadv = '1') then
                    n_write_state4 <= ws4_not_almost_full;
                    n_wpf2_int <= '0';
                else
                    n_write_state4 <= ws4_almost_full;
                    n_wpf2_int <= '1';
                end if;
        end case;
    end process;

    -- the synchronous part of the reader side state machine 1
    read_machine1_sync: process(rst, rk) begin
        if rst = '1' then
            read_state1 <= rs1_empty;
            dec_rd_idx <= '0';
            re_int <= '1';
            push <= '0';
            inhibit <= '1';
        elsif rk'event and rk = '1' then
            if rflush = '1' then
                read_state1 <= rs1_empty;
                dec_rd_idx <= '0';
                re_int <= '1';
                push <= '0';
                inhibit <= '1';
            else
                read_state1 <= n_read_state1;
                dec_rd_idx <= n_dec_rd_idx;
                re_int <= n_re_int;
                push <= n_push;
                inhibit <= n_inhibit;
            end if;
        end if;
    end process;

    -- the combinatorial part of the reader side state machine 1
    read_machine1_comb: process(
        read_state1,
        radv,
        fcnt_r)
    begin
        case read_state1 is
            when rs1_empty =>
                if OR_reduce(fcnt_r) = '0' then
                    n_read_state1 <= rs1_empty;
                    n_dec_rd_idx <= '0';
                    n_re_int <= '1';
                    n_push <= '0';
                    n_inhibit <= '1';
                else
                    n_read_state1 <= rs1_push;
                    n_dec_rd_idx <= '0';
                    n_re_int <= '1';
                    n_push <= '1';
                    n_inhibit <= '0';
                end if;

            when rs1_push =>
                n_read_state1 <= rs1_not_empty;
                n_dec_rd_idx <= '0';
                n_re_int <= '0';
                n_push <= '0';
                n_inhibit <= '0';

            when rs1_not_empty =>
                if radv = '1' and OR_reduce(fcnt_r(fcnt_r'high downto 1)) = '0' then
                    n_read_state1 <= rs1_empty;
                    n_dec_rd_idx <= '1';
                    n_re_int <= '1';
                    n_push <= '0';
                    n_inhibit <= '1';
                else
                    n_read_state1 <= rs1_not_empty;
                    n_dec_rd_idx <= '0';
                    n_re_int <= '0';
                    n_push <= '0';
                    n_inhibit <= '0';
                end if;
        end case;
    end process;

    -- the synchronous part of the reader side state machine 2
    read_machine2_sync: process(rst, rk) begin
        if rst = '1' then
            read_state2 <= rs2_almost_empty;
            rpe_int     <= '1';
        elsif rk'event and rk = '1' then
            if rflush = '1' or inhibit = '1' then
                read_state2 <= rs2_almost_empty;
                rpe_int <= '1';
            else
                read_state2 <= n_read_state2;
                rpe_int <= n_rpe_int;
            end if;
        end if;
    end process;

    -- the combinatorial part of the reader side state machine 2
    read_machine2_comb: process(
        read_state2,
        radv,
        fcnt_r)
    begin
        case read_state2 is
            when rs2_almost_empty =>
                if fcnt_r > rpel and not (fcnt_r = (rpel + 1) and radv = '1') then
                    n_read_state2 <= rs2_not_almost_empty;
                    n_rpe_int <= '0';
                else
                    n_read_state2 <= rs2_almost_empty;
                    n_rpe_int <= '1';
                end if;

            when rs2_not_almost_empty =>
                if fcnt_r = (rpel + 1) and radv = '1' then
                    n_read_state2 <= rs2_almost_empty;
                    n_rpe_int <= '1';
                else
                    n_read_state2 <= rs2_not_almost_empty;
                    n_rpe_int <= '0';
                end if;
        end case;
    end process;

    -- the synchronous part of the reader side state machine 3
    read_machine3_sync: process(rst, rk) begin
        if rst = '1' then
            read_state3 <= rs3_not_full;
            rf_int      <= '0';
        elsif rk'event and rk = '1' then
            if rflush = '1' or inhibit = '1' then
                read_state3 <= rs3_not_full;
                rf_int      <= '0';
            else
                read_state3 <= n_read_state3;
                rf_int      <= n_rf_int;
            end if;
        end if;
    end process;

    -- the combinatorial part of the reader side state machine 3
    read_machine3_comb: process(
        read_state3,
        radv,
        fcnt_r)
    begin
        case read_state3 is
            when rs3_not_full =>
                if fcnt_r = full and radv = '0' then
                    n_read_state3 <= rs3_full;
                    n_rf_int <= '1';
                else
                    n_read_state3 <= rs3_not_full;
                    n_rf_int <= '0';
                end if;

            when rs3_full =>
                if radv = '1' then
                    n_read_state3 <= rs3_not_full;
                    n_rf_int <= '0';
                else
                    n_read_state3 <= rs3_full;
                    n_rf_int <= '1';
                end if;
        end case;
    end process;

    -- the synchronous part of the reader side state machine 3
    read_machine4_sync: process(rst, rk) begin
        if rst = '1' then
            read_state4 <= rs4_le_one;
            r1e <= '1';
        elsif rk'event and rk = '1' then
            if rflush = '1' or inhibit = '1' then
                read_state4 <= rs4_le_one;
                r1e <= '1';
            else
                read_state4 <= n_read_state4;
                r1e <= n_r1e;
            end if;
        end if;
    end process;

    -- the combinatorial part of the reader side state machine 3
    read_machine4_comb: process(
        read_state4,
        radv,
        fcnt_r)
    begin
        case read_state4 is
            when rs4_le_one =>
                if fcnt_r > 1 and not (fcnt_r = 2 and radv = '1') then
                    n_read_state4 <= rs4_gt_one;
                    n_r1e <= '0';
                else
                    n_read_state4 <= rs4_le_one;
                    n_r1e <= '1';
                end if;

            when rs4_gt_one =>
                if fcnt_r = 2 and radv = '1' then
                    n_read_state4 <= rs4_le_one;
                    n_r1e <= '1';
                else
                    n_read_state4 <= rs4_gt_one;
                    n_r1e <= '0';
                end if;
        end case;
    end process;

--    inc_rd_idx <= '1' when (fcnt_r /= 0 and re_int = '1') or (radv = '1' and re_int = '0' and fcnt_r /= 1) else '0';
    inc_rd_idx <= '1' when push = '1' or (safe_radv = '1' and OR_reduce(fcnt_r(order - 1 downto 1)) = '1') else '0';

    gen_mem_rd_idx: process(rst, rk)
        variable x : std_logic_vector(1 downto 0);
    begin
        if rst = '1' then
            mem_rd_idx <= (others => '0');
        elsif rk'event and rk = '1' then
            if rflush = '1' then
                mem_rd_idx <= widx_rb;
            else
                if inc_rd_idx = '1' then
                    mem_rd_idx <= mem_rd_idx + 1;
                end if;
            end if;
        end if;
    end process;

    d1_zeroes <= (others => '0');
    mem_rd <= push or radv;

    gen_dpbram : if use_blockram(family, order) generate
        dpbram_0 : dpbram
            generic map(
                order0      => order,
                width0      => width,
                order1      => order,
                width1      => width,
                -- synopsys translate_off
                init        => dpmem_init,
                -- synopsys translate_on
                family      => to_dpmem_family(family),
                depth_waste => true)
            port map(
                rst    => rst,
                k0     => wk,
                sr0    => logic0,
                en0    => logic1,
                w0     => safe_wadv,
                a0     => widx_wb,
                d0     => wd,
                q0     => open,
                k1     => rk,
                sr1    => rflush,
                en1    => mem_rd,
                w1     => logic0,
                a1     => mem_rd_idx,
                d1     => d1_zeroes,
                q1     => rq);
    end generate;
            
    gen_distmem : if not use_blockram(family, order) generate
        distmem_0 : distmem
            generic map(
                order       => order,
                width       => width,
                -- synopsys translate_off
                init        => dpmem_init,
                -- synopsys translate_on
                family      => to_dpmem_family(family))
            port map(
                rst    => rst,
                k0     => wk,
                sr0    => logic0,
                en0    => logic1,
                w0     => safe_wadv,
                a0     => widx_wb,
                d0     => wd,
                q0     => open,
                k1     => rk,
                sr1    => rflush,
                en1    => mem_rd,
                a1     => mem_rd_idx,
                q1     => rq);
    end generate;
            
end;
