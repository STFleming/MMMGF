-- admxrc5t2_main.vhd
-- modified from memory64_main.vhd from Alpha Data

-- memory64_main.vhd - Example design demonstrating FPGA-to-memory interfaces
--
-- SYNTHESIZABLE
--
-- (C) Copyright Alpha Data 2008
--
-- Memory map:
--
--   Two regions exist in the FPGA space on the local bus; a register region
--   and a memory region.
--
--        0x0 - 0x1FFFFF     register region
--   0x200000 - 0x3FFFFF     memory region
--
-- 1. Register region (Addresses on local bus; all registers 32-bit wide)
--
--   0x0      BANK     Selects bank for access via memory region:
--                     [3:0]    R/W   bank select
--
--   0x4      PAGE     Selects page within currently selected bank for access:
--                     [12:0]   R/W   page select
--
--   0x8      MEMCTL   Control functions associated with memory
--
--                     [0]      R/W   1 => memory subsystem held in reset. DO
--                                         NOT access memory region while held
--                                         in reset.
--
--   0x10     STATUS   Various DLL/DCM/PLL/IDELAYCTRL status signals. Bit fields vary
--                     according to model being targetted:
--                     [0]      RO    'lclk' DLL/DCM lock flag (1 => locked)
--                     [1]      R/W1C Stick loss-of-lock flag corresponding to [0]
--                     [7:1]          (reserved)
--                     ** ADM-XRC **
--                     [9:8]    RO    ZBT clock deskew DLL lock flags (1 => locked)
--                     [15:10]        (reserved)
--                     [17:16]  R/W1C Sticky loss-of-lock flags corresponding to [9:8]
--                     [31:18]        (reserved)
--                     ** ADM-XRC-P **
--                     [8]      RO    ZBT clock deskew DLL lock flags (1 => locked)
--                     [15:9]         (reserved)
--                     [16]     R/W1C Sticky loss-of-lock flag corresponding to [8]
--                     [31:17]        (reserved)
--                     ** ADM-XRC-II-Lite, ADM-XRC-II **
--                     [8]      RO    MCLK doubler DCM lock flag (1 => locked)
--                     [10:9]   RO    ZBT clock deskew DCM lock flags (1 => locked)
--                     [15:11]        (reserved)
--                     [18:16]  R/W1C Sticky loss-of-lock flags corresponding to [10:8]
--                     [31:19]        (reserved)
--                     ** ADM-XPL **
--                     [8]      RO    Memory clock DCM lock flag (1 => locked)
--                     [9]      RO    ZBT clock deskew DCM lock flag (1 => locked)
--                     [15:10]        (reserved)
--                     [17:16]  R/W1C Sticky loss-of-lock flags corresponding to [9:8]
--                     [31:18]        (reserved)
--                     ** ADM-XP **
--                     [8]      RO    Memory clock DCM lock flag (1 => locked)
--                     [15:9]         (reserved)
--                     [16]     R/W1C Sticky loss-of-lock flag corresponding to [8]
--                     [31:17]        (reserved)
--                     ** ADM-XRC-4LX, ADM-XRC-4SX **
--                     [8]      RO    Memory clock DCM lock flag (1 => locked)
--                     [9]      RO    ZBT clock deskew DCM lock flag (1 => locked)
--                     [15:10]        (reserved)
--                     [17:16]  R/W1C Sticky loss-of-lock flags corresponding to [9:8]
--                     [31:18]        (reserved)
--                     ** ADM-XRC-4FX, ADPE-XRC-4FX **
--                     [8]      RO    Memory clock DCM lock flag (1 => locked)
--                     [9]      RO    IDELAYCTRL lock flag (1 => locked)
--                     [15:10]        (reserved)
--                     [17:16]  R/W1C Sticky loss-of-lock flags corresponding to [9:8]
--                     [31:18]        (reserved)
--                     ** ADM-XRC-5LX, ADM-XRC-5T1, ADM-XRC-5T2 **
--                     [8]      RO    Memory clock PLL lock flag (1 => locked)
--                     [9]      RO    IDELAY reference clock PLL lock flag (1 => locked)
--                     [10]     RO    IDELAYCTRL lock flag (1 => locked)
--                     [15:11]        (reserved)
--                     [18:16]  R/W1C Sticky loss-of-lock flags corresponding to [10:8]
--                     [31:19]        (reserved)
--
--   0x14     SPD      Access to DIMM SPD I2C bus:
--                     [7:0]    R/W   EEPROM address
--                     [15:8]         (reserved)
--                     [23:16]  RO    byte read from EEPROM
--                     [24]     RO    1 => read failed
--                     [27:26]  R/W   DIMM socket address
--                     [30:27]        (reserved)
--                     [31]     WO    Write 1 to initiate read of EEPROM
--                              RO    1 => busy
--
--   0x18     MEMSTAT  Memory bank status:
--                     ** ADM-XRC-4FX, ADPE-XRC-4FX, ADM-XRC-5LX **
--                     [3:0]    RO    DDR-II SDRAM bank training status, 1 => trained
--                     [31:4]         (reserved)
--                     ** ADM-XRC-5T1 **
--                     [1:0]      RO  DDR-II SDRAM bank training status, 1 => trained
--                     [31:2]         (reserved)
--                     ** ADM-XRC-5T2 **
--                     [3:0]      RO  DDR-II SDRAM bank training status, 1 => trained
--                     [5:4]      RO  DDR-II SSRAM bank training status, 1 => trained
--                     [31:6]         (reserved)
--
--   0x40     MODE0    Bank mode register 0 (corresponds to logical bank 0)
--   0x44     MODE1    Bank mode register 1 (corresponds to logical bank 1)
--   ....
--   0x7c     MODE15   Bank mode register 15 (corresponds to logical bank 15).
--
--                     Each MODEx register works differently depending on type
--                     of memory bank it is assocaited with.
--
--                       ZBT SRAM:
--                       [0]     Selects pipelined/flowthru:
--                               0 => flowthru, 1 => pipelined
--                       [31:1]  (reserved)
--   
--                       DDR-II SRAM:
--                       [0]     Burst length: 0 => 2, 1 => 4
--                       [2]     DLL control: 0 => enabled, 1 => disabled
--                       [31:3]  (reserved)
--   
--                       DDR SDRAM:
--                       [0]     Registered: 0 => not registered, 1 => registered
--                       [1]     (reserved for x4 device support, must be zero at present)
--                       [3:2]   Row address width (see below)
--                       [5:4]   Column address width (see below)
--                               
--                                  [3:2]    [5:4]      # row bits   # col bits
--                                 ---------------------------------------------
--                                  00       00         12           8
--                                  00       01         12           9
--                                  00       10         12           10
--                                  00       11         12           11
--                                  01       00         13           9
--                                  01       01         13           10
--                                  01       10         13           11
--                                  01       11         13           12
--                                  10       00         14           10
--                                  10       01         14           11
--                                  10       10         14           12
--                                  10       11         14           13
--                                  11       00         15           11
--                                  11       01         15           11
--                                  11       10         15           13
--                                  11       11         15           14
--
--                       [7:6]   Number of banks on devices: 00 => 1, 01 => 2, 10 => 4, 11 => 8
--                       [9:8]   Number of physical banks: 00 => 1, 01 => 2, 10 => 4, 11 => 8
--                       [31:10] (reserved)
--   
--                       DDR-II SDRAM:
--                       [1:0]   (reserved)
--                       [3:2]   Row address width (see below)
--                       [5:4]   Column address width (see below)
--                               
--                                  [3:2]    [5:4]      # row bits   # col bits
--                                 ---------------------------------------------
--                                  00       00         12           8
--                                  00       01         12           9
--                                  00       10         12           10
--                                  00       11         12           11
--                                  01       00         13           9
--                                  01       01         13           10
--                                  01       10         13           11
--                                  01       11         13           12
--                                  10       00         14           10
--                                  10       01         14           11
--                                  10       10         14           12
--                                  10       11         14           13
--                                  11       00         15           11
--                                  11       01         15           11
--                                  11       10         15           13
--                                  11       11         15           14
--
--                       [7:6]   Number of banks on devices: 00 => 1, 01 => 2, 10 => 4, 11 => 8
--                       [9:8]   Number of physical banks: 00 => 1, 01 => 2, 10 => 4, 11 => 8
--                       [31:10] (reserved)
--
--   0x100    USER0    User-definable register 0
--   0x104    USER1    User-definable register 1
--   .....
--   0x1fc    USER63   User-definable register 63
--
--                     The attributes of the user-definable registers are determined by the
--                     implementation of the 'user_app' module.
--
--                     In the default 'user_app' implementation, which is a memory test, each
--                     of USER0-USER15 specifies the starting word address at which to begin
--                     testing the corresponding bank. Each of USER16-USER31 specifies the
--                     the length, in words, of memory to test. USER63 is the control register
--                     where each of bits 0-15 can be written with 1 to initiate a memory test
--                     on the corresponding bank. When read back, those bits are 1 if the memory
--                     test is completed or has not yet been started.
--                     
--
--   All other locations in memory region are reserved.
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
use work.localbus.all;
use work.memif.all;
use work.admxrc5t2_common.all;

entity admxrc5t2_main is
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
end entity;

architecture mixed of admxrc5t2_main is

    -- SPD clock division factor (80kHz SCL @ LCLK frequency of 80MHz)
    constant scldiv : natural := 250;

    --
    -- Memory bank status
    --
    signal locked : std_logic_vector(7 downto 0);
    signal trained : std_logic_vector(max_num_bank - 1 downto 0);

    --
    -- Local bus signals in and out
    --
    signal lads_i : std_logic;
    signal lblast_i : std_logic;
    signal lbterm_i : std_logic;
    signal lready_i : std_logic;
    signal lwrite_i : std_logic;
    signal lready_o_l : std_logic;
    signal lready_oe_l : std_logic;
    signal lbterm_o_l : std_logic;
    signal lbterm_oe_l : std_logic;
    signal eld_oe : std_logic;
    signal ld_iq : std_logic_vector(63 downto 0);
    signal lbe_iq_l : std_logic_vector(7 downto 0);

    --
    -- Qualified address strobe; this is LADS# qualified by some combinatorial
    -- decoding of the local bus address.
    --
    signal qlads : std_logic;

    --
    -- Local bus interface state machine outputs, indicating data transfer,
    -- address decoding and whether current transfer is a read or a write.
    --
    signal ds_xfer : std_logic;
    signal ds_decode : std_logic;
    signal ds_write : std_logic;
    signal ds_idle : std_logic;

    --
    -- Local bus interface state machine inputs; these determine when
    -- the FPGA asserts LREADY# and LBTERM#.
    --
    signal ds_ready_mem : std_logic;
    signal ds_ready_regs : std_logic;
    signal ds_ready : std_logic;
    signal ds_stop : std_logic;

    --
    -- Tracks local bus address
    --
    signal la_q : std_logic_vector(23 downto 3);

    --
    -- Registers and their selects
    --
    signal bank_reg : std_logic_vector(3 downto 0);
    signal sel_bank_reg : std_logic;
    signal wr_bank_reg : std_logic;
    signal page_reg : std_logic_vector(12 downto 0);
    signal sel_page_reg : std_logic;
    signal wr_page_reg : std_logic;
    signal memctl_reg : std_logic_vector(0 downto 0);
    signal sel_memctl_reg : std_logic;
    signal wr_memctl_reg : std_logic;
    signal status_reg : std_logic_vector(31 downto 0);
    signal sel_status_reg : std_logic;
    signal wr_status_reg : std_logic;
    -- Mode registers are regarded here as being 8 x 64-bit registers.
    signal mode_reg : std_logic_vector(511 downto 0);
    signal sel_mode_reg : std_logic_vector(7 downto 0);
    signal wr_mode_reg : std_logic_vector(7 downto 0);
    signal spd_reg : std_logic_vector(31 downto 0);
    signal sel_spd_reg : std_logic;
    signal wr_spd_reg : std_logic;
    signal memstat_reg : std_logic_vector(31 downto 0);
    signal sel_memstat_reg : std_logic;
    -- User registers are regarded here as being 32 x 64-bit registers
    signal sel_user_reg : std_logic_vector(31 downto 0);
    signal sel_user_reg_any : std_logic;
    signal wr_user_reg : std_logic_vector(31 downto 0);
    signal wr_user_reg_any : std_logic;

    -- User-definable registers
    signal do_user_reg_xfer : std_logic;
    signal user_reg_in : std_logic_vector(63 downto 0);      -- Used directly in local bus and user clock domain
    signal user_reg_wr : std_logic_vector(255 downto 0);     -- Local bus clock domain version
    signal user_reg_wr_u : std_logic_vector(255 downto 0);   -- User clock domain version
    signal user_reg_out : std_logic_vector(2047 downto 0);   -- Local bus clock domain version
    signal user_reg_out_u : std_logic_vector(2047 downto 0); -- User clock domain version
    signal user_reg_busy : std_logic;

    --
    -- Bank selects
    --
    signal sel_bank_1h : std_logic_vector(max_num_bank - 1 downto 0);

    signal reading : std_logic;

    --
    -- Signals to/from memory port(s)
    --
    signal mem_rst : std_logic;
    signal mem_ce : std_logic;
    signal mem_cw : std_logic;
    signal mem_term : std_logic;
    signal mem_wr : std_logic;
    signal mem_adv : std_logic;
    signal mem_a : std_logic_vector(30 downto 0);
    signal mem_d : std_logic_vector(63 downto 0);
    signal mem_be : std_logic_vector(7 downto 0);
    signal mem_q : std_logic_vector(63 downto 0);
    signal mem_wf : std_logic;
    signal mem_wpf : std_logic;
    signal mem_re : std_logic;
    signal mem_rpe : std_logic;

    --
    -- Signals to/from SPD interface
    --
    signal read_spd : std_logic;
    signal read_spd_ack : std_logic;
    signal spd_d : std_logic_vector(7 downto 0);
    signal spd_q : std_logic_vector(7 downto 0);
    signal spd_err : std_logic;
    signal spd_busy : std_logic;

    --
    -- Signals between user app and memory port(s)
    --
    signal user_rst : std_logic;
    signal user_clk : std_logic;
    signal user_clk2x : std_logic;
    signal user_req : control_vector_t(max_num_bank - 1 downto 0);
    signal user_ce : control_vector_t(max_num_bank - 1 downto 0);
    signal user_w : control_vector_t(max_num_bank - 1 downto 0);
    signal user_a : address_vector_t(max_num_bank - 1 downto 0);
    signal user_tag : tag_vector_t(max_num_bank - 1 downto 0);
    signal user_d : data_vector_t(max_num_bank - 1 downto 0);
    signal user_be : be_vector_t(max_num_bank - 1 downto 0);
    signal user_valid : control_vector_t(max_num_bank - 1 downto 0);
    signal user_q : data_vector_t(max_num_bank - 1 downto 0);
    signal user_qtag : tag_vector_t(max_num_bank - 1 downto 0);
    signal user_ready : control_vector_t(max_num_bank - 1 downto 0);

    signal logic0, logic1 : std_logic;

    component IBUFG
        port(
            I : in  std_logic;
            O : out std_logic);
    end component;
    
    component BUFG
        port(
            I : in  std_logic;
            O : out std_logic);
    end component;
    
    attribute IOB : string;
    attribute IOB of ld_oe_l : signal is "true";

    attribute MAX_FANOUT : string;
    attribute MAX_FANOUT of mem_rst : signal is "100000";

    signal mgt_rdy     : std_logic;
    signal mgt_clk     : std_logic;
    signal mgt_txd     : gtp_data_t(3 downto 0);
    signal mgt_txk     : std_logic_vector(7 downto 0);
    signal mgt_rxd     : gtp_data_t(3 downto 0);
    signal mgt_rxk     : std_logic_vector(7 downto 0);
    signal mgt_aligned : std_logic_vector(3 downto 0);

begin

    logic0 <= '0';
    logic1 <= '1';

    --
    -- Convert the inputs to active high.
    --

    lblast_i <= not lblast_l;
    lads_i <= not lads_l;
    lbterm_i <= not lbterm_l;
    lready_i <= not lready_l;
    lwrite_i <= lwrite;

    --
    -- Register lbe_l and ld_i (flip-flops should be mapped into IOBs)
    --

    register_ld_i : process(clk)
    begin
        if clk'event and clk = '1' then
            lbe_iq_l <= lbe_l;
            ld_iq <= ld_i;
        end if;
    end process;

    --
    -- Generate a qualified version of 'lads_l', which is
    -- asserted when the FPGA is addressed AND the FPGA is
    -- not the local bus master.
    --

    qlads <= lads_i and not la_i(la_top) and not fholda;

    --
    -- Latch the local bus address on the 'lads_l' pulse.
    --

    latch_addr : process(rst, clk)
    begin
        if rst = '1' then
            la_q <= (others => '0');
        elsif clk'event and clk = '1' then
            if lads_i = '1' then
                la_q <= la_i(23 downto 3);
            end if;
        end if;
    end process;
    
    --
    -- 'lbterm_l' should only be driven when the FPGA is addressed; otherwise
    -- float, because the control logic on the card might also drive it.
    --

    lbterm_l <= lbterm_o_l when lbterm_oe_l = '0' else 'Z';
    
    --
    -- 'lready_l' should only be driven when the FPGA is addressed; otherwise
    -- float because the control logic on the card might also drive it.
    --

    lready_l <= lready_o_l when lready_oe_l = '0' else 'Z';
    
    --
    -- Drive the local data bus on a read.
    --

    gen_ld_oe_l : process(rst, clk)
    begin
        if rst = '1' then
            ld_oe_l <= (others => '1');
        elsif clk'event and clk = '1' then
            ld_oe_l <= (others => not eld_oe);
        end if;
    end process;

    --
    -- If the current cycle is a write, update the registers.
    --		

    update_regs : process(rst, clk)
    begin
        if rst = '1' then
            bank_reg <= (others => '0');
            wr_bank_reg <= '0';
            page_reg <= (others => '0');
            wr_page_reg <= '0';
            memctl_reg <= (others => '0');
            wr_memctl_reg <= '0';
            memstat_reg <= (others => '0');
            mode_reg <= (others => '0');
            wr_mode_reg <= (others => '0');
            spd_reg <= (others => '0');
            wr_spd_reg <= '0';
            sel_bank_1h <= (others => '0');
            user_reg_in <= (others => '-');
            wr_user_reg <= (others => '0');
            wr_user_reg_any <= '0';
        elsif clk'event and clk = '1' then
            --
            -- BANK register
            --

            wr_bank_reg <= ds_xfer and ds_write and sel_bank_reg;
            if wr_bank_reg = '1' then
                if lbe_iq_l(0) = '0' then
                    bank_reg(3 downto 0) <= ld_iq(3 downto 0);
                end if;
            end if;

            --
            -- PAGE register
            --

            wr_page_reg <= ds_xfer and ds_write and sel_page_reg;
            if wr_page_reg = '1' then
                if lbe_iq_l(4) = '0' then
                    page_reg(7 downto 0) <= ld_iq(39 downto 32);
                end if;
                if lbe_iq_l(5) = '0' then
                    page_reg(12 downto 8) <= ld_iq(44 downto 40);
                end if;
            end if;

            --
            -- MEMCTL register
            --

            wr_memctl_reg <= ds_xfer and ds_write and sel_memctl_reg;
            if wr_memctl_reg = '1' then
                if lbe_iq_l(0) = '0' then
                    memctl_reg(0 downto 0) <= ld_iq(0 downto 0);
                end if;
            end if;

            --
            -- MODEx registers (treated as 8 x 64-bit registers)
            --

            for i in 0 to 7 loop
                wr_mode_reg(i) <= ds_xfer and ds_write and sel_mode_reg(i);
                if wr_mode_reg(i) = '1' then
                    for j in 0 to 7 loop
                        if lbe_iq_l(j) = '0' then
                            mode_reg(64 * i + 8 * (j + 1) - 1 downto 64 * i + 8 * j) <= ld_iq(8 * (j + 1) - 1 downto 8 * j);
                        end if;
                    end loop;
                end if;
            end loop;

            --
            -- SPD register
            --

            wr_spd_reg <= ds_xfer and ds_write and sel_spd_reg;
            if wr_spd_reg = '1' then
                if lbe_iq_l(4) = '0' then
                    spd_reg(7 downto 0) <= ld_iq(39 downto 32);
                end if;
                if lbe_iq_l(7) = '0' then
                    spd_reg(27 downto 25) <= ld_iq(59 downto 57);
                end if;
            end if;

            if wr_spd_reg = '1' then
                -- Initiate SPD read
                read_spd <= ld_iq(63);
            else
                read_spd <= '0';
            end if;

            if read_spd_ack = '1' then
                spd_reg(23 downto 16) <= spd_q;
                spd_reg(24) <= spd_err;
            end if;

            spd_reg(31) <= spd_busy;

            --
            -- MEMSTAT register
            --

            memstat_reg(max_num_bank - 1 downto 0) <= trained;

            --
            -- USERx registers (treated as 32 x 64-bit registers)
            --

            wr_user_reg_any <= ds_xfer and ds_write and sel_user_reg_any;
            if wr_user_reg_any = '1' then
                for i in 0 to 31 loop
                    if sel_user_reg(i) = '1' then
                        for j in 0 to 7 loop
                            if lbe_iq_l(j) = '0' then
                                user_reg_wr(8 * i + j) <= '1';
                            else
                                user_reg_wr(8 * i + j) <= '0';
                            end if;
                        end loop;
                    else
                        for j in 0 to 7 loop
                           user_reg_wr(8 * i + j) <= '0';
                        end loop;
                    end if;
                end loop;

                user_reg_in <= ld_iq;
            end if;

            --
            -- Generate one-hot bank-select vector
            --

            for i in 0 to max_num_bank - 1 loop
                if bank_reg = i then
                    sel_bank_1h(i) <= '1';
                else
                    sel_bank_1h(i) <= '0';
                end if;
            end loop;
        end if;
    end process;

    --
    -- Implement the STATUS register. This is treated as a special case,
    -- since some bits of STATUS are asynchronously set to 1 by loss of lock.
    --		

    gen_wr_status_reg : process(rst, clk)
    begin
        if rst = '1' then
            wr_status_reg <= '1';
        elsif clk'event and clk = '1' then
            wr_status_reg <= ds_xfer and ds_write and sel_status_reg;
        end if;
    end process;

    --
    -- Bit 0 shows LCLK DCM/DLL lock status
    --
    status_reg_0 : process(clk)
    begin
        if clk'event and clk = '1' then
            status_reg(0) <= clk_locked;
        end if;
    end process;

    --
    -- Bit 1 is a "sticky" version of bit 0, which is asynchronously set to 1
    -- when LCLK DCM/DLL lock is lost.
    --
    status_reg_1 : process(clk_locked, clk)
    begin
        if clk_locked = '0' then
            status_reg(1) <= '1';
        elsif clk'event and clk = '1' then
            if wr_status_reg = '1' then
                if lbe_iq_l(0) <= '0' and ld_iq(1) = '1' then
                    status_reg(1) <= '0';
                end if;
            end if;
        end if;
    end process;

    status_reg(7 downto 2) <= (others => '0');

    --
    -- Bits 15:8 show lock status for memory DLL/DCM/IDELAYCTRL/PLLs.
    --
    status_reg_15_8 : process(clk)
    begin
        if clk'event and clk = '1' then
            status_reg(15 downto 8) <= locked;
        end if;
    end process;

    --
    -- Bits 23:16 are "sticky" versions of bits 15:8, which are asynchronously set
    -- to 1 when memory DLL/DCM/PLL/IDELAYCTRL lock is lost.
    -- is 0.
    --
    status_reg_23_16 : for i in 0 to 7 generate
        U0 : process(locked, clk)
        begin
            if locked(i) = '0' then
                status_reg(16 + i) <= '1';
            elsif clk'event and clk = '1' then
                if wr_status_reg = '1' then
                    if lbe_iq_l(2) = '0' and ld_iq(16 + i) = '1' then
                        status_reg(16 + i) <= '0';
                    end if;
                end if;
            end if;
        end process;
    end generate;

    status_reg(31 downto 24) <= (others => '0');

    --
    -- Generate the 'sel_*_reg' signals, for multiplexing registers onto
    -- the outbound local bus data.
    --

    generate_selects : process(rst, clk)
    begin
        if rst = '1' then
            sel_bank_reg <= '0';
            sel_page_reg <= '0';
            sel_memctl_reg <= '0';
            sel_status_reg <= '0';
            sel_mode_reg <= (others => '0');
            sel_spd_reg <= '0';
            sel_memstat_reg <= '0';
            sel_user_reg <= (others => '0');
            sel_user_reg_any <= '0';
        elsif clk'event and clk = '1' then
            if qlads = '1' then
                -- Select BANK and PAGE registers
                if la_i(21) = '0' and la_i(8 downto 3) = "000000" then
                    sel_bank_reg <= '1';
                    sel_page_reg <= '1';
                else
                    sel_bank_reg <= '0';
                    sel_page_reg <= '0';
                end if;

                -- Select MEMCTL register
                if la_i(21) = '0' and la_i(8 downto 3) = "000001" then
                    sel_memctl_reg <= '1';
                else
                    sel_memctl_reg <= '0';
                end if;

                -- Select STATUS and SPD registers
                if la_i(21) = '0' and la_i(8 downto 3) = "000010" then
                    sel_status_reg <= '1';
                    sel_spd_reg <= '1';
                else
                    sel_status_reg <= '0';
                    sel_spd_reg <= '0';
                end if;

                -- Select MEMSTAT register
                if la_i(21) = '0' and la_i(8 downto 3) = "000011" then
                    sel_memstat_reg <= '1';
                else
                    sel_memstat_reg <= '0';
                end if;

                -- Select MODEx registers
                for i in 0 to 7 loop
                    if la_i(21) = '0' and la_i(8 downto 6) = "001" and la_i(5 downto 3) = i then
                        sel_mode_reg(i) <= '1';
                    else
                        sel_mode_reg(i) <= '0';
                    end if;
                end loop;

                -- Select USERx registers
                for i in 0 to 31 loop
                    if la_i(21) = '0' and la_i(8) = '1' and la_i(7 downto 3) = i then
                        sel_user_reg(i) <= '1';
                    else
                        sel_user_reg(i) <= '0';
                    end if;
                end loop;
                if la_i(21) = '0' and la_i(8) = '1' then
                    sel_user_reg_any <= '1';
                end if;
            end if;
        end if;
    end process;

    --
    -- Generate the outbound local bus data, by multiplexing either a
    -- register or a memory bank data bus onto the outbound local bus data.
    --

    gen_ld_o : process(rst, clk)
        variable lo : std_logic_vector(31 downto 0);
        variable hi : std_logic_vector(31 downto 0);
    begin
        if rst = '1' then
            ld_o <= (others => '0');
        elsif clk'event and clk = '1' then
            lo := (others => '0');
            hi := (others => '0');

            if sel_bank_reg = '1' then
                lo := lo or EXT(bank_reg, 32);
            end if;

            if sel_page_reg = '1' then
                hi := hi or EXT(page_reg, 32);
            end if;

            if sel_memctl_reg = '1' then
                lo := lo or EXT(memctl_reg, 32);
            end if;

            if sel_status_reg = '1' then
                lo := lo or status_reg;
            end if;

            if sel_spd_reg = '1' then
                hi := hi or spd_reg;
            end if;

            if sel_memstat_reg = '1' then
                lo := lo or memstat_reg;
            end if;

            for i in 0 to 7 loop
                if sel_mode_reg(i) = '1' then
                    lo := lo or mode_reg(64 * i + 31 downto 64 * i);
                    hi := hi or mode_reg(64 * i + 63 downto 64 * i + 32);
                end if;
            end loop;

            for i in 0 to 31 loop
                if sel_user_reg(i) = '1' then
                    lo := lo or user_reg_out(64 * i + 31 downto 64 * i);
                    hi := hi or user_reg_out(64 * i + 63 downto 64 * i + 32);
                end if;
            end loop;

            if la_q(21) = '1' then
                lo := lo or mem_q(31 downto 0);
                hi := hi or mem_q(63 downto 32);
            end if;

            ld_o <= hi & lo;
        end if;
    end process;

    ds_stop <= not la_q(21) or ((ds_write and mem_wpf) or (not ds_write and mem_adv and mem_rpe));
    ds_ready_regs <= not user_reg_busy;
    ds_ready_mem <= (ds_write and not mem_wpf) or (not ds_write and mem_adv);
    ds_ready <= (not la_q(21) and ds_ready_regs) or (la_q(21) and ds_ready_mem);

    --
    -- Instantiate the direct slave state machine; monitors the local bus for
    -- direct slave cycles and responds appropriately.
    --

    dssm : plxdssm
        port map(
            clk => clk,
            rst => rst,
            sr => logic0,
            qlads => qlads,
            lbterm => lbterm_i,
            lblast => lblast_i,
            lwrite => lwrite_i,
            eld_oe => eld_oe,
            lready_o_l => lready_o_l,
            lready_oe_l => lready_oe_l,
            lbterm_o_l => lbterm_o_l,
            lbterm_oe_l => lbterm_oe_l,
            idle => ds_idle,
            transfer => ds_xfer,
            decode => ds_decode,
            write => ds_write,
            ready => ds_ready,
            stop => ds_stop);

    --
    -- Instantiate memory banks.
    --

    gen_mem_sig : process(rst, clk)
    begin
        if rst = '1' then
            mem_term <= '0';
            mem_wr <= '0';
            mem_adv <= '0';
            reading <= '0';
        elsif clk'event and clk = '1' then
            mem_term <= ds_xfer and la_q(21) and (lblast_i or lbterm_i);
            mem_wr <= ds_xfer and ds_write and la_q(21);

            if ds_xfer = '1' and (lblast_i = '1' or lbterm_i = '1') then
                mem_adv <= '0';
            else
                if reading = '1' and mem_re = '0' then
                    mem_adv <= '1';
                end if;
            end if;

            if ds_xfer = '1' and (lblast_i = '1' or lbterm_i = '1') then
                reading <= '0';
            else
                if ds_decode = '1' then
                    reading <= la_q(21) and not ds_write;
                end if;
            end if;
        end if;
    end process;

    mem_d <= ld_iq;
    mem_be <= not lbe_iq_l;
    mem_ce <= ds_decode and la_q(21);
    mem_cw <= ds_decode and ds_write;
    mem_a <= page_reg & la_q(20 downto 3);
    mem_rst <= not clk_locked or memctl_reg(0);

    memory_banks_0 : memory_banks
        generic map(
            addr_width => 31,
            data_width => 64,
            bank0 => bank0,
            bank1 => bank1,
            bank2 => bank2,
            bank3 => bank3,
            bank4 => bank4,
            bank5 => bank5,
            bank6 => bank6,
            bank7 => bank7,
            bank8 => bank8,
            bank9 => bank9,
            bank10 => bank10,
            bank11 => bank11,
            bank12 => bank12,
            bank13 => bank13,
            bank14 => bank14,
            bank15 => bank15,
            num_ramclk => num_ramclk)
        port map(
            rst => mem_rst,
            clk => clk,
            mclk_i => mclk_i,
            refclk_i => refclk_i,
            sel_bank_1h => sel_bank_1h,
            bank_reg => bank_reg,
            mode_reg => mode_reg,
            mem_ce => mem_ce,
            mem_cw => mem_cw,
            mem_term => mem_term,
            mem_wr => mem_wr,
            mem_adv => mem_adv,
            mem_a => mem_a,
            mem_d => mem_d,
            mem_be => mem_be,
            mem_q => mem_q,
            mem_wf => mem_wf,
            mem_wpf => mem_wpf,
            mem_re => mem_re,
            mem_rpe => mem_rpe,
            locked => locked,
            trained => trained,
            user_req => user_req,
            user_ce => user_ce,
            user_w => user_w,
            user_a => user_a,
            user_tag => user_tag,
            user_d => user_d,
            user_be => user_be,
            user_rst => user_rst,
            user_clk => user_clk,
            user_clk2x => user_clk2x,
            user_valid => user_valid,
            user_q => user_q,
            user_qtag => user_qtag,
            user_ready => user_ready,
            ra0 => ra0,
            rc0 => rc0,
            rd0 => rd0,
            ra1 => ra1,
            rc1 => rc1,
            rd1 => rd1,
            ra2 => ra2,
            rc2 => rc2,
            rd2 => rd2,
            ra3 => ra3,
            rc3 => rc3,
            rd3 => rd3,
            ra4 => ra4,
            rc4 => rc4,
            rd4 => rd4,
            ra5 => ra5,
            rc5 => rc5,
            rd5 => rd5,
            ra6 => ra6,
            rc6 => rc6,
            rd6 => rd6,
            ra7 => ra7,
            rc7 => rc7,
            rd7 => rd7,
            ra8 => ra8,
            rc8 => rc8,
            rd8 => rd8,
            ra9 => ra9,
            rc9 => rc9,
            rd9 => rd9,
            ra10 => ra10,
            rc10 => rc10,
            rd10 => rd10,
            ra11 => ra11,
            rc11 => rc11,
            rd11 => rd11,
            ra12 => ra12,
            rc12 => rc12,
            rd12 => rd12,
            ra13 => ra13,
            rc13 => rc13,
            rd13 => rd13,
            ra14 => ra14,
            rc14 => rc14,
            rd14 => rd14,
            ra15 => ra15,
            rc15 => rc15,
            rd15 => rd15,
            ramclki => ramclki,
            ramclko => ramclko);

    spd_d <= (others => '-');

    spd_i2c_0 : spd_i2c
        generic map(
            scldiv => scldiv)
        port map(
            rst => rst,
            clk => clk,
            sr => logic0,
            ce => read_spd,
            wr => logic0,
            sa => spd_reg(27 downto 25),
            a => spd_reg(7 downto 0),
            d => spd_d,
            ack => read_spd_ack,
            busy => spd_busy,
            q => spd_q,
            err => spd_err,
            scl_i => scl_i,
            scl_o => scl_o,
            sda_i => sda_i,
            sda_o => sda_o);

    --
    -- Retime user registers between local bus and user (i.e. memory) clock domains
    --

    do_user_reg_xfer <= ds_xfer and ds_write and sel_user_reg_any;

    user_reg_sync_0 : user_reg_sync
        generic map(
            width => 2048)
        port map(
            rst => rst,
            clk => clk,
            user_clk => user_clk,
            write => do_user_reg_xfer,
            busy => user_reg_busy,
            reg_wr => user_reg_wr,
            reg_wr_u => user_reg_wr_u,
            reg_out_u => user_reg_out_u,
            reg_out => user_reg_out);
        
    --
    -- User application
    --

    user_app_0 : user_app
        port map(
            rst => user_rst,
            clk => user_clk,
            clk2x => user_clk2x,
            reg_in => user_reg_in,
            reg_wr => user_reg_wr_u,
            reg_out => user_reg_out_u,
            gtp_rdy => mgt_rdy,
            gtp_clk => mgt_clk,
            gtp_txd => mgt_txd,
            gtp_txk => mgt_txk,
            gtp_rxd => mgt_rxd,
            gtp_rxk => mgt_rxk,
            gtp_aligned => mgt_aligned,
            valid => user_valid,
            q => user_q,
            qtag => user_qtag,
            ready => user_ready,
            req => user_req,
            ce => user_ce,
            w => user_w,
            a => user_a,
            tag => user_tag,
            d => user_d,
            be => user_be);

    U_MGT : MGTIF port map
      (
          -- user interface
          MGT_CLK               => mgt_clk,
          MGT_RDY               => mgt_rdy,
          MGT_TXD               => mgt_txd,
          MGT_TXK               => mgt_txk,
          MGT_RXD               => mgt_rxd,
          MGT_RXK               => mgt_rxk,
          MGT_ALIGNED           => mgt_aligned,
          -- system interface
          TILE0_REFCLK_PAD_N_IN => mclkb_n,
          TILE0_REFCLK_PAD_P_IN => mclkb_p,
          MGTRESET_IN           => rst,
          RXN_IN                => rxn,
          RXP_IN                => rxp,
          TXN_OUT               => txn,
          TXP_OUT               => txp
      );

end architecture;
