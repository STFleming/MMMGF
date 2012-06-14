--
-- user_app.vhd - user application code
--
--  Project   : <<<APPLICATION_NAME>>>
--  Programmer: <<<EMAIL>>>
--  Date      : <<<DATE>>>
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;

library unisim;
use unisim.vcomponents.all;

library work;
--use work.memif.all;
use work.admxrc5t2_common.all;
use work.user_defs.all;

entity user_app is
    port(
        rst           : in    std_logic;   -- Reset from memory clock domain
        clk           : in    std_logic;   -- Clock from memory clock domain
        -- To/from local bus interface (32 x 64-bit register)
        reg_in        : in    std_logic_vector(63 downto 0);
        reg_wr        : in    std_logic_vector(255 downto 0); -- 256 bwe
        reg_out       : out   std_logic_vector(2047 downto 0); -- 256 bytes
        -- MGT interface
        mgt_clk       : in    std_logic;
        mgt_rdy       : in    std_logic;   -- MGT clock stable
        mgt_txd       : out   mgt_data_t(3 downto 0);
        mgt_txk       : out   std_logic_vector(7 downto 0);
        mgt_rxd       : in    mgt_data_t(3 downto 0);
        mgt_rxk       : in    std_logic_vector(7 downto 0);
        mgt_aligned   : in    std_logic_vector(3 downto 0);
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
end entity;

architecture syn of user_app is

  COMPONENT pe IS
    PORT (
    debug : out std_logic_vector(31 downto 0);
    -- global interface
    clk   : in  std_logic;
    rst   : in  std_logic;
    en    : in  std_logic;
    -- parameter interface
    <<<REG_PORT>>>
    -- ram interface
    <<<MEM_PORT>>>
    -- control interface
    start : in  std_logic;
    done  : out std_logic);
  END COMPONENT;

  signal en    : std_logic;
  signal start : std_logic;
  signal done  : std_logic;
  <<<REG_SIGNAL>>>

begin

  ---------- Memory Interface ----------
  gen_dummy: for i in <<<BANK_CNT>>> to max_num_bank -1 generate
    req(i) <= '0';
    ce(i)  <= '0';
    w(i)   <= '0';
    a(i)   <= (others => '0');
    tag(i) <= (others => '0');
    d(i)   <= (others => '0');
    be(i)  <= (others => '0');
  end generate;
  <<<MEM_BE>>>

  ---------- Processing Element ----------
  U0 : pe port map (
    debug => open,
    clk   => clk,
    rst   => rst,
    en    => en,
    -- parameter interface
    <<<REG_MAP>>>
    -- ram interface
    <<<MEM_MAP>>>
    -- control interface
    start => start,
    done  => done);

  ---------- User Registers ----------
  <<<REG_IO>>>

end architecture;
