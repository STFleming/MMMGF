--
-- arbiter_2.vhd - two-port arbiter for sharing a memory port between clients
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library work;
use work.memif.all;

-- synopsys translate_off
library std;
use std.textio.all;
-- synopsys translate_on

entity arbiter_2 is
    generic(
        registered    : in    boolean;  -- 'true' to register memory port outputs
        ready_delay   : in    natural;  -- Delay from deassertion of 'ready(x)' to deassertion of 'ce(x)'
        latency       : in    natural;  -- Maximum number of clocks to award a grant if other clients are requesting
        unfair        : in    boolean;  -- 'true' to favor a particular client
        bias          : in    natural;  -- If 'unfair' is 'true', specifies which client to favor
        a_width       : in    natural;  -- Address width
        d_width       : in    natural;  -- Data width
        tag_width     : in    natural); -- Tag width
    port(
        rst           : in    std_logic;
        clk           : in    std_logic;
        sr            : in    std_logic;
        -- Memory port interface
        ce            : out   std_logic;
        w             : out   std_logic;
        tag           : out   std_logic_vector(tag_width - 1 downto 0);
        a             : out   std_logic_vector(a_width - 1 downto 0);
        d             : out   std_logic_vector(d_width - 1 downto 0);
        be            : out   std_logic_vector(d_width / 8 - 1 downto 0);
        q             : in    std_logic_vector(d_width - 1 downto 0);
        qtag          : in    std_logic_vector(tag_width - 1 downto 0);
        valid         : in    std_logic;
        ready         : in    std_logic;
        -- Client 0 interface
        req0          : in    std_logic;
        ce0           : in    std_logic;
        w0            : in    std_logic;
        tag0          : in    std_logic_vector(tag_width - 1 downto 0);
        a0            : in    std_logic_vector(a_width - 1 downto 0);
        d0            : in    std_logic_vector(d_width - 1 downto 0);
        be0           : in    std_logic_vector(d_width / 8 - 1 downto 0);
        q0            : out   std_logic_vector(d_width - 1 downto 0);
        qtag0         : out   std_logic_vector(tag_width - 1 downto 0);
        valid0        : out   std_logic;
        ready0        : out   std_logic;
        -- Client 1 interface
        req1          : in    std_logic;
        ce1           : in    std_logic;
        w1            : in    std_logic;
        tag1          : in    std_logic_vector(tag_width - 1 downto 0);
        a1            : in    std_logic_vector(a_width - 1 downto 0);
        d1            : in    std_logic_vector(d_width - 1 downto 0);
        be1           : in    std_logic_vector(d_width / 8 - 1 downto 0);
        q1            : out   std_logic_vector(d_width - 1 downto 0);
        qtag1         : out   std_logic_vector(tag_width - 1 downto 0);
        valid1        : out   std_logic;
        ready1        : out   std_logic);
end entity;

architecture struct of arbiter_2 is

    signal req_null : std_logic;
    signal ce_null : std_logic;
    signal w_null : std_logic;
    signal tag_null : std_logic_vector(tag_width - 1 downto 0);
    signal a_null : std_logic_vector(a_width - 1 downto 0);
    signal d_null : std_logic_vector(d_width - 1 downto 0);
    signal be_null : std_logic_vector(d_width / 8 - 1 downto 0);

begin

    -- synopsys translate_off
    assert bias >= 0 and bias <= 1 report "arbiter_2 : invalid 'bias' parameter" severity failure;
    -- synopsys translate_on

    -- synopsys translate_off
    assert d_width mod 8 = 0 report "arbiter_2 : d_width not an integer multiple of 8" severity failure;
    -- synopsys translate_on

    req_null <= '0';
    ce_null <= '-';
    w_null <= '-';
    tag_null <= (others => '-');
    a_null <= (others => '-');
    d_null <= (others => '-');
    be_null <= (others => '-');

    U0 : arbiter_4
        generic map(
            registered => registered,
            ready_delay => ready_delay,
            latency => latency,
            unfair => unfair,
            bias => bias,
            a_width => a_width,
            d_width => d_width,
            tag_width => tag_width)
        port map(
            rst => rst,
            clk => clk,
            sr => sr,
            ce => ce,
            w => w,
            tag => tag,
            a => a,
            d => d,
            be => be,
            q => q,
            qtag => qtag,
            valid => valid,
            ready => ready,
            req0 => req0,
            ce0 => ce0,
            w0 => w0,
            tag0 => tag0,
            a0 => a0,
            d0 => d0,
            be0 => be0,
            q0 => q0,
            qtag0 => qtag0,
            valid0 => valid0,
            ready0 => ready0,
            req1 => req1,
            ce1 => ce1,
            w1 => w1,
            tag1 => tag1,
            a1 => a1,
            d1 => d1,
            be1 => be1,
            q1 => q1,
            qtag1 => qtag1,
            valid1 => valid1,
            ready1 => ready1,
            req2 => req_null,
            ce2 => ce_null,
            w2 => w_null,
            tag2 => tag_null,
            a2 => a_null,
            d2 => d_null,
            be2 => be_null,
            q2 => open,
            qtag2 => open,
            valid2 => open,
            ready2 => open,
            req3 => req_null,
            ce3 => ce_null,
            w3 => w_null,
            tag3 => tag_null,
            a3 => a_null,
            d3 => d_null,
            be3 => be_null,
            q3 => open,
            qtag3 => open,
            valid3 => open,
            ready3 => open);

end architecture;
