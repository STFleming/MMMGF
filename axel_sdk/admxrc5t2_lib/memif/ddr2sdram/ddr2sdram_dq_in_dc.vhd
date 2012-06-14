--
-- ddr2sdram_dq_in_dc.vhd
--
-- Module for capturing DQ from DDR-II SDRAM using direct clocking scheme.
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
library std;
use std.textio.all;
-- synopsys translate_on

library work;
use work.memif.all;

entity ddr2sdram_dq_in_dc is
    generic(
        dqs_width       : in  natural;
        dq_width        : in  natural;
        d_width         : in  natural;
        tag_width       : in  natural);
    port( 
        clk0            : in  std_logic;
        clk45           : in  std_logic;
        clk2x0          : in  std_logic;
        clk2x90         : in  std_logic;
        sr              : in  std_logic_vector(dq_width - 1 downto 0);
        ce              : in  std_logic_vector(dq_width - 1 downto 0);
        dlysr           : in  std_logic_vector(dq_width - 1 downto 0);
        dlyce           : in  std_logic_vector(dq_width - 1 downto 0);
        dlyinc          : in  std_logic_vector(dq_width - 1 downto 0);
        qce             : in  std_logic_vector(dq_width - 1 downto 0);
        qdelay          : in  std_logic_vector(dq_width * 2 - 1 downto 0);
        vdelay          : in  std_logic_vector(3 downto 0);
        rd              : in  std_logic;
        init_done       : in  std_logic;
        tag             : in  std_logic_vector(tag_width - 1 downto 0);
        dq_i            : in  std_Logic_vector(dq_width - 1 downto 0);
        q               : out std_logic_vector(d_width - 1 downto 0);
        dq              : out std_logic_vector(dq_width - 1 downto 0); -- unregistered data, for debug
        qtag            : out std_logic_vector(tag_width - 1 downto 0);
        valid           : out std_logic;
        init_valid      : out std_logic);
end entity;

architecture mixed of ddr2sdram_dq_in_dc is

    constant this_module : string := "ddr2sdram_dq_in_dc";

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

    signal dlysr_q : std_logic_vector(dq_width - 1 downto 0);
    signal dlyce_q : std_logic_vector(dq_width - 1 downto 0);
    signal dlyce_qq : std_logic_vector(dq_width - 1 downto 0);
    signal dlyinc_q : std_logic_vector(dq_width - 1 downto 0);

    signal dq_iserdes : std_logic_vector(4 * dq_width - 1 downto 0);
    signal dq_ro : std_logic_vector(4 * dq_width - 1 downto 0);
    signal dq_ro_q : std_logic_vector(4 * dq_width - 1 downto 0);
    signal dq_ro_qq : std_logic_vector(4 * dq_width - 1 downto 0);
    signal q_ext : std_logic_vector(4 * dq_width - 1 downto 0);

    signal beat : std_logic;
    signal beat_q : std_logic;
    signal first : std_logic;
    signal second : std_logic;

    signal ce_ro : std_logic_vector(dq_width - 1 downto 0);

    signal rd_init : std_logic;
    signal rd_not_init : std_logic;

    signal clk2x90_l : std_logic;

    signal logic0 : std_logic;
    signal logic1 : std_logic;

    component ddr2sdram_iserdes_dq
        port(
            clk2x      : in  std_logic;
            dlysr      : in  std_logic;
            dlyce      : in  std_logic;
            dlyinc     : in  std_logic;
            sr         : in  std_logic;
            ce         : in  std_logic;
            dqs        : in  std_logic;
            d          : in  std_logic;
            q          : out std_logic_vector(3 downto 0);
            o          : out std_logic);
    end component;

    component SRL16E
        generic(
            INIT : bit_vector := X"0000");
        port(
            D : in std_logic;
            CE : in std_logic;
            CLK : in std_logic;
            A0 : in std_logic;
            A1 : in std_logic;
            A2 : in std_logic;
            A3 : in std_logic;
            Q : out std_logic);
    end component;

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of dlyce_q : signal is "no";
    attribute equivalent_register_removal of dlyce_qq : signal is "no";
    attribute equivalent_register_removal of dlyinc_q : signal is "no";
    attribute equivalent_register_removal of dlysr_q : signal is "no";

begin

    -- synopsys translate_off
    assert dq_width = 8 * dqs_width
        report "*** " & this_module & ": illegal value " & conv_string(dq_width) & " for dq_width : not 8 * dqs_width"
        severity failure;
    -- synopsys translate_on

    logic0 <= '0';
    logic1 <= '1';

    q <= EXT(q_ext, d_width);

    gen_dlyce_q : process(clk45)
    begin
        if clk45'event and clk45 = '1' then
            dlyce_q <= dlyce;
            dlyinc_q <= dlyinc;
            dlysr_q <= dlysr;
        end if;
    end process;

    gen_dlyce_qq : process(clk2x90)
    begin
        if clk2x90'event and clk2x90 = '1' then
            for i in 0 to dq_width - 1 loop
                dlyce_qq(i) <= dlyce_q(i) and first;
            end loop;
        end if;
    end process;

    clk2x90_l <= not clk2x90;

    gen_serdes : for i in 0 to dq_width - 1 generate
        U0 : ddr2sdram_iserdes_dq
            port map(
                clk2x => clk2x90,
                dlysr => dlysr_q(i),
                dlyce => dlyce_qq(i),
                dlyinc => dlyinc_q(i),
                sr => sr(i),
                ce => ce(i),
                dqs => clk2x90_l,
                d => dq_i(i),
                q => dq_iserdes(4 * i + 3 downto 4 * i),
                o => dq(i));
    end generate;

    gen_beat : process(clk45)
    begin
        if clk45'event and clk45 = '1' then
            if sr(0) = '1' then
                beat <= '0';
            else
                beat <= not beat;
            end if;
        end if;
    end process;

    gen_ce_ro : process(clk2x90)
    begin
        if clk2x90'event and clk2x90 = '1' then
            beat_q <= beat;
            first <= beat xnor beat_q;
            second <= beat xor beat_q;
        end if;
    end process;

    gen_first : process(clk2x90)
    begin
        if clk2x90'event and clk2x90 = '1' then
            for i in 0 to dq_width - 1 loop
                if qce(i) = '1' then
                    ce_ro(i) <= first;
                else
                    ce_ro(i) <= second;
                end if;
            end loop;
        end if;
    end process;

    reorder : process(dq_iserdes)
    begin
        for i in 0 to dq_width - 1 loop
            dq_ro(i + 0 * dq_width) <= dq_iserdes(4 * i + 0);
            dq_ro(i + 1 * dq_width) <= dq_iserdes(4 * i + 1);
            dq_ro(i + 2 * dq_width) <= dq_iserdes(4 * i + 2);
            dq_ro(i + 3 * dq_width) <= dq_iserdes(4 * i + 3);
        end loop;
    end process;

    reg_dq_ro1 : process(clk2x90)
    begin
        if clk2x90'event and clk2x90 = '1' then
            for i in 0 to dq_width - 1 loop
                if ce_ro(i) = '1' then
                    dq_ro_q(i + 0 * dq_width) <= dq_ro(i + 0 * dq_width);
                    dq_ro_q(i + 1 * dq_width) <= dq_ro(i + 1 * dq_width);
                    dq_ro_q(i + 2 * dq_width) <= dq_ro(i + 2 * dq_width);
                    dq_ro_q(i + 3 * dq_width) <= dq_ro(i + 3 * dq_width);
                end if;
            end loop;
        end if;
    end process;

    reg_dq_ro2 : process(clk45)
    begin
        if clk45'event and clk45 = '0' then
            dq_ro_qq <= dq_ro_q;
        end if;
    end process;

    rd_not_init <= rd and init_done;

    SRL16E_valid : SRL16E
        port map(
            D => rd_not_init,
            CE => logic1,
            CLK => clk0,
            A0 => vdelay(0),
            A1 => vdelay(1),
            A2 => vdelay(2),
            A3 => vdelay(3),
            Q => valid);

    rd_init <= rd and not init_done;

    SRL16E_init_valid : SRL16E
        port map(
            D => rd_init,
            CE => logic1,
            CLK => clk0,
            A0 => vdelay(0),
            A1 => vdelay(1),
            A2 => vdelay(2),
            A3 => vdelay(3),
            Q => init_valid);

    gen_tag : for i in 0 to tag_width - 1 generate
        U0 : SRL16E
            port map(
                D => tag(i),
                CE => logic1,
                CLK => clk0,
                A0 => vdelay(0),
                A1 => vdelay(1),
                A2 => vdelay(2),
                A3 => vdelay(3),
                Q => qtag(i));
    end generate;

    gen_q : for i in 0 to dq_width - 1 generate
        U0 : SRL16E
            port map(
                D => dq_ro_qq(i + 0 * dq_width),
                CE => logic1,
                CLK => clk0,
                A0 => qdelay(2 * i),
                A1 => qdelay(2 * i + 1),
                A2 => logic0,
                A3 => logic0,
                Q => q_ext(i + 0 * dq_width));

        U1 : SRL16E
            port map(
                D => dq_ro_qq(i + 1 * dq_width),
                CE => logic1,
                CLK => clk0,
                A0 => qdelay(2 * i),
                A1 => qdelay(2 * i + 1),
                A2 => logic0,
                A3 => logic0,
                Q => q_ext(i + 1 * dq_width));

        U2 : SRL16E
            port map(
                D => dq_ro_qq(i + 2 * dq_width),
                CE => logic1,
                CLK => clk0,
                A0 => qdelay(2 * i),
                A1 => qdelay(2 * i + 1),
                A2 => logic0,
                A3 => logic0,
                Q => q_ext(i + 2 * dq_width));

        U3 : SRL16E
            port map(
                D => dq_ro_qq(i + 3 * dq_width),
                CE => logic1,
                CLK => clk0,
                A0 => qdelay(2 * i),
                A1 => qdelay(2 * i + 1),
                A2 => logic0,
                A3 => logic0,
                Q => q_ext(i + 3 * dq_width));
    end generate;

end mixed;
