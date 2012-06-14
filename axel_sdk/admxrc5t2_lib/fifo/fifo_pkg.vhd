--
-- fifo_pkg.vhd - package of FIFO components
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;

package fifo is
  
    --
    -- Type that represents a FPGA family
    --
    type family_t is (
        family_virtex,    -- Virtex/Virtex-E/Virtex-EM
        family_virtex2,   -- Virtex-II
        family_virtex2p,  -- Virtex-II Pro
        family_virtex4,   -- Virtex-4
        family_virtex5);  -- Virtex-5

    function afifo_depth(
        constant order : in natural)
    return natural;

    function sfifo_depth(
        constant order : in natural)
    return natural;

    component afifo
        generic(
            width    : in  natural;
            order    : in  natural;
            wpfl     : in  natural;
            wpfl2    : in  natural;
            rpel     : in  natural;
            family   : in  family_t;
            safety   : in  boolean;
            fflush   : in  boolean);
        port(
            rst      : in  std_logic;
            wk       : in  std_logic;
            wd       : in  std_logic_vector(width - 1 downto 0);
            wadv     : in  std_logic;
            we       : out std_logic;
            wpf      : out std_logic;
            wpf2     : out std_logic;
            wf       : out std_logic;
            wovf     : out std_logic;
            wlevel   : out std_logic_vector(15 downto 0);
            rk       : in  std_logic;
            rq       : out std_logic_vector(width - 1 downto 0);
            radv     : in  std_logic;
            rflush   : in  std_logic;
            re       : out std_logic;
            rpe      : out std_logic;
            rf       : out std_logic;
            rudf     : out std_logic;
            rlevel   : out std_logic_vector(15 downto 0));
    end component;

    component sfifo
        generic(
            width    : in  natural;
            order    : in  natural;
            wpfl     : in  natural;
            rpel     : in  natural;
            family   : in  family_t;
            safety   : in  boolean);
        port(
            rst      : in  std_logic;
            k        : in  std_logic;
            wd       : in  std_logic_vector(width - 1 downto 0);
            wadv     : in  std_logic;
            we       : out std_logic;
            wpf      : out std_logic;
            wf       : out std_logic;
            wovf     : out std_logic;
            rq       : out std_logic_vector(width - 1 downto 0);
            radv     : in  std_logic;
            rflush   : in  std_logic;
            re       : out std_logic;
            rpe      : out std_logic;
            rf       : out std_logic;
            rudf     : out std_logic;
            rlevel   : out std_logic_vector(15 downto 0));
    end component;

    component sfifop is
        generic(
            width    : in  natural;    -- Width of FIFO
            order    : in  natural;    -- FIFO depth is (2 ** order)
            wpfl     : in  natural;    -- Programmable full level
            rpel     : in  natural;    -- Programmable empty level
            family   : in  family_t;   -- FPGA family to target
            safety   : in  boolean);   -- true => protect against illegal inputs (may be slower)
        port(
            rst      : in  std_logic;  -- Asynchronous reset
            k        : in  std_logic;  -- Reader side clock
            wd       : in  std_logic_vector(width - 1 downto 0); -- Write data
            wadv     : in  std_logic;  -- Write & advance pointer
            we       : out std_logic;  -- Writer side empty flag
            wpf      : out std_logic;  -- Writer side programmable full flag
            wf       : out std_logic;  -- Writer side full flag
            wovf     : out std_logic;  -- Writer side overflow flag
            rq       : out std_logic_vector(width - 1 downto 0); -- Read data
            radvt    : in  std_logic;  -- Read & advance read pointer temporarily
            radv     : in  std_logic;  -- Advance read pointer permanently
            rrev     : in  std_logic;  -- Revert temporary read pointer to permanent read pointer
            rflush   : in  std_logic;  -- Reader flush
            ret      : out std_logic;  -- Reader side temporary empty flag
            re       : out std_logic;  -- Reader side permanent empty flag
            rpet     : out std_logic;  -- Reader side temporary programmable empty flag
            rpe      : out std_logic;  -- Reader side permanent programmable empty flag
            rf       : out std_logic;  -- Reader side full flag
            rudf     : out std_logic;  -- Reader side underflow flag
            rlevelt  : out std_logic_vector(15 downto 0);  -- Number of occupied locations (temporary)
            rlevel   : out std_logic_vector(15 downto 0)); -- Number of occupied locations (permanent)
    end component;

end;

package body fifo is

    function afifo_depth(
        constant order : in natural)
    return natural is
    begin
        return 2**order - 1;
    end;

    function sfifo_depth(
        constant order : in natural)
    return natural is
    begin
        return 2**order;
    end;

end;
