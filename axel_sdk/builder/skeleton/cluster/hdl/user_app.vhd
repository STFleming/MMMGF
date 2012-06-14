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
  SIZE : in std_logic_vector(31 downto 0);
    -- ram interface
  rdy0   : in  std_logic;
  req0   : out std_logic;
  ce0    : out std_logic;
  we0    : out std_logic;
  vld0   : in  std_logic;
  addr0  : out std_logic_vector(max_address_width-1 downto 0);
  data0w : out std_logic_vector(127 downto 0);
  data0r : in  std_logic_vector(127 downto 0);
  rdy1   : in  std_logic;
  req1   : out std_logic;
  ce1    : out std_logic;
  we1    : out std_logic;
  vld1   : in  std_logic;
  addr1  : out std_logic_vector(max_address_width-1 downto 0);
  data1w : out std_logic_vector(127 downto 0);
  data1r : in  std_logic_vector(127 downto 0);
    -- control interface
    start : in  std_logic;
    done  : out std_logic);
  END COMPONENT;

  signal en    : std_logic;
  signal start : std_logic;
  signal done  : std_logic;
  signal SIZE : std_logic_vector(31 downto 0);

begin

  ---------- Memory Interface ----------
  gen_dummy: for i in 2 to max_num_bank -1 generate
    req(i) <= '0';
    ce(i)  <= '0';
    w(i)   <= '0';
    a(i)   <= (others => '0');
    tag(i) <= (others => '0');
    d(i)   <= (others => '0');
    be(i)  <= (others => '0');
  end generate;
  be(0) <= (others => '1');
  be(1) <= (others => '1');
  tag(0) <= (others => '0');
  tag(1) <= (others => '0');

  ---------- Processing Element----------
  U0 : pe port map (
    debug => open,
    clk   => clk,
    rst   => rst,
    en    => en,
    -- parameter interface
  SIZE => SIZE,
    -- ram interface
  rdy0   => ready(0),
  req0   => req(0),
  ce0    => ce(0),
  we0    => w(0),
  vld0   => valid(0),
  addr0  => a(0),
  data0w => d(0),
  data0r => q(0),
  rdy1   => ready(1),
  req1   => req(1),
  ce1    => ce(1),
  we1    => w(1),
  vld1   => valid(1),
  addr1  => a(1),
  data1w => d(1),
  data1r => q(1),
    -- control interface
    start => start,
    done  => done);

  en <= not rst;
  start <= reg_in(0) and reg_wr(0);

  ---------- User Registers ----------
  U_REG_SIZE: process (clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        SIZE <= (others => '0');
      elsif reg_wr(4) = '1' then
        SIZE <= reg_in(63 downto 32);
      end if;
    end if;
  end process;

  reg_out(31  downto  0) <= (31 downto 1 => '0')&done;
  reg_out(63  downto 32) <= SIZE;
  reg_out(2047 downto 64) <= (others => '0');

end architecture;
