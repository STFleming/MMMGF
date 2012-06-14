--
-- dpmem_pkg.vhd - dual-port FPGA-internal memory component package
--
-- SYNTHESIZABLE
--

library ieee;
use ieee.std_logic_1164.all;

package dpmem is

    --
    -- Type that represents a FPGA family
    --
    type family_t is (
        family_virtex,    -- Virtex/Virtex-E/Virtex-EM
        family_virtex2,   -- Virtex-II
        family_virtex2p,  -- Virtex-II Pro
        family_virtex4,   -- Virtex-4
        family_virtex5);  -- Virtex-5

    -- Convert a 'family_t' value to a string
    function conv_string(
        family : in family_t)
    return string;

    -- Number of bits in a BlockRAM, by FPGA family
    function blockram_data_size(
        family : in family_t)
    return natural;

    -- Returns 'true' if a particular width is valid for a particular FPGA family
    function blockram_is_valid_width(
        family : in family_t;
        width  : in natural)
    return boolean;

    -- Maximum depth configuration for a BlockRAM, by FPGA family
    function blockram_max_depth(
        family : in family_t)
    return natural;

    -- Minimum depth configuration for a BlockRAM, by FPGA family
    function blockram_min_depth(
        family : in family_t)
    return natural;

    -- Maximum width configuration for a BlockRAM, by FPGA family
    function blockram_max_data_width(
        family : in family_t)
    return natural;

    -- Minimum width configuration for a BlockRAM, by FPGA family
    function blockram_min_data_width(
        family : in family_t)
    return natural;

    -- Ratio of data bits to parity bits, by FPGA family
    function blockram_parity_ratio(
        family : in family_t)
    return natural;

    component dpbram
        generic(
            order0      : in  natural;          -- Number of address bits in port 0
            width0      : in  natural;          -- Data width of port 0
            order1      : in  natural;          -- Number of address bits in port 1
            width1      : in  natural;          -- Data width of port 1
            -- synopsys translate_off
            init        : in  std_logic_vector; -- initial contents of RAM
            -- synopsys translate_on
            family      : in  family_t;         -- FPGA family to target
            depth_waste : in  boolean);         -- If false, assertion failure if dimensions would "waste" part of BlockRAM
        port(
            rst : in  std_logic;
            k0  : in  std_logic;
            sr0 : in  std_logic;
            en0 : in  std_logic;
            w0  : in  std_logic;
            a0  : in  std_logic_vector(order0 - 1 downto 0);
            d0  : in  std_logic_vector(width0 - 1 downto 0);
            q0  : out std_logic_vector(width0 - 1 downto 0);
            k1  : in  std_logic;
            sr1 : in  std_logic;
            en1 : in  std_logic;
            w1  : in  std_logic;
            a1  : in  std_logic_vector(order1 - 1 downto 0);
            d1  : in  std_logic_vector(width1 - 1 downto 0);
            q1  : out std_logic_vector(width1 - 1 downto 0));
    end component;

    component dpbram0
        generic(
            order0      : in  natural;          -- Number of address bits in port 0
            width0      : in  natural;          -- Data width of port 0
            order1      : in  natural;          -- Number of address bits in port 1
            width1      : in  natural;          -- Data width of port 1
            -- synopsys translate_off
            init        : in  std_logic_vector; -- initial contents of RAM
            -- synopsys translate_on
            family      : in  family_t);        -- FPGA family to target
        port(
            rst : in  std_logic;
            k0  : in  std_logic;
            sr0 : in  std_logic;
            en0 : in  std_logic;
            w0  : in  std_logic;
            a0  : in  std_logic_vector(order0 - 1 downto 0);
            d0  : in  std_logic_vector(width0 - 1 downto 0);
            q0  : out std_logic_vector(width0 - 1 downto 0);
            k1  : in  std_logic;
            sr1 : in  std_logic;
            en1 : in  std_logic;
            w1  : in  std_logic;
            a1  : in  std_logic_vector(order1 - 1 downto 0);
            d1  : in  std_logic_vector(width1 - 1 downto 0);
            q1  : out std_logic_vector(width1 - 1 downto 0));
    end component;

    component distmem
        generic(
            order       : in  natural;          -- Number of address bits of ports
            width       : in  natural;          -- Data width of ports
            -- synopsys translate_off
            init        : in  std_logic_vector; -- initial contents of RAM
            -- synopsys translate_on
            family      : in  family_t);        -- FPGA family to target
        port(
            rst : in  std_logic;
            k0  : in  std_logic;
            sr0 : in  std_logic;
            en0 : in  std_logic;
            w0  : in  std_logic;
            a0  : in  std_logic_vector(order - 1 downto 0);
            d0  : in  std_logic_vector(width - 1 downto 0);
            q0  : out std_logic_vector(width - 1 downto 0);
            k1  : in  std_logic;
            sr1 : in  std_logic;
            en1 : in  std_logic;
            a1  : in  std_logic_vector(order - 1 downto 0);
            q1  : out std_logic_vector(width - 1 downto 0));
    end component;

    component distmem0
        generic(
            order       : in  natural;          -- number of address bits
            width       : in  natural;          -- width of port
            -- synopsys translate_off
            init        : in  std_logic_vector; -- initial contents of RAM
            -- synopsys translate_on
            family      : in  family_t);        -- FPGA family to target
        port(
            rst : in  std_logic;
            k0  : in  std_logic;
            sr0 : in  std_logic;
            en0 : in  std_logic;
            w0  : in  std_logic;
            a0  : in  std_logic_vector(order - 1 downto 0);
            d0  : in  std_logic_vector(width - 1 downto 0);
            q0  : out std_logic_vector(width - 1 downto 0);
            k1  : in  std_logic;
            sr1 : in  std_logic;
            en1 : in  std_logic;
            a1  : in  std_logic_vector(order - 1 downto 0);
            q1  : out std_logic_vector(width - 1 downto 0));
    end component;

end;

package body dpmem is

    function conv_string(
        family : in family_t)
    return string is
    begin
        case family is
            when family_virtex =>
                return "Virtex/-E/-EM";
            when family_virtex2 =>
                return "Virtex-II";
            when family_virtex2p =>
                return "Virtex-II Pro";
            when family_virtex4 =>
                return "Virtex-4";
            when family_virtex5 =>
                return "Virtex-5";
        end case;
    end;

    -- Number of bits in a BlockRAM, by FPGA family
    function blockram_data_size(
        family : in family_t)
    return natural is begin
        case family is
            when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                return 16384;
            when family_virtex =>
                return 4096;
        end case;
    end;

    -- Returns 'true' if a particular width is valid for a particular FPGA family
    function blockram_is_valid_width(
        family : in family_t;
        width  : in natural)
    return boolean is begin
        case family is
            when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                case width is
                    when 1 | 2 | 4 | 9 | 18 | 36 =>
                        return true;
                    when others =>
                        return false;
                end case;

            when family_virtex =>
                case width is
                    when 1 =>
                        return true;
                    when 2 =>
                        return true;
                    when 4 =>
                        return true;
                    when 8 =>
                        return true;
                    when 16 =>
                        return true;
                    when others =>
                        return false;
                end case;
        end case;
    end;

    -- Maximum depth configuration for a BlockRAM, by FPGA family
    function blockram_max_depth(
        family : in family_t)
    return natural is begin
        case family is
            when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                return 16384;

            when family_virtex =>
                return 4096;
        end case;
    end;

    -- Minimum depth configuration for a BlockRAM, by FPGA family
    function blockram_min_depth(
        family : in family_t)
    return natural is begin
        case family is
            when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                return 512;

            when family_virtex =>
                return 256;
        end case;
    end;

    -- Maximum width configuration for a BlockRAM, by FPGA family
    function blockram_max_data_width(
        family : in family_t)
    return natural is begin
        case family is
            when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                return 32;

            when family_virtex =>
                return 16;
        end case;
    end;

    -- Minimum width configuration for a BlockRAM, by FPGA family
    function blockram_min_data_width(
        family : in family_t)
    return natural is begin
        case family is
            when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                return 1;

            when family_virtex =>
                return 1;
        end case;
    end;

    -- Ratio of data bits to parity bits, by FPGA family
    function blockram_parity_ratio(
        family : in family_t)
    return natural is begin
        case family is
            when family_virtex2 | family_virtex2p | family_virtex4 | family_virtex5 =>
                -- Virtex-II and later have 8 data bits per parity bit in the 8, 9, 16,
                -- 18, 32 and 36 width configurations.
                return 8;

            when family_virtex =>
                -- This is an approximation to infinity, i.e. Virtex BlockRAMs do not
                -- have parity bits.
                return 2147483647;
        end case;
    end;

end;
