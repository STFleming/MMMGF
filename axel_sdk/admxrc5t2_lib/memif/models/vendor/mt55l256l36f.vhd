-----------------------------------------------------------------------------------------
--
--     File Name:  MT55L256L36F.VHD
--       Version:  1.2
--          Date:  February 15th, 1999
--         Model:  BUS Functional
--     Simulator:  Model Technology VPLUS (PC version 4.7i)
--
--        Author:  Son P. Huynh
--         Email:  sphuynh@micron.com
--         Phone:  (208) 368-3825
--       Company:  Micron Technology, Inc.
--         Model:  MT55L256L36F (256K x 36)
--          Mode:  Flow-Through
--
--   Description:  ZBT SRAM VHDL model
--
--    Limitation:  None
--
--    Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY
--                 WHATSOEVER AND MICRON SPECIFICALLY DISCLAIMS ANY
--                 IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
--                 A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
--
--                 Copyright (c) 1997 Micron Semiconductor Products, Inc.
--                 All rights researved
--
--  Rev  Author          Phone         Date        Changes
--  ---  ----------------------------  ----------  --------------------------------------
--  1.2  Son Huynh       208-368-3825  02/15/1999  Fix hold timing check
--       Micron Technology, Inc.
-----------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_misc.all;

--LIBRARY work;
--    USE work.mti_pkg.all;

ENTITY mt55l256l36f IS
    GENERIC (
        addr_bits : INTEGER := 18;
        data_bits : INTEGER := 36;
        init      : std_logic := 'X';
        -- Timing parameter for -10 device
        t_KHKH    : TIME    := 10.0 ns;
        t_KHKL    : TIME    :=  3.0 ns;
        t_KLKH    : TIME    :=  3.0 ns;
        t_KHQZ    : TIME    :=  5.0 ns;
        t_AVKH    : TIME    :=  2.0 ns;
        t_EVKH    : TIME    :=  2.0 ns;
        t_CVKH    : TIME    :=  2.0 ns;
        t_DVKH    : TIME    :=  2.0 ns;
        t_KHAX    : TIME    :=  0.5 ns;
        t_KHEX    : TIME    :=  0.5 ns;
        t_KHCX    : TIME    :=  0.5 ns;
        t_KHDX    : TIME    :=  0.5 ns);
    PORT (
        Dq    : INOUT STD_LOGIC_VECTOR (data_bits - 1 DOWNTO 0);  -- Data I/O
        Addr  : IN    STD_LOGIC_VECTOR (addr_bits - 1 DOWNTO 0);  -- Address
        Lbo_n : IN    STD_LOGIC;                                  -- Burst Mode
        Clk   : IN    STD_LOGIC;                                  -- Clk
        Cke_n : IN    STD_LOGIC;                                  -- Cke#
        Ld_n  : IN    STD_LOGIC;                                  -- Adv/Ld#
        Bwa_n : IN    STD_LOGIC;                                  -- Bwa#
        Bwb_n : IN    STD_LOGIC;                                  -- BWb#
        Bwc_n : IN    STD_LOGIC;                                  -- Bwc#
        Bwd_n : IN    STD_LOGIC;                                  -- BWd#
        Rw_n  : IN    STD_LOGIC;                                  -- RW#
        Oe_n  : IN    STD_LOGIC;                                  -- OE# - Output Enable
        Ce_n  : IN    STD_LOGIC;                                  -- CE#
        Ce2_n : IN    STD_LOGIC;                                  -- CE2#
        Ce2   : IN    STD_LOGIC;                                  -- CE2
        Zz    : IN    STD_LOGIC                                   -- Snooze Mode
    );
END mt55l256l36f;

ARCHITECTURE behave OF mt55l256l36f IS
    CONSTANT lane : integer := data_bits / 4;

    SIGNAL addr_in, addr_out : STD_LOGIC_VECTOR (addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL bwa_in, bwb_in, bwc_in, bwd_in, ce, ce_in, rw_in : STD_LOGIC := '0';
    SIGNAL bcount : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL addr1 : INTEGER := 0;
    SIGNAL dout : STD_LOGIC_VECTOR (data_bits - 1 DOWNTO 0) := (OTHERS => 'Z');
BEGIN

    ce <= NOT(Ce_n) AND NOT(Ce2_n) AND Ce2;

    -- Decode Burst Address
    addr_out(addr_bits - 1 DOWNTO 2) <= addr_in(addr_bits - 1 DOWNTO 2);
    WITH Lbo_n SELECT
        addr_out(1) <= bcount(1) XOR addr_in(1) WHEN '1',
                       bcount(1)                WHEN OTHERS;
    WITH Lbo_n SELECT
        addr_out(0) <= bcount(0) XOR addr_in(0) WHEN '1',
                       bcount(0)                WHEN OTHERS;

    addr1 <= CONV_INTEGER("0" & addr_out);

    -- Output Buffers
    WITH (ce_in AND rw_in AND NOT(oe_n) AND NOT(Zz)) SELECT
        dq <= TRANSPORT dout            AFTER t_KHQZ WHEN '1',
                        (OTHERS => 'Z') AFTER t_KHQZ WHEN OTHERS;

    -- Main Program
    main : PROCESS
        TYPE mem_array IS ARRAY ((2**addr_bits) - 1 DOWNTO 0) OF STD_LOGIC_VECTOR(lane - 1 DOWNTO 0);
        VARIABLE ram0 : mem_array := (others => (others => init));
        VARIABLE ram1 : mem_array := (others => (others => init));
        VARIABLE ram2 : mem_array := (others => (others => init));
        VARIABLE ram3 : mem_array := (others => (others => init));
    BEGIN
        WAIT ON Clk;
            IF Clk'EVENT AND Clk = '1' THEN
                IF Cke_n = '0' AND Zz = '0' THEN
                    -- Write Registry and Data Coherency Control Logic
                    bwa_in <= Bwa_n;
                    bwb_in <= Bwb_n;
                    bwc_in <= Bwc_n;
                    bwd_in <= Bwd_n;

                    -- Read Logic
                    IF Ld_n = '0' THEN
                        ce_in <= ce;
                        rw_in <= NOT(ce AND NOT(Rw_n));
                    END IF;

                    -- Capture Address Register
                    IF Ld_n = '0' and ce = '1' THEN
                        addr_in(addr_bits - 1 DOWNTO 0) <= Addr(addr_bits - 1 DOWNTO 0);
                    END IF;

                    -- Burst Logic Decode
                    IF    Lbo_n = '1' AND Ld_n = '0' THEN
                        bcount (1 DOWNTO 0) <= "00";
                    ELSIF Lbo_n = '0' AND Ld_n = '0' THEN
                        bcount (1 DOWNTO 0) <= Addr (1 DOWNTO 0);
                    ELSIF                 Ld_n = '1' THEN
                        bcount (0) <= NOT(bcount(0));
                        bcount (1) <= bcount(1) XOR bcount(0);
                    END IF;

                    -- Write Data to Memory
                    IF rw_in = '0' AND bwa_in = '0' THEN
                        ram0(addr1) := Dq (1 * lane - 1 DOWNTO 0 * lane);
                    END IF;
                    IF rw_in = '0' AND bwb_in = '0' THEN
                        ram1(addr1) := Dq (2 * lane - 1 DOWNTO 1 * lane);
                    END IF;
                    IF rw_in = '0' AND bwc_in = '0' THEN
                        ram2(addr1) := Dq (3 * lane - 1 DOWNTO 2 * lane);
                    END IF;
                    IF rw_in = '0' AND bwd_in = '0' THEN
                        ram3(addr1) := Dq (4 * lane - 1 DOWNTO 3 * lane);
                    END IF;
                END IF;

                -- Read Data from Memory
                WAIT FOR 100 ps;
                Dout (1 * lane - 1 DOWNTO 0 * lane) <= ram0(addr1);
                Dout (2 * lane - 1 DOWNTO 1 * lane) <= ram1(addr1);
                Dout (3 * lane - 1 DOWNTO 2 * lane) <= ram2(addr1);
                Dout (4 * lane - 1 DOWNTO 3 * lane) <= ram3(addr1);
            END IF;
    END PROCESS;

    -- Check for Clock Timing Violation
    clk_check : PROCESS
        VARIABLE clk_high, clk_low : TIME := 0 ns;
    BEGIN
        WAIT ON Clk;
            IF Clk = '1' AND NOW /= 0 ns THEN
                ASSERT (NOW - clk_low >= t_KHKL)
                    REPORT "Clk width low - t_KHKL violation"
                    SEVERITY ERROR;
                ASSERT (NOW - clk_high >= t_KHKH)
                    REPORT "Clk period high - t_KHKH violation"
                    SEVERITY ERROR;
                clk_high := NOW;
            ELSIF Clk = '0' AND NOW /= 0 ns THEN
                ASSERT (NOW - clk_high >= t_KLKH)
                    REPORT "Clk width high - t_KLKH violation"
                    SEVERITY ERROR;
                ASSERT (NOW - clk_low >= t_KHKH)
                    REPORT "Clk period low - t_KHKH violation"
                    SEVERITY ERROR;
                clk_low := NOW;
            END IF;
    END PROCESS;

    -- Check for Setup Timing Violation
    setup_check : PROCESS
    BEGIN
        WAIT ON Clk;
        IF Clk = '1' THEN
            ASSERT (Addr'LAST_EVENT >= t_AVKH)
                REPORT "Address - t_AVKH violation"
                SEVERITY ERROR;
            ASSERT (Cke_n'LAST_EVENT >= t_EVKH)
                REPORT "CKE# - t_EVKH violation"
                SEVERITY ERROR;
            ASSERT (Ce_n'LAST_EVENT >= t_CVKH)
                REPORT "CE# - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Ce2_n'LAST_EVENT >= t_CVKH)
                REPORT "CE2# - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Ce2'LAST_EVENT >= t_CVKH)
                REPORT "CE2 - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Ld_n'LAST_EVENT >= t_CVKH)
                REPORT "ADV/LD# - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Rw_n'LAST_EVENT >= t_CVKH)
                REPORT "RW# - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Bwa_n'LAST_EVENT >= t_CVKH)
                REPORT "BWa# - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Bwb_n'LAST_EVENT >= t_CVKH)
                REPORT "BWb# - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Bwc_n'LAST_EVENT >= t_CVKH)
                REPORT "BWc# - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Bwd_n'LAST_EVENT >= t_CVKH)
                REPORT "BWd# - t_CVKH violation"
                SEVERITY ERROR;
            ASSERT (Dq'LAST_EVENT >= t_DVKH)
                REPORT "Dq - t_DVKH violation"
                SEVERITY ERROR;
        END IF;
    END PROCESS;

    -- Check for Hold Timing Violation
    hold_check : PROCESS
    BEGIN
        WAIT ON Clk'DELAYED(t_KHAX), Clk'DELAYED(t_KHEX), Clk'DELAYED(t_KHCX), Clk'DELAYED(t_KHDX);
        IF Clk'DELAYED(t_KHAX) = '1' THEN
            ASSERT (Addr'LAST_EVENT > t_KHAX)
                REPORT "Address - t_KHAX violation"
                SEVERITY ERROR;
        END IF;
        IF Clk'DELAYED(t_KHEX) = '1' THEN
            ASSERT (Cke_n'LAST_EVENT > t_KHEX)
                REPORT "CKE# - t_KHEX violation"
                SEVERITY ERROR;
        END IF;
        IF Clk'DELAYED(t_KHCX) = '1' THEN
            ASSERT (Ce_n'LAST_EVENT > t_KHCX)
                REPORT "CE# - t_KHCX violation"
                SEVERITY ERROR;
            ASSERT (Ce2_n'LAST_EVENT > t_KHCX)
                REPORT "CE2# - t_KHCX violation"
                SEVERITY ERROR;
            ASSERT (Ce2'LAST_EVENT > t_KHCX)
                REPORT "CE2 - t_KHCX violation"
                SEVERITY ERROR;
            ASSERT (Ld_n'LAST_EVENT > t_KHCX)
                REPORT "ADV/LD# - t_KHCX violation"
                SEVERITY ERROR;
            ASSERT (Rw_n'LAST_EVENT > t_KHCX)
                REPORT "RW# - t_KHCX violation"
                SEVERITY ERROR;
            ASSERT (Bwa_n'LAST_EVENT > t_KHCX)
                REPORT "BWa# - t_KHCX violation"
                SEVERITY ERROR;
            ASSERT (Bwb_n'LAST_EVENT > t_KHCX)
                REPORT "BWb# - t_KHCX violation"
                SEVERITY ERROR;
            ASSERT (Bwc_n'LAST_EVENT > t_KHCX)
                REPORT "BWc# - t_KHCX violation"
                SEVERITY ERROR;
            ASSERT (Bwd_n'LAST_EVENT > t_KHCX)
                REPORT "BWd# - t_KHCX violation"
                SEVERITY ERROR;
        END IF;
        IF Clk'DELAYED(t_KHDX) = '1' THEN
            ASSERT (Dq'LAST_EVENT > t_KHDX)
                REPORT "Dq - t_KHDX violation"
                SEVERITY ERROR;
        END IF;
    END PROCESS;

END behave;
