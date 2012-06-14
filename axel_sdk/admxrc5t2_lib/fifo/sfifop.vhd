--
-- sfifop.vhd - synchronous FIFO module with temporary read pointer for
--              easy pipelining.
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library work;
use work.dpmem.all;
use work.fifo.all;

entity sfifop is
    generic(
        width   : in  natural;    -- Width of FIFO
        order   : in  natural;    -- FIFO depth is (2 ** order)
        wpfl    : in  natural;    -- Programmable full level
        rpel    : in  natural;    -- Programmable empty level
        family  : in  work.fifo.family_t; -- FPGA family to target
        safety  : in  boolean);   -- true => protect against illegal inputs (may be slower)
    port(
        rst     : in  std_logic;  -- Asynchronous reset
        k       : in  std_logic;  -- Reader side clock
        wd      : in  std_logic_vector(width - 1 downto 0); -- Write data
        wadv    : in  std_logic;  -- Write & advance pointer
        we      : out std_logic;  -- Writer side empty flag
        wpf     : out std_logic;  -- Writer side programmable full flag
        wf      : out std_logic;  -- Writer side full flag
        wovf    : out std_logic;  -- Writer side overflow flag
        rq      : out std_logic_vector(width - 1 downto 0); -- Read data
        radvt   : in  std_logic;  -- Read & advance read pointer temporarily
        radv    : in  std_logic;  -- Advance read pointer permanently
        rrev    : in  std_logic;  -- Revert temporary read pointer to permanent read pointer
        rflush  : in  std_logic;  -- Reader flush
        ret     : out std_logic;  -- Reader side temporary empty flag
        re      : out std_logic;  -- Reader side permanent empty flag
        rpet    : out std_logic;  -- Reader side temporary programmable empty flag
        rpe     : out std_logic;  -- Reader side permanent programmable empty flag
        rf      : out std_logic;  -- Reader side full flag
        rudf    : out std_logic;  -- Reader side underflow flag
        rlevelt : out std_logic_vector(15 downto 0);  -- Number of occupied locations (temporary)
        rlevel  : out std_logic_vector(15 downto 0)); -- Number of occupied locations (permanent)
end sfifop;

architecture struct of sfifop is

    constant depth : natural := 2**order;
    -- synopsys translate_off
    constant dpmem_init : std_logic_vector(depth * width - 1 downto 0) := (others => '0');
    -- synopsys translate_on

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

    signal widx : std_logic_vector(order - 1 downto 0);
    signal ridx : std_logic_vector(order - 1 downto 0);
    signal ridx1 : std_logic_vector(order - 1 downto 0);
    signal ridxt : std_logic_vector(order - 1 downto 0);
    signal size : std_logic_vector(order downto 0);
    signal sizet : std_logic_vector(order downto 0);
    
    signal i_we : std_logic;
    signal i_wpf : std_logic;
    signal i_wf : std_logic;
    signal i_re : std_logic;
    signal i_ret : std_logic;
    signal i_rpe : std_logic;
    signal i_rpet : std_logic;
    signal i_rf : std_logic;

    signal push : std_logic;
    
    signal mem_rd : std_logic;
    signal mem_addr : std_logic_vector(order - 1 downto 0);
    signal mem_wr : std_logic;
    
    signal logic0 : std_logic;
    signal logic1 : std_logic;
    signal d1_zeroes : std_logic_vector(width - 1 downto 0);

begin

    logic0 <= '0';
    logic1 <= '1';
    
    rf <= i_rf;
    rpe <= i_rpe when rpel /= 0 else i_re;
    re <= i_re;
    rpet <= i_rpet when rpel /= 0 else i_ret;
    ret <= i_ret;
    wf <= i_wf;
    wpf <= i_wpf when wpfl /= 0 else i_wf;
    we <= i_we;
    rlevel <= EXT(size, 16);
    rlevelt <= EXT(sizet, 16);

    --
    -- Generate overflow/underflow error flags
    --    
    gen_wovf : process(rst, k)
    begin
        if rst = '1' then
            wovf <= '0';
        elsif k'event and k = '1' then
            if wadv = '1' and i_wf = '1' then
                wovf <= '1';
            end if;
        end if;
    end process;

    gen_rudf : process(rst, k)
    begin
        if rst = '1' then
            rudf <= '0';
        elsif k'event and k = '1' then
            if radv = '1' and i_re = '1' then
                rudf <= '1';
            end if;
        end if;
    end process;

    update_flags: process(k, rst)
        variable sizectl : std_logic_vector(1 downto 0);
        variable n_size : std_logic_vector(size'range);
        variable n_re : std_logic;
        variable n_rpe : std_logic;
        variable writing : std_logic;
        variable reading : std_logic;
    begin
        if rst = '1' then
            size <= (others => '0');
            sizet <= (others => '0');
            i_we <= '1';
            i_wpf <= '0';
            i_wf <= '0';
            i_re <= '1';
            i_ret <= '1';
            i_rpe <= '1';
            i_rpet <= '1';
            i_rf <= '0';
            ridx <= (others => '0');
            ridx1 <= EXT("1", ridx1'length);
            ridxt <= (others => '0');
            widx <= (others => '0');
        elsif k'event and k = '1' then
            if rflush = '1' then
                size <= (others => '0');
                sizet <= (others => '0');
                i_we <= '1';
                i_wpf <= '0';
                i_wf <= '0';
                i_re <= '1';
                i_ret <= '1';
                i_rpe <= '1';
                i_rpet <= '1';
                i_rf <= '0';
                ridx <= (others => '0');
                ridx1 <= EXT("1", ridx1'length);
                ridxt <= (others => '0');
                widx <= (others => '0');
            else
                --
                -- Writer side flags
                --

                if wadv = '1' and i_wf = '0' then
                    widx <= widx + 1;
                end if;

                if wadv = '1' then
                    if radv = '0' then
                        i_we <= '0';
                    end if;
                else
                    if radv = '1' and size = 1 then
                        i_we <= '1';
                    end if;
                end if;

                if wadv = '1' then
                    if radv = '0' and size = (depth - 1) then
                        i_wf <= '1';
                    end if;
                else
                    if radv = '1' and i_wf = '1' then
                        i_wf <= '0';
                    end if;
                end if;

                if wadv = '1' then
                    if radv = '0' and size = (depth - wpfl - 1) then
                        i_wpf <= '1';
                    end if;
                else
                    if radv = '1' and size = (depth - wpfl) then
                        i_wpf <= '0';
                    end if;
                end if;
                
                --
                -- Reader side permanent pointer
                --

                if radv = '1' and i_re = '0' then
                    ridx1 <= ridx1 + 1;
                    ridx <= ridx1;
                end if;

                --
                -- Reader side permanent full flag
                --

                if radv = '1' then
                    if wadv = '0' then
                        i_rf <= '0';
                    end if;
                else
                    if wadv = '1' and size = (depth - 1) then
                        i_rf <= '1';
                    end if;
                end if;

                --
                -- Reader side permanent empty flag
                --

                if radv = '1' then
                    if size = 1 then
                        n_re := '1';
                    else
                        n_re := i_re;
                    end if;
                else
                    if OR_reduce(size) = '1' and i_re = '1' then
                        n_re := '0';
                    else
                        n_re := i_re;
                    end if;
                end if;
                i_re <= n_re;

                --
                -- Reader side permanent almost empty flag
                --

                if radv = '1' then
                    if wadv = '0' and size = (rpel + 1) then
                        n_rpe := '1';
                    else
                        n_rpe := i_rpe;
                    end if;
                else
                    if wadv = '1' and size = rpel then
                        n_rpe := '0';
                    else
                        n_rpe := i_rpe;
                    end if;
                end if;
                i_rpe <= n_rpe;

                --
                -- FIFO permanent level counter
                --

                writing := wadv and not i_wf;
                reading := radv and not i_re;
                sizectl := writing & reading;
                case sizectl is
                    when "10" =>
                        n_size := size + 1;
                    when "01" =>
                        n_size := size - 1;
                    when others =>
                        n_size := size;
                end case;
                size <= n_size;

                --
                -- Reader side temporary pointer
                --

                if rrev = '1' then
                    if n_re = '1' then
                        ridxt <= ridx;
                    else
                        ridxt <= ridx1;
                    end if;
                else
                    if radvt = '1' or push = '1' then
                        ridxt <= ridxt + 1;
                    end if;
                end if;

                --
                -- Reader side temporary empty flag
                --

                if rrev = '1' then
                    i_ret <= n_re;
                else
                    if radvt = '1' then
                        if sizet = 1 then
                            i_ret <= '1';
                        end if;
                    else
                        if OR_reduce(sizet) = '1' and i_ret = '1' then
                            i_ret <= '0';
                        end if;
                    end if;
                end if;

                --
                -- Reader side temporary almost empty flag
                --

                if rrev = '1' then
                    i_rpet <= n_rpe;
                else
                    if radvt = '1' then
                        if wadv = '0' and sizet = (rpel + 1) then
                            i_rpet <= '1';
                        end if;
                    else
                        if wadv = '1' and sizet = rpel then
                            i_rpet <= '0';
                        end if;
                    end if;
                end if;

                --
                -- FIFO temporary level counter
                --

                if rrev = '1' then
                    sizet <= n_size;
                else
                    writing := wadv and not i_wf;
                    reading := radvt and not i_ret;
                    sizectl := writing & reading;
                    case sizectl is
                        when "10" =>
                            sizet <= sizet + 1;
                        when "01" =>
                            sizet <= sizet - 1;
                        when others =>
                            null;
                    end case;
                end if;
            end if;
        end if;
    end process;

    d1_zeroes <= (others => '0');

    mem_wr <= wadv and not i_wf;

    push <= OR_reduce(sizet) and i_ret;
    mem_rd <= rrev or push or radvt;
    mem_addr <= ridxt when rrev = '0' else
                ridx  when rrev = '1' else
                (others => '-');

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
                k0     => k,
                sr0    => logic0,
                en0    => logic1,
                w0     => mem_wr,
                a0     => widx,
                d0     => wd,
                q0     => open,
                k1     => k,
                sr1    => rflush,
                en1    => mem_rd,
                w1     => logic0,
                a1     => mem_addr,
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
                k0     => k,
                sr0    => logic0,
                en0    => logic1,
                w0     => mem_wr,
                a0     => widx,
                d0     => wd,
                q0     => open,
                k1     => k,
                sr1    => rflush,
                en1    => mem_rd,
                a1     => mem_addr,
                q1     => rq);
    end generate;

end struct;
