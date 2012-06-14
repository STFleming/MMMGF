--
-- mgt_stream.vhd - streaming data from MGT interface
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;

library work;
--use work.memif.all;
use work.admxrc5t2_common.all;
use work.user_defs.all;

entity mgt_stream is
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
        usr_rxrdy     : out  std_logic_vector(3 downto 0));
end entity;

architecture syn of mgt_stream is

  constant k_comma : std_logic_vector(15 downto 0) := X"3CBC";
  constant k_sof   : std_logic_vector(15 downto 0) := X"3C5C";
  constant k_eof   : std_logic_vector(15 downto 0) := X"3C9C";
  constant k_idle  : std_logic_vector(15 downto 0) := X"1C1C";

  type state_type is (ST_SYNC, ST_WAIT, ST_IDLE, ST_WORK);
  type state_array_type is array (natural range <>) of state_type;
  signal state : state_array_type(3 downto 0);
  type cnt_array_type is array (natural range <>) of std_logic_vector(3 downto 0);
  signal sync_cnt : cnt_array_type(3 downto 0);

begin

  usr_rxdat <= mgt_rxd;

  GEN_SIGNALS : for i in 0 to 3 generate

    U_CNT : process (mgt_clk)
    begin
      if rising_edge(mgt_clk) then
        if rst = '1' then
          sync_cnt(i) <= (others => '0');
        elsif state(i) = ST_IDLE then
          sync_cnt(i) <= sync_cnt(i) + 1;
        end if;
      end if;
    end process;

    U_FSM : process (mgt_clk)
    begin
      if rising_edge(mgt_clk) then
        if rst = '1' then
          state(i) <= ST_SYNC;
        elsif mgt_rdy = '1' then
          case state(i) is

            when ST_SYNC =>
              state(i) <= ST_WAIT;

            when ST_WAIT =>
              if mgt_aligned(i) = '1' then
                state(i) <= ST_IDLE;
              end if;

            when ST_IDLE =>
              if sync_cnt(i) = 15 then
                state(i) <= ST_WORK;
              end if;

            when ST_WORK =>
              if (mgt_rxk(i*2+1 downto i*2) = "11" and mgt_rxd(i) = k_comma) or
                 mgt_aligned(i) = '0' then
                state(i) <= ST_SYNC;
              end if;

          end case;

        end if;
      end if;
    end process;

    usr_txrdy(i) <= mgt_aligned(i) when state(i) = ST_WORK else '0';
    usr_rxrdy(i) <= mgt_aligned(i) and not mgt_rxk(i*2);

    mgt_txk(i*2+1 downto i*2) <= "00" when state(i) = ST_WORK and usr_txwen(i) = '1' else "11";
    mgt_txd(i) <= k_comma when state(i) = ST_SYNC or state(i) = ST_WAIT else
                  usr_txdat(i) when state(i) = ST_WORK and usr_txwen(i) = '1' else
                  k_idle;

  end generate;

end architecture;
