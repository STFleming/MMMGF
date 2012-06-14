--
-- ddr2sram_trace_model.vhd - Simple model of PCB traces connecting a DDR-II SRAM
--                            device to the controller.
--
-- NOT SYNTHESIZABLE
--
-- VHDL lacks any construct for simulating a bidirectional delay line.
-- Therefore, we have to monitor what is happening on the DDR-II SRAM control
-- signals such as LD# and W# and generate output enables accordingly for each
-- end of the line.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

entity ddr2sram_trace_model is
    generic(
        a_width         : in    natural;
        dq_width        : in    natural;
        t_trace_k       : in    time;   -- k, k_l
        t_trace_c       : in    time;   -- c, c_l
        t_trace_cq      : in    time;   -- cq, cq_l
        t_trace_a       : in    time;   -- a
        t_trace_ctl     : in    time;   -- ld_l, w_l, bwe_l
        t_trace_dq      : in    time);  -- dq
    port(
        -- Memory controller side
        mk              : in    std_logic;
        mk_l            : in    std_logic;
        mc              : in    std_logic;
        mc_l            : in    std_logic;
        mld_l           : in    std_logic;
        mw_l            : in    std_logic;
        mbwe_l          : in    std_logic_vector(dq_width / 8 - 1 downto 0);
        mdq             : inout std_logic_vector(dq_width - 1 downto 0);
        mcq             : out   std_logic;
        mcq_l           : out   std_logic;
        ma              : in    std_logic_vector(a_width - 1 downto 0);
        -- Device side
        dk              : out   std_logic;
        dk_l            : out   std_logic;
        dc              : out   std_logic;
        dc_l            : out   std_logic;
        dld_l           : out   std_logic;
        dw_l            : out   std_logic;
        dbwe_l          : out   std_logic_vector(dq_width / 8 - 1 downto 0);
        ddq             : inout std_logic_vector(dq_width - 1 downto 0);
        dcq             : in    std_logic;
        dcq_l           : in    std_logic;
        da              : out   std_logic_vector(a_width - 1 downto 0));
end entity;

architecture behav of ddr2sram_trace_model is

    signal period_ok : boolean := false;
    signal prev, curr : time := 0.0 ns;
    signal period : time := 0.0 ns;

    signal dq_delay : time := 0.0 ns;

    signal oe_to_device : std_logic := '0';

    signal oe_from_device0 : std_logic := '0';
    signal oe_from_device1 : std_logic := '0';
    signal oe_from_device : std_logic := '0';

begin

    find_period : process(mk)
    begin
        if mk'event and mk = '1' then
            prev <= curr;
            curr <= now;
            period <= curr - prev;
            period_ok <= true;
        end if;
    end process;

    dq_delay <= period * 0.75 when period_ok else 0.0 ns;

    to_device : process(mk)
    begin
        if mk'event and mk = '1' then
            oe_to_device <= transport not mld_l and not mw_l after dq_delay;
        end if;
    end process;

    dq_to_device : process(
        oe_to_device,
        mdq)
    begin
        if oe_to_device = '1' then
            ddq <= transport mdq after t_trace_dq;
        else
            ddq <= transport (others => 'Z') after t_trace_dq;
        end if;
    end process;

    from_device_k : process(mk)
    begin
        if mk'event and mk = '1' then
            oe_from_device0 <= not mld_l and mw_l;
            oe_from_device1 <= oe_from_device0;
        end if;
    end process;

    from_device_cq : process(dcq_l)
    begin
        if dcq_l'event and dcq_l = '1' then
            oe_from_device <= oe_from_device1;
        end if;
    end process;

    dq_from_device : process(
        oe_from_device,
        ddq)
    begin
        if oe_from_device = '1' then
            mdq <= transport ddq after t_trace_dq;
        else
            mdq <= transport (others => 'Z') after t_trace_dq;
        end if;
    end process;

    dld_l <= transport mld_l after t_trace_ctl;
    dw_l <= transport mw_l after t_trace_ctl;
    dbwe_l <= transport mbwe_l after t_trace_ctl;
    da <= transport ma after t_trace_a;

    dk <= transport mk after t_trace_k;
    dk_l <= transport mk_l after t_trace_k;

    dc <= transport mc after t_trace_c;
    dc_l <= transport mc_l after t_trace_c;

    mcq <= transport dcq after t_trace_cq;
    mcq_l <= transport dcq_l after t_trace_cq;

end architecture;
