--
-- ddr2sram_model.vhd - DDR-II SRAM interface and IO pins
--
-- NOT SYNTHESIZABLE
--
-- 'burst_order' represents DDR burst length. Typical values are:
--
--   1 => burst length 2
--   2 => burst length 4
--
-- A burst of length 4 takes 2 clock cycles to complete.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

entity ddr2sram_model is
    generic(
        burst_order : in    natural;
        a_width     : in    natural;
        dq_width    : in    natural;
        t_trace     : in    time := 0.0 ns); -- Model trace delay etc.
    port(
        k           : in    std_logic;
        k_l         : in    std_logic;
        c           : in    std_logic;
        c_l         : in    std_logic;
        ld_l        : in    std_logic;
        w_l         : in    std_logic;
        bwe_l       : in    std_logic_vector(dq_width / 8 - 1 downto 0);
        dq          : inout std_logic_vector(dq_width - 1 downto 0);
        cq          : out   std_logic;
        cq_l        : out   std_logic;
        a           : in    std_logic_vector(a_width - 1 downto 0));
end entity;

architecture behav of ddr2sram_model is

    constant depth : natural := 2**(a_width + 1);
    constant byte_width : natural := dq_width / 8;
    constant burst_len : natural := 2**(burst_order - 1);
    constant burst_limit : natural := burst_len - 1;

    subtype byte_t is natural range 0 to 255;
    type byte_vector_t is array (natural range <>) of byte_t;

    shared variable memory : byte_vector_t(0 to depth - 1) := (others => 0);

    signal a1 : std_logic_vector(a_width - 1 downto 0) := (others => '-');
    signal a1f : std_logic_vector(a_width - 1 downto 0) := (others => '-');
    signal a2 : std_logic_vector(a_width - 1 downto 0) := (others => '-');
    signal a2f : std_logic_vector(a_width - 1 downto 0) := (others => '-');
    signal ce1 : std_logic := '0';
    signal ce2 : std_logic := '0';
    signal we1 : std_logic := '0';
    signal we2 : std_logic := '0';

    signal dq_oe : std_logic := '0';
    signal dq_out0, dq_out1, dq_out : std_logic_vector(dq_width - 1 downto 0);

    type state_t is (s_idle, s_burst_read, s_burst_write);
    signal state : state_t := s_idle;
    signal n_state : state_t;
    signal burst_count : std_logic_vector(7 downto 0) := (others => '0');
    signal n_burst_count : std_logic_vector(7 downto 0);
    signal a0 : std_logic_vector(a_width - 1 downto 0) := (others => '-');
    signal n_a0 : std_logic_vector(a_width - 1 downto 0);
    signal a0f : std_logic_vector(a_width - 1 downto 0) := (others => '-');
    signal n_a0f : std_logic_vector(a_width - 1 downto 0);
    signal ce0 : std_logic := '0';
    signal n_ce0 : std_logic;
    signal we0 : std_logic := '0';
    signal n_we0 : std_logic;

begin

    assert burst_order >= 1 and burst_order <= 4
        report "invalid generic burst_order in ddrzbt_port"
        severity failure;

    gen_state : process(k)
    begin
        if k'event and k = '1' then
            state <= n_state;
            a0 <= n_a0;
            a0f <= n_a0f;
            burst_count <= n_burst_count;
            ce0 <= n_ce0;
            we0 <= n_we0;
        end if;
    end process;

    gen_n_state : process(
        state,
        a,
        ld_l,
        w_l,
        burst_count,
        a0,
        a0f)
    begin
        case state is
            when s_idle =>
                if ld_l = '0' then
                    if burst_order > 1 then
                        if w_l = '0' then
                            n_state <= s_burst_write;
                        else
                            n_state <= s_burst_read;
                        end if;
                    else
                        n_state <= s_idle;
                    end if;
                    n_a0 <= a;
                    n_a0f(a'high downto burst_order) <= a(a'high downto burst_order);
                    n_a0f(burst_order - 1 downto 0) <= a(burst_order - 1 downto 0) + 1;
                    n_burst_count <= X"01";
                    n_ce0 <= '1';
                    n_we0 <= not w_l;
                else
                    n_state <= s_idle;
                    n_a0 <= (others => '-');
                    n_a0f <= (others => '-');
                    n_burst_count <= X"00";
                    n_ce0 <= '0';
                    n_we0 <= '0';
                end if;

            when s_burst_read =>
                if burst_count = burst_limit then
                    n_state <= s_idle;
                    n_burst_count <= X"00";
                    n_ce0 <= '1';
                    n_we0 <= '0';
                else
                    n_state <= s_burst_read;
                    n_burst_count <= burst_count + 1;
                    n_ce0 <= '1';
                    n_we0 <= '0';
                end if;
                n_a0(a'high downto burst_order) <= a0(a'high downto burst_order);
                n_a0(burst_order - 1 downto 0) <= a0(burst_order - 1 downto 0) + 2;
                n_a0f(a'high downto burst_order) <= a0f(a'high downto burst_order);
                n_a0f(burst_order - 1 downto 0) <= a0f(burst_order - 1 downto 0) + 2;

            when s_burst_write =>
                if burst_count = burst_limit then
                    n_state <= s_idle;
                    n_burst_count <= X"00";
                    n_ce0 <= '1';
                    n_we0 <= '1';
                else
                    n_state <= s_burst_write;
                    n_burst_count <= burst_count + 1;
                    n_ce0 <= '1';
                    n_we0 <= '1';
                end if;
                n_a0(a'high downto burst_order) <= a0(a'high downto burst_order);
                n_a0(burst_order - 1 downto 0) <= a0(burst_order - 1 downto 0) + 2;
                n_a0f(a'high downto burst_order) <= a0f(a'high downto burst_order);
                n_a0f(burst_order - 1 downto 0) <= a0f(burst_order - 1 downto 0) + 2;
        end case;
    end process;

    delayed_sigs_r : process(k)
    begin
        if k'event and k = '1' then
            a1 <= a0;
            a2 <= a1;
            a1f <= a0f;
            ce1 <= ce0;
            ce2 <= ce1;
            we1 <= we0;
            we2 <= we1;
        end if;
    end process;

    delayed_sigs_f : process(k_l)
    begin
        if k_l'event and k_l = '1' then
            a2f <= a1f;
        end if;
    end process;

    gen_dq_oe : process(c_l)
    begin
        if c_l'event then
            if c_l = '1' then
                if ce1 = '1' and we1 = '0' then
                    dq_oe <= '1';
                else
                    dq_oe <= '0';
                end if;
            end if;
        end if;
    end process;

    gen_dq_out0 : process(c)
        variable index : natural;
        variable byte : natural;
    begin
        if c'event then
            if c = '1' then
                index := CONV_INTEGER("0" & a2f);
                for i in 0 to byte_width - 1 loop
                    byte := memory(byte_width * index + i);
                    dq_out0(8 * (i + 1) - 1 downto 8 * i) <= CONV_STD_LOGIC_VECTOR(byte, 8);
                end loop;
            else
                dq_out0 <= (others => '0');
            end if;
        end if;
    end process;

    gen_dq_out1 : process(c_l)
        variable index : natural;
        variable byte : natural;
    begin
        if c_l'event then
            if c_l = '1' then
                index := CONV_INTEGER("0" & a1);
                for i in 0 to byte_width - 1 loop
                    byte := memory(byte_width * index + i);
                    dq_out1(8 * (i + 1) - 1 downto 8 * i) <= CONV_STD_LOGIC_VECTOR(byte, 8);
                end loop;
            else
                dq_out1 <= (others => '0');
            end if;
        end if;
    end process;

    dq_out <= dq_out0 or dq_out1;

    cq <= transport c after t_trace;
    cq_l <= transport c_l after t_trace;

    gen_dq : process(
        dq_oe, 
        dq_out)
    begin
        if dq_oe = '1' then
            dq <= transport dq_out after t_trace;
        else
            dq <= transport (others => 'Z') after t_trace;
        end if;
    end process;

    store_data_rising : process(k)
        variable index : natural;
        variable byte : natural;
    begin
        if k'event and k = '1' then
            index := CONV_INTEGER("0" & a0);
            if ce0 = '1' and we0 = '1' then
                for i in 0 to byte_width - 1 loop
                    if bwe_l(i) = '0' then
                        byte := CONV_INTEGER("0" & dq(8 * (i + 1) - 1 downto 8 * i));
                        memory(byte_width * index + i) := byte;
                    end if;
                end loop;
            end if;
        end if;
    end process;

    store_data_falling : process(k_l)
        variable index : natural;
        variable byte : natural;
    begin
        if k_l'event and k_l = '1' then
            index := CONV_INTEGER("0" & a1f);
            if ce1 = '1' and we1 = '1' then
                for i in 0 to byte_width - 1 loop
                    if bwe_l(i) = '0' then
                        byte := CONV_INTEGER("0" & dq(8 * (i + 1) - 1 downto 8 * i));
                        memory(byte_width * index + i) := byte;
                    end if;
                end loop;
            end if;
        end if;
    end process;

end behav;
