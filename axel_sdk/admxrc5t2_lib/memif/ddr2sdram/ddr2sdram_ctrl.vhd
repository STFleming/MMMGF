--
-- ddr2sdram_ctrl.vhd - module for generating address and control signals
--                      to DDR-II SDRAM.
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

library work;
use work.memif.all;

entity ddr2sdram_ctrl is
    generic(
        rowcol_width    : in  natural;
        bank_width      : in  natural;
        num_phys_bank   : in  natural;
        num_clock_en    : in  natural);
    port (
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
end entity;

architecture mixed of ddr2sdram_ctrl is

    component ODDR
        generic(
            DDR_CLK_EDGE : in  string := "OPPOSITE_EDGE";
            INIT         : in  bit := '1';
            SRTYPE       : in  string := "SYNC");
        port(
            D1           : in  std_logic;
            D2           : in  std_logic;
            CE           : in  std_logic;
            C            : in  std_logic;
            S            : in  std_logic;
            R            : in  std_logic;
            Q            : out std_logic);
    end component;

    signal cs_o_l : std_logic_vector(num_phys_bank - 1 downto 0);

    signal logic0, logic1 : std_logic;

    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of ddr_addr_o : signal is "no";
    attribute equivalent_register_removal of ddr_ba_o : signal is "no";
    attribute equivalent_register_removal of ddr_cke_o : signal is "no";
    attribute equivalent_register_removal of ddr_cs_o_l : signal is "no";
    attribute equivalent_register_removal of ddr_we_o_l : signal is "no";
    attribute equivalent_register_removal of ddr_ras_o_l : signal is "no";
    attribute equivalent_register_removal of ddr_cas_o_l : signal is "no";
    attribute iob : string;
    attribute iob of ddr_addr_o : signal is "true";
    attribute iob of ddr_ba_o : signal is "true";
    attribute iob of ddr_cke_o : signal is "true";
    attribute iob of ddr_we_o_l : signal is "true";
    attribute iob of ddr_cas_o_l : signal is "true";
    attribute iob of ddr_ras_o_l : signal is "true";
    attribute iob of ddr_cs_o_l : signal is "true";

    attribute DDR_CLK_EDGE : string;
    attribute DDR_CLK_EDGE of gen_WE : label is "SAME_EDGE";
    attribute DDR_CLK_EDGE of gen_CAS : label is "SAME_EDGE";
    attribute DDR_CLK_EDGE of gen_RAS : label is "SAME_EDGE";
    attribute INIT : bit;
    attribute INIT of gen_WE : label is '1';
    attribute INIT of gen_CAS : label is '1';
    attribute INIT of gen_RAS : label is '1';
    attribute SRTYPE : string;
    attribute SRTYPE of gen_WE : label is "ASYNC";
    attribute SRTYPE of gen_CAS : label is "ASYNC";
    attribute SRTYPE of gen_RAS : label is "ASYNC";

begin

    logic0 <= '0';
    logic1 <= '1';

    gen_WE : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => command(0),
            D2 => logic1,
            CE => logic1,
            C => clk,
            S => sr,
            R => logic0,
            Q => ddr_we_o_l);

    gen_CAS : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => command(1),
            D2 => logic1,
            CE => logic1,
            C => clk,
            S => sr,
            R => logic0,
            Q => ddr_cas_o_l);

    gen_RAS : ODDR
        generic map(
            DDR_CLK_EDGE => "SAME_EDGE",
            INIT => '1',
            SRTYPE => "ASYNC")
        port map(
            D1 => command(2),
            D2 => logic1,
            CE => logic1,
            C => clk,
            S => sr,
            R => logic0,
            Q => ddr_ras_o_l);

    gen_CS : for i in 0 to num_phys_bank - 1 generate
        attribute DDR_CLK_EDGE of U0 : label is "SAME_EDGE";
        attribute INIT of U0 : label is '1';
        attribute SRTYPE of U0 : label is "ASYNC";
    begin
        cs_o_l(i) <= command(3) or not (command(4) or pbank_addr_1h(i));

        U0 : ODDR
            generic map(
                DDR_CLK_EDGE => "SAME_EDGE",
                INIT => '1',
                SRTYPE => "ASYNC")
            port map(
                D1 => cs_o_l(i),
                D2 => logic1,
                CE => logic1,
                C => clk,
                S => sr,
                R => logic0,
                Q => ddr_cs_o_l(i));
    end generate;

    gen_cke_out : process(clk, rst)
    begin
        if rst = '1' then
            ddr_cke_o <= (others => '0');
        elsif clk'event and clk = '1' then
            if sr = '1' then
                ddr_cke_o <= (others => '0');
            else
                ddr_cke_o <= (others => cke);
            end if;
        end if;
    end process;

    gen_addr_out : process(clk)
    begin
        if clk'event and clk = '1' then
            if mux_special = '1' then
                ddr_addr_o <= special_addr(rowcol_width - 1 downto 0);
                ddr_ba_o <= special_addr(rowcol_width + bank_width - 1 downto rowcol_width);
            else
                if mux_col = '0' then
                    ddr_addr_o <= row_addr;
                else
                    ddr_addr_o <= col_addr;
                end if;
                ddr_ba_o <= bank_addr;
            end if;
        end if;
    end process;

end mixed;
