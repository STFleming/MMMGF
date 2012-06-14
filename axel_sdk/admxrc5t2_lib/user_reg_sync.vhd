--
-- user_reg_sync.vhd - module to synchronise user-definable registers between
--                     local bus clock domain and user clock domain.
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

library work;
use work.admxrc5t2_common.all;

entity user_reg_sync is
    generic(
        width         : in    natural);
    port(
        rst           : in    std_logic;
        clk           : in    std_logic;
        user_clk      : in    std_logic;
        write         : in    std_logic;
        reg_wr        : in    std_logic_vector(width / 8 - 1 downto 0);
        reg_out_u     : in    std_logic_vector(width - 1 downto 0);
        busy          : out   std_logic;
        reg_wr_u      : out   std_logic_vector(width / 8 - 1 downto 0);
        reg_out       : out   std_logic_vector(width - 1 downto 0));
end entity;

architecture rtl of user_reg_sync is

    component FDCE
        port(
            CLR : in  std_logic;
            C   : in  std_logic;
            D   : in  std_logic;
            CE  : in  std_logic;
            Q   : out std_logic);
    end component;

    signal write0, write1, write2, write3 : std_logic;
    signal write4, write5, write6, write7 : std_logic;

    signal logic0, logic1 : std_logic;

begin

    logic0 <= '0';
    logic1 <= '1';

    busy <= write0;

    --
    -- Synchronise 'reg_wr' to user clock domain
    --

    gen_write0 : FDCE
        port map(
            CLR => write7,
            C => clk,
            D => logic1,
            CE => write,
            Q => write0);

    gen_write1 : FDCE
        port map(
            CLR => write7,
            C => clk,
            D => logic1,
            CE => write0,
            Q => write1);

    gen_write2 : FDCE
        port map(
            CLR => write7,
            C => clk,
            D => logic1,
            CE => write1,
            Q => write2);

    gen_write3 : FDCE
        port map(
            CLR => write7,
            C => clk,
            D => logic1,
            CE => write2,
            Q => write3);

    write4 <= write3 and not write7;

    gen_write5 : FDCE
        port map(
            CLR => rst,
            C => user_clk,
            D => write4,
            CE => logic1,
            Q => write5);

    write6 <= write5 and not write7;

    gen_write7 : FDCE
        port map(
            CLR => rst,
            C => user_clk,
            D => write6,
            CE => logic1,
            Q => write7);

    gen_reg_wr_u : process(rst, user_clk)
    begin
        if rst = '1' then
            reg_wr_u <= (others => '0');
        elsif user_clk'event and user_clk = '1' then
            if write7 = '1' then
                reg_wr_u <= reg_wr;
            else
                reg_wr_u <= (others => '0');
            end if;
        end if;
    end process;

    --
    -- Synchronise 'reg_out_u' to local bus clock domain
    --

    reg_sync_0 : reg_sync
        generic map(
            width => width)
        port map(
            ar => rst,
            ik => user_clk,
            i => reg_out_u,
            ok => clk,
            o => reg_out);

end architecture;
