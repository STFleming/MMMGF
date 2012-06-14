--
-- zbtsram_port.vhd - ZBT SRAM interface
--
-- SYNTHESIZABLE
--
-- The following inputs control the mode of this memory interface. Except where
-- noted, they do not have to be driven by constant values:
--
--   pipeline      0 => For flowthrough ZBT SRAM device
--                 1 => For pipelined ZBT SRAM device
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
use work.memif_int.all;

entity zbtsram_port is
    generic(
        pinout          : in    zbtsram_pinout_t;
        ra_width        : in    natural;
        rd_width        : in    natural;
        rc_width        : in    natural;
        a_width         : in    natural;
        d_width         : in    natural;
        tag_width       : in    natural);
    port(
        -- To/from clocking infrastructure
        clk0            : in    std_logic;                                   -- Clock
        rst             : in    std_logic;                                   -- Aynchronous reset
        -- To/from application
        sr              : in    std_logic;                                   -- Synchronous reset
        ce              : in    std_logic;                                   -- Command enable, qualified by 'ready'
        tag             : in    std_logic_vector(tag_width - 1 downto 0);    -- Tag, qualified by 'ce and not w')
        w               : in    std_logic;                                   -- 1 => write, qualified by 'ce')
        a               : in    std_logic_vector(a_width - 1 downto 0);      -- Address, qualified by 'ce'
        d               : in    std_logic_vector(d_width - 1 downto 0);      -- Write data, qualified by 'ce and w'
        be              : in    std_logic_vector(d_width / 8 - 1 downto 0);  -- Write byte enables, qualified by 'ce and w'
        q               : out   std_logic_vector(d_width - 1 downto 0);      -- Read data, qualified by 'valid'
        qtag            : out   std_logic_vector(tag_width - 1 downto 0);    -- Read tag, qualified by 'valid'
        valid           : out   std_logic;                                   -- 1 => 'q' and 'qtag' are valid
        ready           : out   std_logic;                                   -- When low, indicates that 'ce' is ignored
        -- Sideband control signals, must be stable during operation
        pipeline        : in    std_logic;                                   -- 1 => operate in pipelined mode
        trained         : out   std_logic;                                   -- 1 => training was successful
        -- To/from memories
        ra              : out   std_logic_vector(ra_width - 1 downto 0);
        rc              : inout std_logic_vector(rc_width - 1 downto 0);
        rd              : inout std_logic_vector(rd_width - 1 downto 0));
end entity;

architecture mixed of zbtsram_port is

    component OBUF
        port(
            I  : in    std_logic;
            O  : out   std_logic);
    end component;

    component IOBUF
        port(
            I  : in    std_logic;
            IO : inout std_logic;
            O  : out   std_logic;
            T  : in    std_logic);
    end component;

    constant be_width : natural := rd_width / 8;

    signal ce_q0 : std_logic;
    signal ce_q1 : std_logic;
    signal ce_q2 : std_logic;
    signal w_q0 : std_logic;
    signal w_q1 : std_logic;
    signal w_q2 : std_logic;
    signal tag_q0 : std_logic_vector(tag_width - 1 downto 0);
    signal a_q0 : std_logic_vector(ra_width - 1 downto 0);
    signal d_q0 : std_logic_vector(rd_width - 1 downto 0);
    signal d_q1 : std_logic_vector(rd_width - 1 downto 0);
    signal d_q2 : std_logic_vector(rd_width - 1 downto 0);
    signal be_q0 : std_logic_vector(be_width - 1 downto 0);

    type tag_pipe_t is array(0 to 2) of std_logic_vector(tag_width - 1 downto 0);
    signal tag_pipe : tag_pipe_t;
    signal valid_pipe : std_logic_vector(2 downto 0);

    signal i_q : std_logic_vector(rd_width - 1 downto 0);
    signal i_valid : std_logic;
    signal i_qtag : std_logic_vector(tag_width - 1 downto 0);

    signal ra_t : std_logic_vector(ra_width - 1 downto 0);
    signal ra_o : std_logic_vector(ra_width - 1 downto 0);
    signal rc_t : std_logic_vector(rc_width - 1 downto 0);
    signal rc_o : std_logic_vector(rc_width - 1 downto 0);
    signal rc_i : std_logic_vector(rc_width - 1 downto 0);
    signal rd_t : std_logic_vector(rd_width - 1 downto 0);
    signal rd_o : std_logic_vector(rd_width - 1 downto 0);
    signal rd_i : std_logic_vector(rd_width - 1 downto 0);

    --
    -- XST synthesis constraints, required to prevent optimization of
    -- flip-flops that would otherwise prevent IOB packing.
    --
    attribute equivalent_register_removal : string;
    attribute equivalent_register_removal of ra_o : signal is "no";
    attribute equivalent_register_removal of rc_o : signal is "no";
    attribute equivalent_register_removal of rd_o : signal is "no";
    attribute equivalent_register_removal of rd_i : signal is "no";
    attribute equivalent_register_removal of rd_t : signal is "no";
    attribute equivalent_register_removal of ready : signal is "no";
    attribute equivalent_register_removal of trained : signal is "no";
    attribute iob : string;
    attribute iob of rd_t : signal is "true";

begin

    --
    -- The SSRAM address and control busses are always enabled onto the FPGA pins
    --

    ra_t <= (others => '0');
    rc_t <= (others => '0');

    gen_ra : for i in 0 to ra_width - 1 generate
        U0 : OBUF
            port map(
                I => ra_o(i),
                O => ra(i));
    end generate;

    gen_rc : for i in 0 to rc_width - 1 generate
        U0 : IOBUF
            port map(
                I => rc_o(i),
                IO => rc(i),
                O => rc_i(i),
                T => rc_t(i));
    end generate;

    gen_rd : for i in 0 to rd_width - 1 generate
        U0 : IOBUF
            port map(
                I => rd_o(i),
                IO => rd(i),
                O => rd_i(i),
                T => rd_t(i));
    end generate;

    --
    -- Generate interface outputs
    --

    q <= EXT(i_q, d_width); -- Truncate/zero extend SSRAM data if necessary
    qtag <= i_qtag;
    valid <= i_valid;

    --
    -- Register all synchronous inputs (except 'sr')
    --

    reg_inputs : process(rst, clk0)
    begin
        if rst = '1' then
            ce_q0 <= '0';
            ce_q1 <= '0';
            ce_q2 <= '0';
            a_q0 <= (others => '-');
            tag_q0 <= (others => '-');
            w_q0 <= '-';
            w_q1 <= '-';
            w_q2 <= '-';
            be_q0 <= (others => '-');
            d_q0 <= (others => '-');
            d_q1 <= (others => '-');
            d_q2 <= (others => '-');
            ready <= '0';
            trained <= '0';
        elsif clk0'event and clk0 = '1' then
            if sr = '1' then
                ce_q0 <= '0';
                ce_q1 <= '0';
                ce_q2 <= '0';
                ready <= '0';
                trained <= '0';
            else
                ce_q0 <= ce;
                ce_q1 <= ce_q0;
                ce_q2 <= ce_q1;
                ready <= '1'; -- Always ready when not reset
                trained <= '1'; -- Always trained when not reset
            end if;
            a_q0 <= EXT(a, ra_width);
            tag_q0 <= tag;
            w_q0 <= w;
            w_q1 <= w_q0;
            w_q2 <= w_q1;
            be_q0 <= EXT(be, be_width); -- truncate/zero extend if necessary
            d_q0 <= EXT(d, rd_width); -- truncate/zero extend if necessary
            d_q1 <= d_q0;
            d_q2 <= d_q1;
        end if;
    end process;

    --
    -- Generate 'valid' signal.
    --

    gen_valid : process(rst, clk0)
    begin
        if rst = '1' then
            valid_pipe <= (others => '0');
            i_valid <= '0';
        elsif clk0'event and clk0 = '1' then
            valid_pipe(0) <= ce_q0 and not w_q0;
            valid_pipe(valid_pipe'high downto 1) <= valid_pipe(valid_pipe'high - 1 downto 0);

            if sr = '1' then
                i_valid <= '0';
            else
                if pipeline = '1' then
                    i_valid <= valid_pipe(2);
                else
                    i_valid <= valid_pipe(1);
                end if;
            end if;
        end if;
    end process;

    --
    -- Generate 'qtag' signal
    --

    gen_qtag : process(clk0)
    begin
        if clk0'event and clk0 = '1' then
            tag_pipe(0) <= tag_q0;
            tag_pipe(1 to tag_pipe'high) <= tag_pipe(0 to tag_pipe'high - 1);

            if pipeline = '1' then
                i_qtag <= tag_pipe(2);
            else
                i_qtag <= tag_pipe(1);
            end if;
        end if;
    end process;

    --
    -- Generate SRAM address, 'ra_o'
    --

    gen_ra_o : process(rst, clk0)
    begin
        if clk0'event and clk0 = '1' then
            ra_o <= a_q0;
        end if;
    end process;

    --
    -- Generate 'rd_t', tristate control signals for data IOBs
    --

    gen_rd_t : process(rst, clk0)
    begin
        if rst = '1' then
            rd_t <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            if pipeline = '1' then
                rd_t <= (others => not (ce_q2 and w_q2));
            else
                rd_t <= (others => not (ce_q1 and w_q1));
            end if;
        end if;
    end process;

    --
    -- Generate 'rd_o', data to SRAM
    --

    gen_rd_o : process(rst, clk0)
    begin
        if rst = '1' then
            rd_o <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            if pipeline = '1' then
                rd_o <= d_q2;
            else
                rd_o <= d_q1;
            end if;
        end if;
    end process;

    --
    -- Capture data 'rd_i' into 'i_q' on the rising edge of the memory clock.
    --

    capture_rd_i : process(rst, clk0)
    begin
        if rst = '1' then
            i_q <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            i_q <= rd_i;
        end if;
    end process;

    --
    -- Generate ZBT SRAM control, 'rc_o'
    --

    gen_rc_o : process(clk0, rst)
        variable index : natural;
    begin
        if rst = '1' then
            rc_o <= (others => '1');
        elsif clk0'event and clk0 = '1' then
            -- BWE#
            index := 0;
            if ce_q0 = '1' and w_q0 = '1'then
                rc_o(index + be_width - 1 downto index) <= not be_q0;
            else
                rc_o(index + be_width - 1 downto index) <= (others => '1');
            end if;
            index := index + be_width;

            -- WE#
            rc_o(index) <= not (ce_q0 and w_q0);
            index := index + 1;

            -- CE#
            rc_o(index) <= not ce_q0;
            index := index + 1;

            -- CE2# (if present, always asserted)
            if pinout.has_ce2_l then
                rc_o(index) <= '0';
                index := index + 1;
            end if;

            -- CE2 (if present, always asserted)
            if pinout.has_ce2 then
                rc_o(index) <= '1';
                index := index + 1;
            end if;

            -- ADV/LD#
            rc_o(index) <= '0';
            index := index + 1;

            -- OE# (can be held asserted because a ZBT device does not enable
            -- its DQ drivers unless a read command was registered).
            rc_o(index) <= '0';
            index := index + 1;

            -- CKE# (if present)
            if pinout.has_cke_l then
                rc_o(index) <= '0';
                index := index + 1;
            end if;
        end if;
    end process;

end mixed;
