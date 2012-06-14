--
-- locbus_arb.vhd - arbiter for local bus agents
--
-- (C) Copyright Alpha Data 2004-2005
--
-- NOT SYNTHESIZABLE
--
-- The algorithm used is fair but prioritised. All agents of the same priority
-- get an equal chance to use the bus. However, an agent of a given priority is
-- will ALWAYS be given access to the bus in preference to an agent of lower
-- priority.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

library plxsim;
use plxsim.plxsim.all;

entity locbus_arb is
    generic(
        tco_p2p  : in    time := 5 ns;
        n_arb    : in    natural;
        priority : in    integer_vector_t);
    port(
        lreset_l : in    std_logic;
        lclk     : in    std_logic;
        lhold    : in    std_logic_vector(n_arb - 1 downto 0);
        lholda   : out   std_logic_vector(n_arb - 1 downto 0));
end entity;

architecture simulation of locbus_arb is

    type natural_vector_t is array(natural range <>) of natural;

    type agent_t is record
        index     : natural; -- index of this agent
        priority  : natural; -- priority of this agent
        num_peer  : natural; -- number of agents at same priority
        peers     : natural_vector_t(0 to n_arb - 2); -- indices of agents of same priority
    end record;
    type agent_array_t is array(natural range <>) of agent_t;

    constant prio_safe : integer_vector_t(0 to n_arb - 1) := priority;

    --
    -- Generate the array of agent data structures; used when deciding to whom
    -- the bus grant should be awarded.
    --
    function generate_agents
    return agent_array_t is
        variable agents : agent_array_t(0 to n_arb - 1);
        variable tmp1, tmp2 : agent_t;
        variable np : natural;
    begin
        for i in 0 to n_arb - 1 loop
            -- Find all agents of the same priority as agent 'i'
            agents(i).index := i;
            agents(i).priority := prio_safe(i);
            np := 0;
            for j in 0 to n_arb - 1 loop
                if i /= j and prio_safe(i) = prio_safe(j) then
                    agents(i).peers(np) := j;
                    np := np + 1;
                end if;
            end loop;
            agents(i).num_peer := np;
        end loop;

        -- Bubble-sort the agents in order of decreasing priority
        for i in 0 to n_arb - 2 loop
            for j in i + 1 to n_arb - 1 loop
                tmp2 := agents(j);
                if tmp2.priority > agents(i).priority then
                    agents(j) := agents(i);
                    agents(i) := tmp2;
                end if;
            end loop;
        end loop;

        return agents;
    end;

    constant agents : agent_array_t(0 to n_arb - 1) := generate_agents;

    type state_t is (s_idle, s_holda);
    signal state, n_state : state_t;
    signal i_lholda, n_lholda : std_logic_vector(n_arb - 1 downto 0);
    signal current, n_current : natural; -- Index of agent that currently is on the bus
    signal timestamp, n_timestamp : natural; -- Timestamp of current bus tenure
    -- Array of timestamps, one per agent, of that each agent's last bus tenure
    signal timestamps, n_timestamps : natural_vector_t(0 to n_arb - 1);

    --
    -- Determine to whom the bus grant should be awarded next; uses the current set
    -- of 'lhold' signals and the set of timestamps.
    --
    function choose_agent(
        lhold       : in std_logic_vector;
        timestamps  : in natural_vector_t)
    return natural is
        variable best_candidate : natural;
        variable agent : agent_t;
        variable index, index_j : natural;
        variable np : natural;
        variable ts : natural;
        variable best : boolean;
    begin
        for i in 0 to n_arb - 1 loop
            agent := agents(i);
            index := agent.index;
            np := agent.num_peer;
            ts := timestamps(index);
            if lhold(index) = '1' then
                best := true;
                for j in 0 to np - 1 loop
                    index_j := agents(j).index;
                    if lhold(index_j) = '1' and timestamps(index_j) < ts then
                        best := false;
                    end if;
                end loop;
                if best then
                    return index;
                end if;
            end if;
        end loop;

        -- We should never get here.
        assert false report "*** locbus_arb: choose_agent failed to determine the next agent!" severity failure;
        return 0;
    end;

begin

    lholda <= transport i_lholda after tco_p2p;

    gen_i_lholda : process(lreset_l, lclk)
    begin
        if lreset_l = '0' then
            state <= s_idle;
            current <= 0;
            i_lholda <= (others => '0');
            timestamp <= 0;
            timestamps <= (others => 0);
        elsif lclk'event and lclk = '1' then
            state <= n_state;
            current <= n_current;
            i_lholda <= n_lholda;
            timestamp <= n_timestamp;
            timestamps <= n_timestamps;
        end if;
    end process;

    gen_n_lholda : process(
        state,
        lhold,
        current,
        timestamp,
        timestamps)
        variable idx : natural;
        variable x : std_logic_vector(n_arb - 1 downto 0);
        variable y : natural_vector_t(n_arb - 1 downto 0);
    begin
        case state is
            when s_idle =>
                if OR_reduce(lhold) = '1' then
                    n_state <= s_holda;
                    idx := choose_agent(lhold, timestamps);
                    n_current <= idx;
                    x := (others => '0');
                    x(idx) := '1';
                    n_lholda <= x;
                    y := timestamps;
                    y(idx) := timestamp;
                    if timestamp < 999 then
                        n_timestamp <= timestamp + 1;
                    else
                        n_timestamp <= 0;
                    end if;
                    n_timestamps <= y;
                else
                    n_state <= s_idle;
                    n_current <= 0;
                    n_lholda <= (others => '0');
                    n_timestamp <= timestamp;
                    n_timestamps <= timestamps;
                end if;

            when s_holda =>
                if lhold(current) = '0' then
                    if OR_reduce(lhold) = '1' then
                        n_state <= s_holda;
                        idx := choose_agent(lhold, timestamps);
                        n_current <= idx;
                        x := (others => '0');
                        x(idx) := '1';
                        n_lholda <= x;
                        y := timestamps;
                        y(idx) := timestamp;
                        if timestamp < 999 then
                            n_timestamp <= timestamp + 1;
                        else
                            n_timestamp <= 0;
                        end if;
                        n_timestamps <= y;
                    else
                        n_state <= s_idle;
                        n_current <= 0;
                        n_lholda <= (others => '0');
                        n_timestamp <= timestamp;
                        n_timestamps <= timestamps;
                    end if;
                else
                    n_state <= s_holda;
                    n_current <= current;
                    n_lholda <= i_lholda;
                    n_timestamp <= timestamp;
                    n_timestamps <= timestamps;
                end if;
        end case;
    end process;

end architecture;
