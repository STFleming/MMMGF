--
-- ddrsdram_trace_model.vhd - Simple model of PCB traces connecting a DDR SDRAM
--                            device to the controller.
--
-- NOT SYNTHESIZABLE
--
-- VHDL lacks any construct for simulating a bidirectional delay line.
-- Therefore, we have to monitor what is happening on the SDRAM control
-- signals such as RAS# and CAS# and generate output enables for each
-- end of the line.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

entity ddrsdram_trace_model is
    generic(
        max_bank_width  : in    natural;
        max_addr_width  : in    natural;
        dq_width        : in    natural;
        registered      : in    boolean;
        t_trace_k       : in    time;
        t_trace_ctl     : in    time;
        t_trace_dm      : in    time;
        t_trace_dq      : in    time;
        t_trace_dqs     : in    time);
    port(
        -- Memory controller side
        mk              : in    std_logic;
        mk_l            : in    std_logic;
        mcke            : in    std_logic;
        mwe_l           : in    std_logic;
        mcas_l          : in    std_logic;
        mras_l          : in    std_logic;
        mcs_l           : in    std_logic;
        mba             : in    std_logic_vector(max_bank_width - 1 downto 0);
        ma              : in    std_logic_vector(max_addr_width - 1 downto 0);
        mdq             : inout std_logic_vector(dq_width - 1 downto 0);
        mdm             : in    std_logic_vector(dq_width / 8 - 1 downto 0);
        mdqs            : inout std_logic_vector(dq_width / 8 - 1 downto 0);
        -- Device side
        dk              : out   std_logic;
        dk_l            : out   std_logic;
        dcke            : out   std_logic;
        dwe_l           : out   std_logic;
        dcas_l          : out   std_logic;
        dras_l          : out   std_logic;
        dcs_l           : out   std_logic;
        dba             : out   std_logic_vector(max_bank_width - 1 downto 0);
        da              : out   std_logic_vector(max_addr_width - 1 downto 0);
        ddq             : inout std_logic_vector(dq_width - 1 downto 0);
        ddm             : out   std_logic_vector(dq_width / 8 - 1 downto 0);
        ddqs            : inout std_logic_vector(dq_width / 8 - 1 downto 0));
end entity;

architecture behav of ddrsdram_trace_model is

    signal oe_to_dimm0 : std_logic := '0';
    signal oe_to_dimm1 : std_logic := '0';
    signal oe_to_dimm2 : std_logic := '0';
    signal oe_to_dimm : std_logic := '0';
    signal oe_from_dimm0 : std_logic := '0';
    signal oe_from_dimm1 : std_logic := '0';
    signal oe_from_dimm2 : std_logic := '0';
    signal oe_from_dimm3 : std_logic := '0';
    signal oe_from_dimm : std_logic := '0';

    signal dq_oe_to_dimm : std_logic := '0';
    signal dq_oe_from_dimm : std_logic := '0';
    signal dqs_oe_to_dimm : std_logic := '0';
    signal dqs_oe_from_dimm : std_logic := '0';

begin

    to_dimm : process(mk)
    begin
        if mk'event and mk = '1' then
            oe_to_dimm0 <= not mcs_l and not mwe_l and mras_l and not mcas_l and mcke;
            oe_to_dimm1 <= oe_to_dimm0;
            oe_to_dimm2 <= oe_to_dimm1;
            oe_to_dimm <= oe_to_dimm0 or oe_to_dimm1;
        end if;
    end process;

    from_dimm : process(mk)
    begin
        if mk'event and mk = '0' then
            oe_from_dimm0 <= not mcs_l and mwe_l and mras_l and not mcas_l and mcke;
            oe_from_dimm1 <= oe_from_dimm0;
            oe_from_dimm2 <= oe_from_dimm1;
            oe_from_dimm3 <= oe_from_dimm2;
            if registered then
                oe_from_dimm <= oe_from_dimm2 or oe_from_dimm3;
            else
                oe_from_dimm <= oe_from_dimm1 or oe_from_dimm2;
            end if;
        end if;
    end process;

    dq_oe_to_dimm <= oe_to_dimm;
    dq_oe_from_dimm <= transport oe_from_dimm after t_trace_dq;

    dqs_oe_to_dimm <= oe_to_dimm;
    dqs_oe_from_dimm <= transport oe_from_dimm after t_trace_dqs;

    dq_to_dimm : process(
        dq_oe_to_dimm,
        mdq)
    begin
        if dq_oe_to_dimm = '1' then
            ddq <= transport mdq after t_trace_dq;
        else
            ddq <= transport (others => 'Z') after t_trace_dq;
        end if;
    end process;

    dq_from_dimm : process(
        dq_oe_from_dimm,
        ddq)
    begin
        if dqs_oe_from_dimm = '1' then
            mdq <= transport ddq after t_trace_dq;
        else
            mdq <= transport (others => 'Z') after t_trace_dq;
        end if;
    end process;

    dqs_to_dimm : process(
        dqs_oe_to_dimm,
        mdqs)
    begin
        if dqs_oe_to_dimm = '1' then
            ddqs <= transport mdqs after t_trace_dqs;
        else
            ddqs <= transport (others => 'Z') after t_trace_dqs;
        end if;
    end process;

    dqs_from_dimm : process(
        dqs_oe_from_dimm,
        ddqs)
    begin
        if dqs_oe_from_dimm = '1' then
            mdqs <= transport ddqs after t_trace_dqs;
        else
            mdqs <= transport (others => 'Z') after t_trace_dqs;
        end if;
    end process;

    da <= transport ma after t_trace_ctl;
    dba <= transport mba after t_trace_ctl;
    dcs_l <= transport mcs_l after t_trace_ctl;
    dras_l <= transport mras_l after t_trace_ctl;
    dcas_l <= transport mcas_l after t_trace_ctl;
    dwe_l <= transport mwe_l after t_trace_ctl;
    dcke <= transport mcke after t_trace_ctl;
    ddm <= transport mdm after t_trace_dm;

    dk <= transport mk after t_trace_k;
    dk_l <= transport mk_l after t_trace_k;

end architecture;
