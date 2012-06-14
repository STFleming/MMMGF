--
-- reg_sync.vhd - register retimer
--
-- SYNTHESIZABLE
--
-- This entity periodically copies the register input from the 'ik' clock domain
-- into the 'ok' clock domain.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on

library work;
use work.memif.pulse_sync;

entity reg_sync is
    generic(
        width  : in  natural);
    port(
        ar     : in  std_logic;
        ik     : in  std_logic;
        i      : in  std_logic_vector(width - 1 downto 0);
        ok     : in  std_logic;
        o      : out std_logic_vector(width - 1 downto 0));
end entity;

architecture rtl of reg_sync is

    signal sr0 : std_logic;
    signal sr1 : std_logic;
    signal d : std_logic_vector(width - 1 downto 0);
    signal reqi, reqiq0 : std_logic;
    signal ackiq0, ackiq1 : std_logic;
    signal reqoq0, reqoq1, reqoq2 : std_logic;
    signal acko : std_logic;

begin

    from_side : process(ar, ik)
    begin
        if ar = '1' then
           sr0 <= '1';
           sr1 <= '1';
           reqi <= '0';
           reqiq0 <= '0';
           ackiq0 <= '0';
           ackiq1 <= '0';
        elsif ik'event and ik = '1' then
           sr0 <= '0';
           sr1 <= sr0;

           if sr1 = '1' then
               reqi <= '1';
               reqiq0 <= '0';
           else
               reqi <= not ackiq1;
               reqiq0 <= reqi;
           end if;

           ackiq0 <= acko;
           ackiq1 <= ackiq0;
        end if;
    end process;

    gen_d : process(ik)
    begin
        if ik'event and ik = '1' then
           if reqiq0 = '0' and reqi = '1' then
               d <= i;
           end if;
        end if;
    end process;

    to_side : process(ar, ok)
    begin
        if ar = '1' then
            reqoq0 <= '0';
            reqoq1 <= '0';
            reqoq2 <= '0';
            acko <= '0';
        elsif ok'event and ok = '1' then
            reqoq0 <= reqiq0;
            reqoq1 <= reqoq0;
            reqoq2 <= reqoq1;
            acko <= reqoq2;
        end if;
    end process;

    gen_o : process(ok)
    begin
        if ok'event and ok = '1' then
            if reqoq1 = '1' and reqoq2 = '0' then
                o <= d;
            end if;
        end if;
    end process;

end;
