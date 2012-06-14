--
-- user_app.vhd - user application code
--
--  Project   : myapp
--  Programmer: khtsoi@gmail.com
--  Date      : Thu Nov 12 16:18:01 2009
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
        clk2x         : in    std_logic;   -- Clock from memory clock domain
        -- To/from local bus interface (32 x 64-bit register)
        reg_in        : in    std_logic_vector(63 downto 0);
        reg_wr        : in    std_logic_vector(255 downto 0); -- 256 bwe
        reg_out       : out   std_logic_vector(2047 downto 0); -- 256 bytes
        -- MGT interface
        gtp_clk       : in    std_logic;
        gtp_rdy       : in    std_logic;   -- MGT clock stable
        gtp_txd       : out   gtp_data_t(3 downto 0);
        gtp_txk       : out   std_logic_vector(7 downto 0);
        gtp_rxd       : in    gtp_data_t(3 downto 0);
        gtp_rxk       : in    std_logic_vector(7 downto 0);
        gtp_aligned   : in    std_logic_vector(3 downto 0);
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

  component user_app_v is
    port(
        rst           : in    std_logic;   -- Reset from memory clock domain
        clk           : in    std_logic;   -- Clock from memory clock domain
        clk2x         : in    std_logic;   -- Clock from memory clock domain
        reg_in        : in    std_logic_vector(63 downto 0);
        reg_wr        : in    std_logic_vector(255 downto 0); -- 256 bwe
        reg_out       : out   std_logic_vector(2047 downto 0); -- 256 bytes
        gtp_clk       : in    std_logic;
        gtp_rdy       : in    std_logic;   -- MGT clock stable
        gtp_txd       : out   std_logic_vector(63 downto 0);
        gtp_txk       : out   std_logic_vector(7 downto 0);
        gtp_rxd       : in    std_logic_vector(63 downto 0);
        gtp_rxk       : in    std_logic_vector(7 downto 0);
        gtp_aligned   : in    std_logic_vector(3 downto 0);
        valid         : in    std_logic_vector(5 downto 0);
        q             : in    std_logic_vector(767 downto 0); -- 6*128
        qtag          : in    std_logic_vector(11 downto 0);  -- 6*2
        ready         : in    std_logic_vector(5 downto 0);
        req           : out   std_logic_vector(5 downto 0);
        ce            : out   std_logic_vector(5 downto 0);
        w             : out   std_logic_vector(5 downto 0);
        a             : out   std_logic_vector(191 downto 0); -- 6*32
        tag           : out   std_logic_vector(11 downto 0);  -- 6*2
        d             : out   std_logic_vector(767 downto 0); -- 6*128
        be            : out   std_logic_vector(95 downto 0)); -- 6*16
  end component;

  signal gtp_txd_flat      :   std_logic_vector(63 downto 0);
  signal gtp_rxd_flat      :   std_logic_vector(63 downto 0);
  signal valid_flat        :   std_logic_vector(5 downto 0);
  signal q_flat            :   std_logic_vector(767 downto 0);
  signal qtag_flat         :   std_logic_vector(11 downto 0);
  signal ready_flat        :   std_logic_vector(5 downto 0);
  signal req_flat          :   std_logic_vector(5 downto 0);
  signal ce_flat           :   std_logic_vector(5 downto 0);
  signal w_flat            :   std_logic_vector(5 downto 0);
  signal a_flat            :   std_logic_vector(191 downto 0);
  signal tag_flat          :   std_logic_vector(11 downto 0);
  signal d_flat            :   std_logic_vector(767 downto 0);
  signal be_flat           :   std_logic_vector(95 downto 0);

  signal debug : std_logic_vector(31 downto 0);

begin

  gtp_output : for i in 0 to 3 generate
  begin
    gtp_txd(i) <= gtp_txd_flat((i+1)*16-1 downto i*16);
  end generate;
  gtp_rxd_flat <= gtp_rxd(3)&gtp_rxd(2)&gtp_rxd(1)&gtp_rxd(0);

  valid_flat <= valid(5)&valid(4)&valid(3)&valid(3)&valid(1)&valid(0);
  q_flat <= q(5)&q(4)&q(3)&q(3)&q(1)&q(0);
  qtag_flat <= qtag(5)&qtag(4)&qtag(3)&qtag(3)&qtag(1)&qtag(0);
  ready_flat <= ready(5)&ready(4)&ready(3)&ready(3)&ready(1)&ready(0);
  mem_output : for i in 0 to 5 generate
  begin
    req(i) <= req_flat(i);
    ce(i)  <= ce_flat(i);
    w(i)   <= w_flat(i);
    a(i)   <= a_flat((i+1)*32-1 downto i*32);
    tag(i) <= tag_flat((i+1)*2-1 downto i*2);
    d(i)   <= d_flat((i+1)*128-1 downto i*128);
    be(i)  <= be_flat((i+1)*16-1 downto i*16);
  end generate;

  U0 : user_app_v
    port map (
        rst          => rst,
        clk          => clk,
        clk2x        => clk2x,
        reg_in       => reg_in,
        reg_wr       => reg_wr,
        reg_out      => reg_out,
        gtp_clk      => gtp_clk,
        gtp_rdy      => gtp_rdy,
        gtp_txd      => gtp_txd_flat,
        gtp_txk      => gtp_txk,
        gtp_rxd      => gtp_rxd_flat,
        gtp_rxk      => gtp_rxk,
        gtp_aligned  => gtp_aligned,
        valid        => valid_flat,
        q            => q_flat,
        qtag         => qtag_flat,
        ready        => ready_flat,
        req          => req_flat,
        ce           => ce_flat,
        w            => w_flat,
        a            => a_flat,
        tag          => tag_flat,
        d            => d_flat,
        be           => be_flat);

end architecture;
