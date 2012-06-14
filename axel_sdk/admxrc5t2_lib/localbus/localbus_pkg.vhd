--
-- localbus_pkg.vhd - package "localbus"
--
-- SYNTHESIZABLE
--
-- Package of local bus components.
--

library ieee;
use ieee.std_logic_1164.all;

package localbus is

    -- Demand-mode DMA state machine
    component plxddsm
        port(
            clk              : in    std_logic;  -- Local bus clock
            rst              : in    std_logic;  -- Should reduce during synthesis to global reset
            sr               : in    std_logic;  -- Synchronous reset (do not assert unless bus is idle)
            qlads            : in    std_logic;  -- LADS# from local bus, qualified by address decoding and LDACK#
            lblast           : in    std_logic;  -- From local bus LBLAST# pin, active high
            lbterm           : in    std_logic;  -- From local bus LBTERM# pin, active high
            request          : in    std_logic;  -- Pulse to request demand-mode DMA cycle
            ready            : in    std_logic;  -- Must be same signal as fed to 'plxdssm' instance
            stop             : in    std_logic;  -- Must be same signal as fed to 'plxdssm' instance
            idle             : out   std_logic;  -- 0 => not responding to a demand-mode DMA local bus cycle
            ldreq_o_l        : out   std_logic); -- To LDREQ# local bus signal
    end component;

    -- Demand-mode DMA state machine
    component plxddsm2
        port(
            clk              : in    std_logic;  -- Local bus clock
            rst              : in    std_logic;  -- Should reduce during synthesis to global reset
            sr               : in    std_logic;  -- Synchronous reset (do not assert unless bus is idle)
            qlads            : in    std_logic;  -- LADS# from local bus, qualified by address decoding and LDACK#
            lblast           : in    std_logic;  -- From local bus LBLAST# pin, active high
            lbterm           : in    std_logic;  -- From local bus LBTERM# pin, active high
            lready           : in    std_logic;  -- From local bus LREADY# pin, active high
            request          : in    std_logic;  -- Hold asserted to request demand-mode DMA cycle
            burst            : in    std_logic;  -- Hold asserted to prevent pausing
            ready            : in    std_logic;  -- Must be same signal as fed to 'plxdssm' instance
            idle             : out   std_logic;  -- 0 => not responding to a demand-mode DMA local bus cycle
            ldreq_o_l        : out   std_logic); -- To LDREQ# local bus signal
    end component;

    -- Direct-master state machine
    component plxdmsm
        port(
            clk              : in    std_logic;  -- Local bus clock
            rst              : in    std_logic;  -- Asynchronous reset, should reduce to global reset
            sr               : in    std_logic;  -- Synchronous reset, must be asserted when bus idle
            request          : in    std_logic;  -- Pulse to request a direct-master cycle
            stop             : in    std_logic;  -- Pulse to terminate burst
            transfer         : out   std_logic;  -- Asserted 1 clock after data transfer takes place
            done             : out   std_logic;  -- Asserted when machine is idle
            write            : in    std_logic;  -- Assert coincident with 'request' for a write cycle
            lready           : in    std_logic;  -- LREADY# (PCI9656) or LREADYO# (PCI9080) signal, active high
            lbterm           : in    std_logic;  -- LBTERM# (PCI9656) or LBTERMO# (PCI9080) signal, active high
            fholda           : in    std_logic;  -- From local bus arbiter, FPGA's bus grant signal
            fhold            : out   std_logic;  -- To local bus arbiter, FPGA's bus request signal
            la_oe_l          : out   std_logic;  -- When asserted, app should enable LA pins
            lads_o_l         : out   std_logic;  -- To local bus LADS# pin
            lads_oe_l        : out   std_logic;  -- When asserted, app should enable LADS_L pin
            lbe_oe_l         : out   std_logic;  -- When asserted, app should enable LBE_L pins
            lblast_o_l       : out   std_logic;  -- To local bus LBLAST# pin
            lblast_oe_l      : out   std_logic;  -- When asserted, app should enable LBLAST_L pin
            eld_oe           : out   std_logic;  -- Early output enable for local bus data pins (active high)
            ld_oe_l          : out   std_logic;  -- Output enable for local bus data pins (active low)
            lwrite           : out   std_logic;  -- To local bus LWRITE pin
            lwrite_oe_l      : out   std_logic); -- When asserted, app should enable LWRITE pin
    end component;

    -- Direct-slave state machine
    component plxdssm
        port(
            clk              : in    std_logic;  -- Local bus clock
            rst              : in    std_logic;  -- Should reduce during synthesis to FPGA global reset
            sr               : in    std_logic;  -- Synchronous reset (should never be asserted mid-burst)
            qlads            : in    std_logic;  -- LADS# signal qualified by address, FHOLDA and/or other decoding
            lblast           : in    std_logic;  -- From local bus LBLAST# pin, active high
            lbterm           : in    std_logic;  -- From local bus LBTERM# pin, active high
            lwrite           : in    std_logic;  -- From local bus LWRITE pin
            eld_oe           : out   std_logic;  -- Early output enable for local bus data pins (active high)
            ld_oe_l          : out   std_logic;  -- Output enable for local bus data pins (active low)
            lready_o_l       : out   std_logic;  -- To local bus LREADY# signal
            lready_oe_l      : out   std_logic;  -- To local bus LREADY# signal
            lbterm_o_l       : out   std_logic;  -- To local bus LBTERM# signal
            lbterm_oe_l      : out   std_logic;  -- To local bus LBTERM# signal
            idle             : out   std_logic;  -- 0 => not responding to a local bus cycle
            transfer         : out   std_logic;  -- Data transfer on this clock edge
            decode           : out   std_logic;  -- Application should do further address decoding
            write            : out   std_logic;  -- 'lwrite' latched on 'qlads'
            ready            : in    std_logic;  -- Apply pulse when ready
            stop             : in    std_logic); -- Apply pulse to terminate burst
    end component;

end;
