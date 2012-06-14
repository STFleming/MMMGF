--
-- arbiter_4.vhd - four-port arbiter for sharing a memory port between clients
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

entity arbiter_4 is
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
        ready1        : out   std_logic;
        -- Client 2 interface
        req2          : in    std_logic;
        ce2           : in    std_logic;
        w2            : in    std_logic;
        tag2          : in    std_logic_vector(tag_width - 1 downto 0);
        a2            : in    std_logic_vector(a_width - 1 downto 0);
        d2            : in    std_logic_vector(d_width - 1 downto 0);
        be2           : in    std_logic_vector(d_width / 8 - 1 downto 0);
        q2            : out   std_logic_vector(d_width - 1 downto 0);
        qtag2         : out   std_logic_vector(tag_width - 1 downto 0);
        valid2        : out   std_logic;
        ready2        : out   std_logic;
        -- Client 3 interface
        req3          : in    std_logic;
        ce3           : in    std_logic;
        w3            : in    std_logic;
        tag3          : in    std_logic_vector(tag_width - 1 downto 0);
        a3            : in    std_logic_vector(a_width - 1 downto 0);
        d3            : in    std_logic_vector(d_width - 1 downto 0);
        be3           : in    std_logic_vector(d_width / 8 - 1 downto 0);
        q3            : out   std_logic_vector(d_width - 1 downto 0);
        qtag3         : out   std_logic_vector(tag_width - 1 downto 0);
        valid3        : out   std_logic;
        ready3        : out   std_logic);
end entity;

architecture rtl of arbiter_4 is

    -- Number of clients sharing the memory port
    constant num_client : natural := 4;

    --
    -- Given that client 'x' is requesting, and some or all of the other clients
    -- are also requesting, return '1' if client 'x' should win round-robin
    -- arbitration, or '0' if one of the other clients should win.
    --
    function is_rr_winner(
        x         : in natural;
        gnt       : in std_logic_vector(num_client - 1 downto 0);
        req       : in std_logic_vector(num_client - 1 downto 0))
    return std_logic is
        variable i : integer;
        variable winner : std_logic;
    begin
        winner := '1'; -- assume that client 'x' wins to begin win
        i := X;
        i := (i + num_client - 1) mod num_client;
        while gnt(i) /= '1' and i /= x loop
            if req(i) = '1' then
                winner := '0';
                exit;
            end if;
            i := (i + num_client - 1) mod num_client;
        end loop;
        return winner;
    end;

    signal req : std_logic_vector(num_client - 1 downto 0);
    -- Exactly one bit of 'gnt' must be asserted at all times
    signal gnt : std_logic_vector(num_client - 1 downto 0);
    signal winner : std_logic_vector(num_client - 1 downto 0);
    signal losers : std_logic_vector(num_client - 1 downto 0);

    signal gnt_q0, gnt_q1, gnt_q2, gnt_q3 : std_logic_vector(num_client - 1 downto 0);
    signal delayed_gnt : std_logic_vector(num_client - 1 downto 0);

    signal current_req : std_logic;
    signal can_relinquish : std_logic;

    signal timer_reset : std_logic;
    signal timer_expired : std_logic;
    signal timer : std_logic_vector(15 downto 0);

begin

    -- synopsys translate_off
    assert bias >= 0 and bias <= 3 report "arbiter_4 : invalid 'bias' parameter" severity failure;
    -- synopsys translate_on

    -- synopsys translate_off
    assert d_width mod 8 = 0 report "arbiter_4 : 'd_width' parameter not an integer multiple of 8" severity failure;
    -- synopsys translate_on

    -- synopsys translate_off
    assert ready_delay >= 0 and ready_delay <= 4 report "arbiter_4 : 'ready_delay' parameter out of range" severity failure;
    -- synopsys translate_on

    req(0) <= req0;
    req(1) <= req1;
    req(2) <= req2;
    req(3) <= req3;

    --
    -- Figure out which client gets the grant in this cycle.
    --

    -- 'true' if client that is currently granted has its request asserted
    current_req <= OR_reduce(req and gnt);

    -- 'true' if can reliniquish grant to currently granted client
    can_relinquish <= timer_expired or not current_req;

    select_winner : process(
        gnt,
        req,
        can_relinquish)
    begin
        if unfair then
            if bias = 0 then
                -- Favor client 0, clients 1, 2 & 3 operate round-robin
                winner(0) <= req(0);
                winner(1) <= req(1) and not req(0) and can_relinquish and is_rr_winner(1, gnt, req and "1110");
                winner(2) <= req(2) and not req(0) and can_relinquish and is_rr_winner(2, gnt, req and "1110");
                winner(3) <= req(3) and not req(0) and can_relinquish and is_rr_winner(3, gnt, req and "1110");
            elsif bias = 1 then
                -- Favor client 1, clients 0, 2 and 3 operate round-robin
                winner(0) <= req(0) and not req(1) and can_relinquish and req(0) and is_rr_winner(0, gnt, req and "1101");
                winner(1) <= req(1);
                winner(2) <= req(2) and not req(1) and can_relinquish and req(2) and is_rr_winner(2, gnt, req and "1101");
                winner(3) <= req(3) and not req(1) and can_relinquish and req(3) and is_rr_winner(3, gnt, req and "1101");
            elsif bias = 2 then
                -- Favor client 2, clients 0, 1 & 3 operate round-robin
                winner(0) <= req(0) and not req(2) and can_relinquish and req(0) and is_rr_winner(0, gnt, req and "1011");
                winner(1) <= req(1) and not req(2) and can_relinquish and req(1) and is_rr_winner(1, gnt, req and "1011");
                winner(2) <= req(2);
                winner(3) <= req(3) and not req(2) and can_relinquish and req(3) and is_rr_winner(3, gnt, req and "1011");
            elsif bias = 3 then
                -- Favor client 3, clients 0, 1 & 2 operate round-robin
                winner(0) <= req(0) and not req(3) and can_relinquish and req(0) and is_rr_winner(0, gnt, req and "0111");
                winner(1) <= req(1) and not req(3) and can_relinquish and req(1) and is_rr_winner(1, gnt, req and "0111");
                winner(2) <= req(2) and not req(3) and can_relinquish and req(2) and is_rr_winner(2, gnt, req and "0111");
                winner(3) <= req(3);
            else
                winner <= (others => '-');
            end if;
        else
            -- Favor no client, operate in round-robin mode for all clients
            winner(0) <= req(0) and can_relinquish and is_rr_winner(0, gnt, req);
            winner(1) <= req(1) and can_relinquish and is_rr_winner(1, gnt, req);
            winner(2) <= req(2) and can_relinquish and is_rr_winner(2, gnt, req);
            winner(3) <= req(3) and can_relinquish and is_rr_winner(3, gnt, req);
        end if;
    end process;

    --
    -- Generate the one-hot grant vector; one bit of 'gnt' must be set at all times
    --

    losers(0) <= winner(1) or winner(2) or winner(3);
    losers(1) <= winner(0) or winner(2) or winner(3);
    losers(2) <= winner(0) or winner(1) or winner(3);
    losers(3) <= winner(0) or winner(1) or winner(2);

    gen_gnt : process(rst, clk)
        variable init : std_logic_vector(num_client - 1 downto 0);
    begin
        if rst = '1' then
            if unfair then
                for i in 0 to num_client - 1 loop
                   if i = bias then
                       init(i) := '1';
                   else
                       init(i) := '0';
                   end if;
                end loop;
            else
                init := EXT("01", num_client);
            end if;
            gnt <= init;
            gnt_q0 <= init;
            gnt_q1 <= init;
            gnt_q2 <= init;
            gnt_q3 <= init;
        elsif clk'event and clk = '1' then
            if sr = '1' then
                if unfair then
                    for i in 0 to num_client - 1 loop
                       if i = bias then
                           init(i) := '1';
                       else
                           init(i) := '0';
                       end if;
                    end loop;
                else
                    init := EXT("01", num_client);
                end if;
                gnt <= init;
                gnt_q0 <= init;
                gnt_q1 <= init;
                gnt_q2 <= init;
                gnt_q3 <= init;
            else
                gnt <= (gnt or winner) and not losers;
                gnt_q0 <= gnt;
                gnt_q1 <= gnt_q0;
                gnt_q2 <= gnt_q1;
                gnt_q3 <= gnt_q2;
            end if;
        end if;
    end process;

    -- synopsys translate_off
    check_gnt : process(rst, clk)
        variable n : natural;
    begin
        if rst = '1' then
            null;
        elsif clk'event and clk = '1' then
            if sr = '1' then
                null;
            else
                -- Debug only
                n := 0;
                for i in 0 to num_client - 1 loop
                    if gnt(i) = '1' then
                        n := n + 1;
                    end if;
                end loop;
                assert not (n < 1) report "arbiter_4 : no client granted" severity warning;
                assert not (n > 1) report "arbiter_4 : more than one client granted" severity warning;
            end if;
        end if;
    end process;
    -- synopsys translate_on

    --
    -- Implement the latency timer
    --

    -- Reset the latency timer if 'gnt' is changing in this cycle
    timer_reset <= OR_reduce(winner and not gnt);

    latency_timer : process(rst, clk)
    begin
        if rst = '1' then
            timer <= (others => '-');
            timer_expired <= '1';
        elsif clk'event and clk = '1' then
            if sr = '1' then
                timer <= (others => '-');
                timer_expired <= '1';
            else
                if latency = 0 then
                    timer_expired <= '1';
                    timer <= (others => '-');
                else
                    if timer_reset = '1' then
                        timer <= CONV_STD_LOGIC_VECTOR(latency - 1, timer'length);
                    else
                        if timer_expired = '0' then
                            timer <= timer - 1;
                            if AND_reduce(timer) = '0' then
                                timer_expired <= '1';
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    --
    -- Generate the outputs to the memory port
    --

    delayed_gnt <= gnt    when ready_delay = 0 else
                   gnt_q0 when ready_delay = 1 else
                   gnt_q1 when ready_delay = 2 else
                   gnt_q2 when ready_delay = 3 else
                   gnt_q3;

    mux_reg : if registered generate
        -- Multiplex the clients onto the memory port
        mux_ce : process(rst, clk)
        begin
            if rst = '1' then
                ce <= '0';
            elsif clk'event and clk = '1' then
                if sr = '1' then
                    ce <= '0';
                else
                    ce <= OR_reduce((ce3 & ce2 & ce1 & ce0) and delayed_gnt);
                end if;
            end if;
        end process;

        mux_other : process(clk)
        begin
            if clk'event and clk = '1' then
                w <= OR_reduce((w3 & w2 & w1 & w0) and delayed_gnt);
                for i in tag'range loop
                    tag(i) <= OR_reduce((tag3(i) & tag2(i) & tag1(i) & tag0(i)) and delayed_gnt);
                end loop;
                for i in a'range loop
                    a(i) <= OR_reduce((a3(i) & a2(i) & a1(i) & a0(i)) and delayed_gnt);
                end loop;
                for i in d'range loop
                    d(i) <= OR_reduce((d3(i) & d2(i) & d1(i) & d0(i)) and delayed_gnt);
                end loop;
                for i in be'range loop
                    be(i) <= OR_reduce((be3(i) & be2(i) & be1(i) & be0(i)) and delayed_gnt);
                end loop;
            end if;
        end process;
    end generate;

    mux_unreg : if not registered generate
        -- Multiplex the clients onto the memory port
        multiplex_in : process(
            gnt,
            ce0, w0, tag0, a0, d0, be0,
            ce1, w1, tag1, a1, d1, be1,
            ce2, w2, tag2, a2, d2, be2,
            ce3, w3, tag3, a3, d3, be3)
        begin
            ce <= OR_reduce((ce3 & ce2 & ce1 & ce0) and delayed_gnt);
            w <= OR_reduce((w3 & w2 & w1 & w0) and delayed_gnt);
            for i in tag'range loop
                tag(i) <= OR_reduce((tag3(i) & tag2(i) & tag1(i) & tag0(i)) and delayed_gnt);
            end loop;
            for i in a'range loop
                a(i) <= OR_reduce((a3(i) & a2(i) & a1(i) & a0(i)) and delayed_gnt);
            end loop;
            for i in d'range loop
                d(i) <= OR_reduce((d3(i) & d2(i) & d1(i) & d0(i)) and delayed_gnt);
            end loop;
            for i in be'range loop
                be(i) <= OR_reduce((be3(i) & be2(i) & be1(i) & be0(i)) and delayed_gnt);
            end loop;
        end process;
    end generate;

    --
    -- Propagate the memory port outputs to each of the clients
    --

    q0 <= q;
    q1 <= q;
    q2 <= q;
    q3 <= q;
    valid0 <= valid;
    valid1 <= valid;
    valid2 <= valid;
    valid3 <= valid;
    qtag0 <= qtag;
    qtag1 <= qtag;
    qtag2 <= qtag;
    qtag3 <= qtag;
    ready0 <= ready and gnt(0);
    ready1 <= ready and gnt(1);
    ready2 <= ready and gnt(2);
    ready3 <= ready and gnt(3);

end architecture;
