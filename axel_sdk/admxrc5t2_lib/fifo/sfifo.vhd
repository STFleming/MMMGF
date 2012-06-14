--
-- sfifo.vhd - synchronous FIFO module
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

entity sfifo is
    generic(
        width  : in  natural;    -- Width of FIFO
        order  : in  natural;    -- FIFO depth is (2 ** order)
        wpfl   : in  natural;    -- Programmable full level
        rpel   : in  natural;    -- Programmable empty level
        family : in  work.fifo.family_t; -- FPGA family to target
        safety : in  boolean);   -- true => protect against illegal inputs
    port(
        rst    : in  std_logic;  -- Asynchronous reset
        k      : in  std_logic;  -- Reader side clock
        wd     : in  std_logic_vector(width - 1 downto 0); -- Write data
        wadv   : in  std_logic;  -- Write & advance pointer
        we     : out std_logic;  -- Writer side empty flag
        wpf    : out std_logic;  -- Writer side programmable full flag
        wf     : out std_logic;  -- Writer side full flag
        wovf   : out std_logic;  -- Writer side overflow flag
        rq     : out std_logic_vector(width - 1 downto 0); -- Read data
        radv   : in  std_logic;  -- Read & advance pointer
        rflush : in  std_logic;  -- Reader flush
        re     : out std_logic;  -- Reader side empty flag
        rpe    : out std_logic;  -- Reader side programmable empty flag
        rf     : out std_logic;  -- Reader side full flag
        rudf   : out std_logic;  -- Reader side underflow flag
        rlevel : out std_logic_vector(15 downto 0)); -- Number of occupied locations
end sfifo;

architecture struct of sfifo is

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
    signal size : std_logic_vector(order downto 0);
    
    signal i_we : std_logic;
    signal i_wpf : std_logic;
    signal i_wf : std_logic;
    signal i_re : std_logic;
    signal i_rpe : std_logic;
    signal i_rf : std_logic;
    
    signal r1e : std_logic;

    signal wadv_q : std_logic;
    
    signal push : std_logic;
    signal mem_rd : std_logic;
    signal mem_wr : std_logic;
    
    signal logic0 : std_logic;
    signal logic1 : std_logic;
    signal d1_zeroes : std_logic_vector(width - 1 downto 0);

begin

    logic0 <= '0';
    logic1 <= '1';
    
    rf <= i_rf;
    rpe <= i_rpe;
    re <= i_re;
    wf <= i_wf;
    wpf <= i_wpf;
    we <= i_we;
    rlevel <= EXT(size, 16);

    push <= wadv_q and i_re;
    mem_rd <= push or (radv and not r1e);
    mem_wr <= wadv and not i_wf;

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
        variable sizectl : std_logic_vector(3 downto 0);
    begin
        if rst = '1' then
            size <= (others => '0');
            i_we <= '1';
            i_wpf <= '0';
            i_wf <= '0';
            i_re <= '1';
            i_rpe <= '1';
            i_rf <= '0';
            r1e <= '1';
            ridx <= (others => '0');
            widx <= (others => '0');
            wadv_q <= '0';
        elsif k'event and k = '1' then
            if rflush = '1' then
                size <= (others => '0');
                i_we <= '1';
                i_wpf <= '0';
                i_wf <= '0';
                i_re <= '1';
                i_rpe <= '1';
                i_rf <= '0';
                r1e <= '1';
                ridx <= (others => '0');
                widx <= (others => '0');
                wadv_q <= '0';
            else
                --
                -- writer side
                --

                if wadv = '1' and i_wf = '0' then
                    widx <= widx + '1';
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
                -- Register the qualified write signal into 'wadv_q' - this is
                -- used to push the data through when the FIFO read empty
                -- flag changes to 0 (see the 'push' signal above).
                --
                wadv_q <= wadv and not i_wf;
                
                --
                -- reader side
                --

                if mem_rd = '1' then
                    ridx <= ridx + '1';
                end if;

                if radv = '1' then
                    if wadv = '0' then
                        i_rf <= '0';
                    end if;
                else
                    if wadv = '1' and size = (depth - 1) then
                        i_rf <= '1';
                    end if;
                end if;

                if radv = '1' then
                    if r1e = '1' then
                        i_re <= '1';
                    end if;
                else
                    if wadv_q = '1' and i_re = '1' then
                        i_re <= '0';
                    end if;
                end if;

                if radv = '1' then
                    if wadv = '0' and size = 2 then
                        r1e <= '1';
                    end if;
                else
                    if wadv = '1' and size = 1 then
                        r1e <= '0';
                    end if;
                end if;

                if radv = '1' then
                    if wadv = '0' and size = (rpel + 1) then
                        i_rpe <= '1';
                    end if;
                else
                    if wadv = '1' and size = rpel then
                        i_rpe <= '0';
                    end if;
                end if;

                --
                -- FIFO level counter
                --
                sizectl := wadv & radv & i_wf & i_re;
                case sizectl is
                    when "1000" | "1001" =>
                        size <= size + 1;
                    when "0100" | "0110" =>
                        size <= size - 1;
                    when others =>
                end case;
            end if;
        end if;
    end process;

    d1_zeroes <= (others => '0');

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
                a1     => ridx,
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
                a1     => ridx,
                q1     => rq);
    end generate;

end struct;
