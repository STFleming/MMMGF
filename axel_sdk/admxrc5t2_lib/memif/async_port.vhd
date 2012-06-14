--
-- async_port.vhd - inter-clock-domain datapath, used with memory interface
--                  components.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library work;
use work.fifo.all;
use work.memif.all;

entity async_port is
    generic(
        family     : in    work.memif.family_t;
        order      : in    natural;
        iwpfl      : in    natural;
        owpfl      : in    natural;
        orpel      : in    natural;
        addr_width : in    natural;
        data_width : in    natural;
        tag_width  : in    natural);
    port(
        rst        : in    std_logic;
        -- To/from primary clock domain
        pclk       : in    std_logic;
        psr        : in    std_logic;
        pce        : in    std_logic;
        pcw        : in    std_logic;
        pterm      : in    std_logic;
        padv       : in    std_logic;
        pwr        : in    std_logic;
        pa         : in    std_logic_vector(addr_width - 1 downto 0);
        pd         : in    std_logic_vector(data_width - 1 downto 0);
        pbe        : in    std_logic_vector(data_width / 8 - 1 downto 0);
        pq         : out   std_logic_vector(data_width - 1 downto 0);
        pwf        : out   std_logic;
        pwpf       : out   std_logic;
        pre        : out   std_logic;
        prpe       : out   std_logic;
        -- To/from memory interface
        sclk       : in    std_logic;
        sce        : out   std_logic;
        stag       : out   std_logic_vector(tag_width - 1 downto 0);
        sw         : out   std_logic;
        sa         : out   std_logic_vector(addr_width - 1 downto 0);
        sd         : out   std_logic_vector(data_width - 1 downto 0);
        sbe        : out   std_logic_vector(data_width / 8 - 1 downto 0);
        sready     : in    std_logic;
        svalid     : in    std_logic;
        sq         : in    std_logic_vector(data_width - 1 downto 0);
        sqtag      : in    std_logic_vector(tag_width - 1 downto 0);
        -- To/from memory interface arbiter
        sreq       : out   std_logic;
        -- Should be driven with constant values
        tag_base   : in    std_logic_vector(tag_width - 1 downto 0);
        tag_mask   : in    std_logic_vector(tag_width - 1 downto 0));
end entity;

architecture mixed of async_port is

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

    function to_fifo_family(
        family : in work.memif.family_t)
    return work.fifo.family_t is
    begin
        case family is
            when work.memif.family_virtex =>
                return work.fifo.family_virtex;
            when work.memif.family_virtex2 =>
                return work.fifo.family_virtex2;
            when work.memif.family_virtex2p =>
                return work.fifo.family_virtex2p;
            when work.memif.family_virtex4 =>
                return work.fifo.family_virtex4;
            when work.memif.family_virtex5 =>
                return work.fifo.family_virtex5;
        end case;
    end;

    -- Compute required inbound FIFO width
    constant if_cmd_width : natural := addr_width + 1;
    constant if_be_width : natural := data_width / 8;
    constant if_data_width : natural := data_width + if_be_width + 1;
    constant if_width : natural := max(if_cmd_width, if_data_width);

    -- Compute outbound FIFO width
    constant of_width : natural := data_width;

    -- Executive state machine in 'pclk' domain
    type state1_t is (s1_idle, s1_busy, s1_writing, s1_reading);
    signal state1, n_state1 : state1_t;
    signal idle1, n_idle1 : std_logic;
    signal reading1, n_reading1 : std_logic;

    -- Busy state machine in 'pclk' domain
    type state2_t is (s2_idle, s2_busy);
    signal state2, n_state2 : state2_t;
    signal busy2, n_busy2 : std_logic;
    signal flush, n_flush : std_logic;

    signal aq : std_logic_vector(addr_width - 1 downto 0);
    signal writeq : std_logic;

    signal if_d, if_q : std_logic_vector(if_width - 1 downto 0);
    signal if_write, if_read : std_logic;
    signal if_wf, if_wpf : std_logic;
    signal if_re : std_logic;
    signal if_flush : std_logic;

    signal of_d, of_q : std_logic_vector(of_width - 1 downto 0);
    signal of_write, of_read : std_logic;
    signal of_wf, of_wpf : std_logic;
    signal of_re, of_rpe : std_logic;
    signal of_flush : std_logic;

    signal term_ackp : std_logic;

    -- Executive state machine in 'sclk' domain
    type state3_t is (s3_idle, s3_writing, s3_reading, s3_term);
    signal state3, n_state3 : state3_t;
    signal idle3, n_idle3 : std_logic;
    signal reading3, n_reading3 : std_logic;
    signal term_ack, n_term_ack : std_logic;
    signal writing3, n_writing3 : std_logic;
    signal i_sreq, n_sreq : std_logic;
    signal i_sce, n_sce : std_logic;
    signal i_sw, n_sw : std_logic;

    signal ssr : std_logic;

    signal scmd_write : std_logic;
    signal scmd_addr : std_logic_vector(addr_width - 1 downto 0);
    signal i_sa : std_logic_vector(addr_width - 1 downto 0);
    signal sdata_last : std_logic;
    signal curr_stag : std_logic_vector(tag_width - 1 downto 0);
    signal srdaddr : std_logic_vector(addr_width - 1 downto 0);

    signal logic0, logic1 : std_logic;
    signal zeroes : std_logic_vector(31 downto 0);

begin

    logic0 <= '0';
    logic1 <= '1';
    zeroes <= (others => '0');

    -- -------------------------------------------------------------------------------
    -- 'pclk' domain
    -- -------------------------------------------------------------------------------

    pq <= of_q;
    pwf <= if_wf;
    pwpf <= if_wpf;
    pre <= of_re;
    prpe <= of_rpe;

    capture : process(rst, pclk)
    begin
        if rst = '1' then
            aq <= (others => '0');
            writeq <= '0';
        elsif pclk'event and pclk = '1' then
            if idle1 = '1' and pce = '1' then
                aq <= pa;
                writeq <= pcw;
            end if;
        end if;
    end process;
        
    gen_if_d : process(
        state1,
        aq,
        busy2,
        pce,
        pterm,
        pcw,
        pwr,
        pa,
        pbe,
        pd,
        writeq)
        variable x : std_logic_vector(if_width - 1 downto 0);
    begin
        x := (others => '-');
        case state1 is
            when s1_idle =>
                x(addr_width - 1 downto 0) := pa;
                x(addr_width) := pcw;
                if_write <= pce;

            when s1_busy =>
                if_write <= '0';

            when s1_writing =>
                for i in pbe'range loop
                    x(9 * i + 7 downto 9 * i) := pd(8 * i + 7 downto 8 * i);
                    x(9 * i + 8) := pbe(i);
                end loop;
                x(if_data_width - 1) := pterm;
                if_write <= pwr;

            when s1_reading =>
                if_write <= pterm;
        end case;
        if_d <= x;
    end process;

    -- Retime 'term_ack' handshake pulse into 'pclk' domain
    pulse_sync_0 : pulse_sync
        port map(
            ar => rst,
            i => term_ack,
            ik => sclk,
            o => term_ackp,
            ok => pclk);

    gen_state1 : process(pclk, rst)
    begin
        if rst = '1' then
            state1 <= s1_idle;
            idle1 <= '1';
            reading1 <= '0';
        elsif pclk'event and pclk = '1' then
            if psr = '1' then
                state1 <= s1_idle;
                idle1 <= '1';
                reading1 <= '0';
            else
                state1 <= n_state1;
                idle1 <= n_idle1;
                reading1 <= n_reading1;
            end if;
        end if;
    end process;

    gen_n_state1 : process(
        state1,
        pce,
        pcw,
        pterm,
        pwr,
        busy2,
        writeq)
        variable xxx : std_logic_vector(2 downto 0);
    begin
        case state1 is
            when s1_idle =>
                if pce = '1' then
                    if pcw = '1' then
                        n_state1 <= s1_writing;
                        n_idle1 <= '0';
                        n_reading1 <= '0';
                    else
                        if busy2 = '1' then
                            n_state1 <= s1_busy;
                            n_idle1 <= '0';
                            n_reading1 <= '0';
                        else
                            n_state1 <= s1_reading;
                            n_idle1 <= '0';
                            n_reading1 <= '1';
                        end if;
                    end if;
                else
                    n_state1 <= s1_idle;
                    n_idle1 <= '1';
                    n_reading1 <= '0';
                end if;

            when s1_busy =>
                if busy2 = '0' then
                    if writeq = '1' then
                        n_state1 <= s1_writing;
                        n_idle1 <= '0';
                        n_reading1 <= '0';
                    else
                        n_state1 <= s1_reading;
                        n_idle1 <= '0';
                        n_reading1 <= '1';
                    end if;
                else
                    n_state1 <= s1_busy;
                    n_idle1 <= '0';
                    n_reading1 <= '0';
                end if;

            when s1_writing =>
                if pwr = '1' and pterm = '1' then
                    n_state1 <= s1_idle;
                    n_idle1 <= '1';
                    n_reading1 <= '0';
                else
                    n_state1 <= s1_writing;
                    n_idle1 <= '0';
                    n_reading1 <= '0';
                end if;

            when s1_reading =>
                if pterm = '1' then
                    n_state1 <= s1_idle;
                    n_idle1 <= '1';
                    n_reading1 <= '-';
                else
                    n_state1 <= s1_reading;
                    n_idle1 <= '0';
                    n_reading1 <= '1';
                end if;
        end case;
    end process;

    gen_state2 : process(pclk, rst)
    begin
        if rst = '1' then
            state2 <= s2_idle;
            busy2 <= '0';
            flush <= '0';
        elsif pclk'event and pclk = '1' then
            if psr = '1' then
                state2 <= s2_idle;
                busy2 <= '0';
                flush <= '0';
            else
                state2 <= n_state2;
                busy2 <= n_busy2;
                flush <= n_flush;
            end if;
        end if;
    end process;

    gen_n_state2 : process(
        state2,
        reading1,
        pterm,
        term_ackp)
        variable xxx : std_logic_vector(2 downto 0);
    begin
        case state2 is
            when s2_idle =>
                if reading1 = '1' and pterm = '1' then
                    n_state2 <= s2_busy;
                    n_busy2 <= '1';
                    n_flush <= '1';
                else
                    n_state2 <= s2_idle;
                    n_busy2 <= '0';
                    n_flush <= '0';
                end if;

            when s2_busy =>
                if term_ackp = '1' then
                    n_state2 <= s2_idle;
                    n_busy2 <= '0';
                    n_flush <= '1';
                else
                    n_state2 <= s2_busy;
                    n_busy2 <= '1';
                    n_flush <= '1';
                end if;
        end case;
    end process;

    of_read <= padv;
    of_flush <= flush;

    -- -------------------------------------------------------------------------------
    -- 'sclk' domain
    -- -------------------------------------------------------------------------------

    sreq <= i_sreq;
    sce <= i_sce;
    sa <= i_sa;
    stag <= curr_stag;
    sw <= i_sw;

    gen_sa : process(sclk, rst)
    begin
        if rst = '1' then
            i_sa <= (others => '-');
            sd <= (others => '-');
            sbe <= (others => '-');
        elsif sclk'event and sclk = '1' then
            if idle3 = '1' then
                if if_re = '0' then
                    i_sa <= scmd_addr;
                end if;
            else
                if i_sce = '1' then
                    i_sa <= i_sa + 1;
                end if;
            end if;

            for i in sbe'range loop
                sd(8 * i + 7 downto 8 * i) <= if_q(9 * i + 7 downto 9 * i);
            end loop;

            for i in sbe'range loop
                sbe(i) <= if_q(9 * i + 8);
            end loop;
        end if;
    end process;

    scmd_write <= if_q(addr_width);
    scmd_addr <= if_q(addr_width - 1 downto 0);

    sdata_last <= if_q(if_be_width * 9);

    if_read <= not if_re and (idle3 or (writing3 and sready) or reading3);
    if_flush <= ssr;

    store_sq : process(sclk, rst)
    begin
        if rst = '1' then
            of_write <= '0';
            of_d <= (others => '-');
        elsif sclk'event and sclk = '1' then
            of_write <= reading3 and svalid and not OR_reduce(sqtag xor curr_stag);
            of_d <= sq;
        end if;
    end process;

    gen_ssr : process(sclk, rst)
    begin
        if rst = '1' then
            ssr <= '0';
        elsif sclk'event and sclk = '1' then
            ssr <= psr;
        end if;
    end process;

    gen_curr_stag : process(sclk, rst)
    begin
        if rst = '1' then
            curr_stag <= (others => '0');
        elsif sclk'event and sclk = '1' then
            if ssr = '1' then
                curr_stag <= tag_base;
            else
                if reading3 = '1' and if_re = '0' then
                    curr_stag <= ((curr_stag + 1) and tag_mask) or tag_base;
                end if;
            end if;
        end if;
    end process;

    gen_srdaddr : process(sclk, rst)
    begin
        if rst = '1' then
            srdaddr <= (others => '-');
        elsif sclk'event and sclk = '1' then
            if idle3 = '1' then
                if if_re = '0' then
                    srdaddr <= scmd_addr;
                end if;
            else
                if of_write = '1' then
                    srdaddr <= srdaddr + 1;
                end if;
            end if;
        end if;
    end process;

    gen_state3 : process(sclk, rst)
    begin
        if rst = '1' then
            state3 <= s3_idle;
            idle3 <= '1';
            reading3 <= '0';
            term_ack <= '0';
            writing3 <= '0';
            i_sreq <= '0';
            i_sce <= '0';
            i_sw <= '-';
        elsif sclk'event and sclk = '1' then
            if ssr = '1' then
                state3 <= s3_idle;
                idle3 <= '1';
                reading3 <= '0';
                term_ack <= '0';
                writing3 <= '0';
                i_sreq <= '0';
                i_sce <= '0';
                i_sw <= '-';
            else
                state3 <= n_state3;
                idle3 <= n_idle3;
                reading3 <= n_reading3;
                term_ack <= n_term_ack;
                writing3 <= n_writing3;
                i_sreq <= n_sreq;
                i_sce <= n_sce;
                i_sw <= n_sw;
            end if;
        end if;
    end process;

    gen_n_state3 : process(
        state3,
        idle3,
        if_re,
        if_read,
        of_wpf,
        sdata_last,
        scmd_write,
        sready)
    begin
        case state3 is
            when s3_idle =>
                if if_re = '0' then
                    if scmd_write = '1' then
                        n_state3 <= s3_writing;
                        n_idle3 <= '0';
                        n_reading3 <= '0';
                        n_term_ack <= '0';
                        n_writing3 <= '1';
                        n_sreq <= '1';
                        n_sce <= '0';
                        n_sw <= '-';
                    else
                        n_state3 <= s3_reading;
                        n_idle3 <= '0';
                        n_reading3 <= '1';
                        n_term_ack <= '0';
                        n_writing3 <= '0';
                        n_sreq <= '1';
                        n_sce <= not of_wpf and sready;
                        n_sw <= '0';
                    end if;
                else
                    n_state3 <= s3_idle;
                    n_idle3 <= '1';
                    n_reading3 <= '0';
                    n_term_ack <= '0';
                    n_writing3 <= '0';
                    n_sreq <= '0';
                    n_sce <= '0';
                    n_sw <= '-';
                end if;

            when s3_writing =>
                if if_re = '0' then
                    if sready = '1' then
                        if sdata_last = '1' then
                            n_state3 <= s3_idle;
                            n_idle3 <= '1';
                            n_reading3 <= '0';
                            n_term_ack <= '0';
                            n_writing3 <= '0';
                            n_sreq <= '0';
                            n_sce <= '1';
                            n_sw <= '1';
                        else
                            n_state3 <= s3_writing;
                            n_idle3 <= '0';
                            n_reading3 <= '0';
                            n_term_ack <= '0';
                            n_writing3 <= '1';
                            n_sreq <= '1';
                            n_sce <= '1';
                            n_sw <= '1';
                        end if;
                    else
                        n_state3 <= s3_writing;
                        n_idle3 <= '0';
                        n_reading3 <= '0';
                        n_term_ack <= '0';
                        n_writing3 <= '1';
                        n_sreq <= '1';
                        n_sce <= '0';
                        n_sw <= '-';
                    end if;
                else
                    n_state3 <= s3_writing;
                    n_idle3 <= '0';
                    n_reading3 <= '0';
                    n_term_ack <= '0';
                    n_writing3 <= '1';
                    n_sreq <= '0';
                    n_sce <= '0';
                    n_sw <= '-';
                end if;

            when s3_reading =>
                if if_re = '0' then
                    n_state3 <= s3_term;
                    n_idle3 <= '0';
                    n_reading3 <= '0';
                    n_term_ack <= '0';
                    n_writing3 <= '0';
                    n_sreq <= '0';
                    n_sce <= '0';
                    n_sw <= '-';
                else
                    n_state3 <= s3_reading;
                    n_idle3 <= '0';
                    n_reading3 <= '1';
                    n_term_ack <= '0';
                    n_writing3 <= '0';
                    n_sreq <= '1';
                    n_sce <= not of_wpf and sready;
                    n_sw <= '0';
                end if;

            when s3_term =>
                n_state3 <= s3_idle;
                n_idle3 <= '1';
                n_reading3 <= '0';
                n_term_ack <= '1';
                n_writing3 <= '0';
                n_sreq <= '0';
                n_sce <= '0';
                n_sw <= '-';
        end case;
    end process;

    -- -------------------------------------------------------------------------------
    -- Inbound FIFO (pclk -> sclk)
    -- -------------------------------------------------------------------------------

    ififo : afifo
        generic map(
            width => if_width,
            order => order,
            wpfl => iwpfl,
            wpfl2 => 0,
            rpel => 0,
            family => to_fifo_family(family),
            safety => false,
            fflush => true)
        port map(
            rst => rst,
            wk => pclk,
            wd => if_d,
            wadv => if_write,
            we => open,
            wpf => if_wpf,
            wpf2 => open,
            wf => if_wf,
            wovf => open,
            wlevel => open,
            rk => sclk,
            rq => if_q,
            radv => if_read,
            rflush => if_flush,
            re => if_re,
            rpe => open,
            rf => open,
            rudf => open,
            rlevel => open);

    -- -------------------------------------------------------------------------------
    -- Outbound FIFO (sclk -> pclk)
    -- -------------------------------------------------------------------------------

    ofifo : afifo
        generic map(
            width => of_width,
            order => order,
            wpfl => owpfl,
            wpfl2 => 0,
            rpel => orpel,
            family => to_fifo_family(family),
            safety => false,
            fflush => false)
        port map(
            rst => rst,
            wk => sclk,
            wd => of_d,
            wadv => of_write,
            we => open,
            wpf => of_wpf,
            wpf2 => open,
            wf => of_wf,
            wovf => open,
            wlevel => open,
            rk => pclk,
            rq => of_q,
            radv => of_read,
            rflush => of_flush,
            re => of_re,
            rpe => of_rpe,
            rf => open,
            rudf => open,
            rlevel => open);

end mixed;
