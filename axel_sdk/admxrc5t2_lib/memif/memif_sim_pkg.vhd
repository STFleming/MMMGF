--
-- memif_sim_pkg.vhd - Package of memory interface simulation components
--
-- NOT SYNTHESIZABLE
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

-- synopsys translate_off
library std;
use std.textio.all;
-- synopsys translate_on

library work;
use work.memif.all;

package memif_sim is

    component bus_trace_model_bidir
        generic(
            delay           : in    time;
            width           : in    natural);
        port(
            drive_a         : in    std_logic;
            drive_b         : in    std_logic;
            a               : inout std_logic_vector(width - 1 downto 0);
            b               : inout std_logic_vector(width - 1 downto 0));
    end component;

    component bus_trace_model_unidir
        generic(
            delay           : in    time;
            width           : in    natural);
        port(
            a               : in    std_logic_vector(width - 1 downto 0);
            b               : out   std_logic_vector(width - 1 downto 0));
    end component;

    component ddr2sdram_trace_model
        generic(
            max_bank_width  : in    natural;
            max_addr_width  : in    natural;
            num_phys_bank   : in    natural;
            dq_width        : in    natural;
            k_width         : in    natural;
            cke_width       : in    natural;
            odt_width       : in    natural;
            registered      : in    boolean;
            t_trace_k       : in    time;
            t_trace_ctl     : in    time;
            t_trace_dm      : in    time;
            t_trace_dq      : in    time;
            t_trace_dqs     : in    time);
        port(
            -- Memory controller side
            mk              : in    std_logic_vector(k_width - 1 downto 0);
            mk_l            : in    std_logic_vector(k_width - 1 downto 0);
            mcke            : in    std_logic_vector(cke_width - 1 downto 0);
            modt            : in    std_logic_vector(odt_width - 1 downto 0);
            mwe_l           : in    std_logic;
            mcas_l          : in    std_logic;
            mras_l          : in    std_logic;
            mcs_l           : in    std_logic_vector(num_phys_bank - 1 downto 0);
            mba             : in    std_logic_vector(max_bank_width - 1 downto 0);
            ma              : in    std_logic_vector(max_addr_width - 1 downto 0);
            mdq             : inout std_logic_vector(dq_width - 1 downto 0);
            mdm             : in    std_logic_vector(dq_width / 8 - 1 downto 0);
            mdqs            : inout std_logic_vector(dq_width / 8 - 1 downto 0);
            mdqs_l          : inout std_logic_vector(dq_width / 8 - 1 downto 0);
            -- Device side
            dk              : out   std_logic_vector(k_width - 1 downto 0);
            dk_l            : out   std_logic_vector(k_width - 1 downto 0);
            dcke            : out   std_logic_vector(cke_width - 1 downto 0);
            dodt            : out   std_logic_vector(odt_width - 1 downto 0);
            dwe_l           : out   std_logic;
            dcas_l          : out   std_logic;
            dras_l          : out   std_logic;
            dcs_l           : out   std_logic_vector(num_phys_bank - 1 downto 0);
            dba             : out   std_logic_vector(max_bank_width - 1 downto 0);
            da              : out   std_logic_vector(max_addr_width - 1 downto 0);
            ddq             : inout std_logic_vector(dq_width - 1 downto 0);
            ddm             : out   std_logic_vector(dq_width / 8 - 1 downto 0);
            ddqs            : inout std_logic_vector(dq_width / 8 - 1 downto 0);
            ddqs_l          : inout std_logic_vector(dq_width / 8 - 1 downto 0));
    end component;

    component ddr2sram_model
        generic(
            burst_order     : in    natural;
            a_width         : in    natural;
            dq_width        : in    natural;
            -- 't_trace' is a fudge factor that models clock-to-output and setup in FPGA.
            -- Should be normally just over half of the clock period, assuming negligible
            -- PCB trace delay.
            t_trace         : in    time := 0.0 ns);
        port(
            k               : in    std_logic;
            k_l             : in    std_logic;
            c               : in    std_logic;
            c_l             : in    std_logic;
            ld_l            : in    std_logic;
            w_l             : in    std_logic;
            bwe_l           : in    std_logic_vector(dq_width / 8 - 1 downto 0);
            dq              : inout std_logic_vector(dq_width - 1 downto 0);
            cq              : out   std_logic;
            cq_l            : out   std_logic;
            a               : in    std_logic_vector(a_width - 1 downto 0));
    end component;

    component ddrsdram_dimm_model
        generic(
            max_bank_width  : in    natural;
            max_addr_width  : in    natural;
            max_phys_bank   : in    natural;
            num_phys_bank   : in    natural;
            dq_width        : in    natural;
            registered      : in    boolean;
            extra_dqs       : in    boolean);
        port(
            k0              : in    std_logic;
            k0_l            : in    std_logic;
            k1              : in    std_logic;
            k1_l            : in    std_logic;
            k2              : in    std_logic;
            k2_l            : in    std_logic;
            cke             : in    std_logic_vector(1 downto 0);
            we_l            : in    std_logic;
            cas_l           : in    std_logic;
            ras_l           : in    std_logic;
            cs_l            : in    std_logic_vector(max_phys_bank - 1 downto 0);
            ba              : in    std_logic_vector(max_bank_width - 1 downto 0);
            a               : in    std_logic_vector(max_addr_width - 1 downto 0);
            dq              : inout std_logic_vector(dq_width - 1 downto 0);
            dm              : in    std_logic_vector(dq_width / 8 - 1 downto 0);
            dqs             : inout std_logic_vector(dq_width / 8 - 1 downto 0);
            sa              : in    std_logic_vector(2 downto 0);
            scl             : inout std_logic;
            sda             : inout std_logic);
    end component;

    component ddrsdram_dimm_trace_model is
        generic(
            max_bank_width  : in    natural;
            max_addr_width  : in    natural;
            max_phys_bank   : in    natural;
            dq_width        : in    natural;
            registered      : in    boolean;
            t_trace_k       : in    time;
            t_trace_ctl     : in    time;
            t_trace_dm      : in    time;
            t_trace_dq      : in    time;
            t_trace_dqs     : in    time);
        port(
            -- Memory controller side
            mk0             : in    std_logic;
            mk0_l           : in    std_logic;
            mk1             : in    std_logic;
            mk1_l           : in    std_logic;
            mk2             : in    std_logic;
            mk2_l           : in    std_logic;
            mcke            : in    std_logic_vector(1 downto 0);
            mwe_l           : in    std_logic;
            mcas_l          : in    std_logic;
            mras_l          : in    std_logic;
            mcs_l           : in    std_logic_vector(max_phys_bank - 1 downto 0);
            mba             : in    std_logic_vector(max_bank_width - 1 downto 0);
            ma              : in    std_logic_vector(max_addr_width - 1 downto 0);
            mdq             : inout std_logic_vector(dq_width - 1 downto 0);
            mdm             : in    std_logic_vector(dq_width / 8 - 1 downto 0);
            mdqs            : inout std_logic_vector(dq_width / 8 - 1 downto 0);
            -- DIMM side
            dk0             : out   std_logic;
            dk0_l           : out   std_logic;
            dk1             : out   std_logic;
            dk1_l           : out   std_logic;
            dk2             : out   std_logic;
            dk2_l           : out   std_logic;
            dcke            : out   std_logic_vector(1 downto 0);
            dwe_l           : out   std_logic;
            dcas_l          : out   std_logic;
            dras_l          : out   std_logic;
            dcs_l           : out   std_logic_vector(max_phys_bank - 1 downto 0);
            dba             : out   std_logic_vector(max_bank_width - 1 downto 0);
            da              : out   std_logic_vector(max_addr_width - 1 downto 0);
            ddq             : inout std_logic_vector(dq_width - 1 downto 0);
            ddm             : out   std_logic_vector(dq_width / 8 - 1 downto 0);
            ddqs            : inout std_logic_vector(dq_width / 8 - 1 downto 0));
    end component;

    component ddrsdram_trace_model
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
    end component;

    component ddr2sram_trace_model
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
    end component;

    component trace_model_bidir
        generic(
            delay           : in    time);
        port(
            drive_a         : in    std_logic;
            drive_b         : in    std_logic;
            a               : inout std_logic;
            b               : inout std_logic);
    end component;

    component trace_model_unidir
        generic(
            delay           : in    time);
        port(
            a               : in    std_logic;
            b               : out   std_logic);
    end component;

end;

package body memif_sim is

end;
