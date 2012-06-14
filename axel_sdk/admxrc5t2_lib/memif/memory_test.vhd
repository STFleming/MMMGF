--
-- memory_test.vhd - module to perform a test of a bank of memory
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;

entity memory_test is
    generic(
        a_width       : in    natural;                       -- Number of (logical) address bits in memory port
        d_width       : in    natural;                       -- Number of logical bits in a memory port word
        tag_width     : in    natural;                       -- Number of tag bits
        rd_width      : in    natural);                      -- Number of physical data pins on memory bank
    port(
        rst           : in    std_logic;                     -- Sync or async. reset
        clk           : in    std_logic;                     -- Clock
        -- Control interface
        go            : in    std_logic;                     -- Pulse high for at least one cycle to initiate test
        offset        : in    std_logic_vector(31 downto 0); -- Starting word address of test
        length        : in    std_logic_vector(31 downto 0); -- Number of words to test, minus 1
        done          : out   std_logic;                     -- High indicates finished or idle
        error         : out   std_logic;                     -- Qualified by 'done', high indicates at least one error ocurred
        eaddr         : out   std_logic_vector(31 downto 0); -- Qualified by 'done and error', gives word address of first error
        ephase        : out   std_logic_vector(7 downto 0);  -- Qualified by 'done and error', gives phase in which first error occurred
        -- To/from memory bank
        valid         : in    std_logic;
        q             : in    std_logic_vector(d_width - 1 downto 0);
        qtag          : in    std_logic_vector(tag_width - 1 downto 0);
        ready         : in    std_logic;
        req           : out   std_logic;
        ce            : out   std_logic;
        w             : out   std_logic;
        a             : out   std_logic_vector(a_width - 1 downto 0);
        tag           : out   std_logic_vector(tag_width - 1 downto 0);
        d             : out   std_logic_vector(d_width - 1 downto 0);
        be            : out   std_logic_vector(d_width / 8 - 1 downto 0));
end entity;

architecture rtl of memory_test is

    -- LFSR with polynomial x^64 + x^4 + x^3 + 1
    function lfsr64(
        x : in std_logic_vector(63 downto 0))
    return std_logic_vector is
        variable y : std_logic_vector(63 downto 0);
    begin
        y(0) := x(63) xor x(3) xor x(2);
        y(63 downto 1) := x(62 downto 0);
        return y;
    end;

    -- Number of physical data words that make up a logical data word
    constant num_physical_word : natural := d_width / rd_width;

    -- Number of 32-bit words that make up a logical data word
    constant num_32bit_word : natural := d_width / 32;

    constant phase_idle : std_logic_vector(2 downto 0) := "---";
    constant phase_55 : std_logic_vector(2 downto 0) := "000";
    constant phase_aa : std_logic_vector(2 downto 0) := "001";
    constant phase_55_aa : std_logic_vector(2 downto 0) := "010";
    constant phase_addr : std_logic_vector(2 downto 0) := "011";
    constant phase_rev_addr : std_logic_vector(2 downto 0) := "100";
    constant phase_random : std_logic_vector(2 downto 0) := "101";
    constant final_phase : std_logic_vector(2 downto 0) := phase_random;

    type lfsreg_vector_t is array(0 to num_32bit_word - 1) of std_logic_vector(63 downto 0);
    signal lfsreg : lfsreg_vector_t;

    type state1_t is (s1_idle, s1_doing);
    signal state1, n_state1 : state1_t;
    signal i_done, n_done : std_logic;
    signal phase, n_phase : std_logic_vector(2 downto 0);
    signal do_phase, n_do_phase : std_logic;

    type state2_t is (s2_idle, s2_writing, s2_reading, s2_draining);
    signal state2, n_state2 : state2_t;
    signal done_phase, n_done_phase : std_logic;
    signal init_addr, n_init_addr : std_logic;
    signal enable, n_enable : std_logic;
    signal writing, n_writing : std_logic;

    signal increment : std_logic;
    signal address : std_logic_vector(a_width - 1 downto 0);
    signal remaining : std_logic_vector(31 downto 0);

    signal valid_tag : std_logic;
    signal final : std_logic;
    signal valid_count : std_logic_vector(31 downto 0);
    signal final_valid : std_logic;

    signal phase_1h : std_logic_vector(7 downto 0);
    signal next_data : std_logic;
    signal data_55 : std_logic_vector(d_width - 1 downto 0);
    signal data_aa : std_logic_vector(d_width - 1 downto 0);
    signal data_55_aa : std_logic_vector(d_width - 1 downto 0);
    signal data_addr : std_logic_vector(d_width - 1 downto 0);
    signal data_rev_addr : std_logic_vector(d_width - 1 downto 0);
    signal data_random : std_logic_vector(d_width - 1 downto 0);
    signal i_d : std_logic_vector(d_width - 1 downto 0);

    signal qq : std_logic_vector(d_width - 1 downto 0);
    signal valid_tag_q : std_logic;
    signal ok : std_logic;
    signal ok_valid : std_logic;
    signal error_detected : std_logic;
    signal check_addr : std_logic_vector(31 downto 0);
    signal i_error : std_logic;

begin

    -- synopsys translate_off
    assert d_width mod rd_width = 0 report "memory_test : d_width not an integer multiple of rd_width" severity failure;
    -- synopsys translate_on

    -- synopsys translate_off
    assert d_width mod 8 = 0 report "memory_test : d_width not an integer multiple of 8" severity failure;
    -- synopsys translate_on

    -- synopsys translate_off
    assert d_width >= 32 report "memory_test : d_width less than 32" severity failure;
    -- synopsys translate_on

    -- synopsys translate_off
    assert d_width mod 32 = 0 report "memory_test : d_width not an integer multiple of 32" severity failure;
    -- synopsys translate_on

    -- Output internal versions of 'done' and 'error'
    done <= i_done;
    error <= i_error;

    -- Output internal version of 'd'
    d <= i_d;

    -- We recognise our own data by checking that the top tag bit is '1'
    tag(tag_width - 1) <= '1';
    tag(tag_width - 2 downto 0) <= (others => '0');

    -- Use all byte enables (future enhancement - we could test that byte enables
    -- really work for masking writes)
    be <= (others => '1');

    -- Request access to memory if we are not idle
    req <= not i_done;

    --
    -- Executive state machine
    --

    gen_state1 : process(rst, clk)
    begin
        if rst = '1' then
            state1 <= s1_idle;
            i_done <= '1';
            phase <= (others => '-');
            do_phase <= '0';
        elsif clk'event and clk = '1' then
            state1 <= n_state1;
            i_done <= n_done;
            phase <= n_phase;
            do_phase <= n_do_phase;
        end if;
    end process;

    gen_n_state1 : process(
        state1,
        go,
        phase,
        done_phase)
    begin
        case state1 is
            when s1_idle =>
                if go = '1' then
                    n_state1 <= s1_doing;
                    n_done <= '0';
                    n_phase <= phase_55;
                    n_do_phase <= '1';
                else
                    n_state1 <= s1_idle;
                    n_done <= '1';
                    n_phase <= phase_idle;
                    n_do_phase <= '0';
                end if;

            when s1_doing =>
                if done_phase = '1' then
                    if phase = final_phase then
                        n_state1 <= s1_idle;
                        n_done <= '0';
                        n_phase <= phase_idle;
                        n_do_phase <= '0';
                    else
                        n_state1 <= s1_doing;
                        n_done <= '0';
                        n_phase <= phase + 1;
                        n_do_phase <= '1';
                    end if;
                else
                    n_state1 <= s1_doing;
                    n_done <= '0';
                    n_phase <= phase;
                    n_do_phase <= '0';
                end if;
        end case;        
    end process;

    --
    -- Address and remaining counters are reset at the beginning of each test phase
    --

    increment <= enable and ready;

    gen_address : process(clk)
    begin
        if clk'event and clk = '1' then
            if init_addr = '1' then
                address <= offset;
                remaining <= length;
                final <= not OR_reduce(length);
            else
                if increment = '1' then
                    address <= address + 1;
                    remaining <= remaining - 1;
                    final <= not OR_reduce(remaining(31 downto 1));
                end if;
            end if;
        end if;
    end process;

    --
    -- Count number of valid pulses received
    --

    -- We recognise our own data by checking that the top tag bit is '1'
    valid_tag <= '1' when valid = '1' and qtag(tag_width - 1) = '1' else
                 '0';

    count_valid : process(clk)
    begin
        if clk'event and clk = '1' then
            if init_addr = '1' then
                valid_count <= length;
                final_valid <= not OR_reduce(length);
            else
                if ok_valid = '1' then
                    valid_count <= valid_count - 1;
                    final_valid <= not OR_reduce(valid_count(31 downto 1));
                end if;
            end if;
        end if;
    end process;

    --
    -- Test phase state machine
    --

    gen_state2 : process(rst, clk)
    begin
        if rst = '1' then
            state2 <= s2_idle;
            done_phase <= '0';
            init_addr <= '0';
            enable <= '0';
            writing <= '0';
        elsif clk'event and clk = '1' then
            state2 <= n_state2;
            done_phase <= n_done_phase;
            init_addr <= n_init_addr;
            enable <= n_enable;
            writing <= n_writing;
        end if;
    end process;

    gen_n_state2 : process(
        state2,
        do_phase,
        final,
        increment,
        ok_valid,
        final_valid)
    begin
        case state2 is
            when s2_idle =>
                if do_phase = '1' then
                    n_state2 <= s2_writing;
                    n_done_phase <= '0';
                    n_init_addr <= '1';
                    n_enable <= '0';
                    n_writing <= '1';
                else
                    n_state2 <= s2_idle;
                    n_done_phase <= '0';
                    n_enable <= '0';
                    n_init_addr <= '0';
                    n_writing <= '0';
                end if;

            when s2_writing =>
                if increment = '1' and final = '1' then
                    n_state2 <= s2_reading;
                    n_done_phase <= '0';
                    n_init_addr <= '1';
                    n_enable <= '0';
                    n_writing <= '0';
                else
                    n_state2 <= s2_writing;
                    n_done_phase <= '0';
                    n_enable <= '1';
                    n_init_addr <= '0';
                    n_writing <= '1';
                end if;

            when s2_reading =>
                if increment = '1' and final = '1' then
                    n_state2 <= s2_draining;
                    n_done_phase <= '0';
                    n_init_addr <= '0';
                    n_enable <= '0';
                    n_writing <= '0';
                else
                    n_state2 <= s2_reading;
                    n_done_phase <= '0';
                    n_enable <= '1';
                    n_init_addr <= '0';
                    n_writing <= '0';
                end if;

            when s2_draining =>
                if ok_valid = '1' and final_valid = '1' then
                    n_state2 <= s2_idle;
                    n_done_phase <= '1';
                    n_enable <= '0';
                    n_init_addr <= '0';
                    n_writing <= '0';
                else
                    n_state2 <= s2_draining;
                    n_done_phase <= '0';
                    n_enable <= '0';
                    n_init_addr <= '0';
                    n_writing <= '0';
                end if;
        end case;        
    end process;


    --
    -- Data generation
    --

    gen_phase_1h : process(clk)
    begin
        if clk'event and clk = '1' then
            for i in phase_1h'range loop
               if phase = i then
                   phase_1h(i) <= '1';
               else
                   phase_1h(i) <= '0';
               end if;
            end loop;
        end if;
    end process;

    next_data <= (writing and ready) or valid_tag;

    -- Constant 0x55 pattern
    gen_data_55 : for i in 0 to d_width / 8 - 1 generate
        data_55(8 * i + 7 downto 8 * i) <= X"55";
    end generate;

    -- Constant 0xAA pattern
    gen_data_aa : for i in 0 to d_width / 8 - 1 generate
        data_aa(8 * i + 7 downto 8 * i) <= X"aa";
    end generate;

    -- Alternating 0x55/0xAA pattern
    gen_not_ddr : if num_physical_word = 1 generate
        -- This memory type must be non-DDR, so we need to alternate between
        -- between 55 and aa on successive writes in order to force all data bits
        -- to transition on every clock cycle.
        gen_data_55_aa : process(clk)
        begin
            if clk'event and clk = '1' then
                if init_addr = '1' then
                    data_55_aa <= data_55;
                else
                    if next_data = '1' and phase_1h(2) = '1' then
                        data_55_aa <= not data_55_aa;
                    end if;
                end if;
            end if;
        end process;
    end generate;

    gen_ddr : if num_physical_word /= 1 generate
        -- This memory type must be some kind of DDR, so we need to alternate
        -- between 55 and aa within a logical memory word in order to force all
        -- data bits to transition on every clock cycle.
        gen_data_55_aa : for i in 0 to d_width - 1 generate
            data_55_aa(i) <= data_55(i) when ((i / rd_width) mod 2) = 0 else data_aa(i);
        end generate;
    end generate;

    -- Own address
    gen_data_addr : process(clk)
    begin
        if clk'event and clk = '1' then
            if init_addr = '1' then
                for i in 0 to num_32bit_word - 1 loop
                    data_addr(32 * (i + 1) - 1 downto 32 * i) <= conv_std_logic_vector(i, 32);
                end loop;
            else
                if next_data = '1' and OR_reduce(phase_1h(4 downto 3)) = '1' then
                    for i in 0 to num_32bit_word - 1 loop
                        data_addr(32 * (i + 1) - 1 downto 32 * i) <=
                            data_addr(32 * (i + 1) - 1 downto 32 * i) + num_32bit_word;
                    end loop;
                end if;
            end if;
        end if;
    end process;

    -- Bit-reversed own address
    gen_data_rev_addr : process(
        data_addr)
        variable j : natural;
    begin
        for i in 0 to num_32bit_word - 1 loop
            for j in 0 to 31 loop
                data_rev_addr(32 * i + j) <= data_addr(32 * i + 31 - j);
            end loop;
        end loop;
    end process;

    -- Random data using 64-bit LFSR
    gen_lfsreg : process(clk)
    begin
        if clk'event and clk = '1' then
            if init_addr = '1' then 
                for i in 0 to num_32bit_word - 1 loop
                    lfsreg(i) <= conv_std_logic_vector(i + 1, 64);
                end loop;
            else
                if next_data = '1' and phase_1h(5) = '1' then
                    for i in 0 to num_32bit_word - 1 loop
                        lfsreg(i) <= lfsr64(lfsreg(i));
                    end loop;
                end if;
            end if;
        end if;
    end process;

    gen_data_random : for i in 0 to num_32bit_word - 1 generate
        data_random(32 * (i + 1) - 1 downto 32 * i) <= lfsreg(i)(31 downto 0);
    end generate;

    -- Select type of test pattern according to which test phase we are in
    gen_data : process(clk)
    begin
        if clk'event and clk = '1' then
            if next_data = '1' then
                case phase is
                    when phase_55 =>
                        i_d <= data_55;
                    when phase_aa =>
                        i_d <= data_aa;
                    when phase_55_aa =>
                        i_d <= data_55_aa;
                    when phase_addr =>
                        i_d <= data_addr;
                    when phase_rev_addr =>
                        i_d <= data_rev_addr;
                    when phase_random =>
                        i_d <= data_random;
                    when others =>
                        i_d <= (others => '-');
                end case;
            end if;
        end if;
    end process;

    --
    -- Data verification
    --

    error_detected <= ok_valid and not ok;

    check_q : process(clk)
    begin
        if clk'event and clk = '1' then
            if valid = '1' then
                qq <= q;
            end if;

            valid_tag_q <= valid_tag;

            if valid_tag_q = '1' then
                ok <= AND_reduce(i_d xnor qq);
            end if;

            ok_valid <= valid_tag_q;

            if init_addr = '1' then
                check_addr <= offset;
            else
                if ok_valid = '1' then
                    check_addr <= check_addr + 1;
                end if;
            end if;

            if i_done = '0' and i_error = '0' and error_detected = '1' then
                eaddr <= check_addr;
                ephase <= EXT(phase, 8);
            end if;
        end if;
    end process;

    gen_error : process(rst, clk)
    begin
        if rst = '1' then
            i_error <= '0';
        elsif clk'event and clk = '1' then
            if i_done = '1' then
                if go = '1' then
                    i_error <= '0';
                end if;
            else
                i_error <= i_error or error_detected;
            end if;
        end if;
    end process;

    --
    -- Outputs to memory port
    --

    gen_ce : process(rst, clk)
    begin
        if rst = '1' then
            ce <= '0';
        elsif clk'event and clk = '1' then
            ce <= increment;
        end if;
    end process;

    gen_others : process(clk)
    begin
        if clk'event and clk = '1' then
            if increment = '1' then
                a <= address;
                w <= writing;
            end if;
        end if;
    end process;

end architecture;
