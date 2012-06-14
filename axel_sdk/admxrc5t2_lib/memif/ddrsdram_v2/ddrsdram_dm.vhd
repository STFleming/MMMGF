--
-- ddrsdram_dm.vhd
--
-- Module for generating DM signals for DDR SDRAM.
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

entity ddrsdram_dm is
    generic(
        dm_width      : in  natural);
    port(
        clk0          : in  std_logic;
        clk90         : in  std_logic;
        clk180        : in  std_logic;
        clk270        : in  std_logic;
        rst           : in  std_logic;
        regd          : in  std_logic;
        x4            : in  std_logic; -- must be driven by a constant
        oe_l          : in  std_logic_vector(dm_width - 1 downto 0);
        wr            : in  std_logic;
        dm            : in  std_logic_vector(dm_width * 2 - 1 downto 0);
        dm_o          : out std_logic_vector(dm_width - 1 downto 0);
        dm_t          : out std_logic_vector(dm_width - 1 downto 0));
end;

architecture mixed of ddrsdram_dm is

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

    signal dm_q : std_logic_vector(dm_width * 2 - 1 downto 0);
    signal dm_o_sel : std_logic_vector(dm_width * 2 - 1 downto 0);

    signal dqs_o_sel : std_logic_vector(dm_width - 1 downto 0);

    signal i_dm_o : std_logic_vector(dm_width - 1 downto 0);
    signal i_dqs_o : std_logic_vector(dm_width - 1 downto 0);

    signal i_dm_t : std_logic_vector(dm_width - 1 downto 0);

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
    attribute equivalent_register_removal of dm_o : signal is "no";
    attribute equivalent_register_removal of i_dm_t : signal is "no";
    attribute equivalent_register_removal of dm_t : signal is "no";
    attribute equivalent_register_removal of dm_q : signal is "no";
    attribute equivalent_register_removal of dm_o_sel : signal is "no";
    attribute equivalent_register_removal of i_dm_o : signal is "no";
    attribute equivalent_register_removal of dqs_o_sel : signal is "no";
    attribute equivalent_register_removal of i_dqs_o : signal is "no";
    attribute iob : string;
    attribute iob of dm_t : signal is "false";

begin

    logic0 <= '0';
    logic1 <= '1';

    dm_o <= i_dqs_o when x4 = '1' else i_dm_o;

    dm_t <= i_dm_t;

    --
    -- DDR DM/DQS output enable registers
    --

    delay_wr : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            wr_q <= wr;
        end if;
    end process;

    gen_i_dm_t : process(clk0, rst)
    begin
        if rst = '1' then
            i_dm_t <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            i_dm_t <= oe_l;
        end if;
    end process;

    --
    -- Delay byte enables to get DM
    --

    delay_dm : process(clk270)
    begin
        if clk270'event and clk270 = '1' then
            if regd = '1' then
                if wr_q = '1' then
                    dm_o_sel <= dm_q;
                else
                    dm_o_sel <= (others => '1');
                end if;
            else
                if wr = '1' then
                    dm_o_sel <= dm;
                else
                    dm_o_sel <= (others => '1');
                end if;
            end if;

            dm_q <= dm;
        end if;
    end process;
    
    --
    -- Instantiate DDR registers for DM pins (ignored unless x4 = 0)
    --

    gen_dm_o : for i in 0 to dm_width - 1 generate
        U0 : FDDRRSE
            port map(
                D0 => dm_o_sel(i),
                D1 => dm_o_sel(i + dm_width),
                C0 => clk90,
                C1 => clk270,
                CE => '1',
                R  => '0',
                S  => '0',
                Q  => i_dm_o(i));
    end generate;

    --
    -- Generate DQS for DM pins (ignored unless x4 = 1 OR byte_enable = false)
    --

    delay_dqs : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            if x4 = '1' then
                if regd = '1' then
                    if wr_q = '1' then
                        dqs_o_sel <= (others => '1');
                    else
                        dqs_o_sel <= (others => '0');
                    end if;
                else
                    if wr = '1' then
                        dqs_o_sel <= (others => '1');
                    else
                        dqs_o_sel <= (others => '0');
                    end if;
                end if;
            else
                dqs_o_sel <= (others => '0');
            end if;
        end if;
    end process;
    
    --
    -- Instantiate DDR registers for DQS on DM pins (ignored unless x4 = 1)
    --

    gen_dqs_o : for i in 0 to dm_width - 1 generate
        U0 : FDDRRSE
            port map(
                D0 => dqs_o_sel(i),
                D1 => logic0,
                C0 => clk180,
                C1 => clk0,
                CE => '1',
                R  => '0',
                S  => '0',
                Q  => i_dqs_o(i));
    end generate;

end mixed;
