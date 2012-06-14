--
-- ddrsdram_data_dqs.vhd - DDR SDRAM data path, using DQS for read
--                         data capture in IOBs.
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

entity ddrsdram_data_dqs is
    generic(
        family      : in  family_t;
        rd_width    : in  natural;
        d_width     : in  natural;
        dqs_width   : in  natural;
        tag_width   : in  natural);
    port (
        clk0        : in  std_logic;
        clk90       : in  std_logic;
        clk180      : in  std_logic;
        clk270      : in  std_logic;
        clkc0       : in  std_logic;
        clkc180     : in  std_logic;
        rst         : in  std_logic;
        cedge       : in  std_logic_vector(2 downto 0);
        regd        : in  std_logic;
        oe_l        : in  std_logic_vector(rd_width - 1 downto 0);
        wr          : in  std_logic;
        rd          : in  std_logic;
        init_done   : in  std_logic;
        d           : in  std_logic_vector(d_width - 1 downto 0);
        tag         : in  std_logic_vector(tag_width - 1 downto 0);
        dq_i        : in  std_Logic_vector(rd_width - 1 downto 0);
        dqs_i       : in  std_Logic_vector(dqs_width - 1 downto 0);
        dq_o        : out std_logic_vector(rd_width - 1 downto 0);
        dq_t        : out std_Logic_vector(rd_width - 1 downto 0);
        q           : out std_logic_vector(d_width - 1 downto 0);
        qtag        : out std_logic_vector(tag_width - 1 downto 0);
        valid       : out std_logic;
        init_valid  : out std_logic);
end;

architecture mixed of ddrsdram_data_dqs is

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

    signal rd_init : std_logic;
    signal rd_not_init : std_logic;

    signal d_q : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal d_q_sel : std_logic_vector(rd_width * 2 - 1 downto 0);

    signal dq_l, dq_h : std_logic_vector(rd_width - 1 downto 0);
    signal q_l, q_h : std_logic_vector(rd_width - 1 downto 0);
    signal q0_l0, q0_h0 : std_logic_vector(rd_width - 1 downto 0);
    signal q0_l1, q0_h1 : std_logic_vector(rd_width - 1 downto 0);
    signal q0 : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal q180_l0, q180_h0 : std_logic_vector(rd_width - 1 downto 0);
    signal q180_l1 : std_logic_vector(rd_width - 1 downto 0);
    signal q180 : std_logic_vector(rd_width * 2 - 1 downto 0);
    signal i_q : std_logic_vector(rd_width * 2 - 1 downto 0);

    signal srl_tap : std_logic_vector(3 downto 0);

    signal logic0, logic1 : std_logic;

    component FDDRRSE
        port(
            D0 : in  std_logic;
            D1 : in  std_logic;
            C0 : in  std_logic;
            C1 : in  std_logic;
            CE : in  std_logic;
            R  : in  std_logic;
            S  : in  std_logic;
            Q  : out std_logic);
    end component;

    component SRLC16E
        port(
            D   : in  std_logic;
            CE  : in  std_logic;
            CLK : in  std_logic;
            A0  : in  std_logic;
            A1  : in  std_logic;
            A2  : in  std_logic;
            A3  : in  std_logic;
            Q   : out std_logic;
            Q15 : out std_logic);
    end component;

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of dq_o : signal is "no";
    attribute equivalent_register_removal of dq_t : signal is "no";
    attribute equivalent_register_removal of dq_l : signal is "no";
    attribute equivalent_register_removal of dq_h : signal is "no";
    attribute equivalent_register_removal of q_l : signal is "no";
    attribute equivalent_register_removal of q_h : signal is "no";
    -- Ensure that critical signals are packed into IOBs
    attribute iob : string;
    attribute iob of dq_t : signal is "false";
    attribute iob of dq_o : signal is "true";
    attribute iob of dq_l : signal is "true";
    attribute iob of dq_h : signal is "true";

begin

    logic0 <= '0';
    logic1 <= '1';

    --
    -- Write data path (independent of CAS latency)
    --
    -- 'd' is valid when 'wr' is asserted.
    --

    delay_data1 : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            d_q <= EXT(d, rd_width * 2);
        end if;
    end process;

    delay_data2 : process(clk270)
    begin
        if clk270'event and clk270 = '1' then
            if regd = '1' then
                d_q_sel <= d_q;
            else
                d_q_sel <= EXT(d, rd_width * 2);
            end if;
        end if;
    end process;

    --
    -- Here, DQ and DM are generated such that DQS falls in the middle
    -- of the valid window for DQ and DM. This is necessary when the
    -- PCB traces for DQS do not introduce significant delay.
    --

    gen_ddrff : for i in 0 to rd_width - 1 generate
        U0 : FDDRRSE
            port map(
                D0 => d_q_sel(i),
                D1 => d_q_sel(i + rd_width),
                C0 => clk90,
                C1 => clk270,
                CE => '1',
                R  => '0',
                S  => '0',
                Q  => dq_o(i));
    end generate;

    --
    -- Generate output enables for DQ pins
    --

    gen_dq_t : process (rst, clk180)
    begin
        if rst = '1' then
            dq_t <= (others => '1');
        elsif clk180'event and clk180 = '1' then
            dq_t <= oe_l;
        end if;
    end process;

    --
    -- Capture DQ from DDR SDRAM into DDR IOB flip-flops using DQS.
    --

    capture_dqs : for i in 0 to dqs_width - 1 generate
        rising : process(dqs_i)
        begin
            if dqs_i(i)'event and dqs_i(i) = '1' then
                dq_l(8 * i + 7 downto 8 * i) <= dq_i(8 * i + 7 downto 8 * i);
            end if;
        end process;

        falling : process(dqs_i)
        begin
            if dqs_i(i)'event and dqs_i(i) = '0' then
                dq_h(8 * i + 7 downto 8 * i) <= dq_i(8 * i + 7 downto 8 * i);
            end if;
        end process;
    end generate;

    --
    -- Recapture DQ from DQS clock domain into clkc domain
    --

    recapture_clkc0 : process(clkc0)
    begin
        if clkc0'event and clkc0 = '1' then
            q_l <= dq_l;
        end if;
    end process;

    recapture_clkc180 : process(clkc180)
    begin
        if clkc180'event and clkc180 = '1' then
            q_h <= dq_h;
        end if;
    end process;

    --
    --
    -- Retime DQ from 'clkc0/180' domain to 'clk0' domain, using 'clk0/180'
    --

    recapture_0a : process(clk0)
    begin
       if clk0'event and clk0 = '1' then
            q0_l0 <= q_l;
            q0_l1 <= q0_l0;
            q0_h1 <= q0_h0;
        end if;
    end process;

    recapture_0b : process(clk180)
    begin
       if clk180'event and clk180 = '1' then
            q0_h0 <= q_h;
        end if;
    end process;

    q0 <= q0_h1 & q0_l1;

    --
    -- Retime DQ from 'clkc0/180' domain to 'clk0' domain, using 'clk180/0'
    --

    recapture_180a : process(clk180)
    begin
       if clk180'event and clk180 = '1' then
            q180_l0 <= q_l;
        end if;
    end process;

    recapture_180b : process(clk0)
    begin
       if clk0'event and clk0 = '1' then
            q180_h0 <= q_h;
            q180_l1 <= q180_l0;
        end if;
    end process;

    q180 <= q180_h0 & q180_l1;

    --
    -- Generate 'q', selecting either:
    --
    -- (a) IOB-captured data that has been retimed using 'clk0/180', OR
    -- (b) IOB-captured data that has been retimed using 'clk180/0'.
    --
    -- This is necessary because 'clkc0' will either be at least 180 degrees
    -- different from 'clk0', in which case (a) applies, OR at least 180 degrees
    -- different from 'clk180', in which case (b) applies.
    --

    gen_i_q : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if cedge(0) = '1' then
                i_q <= q180;
            else
                i_q <= q0;
            end if;
        end if;
    end process;

    q <= EXT(i_q, d_width);

    --
    -- Generate tap value for SRLC16Es that form a programmable delay line for
    -- 'valid' and 'qtag'
    --

    gen_srl_tap : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            case cedge is
                when "000" | "001" =>
                    srl_tap <= "0100";
                when "010" | "011" =>
                    srl_tap <= "0101";
                when "100" | "101" =>
                    srl_tap <= "0110";
                when "110" | "111" =>
                    srl_tap <= "0111";
                when others =>
                    srl_tap <= "----";
            end case;
        end if;
    end process;

    --
    -- Programmable delay lines for 'valid' and 'qtag'
    --

    rd_not_init <= rd and init_done;

    gen_valid_not_init : SRLC16E
        port map(
            D => rd_not_init,
            CE => logic1,
            CLK => clk0,
            A0 => srl_tap(0),
            A1 => srl_tap(1),
            A2 => srl_tap(2),
            A3 => srl_tap(3),
            Q => valid,
            Q15 => open);

    rd_init <= rd and not init_done;

    gen_valid_init : SRLC16E
        port map(
            D => rd_init,
            CE => logic1,
            CLK => clk0,
            A0 => srl_tap(0),
            A1 => srl_tap(1),
            A2 => srl_tap(2),
            A3 => srl_tap(3),
            Q => init_valid,
            Q15 => open);

    gen_tag : for i in qtag'range generate
        U0 : SRLC16E
            port map(
                D => tag(i),
                CE => logic1,
                CLK => clk0,
                A0 => srl_tap(0),
                A1 => srl_tap(1),
                A2 => srl_tap(2),
                A3 => srl_tap(3),
                Q => qtag(i),
                Q15 => open);
    end generate;

end mixed;
