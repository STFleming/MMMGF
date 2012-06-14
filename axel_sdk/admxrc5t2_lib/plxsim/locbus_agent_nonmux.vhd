--
-- locbus_agent_nonmux.vhd - local bus agent for nonmultiplexed local bus
--
-- (C) Copyright Alpha Data 2004-2005
--
-- NOT SYNTHESIZABLE
--
-- This module should be connected to the local bus. The 'bus_in' and 'bus_out'
-- ports are then driven by the 'plxsim_read*' and 'plxsim_write*' routines in
-- the PLXSIM package.
--

library ieee;
use ieee.std_logic_1164.all;

library plxsim;
use plxsim.plxsim.all;

entity locbus_agent_nonmux is
    generic(
        tco_bussed : time := 5 ns;
        tco_p2p    : time := 5 ns);
    port(
        -- These ports should be connected to the local bus
        lreset_l : in    std_logic;
        lclk     : in    std_logic;
        la       : inout std_logic_vector(31 downto 2) := (others => 'Z');
        lads_l   : inout std_logic := 'Z';
        lbe_l    : inout std_logic_vector(3 downto 0) := (others => 'Z');
        lblast_l : inout std_logic := 'Z';
        lbterm_l : inout std_logic := 'Z';
        ld       : inout std_logic_vector(31 downto 0) := (others => 'Z');
        lready_l : inout std_logic := 'Z';
        lwrite   : inout std_logic := 'Z';
        -- These ports should be connected to the local bus arbiter
        lhold    : out   std_logic;
        lholda   : in    std_logic;
        -- This ports are used by the stimulus process
        bus_in   : out   locbus_in_t;
        bus_out  : in    locbus_out_t);
end entity;

architecture simulation of locbus_agent_nonmux is

    signal la_del : std_logic_vector(31 downto 0);
    signal ld_del : std_logic_vector(31 downto 0);
    signal lbe_del_l : std_logic_vector(3 downto 0);
    signal lads_del_l : std_logic;
    signal lblast_del_l : std_logic;
    signal lwrite_del : std_logic;
    signal lready_del_l : std_logic;
    signal lbterm_del_l : std_logic;
    signal lhold_del: std_logic;

begin

    bus_in.lreset_l <= lreset_l;
    bus_in.lclk <= lclk;
    bus_in.la <= la & "00";
    bus_in.lbe_l(3 downto 0) <= lbe_l;
    bus_in.lbe_l(7 downto 4) <= (others => '1');
    bus_in.lblast_l <= lblast_l;
    bus_in.lbterm_l <= lbterm_l;
    bus_in.ld(31 downto 0) <= ld;
    bus_in.ld(63 downto 32) <= (others => '0');
    bus_in.lready_l <= lready_l;
    bus_in.lwrite <= lwrite;
    bus_in.lholda <= lholda;

    la_del <= bus_out.la when bus_out.oe_la = '1' else (others => 'Z');
    la <= transport la_del(31 downto 2) after tco_bussed;
    ld_del <= bus_out.ld(31 downto 0) when bus_out.oe_ld = '1' else (others => 'Z');
    ld <= transport ld_del after tco_bussed;
    lbe_del_l <= bus_out.lbe_l(3 downto 0) when bus_out.oe_lbe = '1' else (others => 'Z');
    lbe_l <= transport lbe_del_l after tco_bussed;
    lads_del_l <= bus_out.lads_l when bus_out.oe_lads = '1' else 'Z';
    lads_l <= transport lads_del_l after tco_bussed;
    lblast_del_l <= bus_out.lblast_l when bus_out.oe_lblast = '1' else 'Z';
    lblast_l <= transport lblast_del_l after tco_bussed;
    lwrite_del <= bus_out.lwrite when bus_out.oe_lwrite = '1' else 'Z';
    lwrite <= transport lwrite_del after tco_bussed;
    lready_del_l <= bus_out.lready_l when bus_out.oe_lready = '1' else 'Z';
    lready_l <= transport lready_del_l after tco_bussed;
    lbterm_del_l <= bus_out.lbterm_l when bus_out.oe_lbterm = '1' else 'Z';
    lbterm_l <= transport lbterm_del_l after tco_bussed;
    lhold_del <= bus_out.lhold;
    lhold <= transport lhold_del after tco_p2p;

end architecture;
