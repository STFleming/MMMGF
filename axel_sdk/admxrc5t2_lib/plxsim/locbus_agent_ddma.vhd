--
-- locbus_agent_ddma.vhd - local bus agent for demand-mode DMA
--
-- (C) Copyright Alpha Data 2004-2005
--
-- NOT SYNTHESIZABLE
--
-- This module should be connected to the local bus demand-mode DMA pins.
-- The 'dd_in' and 'dd_out' ports are then driven by the 'plxsim_read_demand*'
-- and 'plxsim_write_demand*' routines in the PLXSIM package.
--

library ieee;
use ieee.std_logic_1164.all;

library plxsim;
use plxsim.plxsim.all;

entity locbus_agent_ddma is
    generic(
        tco_p2p    : time := 5 ns);
    port(
        -- These ports should be connected to the local bus demand-mode DMA pins
        ldreq_l    : in    std_logic;
        ldack_l    : out   std_logic;
        -- This ports are used by the stimulus process
        dd_in      : out   locbus_ddma_in_t;
        dd_out     : in    locbus_ddma_out_t);
end entity;

architecture simulation of locbus_agent_ddma is

begin

    dd_in.ldreq_l <= ldreq_l;

    ldack_l <= transport dd_out.ldack_l after tco_p2p;

end architecture;
