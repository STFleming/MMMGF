--
-- ddrsdram_ctrl.vhd - module for generating address and control signals
--                     to DDR SDRAM.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library work;
use work.memif.all;

entity ddrsdram_ctrl is
    generic(
        rowcol_width    : in  natural;
        bank_width      : in  natural;
        num_phys_bank   : in  natural;
        num_clock_en    : in  natural);
    port (
        clk0            : in  std_logic;
        rst             : in  std_logic;
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
end;

architecture mixed of ddrsdram_ctrl is

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

begin

    gen_addr_out : process(clk0, rst)
    begin
        if rst = '1' then
            ddr_ba_o <= (others => '0');
            ddr_addr_o <= (others => '0');
            ddr_cke_o <= (others => '0');
            ddr_cs_o_l <= (others => '1');
            ddr_cas_o_l <= '1';
            ddr_ras_o_l <= '1';
            ddr_we_o_l <= '1';
        elsif clk0'event and clk0 = '1' then
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

            ddr_cke_o <= (others => cke);
            ddr_we_o_l <= command(0);
            ddr_cas_o_l <= command(1);
            ddr_ras_o_l <= command(2);
            for i in 0 to num_phys_bank - 1 loop
                ddr_cs_o_l(i) <= command(3) or not (command(4) or pbank_addr_1h(i));
            end loop;
        end if;
    end process;

end mixed;
