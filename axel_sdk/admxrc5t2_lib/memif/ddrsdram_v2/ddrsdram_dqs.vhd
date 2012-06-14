--
-- ddrsdram_dqs.vhd
--
-- Module for generating outbound DQS signals for DDR SDRAM.
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

entity ddrsdram_dqs is
    generic(
        dqs_width     : in  natural);
    port(
        clk0          : in  std_logic;
        clk180        : in  std_logic;
        rst           : in  std_logic;
        regd          : in  std_logic;
        oe_l          : in  std_logic_vector(dqs_width - 1 downto 0);
        wr            : in  std_logic;
        dqs_o         : out std_logic_vector(dqs_width - 1 downto 0);
        dqs_t         : out std_logic_vector(dqs_width - 1 downto 0));
end;

architecture mixed of ddrsdram_dqs is

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

    signal wr_q : std_logic;
    signal wr_q_sel : std_logic_vector(dqs_width - 1 downto 0);

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

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of wr_q_sel : signal is "no";
    attribute equivalent_register_removal of dqs_o : signal is "no";
    attribute equivalent_register_removal of dqs_t : signal is "no";
    attribute iob : string;
    attribute iob of dqs_t : signal is "false";

begin

    logic0 <= '0';
    logic1 <= '1';

    --
    -- Generate DDR flip-flops for DQS pins
    --

    delay_wr : process (clk0)
    begin
        if clk0'event and clk0 = '1' then
            wr_q <= wr;
            if regd = '1' then
                wr_q_sel <= (others => wr_q);
            else
                wr_q_sel <= (others => wr);
            end if;
        end if;
    end process;

    gen_ddrff : for i in 0 to dqs_width - 1 generate
        U0 : FDDRRSE
            port map(
                D0 => logic0,
                D1 => wr_q_sel(i),
                C0 => clk0,
                C1 => clk180,
                CE => '1',
                R  => '0',
                S  => '0',
                Q  => dqs_o(i));
    end generate;

    --
    -- Generate output-enable flip-flops for DQS pins
    --

    gen_dqs_t : process(rst, clk0)
    begin
        if rst = '1' then
            dqs_t <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            dqs_t <= oe_l;
        end if;
    end process;

end mixed;
