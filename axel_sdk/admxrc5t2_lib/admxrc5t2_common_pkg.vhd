-- admxrc5t2_common_pkg.vhd
-- modified from memory64_common.pkg from Alpha Data SDK

--
-- memory64_pkg.vhd - Common definitions for "memory64" example FPGA design
--
-- SYNTHESIZABLE
--
-- (C) Copyright Alpha Data 2008
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

library work;
use work.memif.all;

package admxrc5t2_common is

    constant max_num_bank : natural := 16;

    -- Maximum data width used by any bank
    constant max_data_width : natural := 128;

    -- Maximum byte enable width used by any bank
    constant max_be_width : natural := max_data_width / 8;

    -- Maximum address width required for addressing any bank
    constant max_address_width : natural := 32;

    -- Change this if 2 tag bits is insufficient in your application
    constant tag_width : natural := 2;

    -- Used for address signal to a memory port
    type address_vector_t is array(natural range <>) of std_logic_vector(max_address_width - 1 downto 0);

    -- Used for 'd' and 'q' signals to and from a memory port
    type be_vector_t is array(natural range <>) of std_logic_vector(max_be_width - 1 downto 0);

    -- Used for single bit signals such as 'ready' from a memory port
    type control_vector_t is array(natural range <>) of std_logic;

    -- Used for 'd' and 'q' signals to and from a memory port
    type data_vector_t is array(natural range <>) of std_logic_vector(max_data_width - 1 downto 0);

    -- Used for 'tag' and 'qtag' signals to and from a memory port
    type tag_vector_t is array(natural range <>) of std_logic_vector(tag_width - 1 downto 0);

    type gtp_data_t is array(natural range<>) of std_logic_vector(15 downto 0);
    type reg_data_t is array(natural range<>) of std_logic_vector(31 downto 0);

    component admxrc5t2_main
        generic(
            -- Bit of local bus address that is used to decode FPGA space
            la_top            : in    natural;
            -- Memory bank parameters
            bank0             : in    bank_t;
            bank1             : in    bank_t;
            bank2             : in    bank_t;
            bank3             : in    bank_t;
            bank4             : in    bank_t;
            bank5             : in    bank_t;
            bank6             : in    bank_t;
            bank7             : in    bank_t;
            bank8             : in    bank_t;
            bank9             : in    bank_t;
            bank10            : in    bank_t;
            bank11            : in    bank_t;
            bank12            : in    bank_t;
            bank13            : in    bank_t;
            bank14            : in    bank_t;
            bank15            : in    bank_t;
            num_ramclk        : in    natural);
        port(
            -- Local bus
            clk               : in    std_logic;
            clk_locked        : in    std_logic;
            rst               : in    std_logic; 
            lwrite            : in    std_logic;
            lads_l            : in    std_logic;
            lblast_l          : in    std_logic;
            lbe_l             : in    std_logic_vector(7 downto 0);
            la_i              : in    std_logic_vector(la_top downto 3);
            ld_i              : in    std_logic_vector(63 downto 0);
            ld_o              : out   std_logic_vector(63 downto 0);
            ld_oe_l           : out   std_logic_vector(63 downto 0);
            lbterm_l          : inout std_logic;
            lready_l          : inout std_logic; 
            fholda            : in    std_logic;
            -- General purpose clock
            mclk_i            : in    std_logic;
            -- Reference clock
            refclk_i          : in    std_logic;
            -- MGT interface
            mclkb_n           : in   std_logic;
            mclkb_p           : in   std_logic;
            rxn               : in   std_logic_vector(3 downto 0);
            rxp               : in   std_logic_vector(3 downto 0);
            txn               : out  std_logic_vector(3 downto 0);
            txp               : out  std_logic_vector(3 downto 0);
            -- Memory banks (up to 16 supported by this design)
            ra0               : out   std_logic_vector(bank0.ra_width - 1 downto 0);
            rc0               : inout std_logic_vector(bank0.rc_width - 1 downto 0);
            rd0               : inout std_logic_vector(bank0.rd_width - 1 downto 0);
            ra1               : out   std_logic_vector(bank1.ra_width - 1 downto 0);
            rc1               : inout std_logic_vector(bank1.rc_width - 1 downto 0);
            rd1               : inout std_logic_vector(bank1.rd_width - 1 downto 0);
            ra2               : out   std_logic_vector(bank2.ra_width - 1 downto 0);
            rc2               : inout std_logic_vector(bank2.rc_width - 1 downto 0);
            rd2               : inout std_logic_vector(bank2.rd_width - 1 downto 0);
            ra3               : out   std_logic_vector(bank3.ra_width - 1 downto 0);
            rc3               : inout std_logic_vector(bank3.rc_width - 1 downto 0);
            rd3               : inout std_logic_vector(bank3.rd_width - 1 downto 0);
            ra4               : out   std_logic_vector(bank4.ra_width - 1 downto 0);
            rc4               : inout std_logic_vector(bank4.rc_width - 1 downto 0);
            rd4               : inout std_logic_vector(bank4.rd_width - 1 downto 0);
            ra5               : out   std_logic_vector(bank5.ra_width - 1 downto 0);
            rc5               : inout std_logic_vector(bank5.rc_width - 1 downto 0);
            rd5               : inout std_logic_vector(bank5.rd_width - 1 downto 0);
            ra6               : out   std_logic_vector(bank6.ra_width - 1 downto 0);
            rc6               : inout std_logic_vector(bank6.rc_width - 1 downto 0);
            rd6               : inout std_logic_vector(bank6.rd_width - 1 downto 0);
            ra7               : out   std_logic_vector(bank7.ra_width - 1 downto 0);
            rc7               : inout std_logic_vector(bank7.rc_width - 1 downto 0);
            rd7               : inout std_logic_vector(bank7.rd_width - 1 downto 0);
            ra8               : out   std_logic_vector(bank8.ra_width - 1 downto 0);
            rc8               : inout std_logic_vector(bank8.rc_width - 1 downto 0);
            rd8               : inout std_logic_vector(bank8.rd_width - 1 downto 0);
            ra9               : out   std_logic_vector(bank9.ra_width - 1 downto 0);
            rc9               : inout std_logic_vector(bank9.rc_width - 1 downto 0);
            rd9               : inout std_logic_vector(bank9.rd_width - 1 downto 0);
            ra10              : out   std_logic_vector(bank10.ra_width - 1 downto 0);
            rc10              : inout std_logic_vector(bank10.rc_width - 1 downto 0);
            rd10              : inout std_logic_vector(bank10.rd_width - 1 downto 0);
            ra11              : out   std_logic_vector(bank11.ra_width - 1 downto 0);
            rc11              : inout std_logic_vector(bank11.rc_width - 1 downto 0);
            rd11              : inout std_logic_vector(bank11.rd_width - 1 downto 0);
            ra12              : out   std_logic_vector(bank12.ra_width - 1 downto 0);
            rc12              : inout std_logic_vector(bank12.rc_width - 1 downto 0);
            rd12              : inout std_logic_vector(bank12.rd_width - 1 downto 0);
            ra13              : out   std_logic_vector(bank13.ra_width - 1 downto 0);
            rc13              : inout std_logic_vector(bank13.rc_width - 1 downto 0);
            rd13              : inout std_logic_vector(bank13.rd_width - 1 downto 0);
            ra14              : out   std_logic_vector(bank14.ra_width - 1 downto 0);
            rc14              : inout std_logic_vector(bank14.rc_width - 1 downto 0);
            rd14              : inout std_logic_vector(bank14.rd_width - 1 downto 0);
            ra15              : out   std_logic_vector(bank15.ra_width - 1 downto 0);
            rc15              : inout std_logic_vector(bank15.rc_width - 1 downto 0);
            rd15              : inout std_logic_vector(bank15.rd_width - 1 downto 0);
            ramclki           : in    std_logic_vector(num_ramclk - 1 downto 0);
            ramclko           : out   std_logic_vector(num_ramclk - 1 downto 0);
            scl_i             : in    std_logic;
            scl_o             : out   std_logic;
            sda_i             : in    std_logic;
            sda_o             : out   std_logic);
    end component;

    component memory_banks
        generic(
            addr_width    : in    natural;
            data_width    : in    natural;
            bank0         : in    bank_t;
            bank1         : in    bank_t;
            bank2         : in    bank_t;
            bank3         : in    bank_t;
            bank4         : in    bank_t;
            bank5         : in    bank_t;
            bank6         : in    bank_t;
            bank7         : in    bank_t;
            bank8         : in    bank_t;
            bank9         : in    bank_t;
            bank10        : in    bank_t;
            bank11        : in    bank_t;
            bank12        : in    bank_t;
            bank13        : in    bank_t;
            bank14        : in    bank_t;
            bank15        : in    bank_t;
            num_ramclk    : in    natural);
        port(
            rst           : in    std_logic;
            clk           : in    std_logic;
            mclk_i        : in    std_logic;
            refclk_i      : in    std_logic;
            -- Interface between memory subsystem and local bus control
            sel_bank_1h   : in    std_logic_vector(max_num_bank - 1 downto 0);
            bank_reg      : in    std_logic_vector(3 downto 0);
            mode_reg      : in    std_logic_vector(511 downto 0);
            mem_ce        : in    std_logic;
            mem_term      : in    std_logic;
            mem_cw        : in    std_logic;
            mem_adv       : in    std_logic;
            mem_wr        : in    std_logic;
            mem_a         : in    std_logic_vector(addr_width - 1 downto 0);
            mem_d         : in    std_logic_vector(data_width - 1 downto 0);
            mem_be        : in    std_logic_vector(data_width / 8 - 1 downto 0);
            mem_q         : out   std_logic_vector(data_width - 1 downto 0);
            mem_wf        : out   std_logic;
            mem_wpf       : out   std_logic;
            mem_re        : out   std_logic;
            mem_rpe       : out   std_logic;
            locked        : out   std_logic_vector(7 downto 0);
            trained       : out   std_logic_vector(max_num_bank - 1 downto 0);
            -- Interface between memory subsystem and user application
            user_req      : in    control_vector_t(max_num_bank - 1 downto 0);
            user_ce       : in    control_vector_t(max_num_bank - 1 downto 0);
            user_w        : in    control_vector_t(max_num_bank - 1 downto 0);
            user_a        : in    address_vector_t(max_num_bank - 1 downto 0);
            user_tag      : in    tag_vector_t(max_num_bank - 1 downto 0);
            user_d        : in    data_vector_t(max_num_bank - 1 downto 0);
            user_be       : in    be_vector_t(max_num_bank - 1 downto 0);
            user_rst      : out   std_logic;
            user_clk      : out   std_logic;
            user_clk2x    : out   std_logic;
            user_valid    : out   control_vector_t(max_num_bank - 1 downto 0);
            user_q        : out   data_vector_t(max_num_bank - 1 downto 0);
            user_qtag     : out   tag_vector_t(max_num_bank - 1 downto 0);
            user_ready    : out   control_vector_t(max_num_bank - 1 downto 0);
            -- To/from memory bank pins
            ra0           : out   std_logic_vector(bank0.ra_width - 1 downto 0);
            rc0           : inout std_logic_vector(bank0.rc_width - 1 downto 0);
            rd0           : inout std_logic_vector(bank0.rd_width - 1 downto 0);
            ra1           : out   std_logic_vector(bank1.ra_width - 1 downto 0);
            rc1           : inout std_logic_vector(bank1.rc_width - 1 downto 0);
            rd1           : inout std_logic_vector(bank1.rd_width - 1 downto 0);
            ra2           : out   std_logic_vector(bank2.ra_width - 1 downto 0);
            rc2           : inout std_logic_vector(bank2.rc_width - 1 downto 0);
            rd2           : inout std_logic_vector(bank2.rd_width - 1 downto 0);
            ra3           : out   std_logic_vector(bank3.ra_width - 1 downto 0);
            rc3           : inout std_logic_vector(bank3.rc_width - 1 downto 0);
            rd3           : inout std_logic_vector(bank3.rd_width - 1 downto 0);
            ra4           : out   std_logic_vector(bank4.ra_width - 1 downto 0);
            rc4           : inout std_logic_vector(bank4.rc_width - 1 downto 0);
            rd4           : inout std_logic_vector(bank4.rd_width - 1 downto 0);
            ra5           : out   std_logic_vector(bank5.ra_width - 1 downto 0);
            rc5           : inout std_logic_vector(bank5.rc_width - 1 downto 0);
            rd5           : inout std_logic_vector(bank5.rd_width - 1 downto 0);
            ra6           : out   std_logic_vector(bank6.ra_width - 1 downto 0);
            rc6           : inout std_logic_vector(bank6.rc_width - 1 downto 0);
            rd6           : inout std_logic_vector(bank6.rd_width - 1 downto 0);
            ra7           : out   std_logic_vector(bank7.ra_width - 1 downto 0);
            rc7           : inout std_logic_vector(bank7.rc_width - 1 downto 0);
            rd7           : inout std_logic_vector(bank7.rd_width - 1 downto 0);
            ra8           : out   std_logic_vector(bank8.ra_width - 1 downto 0);
            rc8           : inout std_logic_vector(bank8.rc_width - 1 downto 0);
            rd8           : inout std_logic_vector(bank8.rd_width - 1 downto 0);
            ra9           : out   std_logic_vector(bank9.ra_width - 1 downto 0);
            rc9           : inout std_logic_vector(bank9.rc_width - 1 downto 0);
            rd9           : inout std_logic_vector(bank9.rd_width - 1 downto 0);
            ra10          : out   std_logic_vector(bank10.ra_width - 1 downto 0);
            rc10          : inout std_logic_vector(bank10.rc_width - 1 downto 0);
            rd10          : inout std_logic_vector(bank10.rd_width - 1 downto 0);
            ra11          : out   std_logic_vector(bank11.ra_width - 1 downto 0);
            rc11          : inout std_logic_vector(bank11.rc_width - 1 downto 0);
            rd11          : inout std_logic_vector(bank11.rd_width - 1 downto 0);
            ra12          : out   std_logic_vector(bank12.ra_width - 1 downto 0);
            rc12          : inout std_logic_vector(bank12.rc_width - 1 downto 0);
            rd12          : inout std_logic_vector(bank12.rd_width - 1 downto 0);
            ra13          : out   std_logic_vector(bank13.ra_width - 1 downto 0);
            rc13          : inout std_logic_vector(bank13.rc_width - 1 downto 0);
            rd13          : inout std_logic_vector(bank13.rd_width - 1 downto 0);
            ra14          : out   std_logic_vector(bank14.ra_width - 1 downto 0);
            rc14          : inout std_logic_vector(bank14.rc_width - 1 downto 0);
            rd14          : inout std_logic_vector(bank14.rd_width - 1 downto 0);
            ra15          : out   std_logic_vector(bank15.ra_width - 1 downto 0);
            rc15          : inout std_logic_vector(bank15.rc_width - 1 downto 0);
            rd15          : inout std_logic_vector(bank15.rd_width - 1 downto 0);
            ramclki       : in    std_logic_vector(num_ramclk - 1 downto 0);
            ramclko       : out   std_logic_vector(num_ramclk - 1 downto 0));
    end component;

    component reg_sync is
        generic(
            width         : in    natural);
        port(
            ar            : in    std_logic;                             -- Async reset
            ik            : in    std_logic;                             -- Input clock
            i             : in    std_logic_vector(width - 1 downto 0);  -- Input vector (sync. to 'ik')
            ok            : in    std_logic;                             -- Output clock
            o             : out   std_logic_vector(width - 1 downto 0)); -- Output vector (sync. to 'ok')
    end component;

    component user_app
        port(
            rst           : in    std_logic;   -- Reset from memory clock domain
            clk           : in    std_logic;   -- Clock from memory clock domain
            clk2x         : in    std_logic;   -- Clock from memory clock domain
            -- To/from local bus interface
            reg_in        : in    std_logic_vector(63 downto 0);   -- Incoming register write values
            reg_wr        : in    std_logic_vector(255 downto 0);  -- Byte write enables for 'reg_in'
            reg_out       : out   std_logic_vector(2047 downto 0); -- Outgoing register values
            -- MGT interface
            gtp_clk       : in  std_logic;
            gtp_rdy       : in  std_logic;
            gtp_txd       : out gtp_data_t(3 downto 0);
            gtp_txk       : out std_logic_vector(7 downto 0);
            gtp_rxd       : in  gtp_data_t(3 downto 0);
            gtp_rxk       : in  std_logic_vector(7 downto 0);
            gtp_aligned   : in  std_logic_vector(3 downto 0);
            -- To/from memory banks
            valid         : in    control_vector_t(max_num_bank - 1 downto 0);
            q             : in    data_vector_t(max_num_bank - 1 downto 0);
            qtag          : in    tag_vector_t(max_num_bank - 1 downto 0);
            ready         : in    control_vector_t(max_num_bank - 1 downto 0);
            req           : out   control_vector_t(max_num_bank - 1 downto 0);
            ce            : out   control_vector_t(max_num_bank - 1 downto 0);
            w             : out   control_vector_t(max_num_bank - 1 downto 0);
            a             : out   address_vector_t(max_num_bank - 1 downto 0);
            tag           : out   tag_vector_t(max_num_bank - 1 downto 0);
            d             : out   data_vector_t(max_num_bank - 1 downto 0);
            be            : out   be_vector_t(max_num_bank - 1 downto 0));
    end component;

    component user_reg_sync
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
    end component;

    component MGTIF is
      generic
      (
        SIM_MODE                        : string    := "FAST";
        SIM_GTPRESET_SPEEDUP            : integer   := 1;
        SIM_PLL_PERDIV2                 : bit_vector:= x"140"
      );
      port
      (
        -- user interface
        MGT_CLK                         : out  std_logic;
        MGT_RDY                         : out  std_logic;
        MGT_TXD                         : in   gtp_data_t(3 downto 0);
        MGT_TXK                         : in   std_logic_vector(7 downto 0);
        MGT_RXD                         : out  gtp_data_t(3 downto 0);
        MGT_RXK                         : out  std_logic_vector(7 downto 0);
        MGT_ALIGNED                     : out  std_logic_vector(3 downto 0);
        -- system interface
        TILE0_REFCLK_PAD_N_IN           : in   std_logic;
        TILE0_REFCLK_PAD_P_IN           : in   std_logic;
        MGTRESET_IN                     : in   std_logic;
        RXN_IN                          : in   std_logic_vector(3 downto 0);
        RXP_IN                          : in   std_logic_vector(3 downto 0);
        TXN_OUT                         : out  std_logic_vector(3 downto 0);
        TXP_OUT                         : out  std_logic_vector(3 downto 0)
      );
    end component;

    component mgt_stream is
      port(
        rst           : in    std_logic;
        -- MGT interface
        mgt_clk       : in    std_logic;
        mgt_rdy       : in    std_logic;   -- MGT clock stable
        mgt_txd       : out   gtp_data_t(3 downto 0);
        mgt_txk       : out   std_logic_vector(7 downto 0);
        mgt_rxd       : in    gtp_data_t(3 downto 0);
        mgt_rxk       : in    std_logic_vector(7 downto 0);
        mgt_aligned   : in    std_logic_vector(3 downto 0);
        -- user interface
        usr_txdat     : in   gtp_data_t(3 downto 0);
        usr_txwen     : in   std_logic_vector(3 downto 0);
        usr_txrdy     : out  std_logic_vector(3 downto 0);
        usr_rxdat     : out  gtp_data_t(3 downto 0);
        usr_rxrdy     : out  std_logic_vector(3 downto 0)
      );
    end component;
end;
