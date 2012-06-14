-- tb.vhd
-- by Brittle 2009

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
Library XilinxCoreLib;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;
library work;
use work.admxrc5t2_common.all;
use work.user_defs.all;

ENTITY tb IS
END tb;

ARCHITECTURE sim of tb IS

  component user_app is
    port(
        rst           : in    std_logic;   -- Reset from memory clock domain
        clk           : in    std_logic;   -- Clock from memory clock domain
        reg_in        : in    std_logic_vector(63 downto 0);
        reg_wr        : in    std_logic_vector(255 downto 0); -- 256 bwe
        reg_out       : out   std_logic_vector(2047 downto 0); -- 256 bytes
        mgt_clk       : in    std_logic;
        mgt_rdy       : in    std_logic;   -- MGT clock stable
        mgt_txd       : out   mgt_data_t(3 downto 0);
        mgt_txk       : out   std_logic_vector(7 downto 0);
        mgt_rxd       : in    mgt_data_t(3 downto 0);
        mgt_rxk       : in    std_logic_vector(7 downto 0);
        mgt_aligned   : in    std_logic_vector(3 downto 0);
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

  constant clk_period : time := 10 ns;
  constant rst_period : time := 23 ns;
  constant sim_period : time := 11 us;

  signal tb_clk  : std_logic;
  signal tb_rst  : std_logic;
  signal tb_en   : std_logic;
  signal tb_start: std_logic;

  signal reg_in        : std_logic_vector(63 downto 0);
  signal reg_wr        : std_logic_vector(255 downto 0); -- 256 bwe
  signal reg_out       : std_logic_vector(2047 downto 0); -- 256 bytes
  signal mgt_clk       : std_logic;
  signal mgt_rdy       : std_logic;   -- MGT clock stable
  signal mgt_txd       : mgt_data_t(3 downto 0);
  signal mgt_txk       : std_logic_vector(7 downto 0);
  signal mgt_rxd       : mgt_data_t(3 downto 0);
  signal mgt_rxk       : std_logic_vector(7 downto 0);
  signal mgt_aligned   : std_logic_vector(3 downto 0);
  signal valid         : control_vector_t(max_num_bank - 1 downto 0);
  signal q             : data_vector_t(max_num_bank - 1 downto 0);
  signal qtag          : tag_vector_t(max_num_bank - 1 downto 0);
  signal ready         : control_vector_t(max_num_bank - 1 downto 0);
  signal req           : control_vector_t(max_num_bank - 1 downto 0);
  signal ce            : control_vector_t(max_num_bank - 1 downto 0);
  signal w             : control_vector_t(max_num_bank - 1 downto 0);
  signal a             : address_vector_t(max_num_bank - 1 downto 0);
  signal tag           : tag_vector_t(max_num_bank - 1 downto 0);
  signal d             : data_vector_t(max_num_bank - 1 downto 0);
  signal be            : be_vector_t(max_num_bank - 1 downto 0);


BEGIN

  U0: user_app
    port map (
      rst            => tb_rst        ,
      clk            => tb_clk        ,

      reg_in         => reg_in        ,
      reg_wr         => reg_wr        ,
      reg_out        => reg_out       ,

      mgt_clk        => mgt_clk       ,
      mgt_rdy        => mgt_rdy       ,
      mgt_txd        => mgt_txd       ,
      mgt_txk        => mgt_txk       ,
      mgt_rxd        => mgt_rxd       ,
      mgt_rxk        => mgt_rxk       ,
      mgt_aligned    => mgt_aligned   ,

      valid          => valid         ,
      q              => q             ,
      qtag           => qtag          ,
      ready          => ready         ,
      req            => req           ,
      ce             => ce            ,
      w              => w             ,
      a              => a             ,
      tag            => tag           ,
      d              => d             ,
      be             => be            );

    reg_wr(0) <= tb_start;

    q(0)(127 downto 32) <= (others => '0');
    process
    begin

      wait until rising_edge(tb_clk);

      ready(0) <= req(0);
      valid(0) <= ce(0);
      if ce(0) = '1' then
        q(0)(31 downto 0) <= a(0);
        qtag(0) <= tag(0);
      end if;

      ready(1) <= req(1);
      valid(1) <= '0';

    end process;

  ---------- ---------- ---------- ----------
  mgt_clk <= tb_clk;
  process
  begin
    mgt_rdy <= '0'; 
    mgt_aligned <= "0000"; 
    wait for rst_period + 33 ns; 
    mgt_rdy <= '1'; 
    wait for 33 ns;
    mgt_aligned <= "1001"; 
    wait;
  end process;

  process
  begin
    wait until rising_edge(mgt_clk);
    mgt_rxd(0) <= mgt_txd(3);
    mgt_rxk(1 downto 0) <= mgt_txk(7 downto 6);
    mgt_rxd(3) <= mgt_txd(0);
    mgt_rxk(7 downto 6) <= mgt_txk(1 downto 0);
  end process;

  ---------- ---------- ---------- ----------
  process
  begin
    tb_clk <= '0'; wait for clk_period/2;
    tb_clk <= '1'; wait for clk_period/2;
  end process;

  process
  begin
    tb_rst <= '1'; wait for rst_period; tb_rst <= '0'; wait;
  end process;
  tb_en <= not tb_rst;

  process
  begin
    tb_start <= '0'; wait for rst_period * 2;
    tb_start <= '1'; wait for clk_period;
    tb_start <= '0'; wait;
  end process;

  process
  begin
    wait for sim_period;
    assert false report "NONE. End of simulation." severity failure;
  end process;


END sim;
