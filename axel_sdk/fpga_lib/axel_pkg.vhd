-- axel_pkg.vhd
-- by Brittle 2009

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE axel IS

  component my_dcm is
     port ( CLKIN_IN   : in    std_logic; 
            DADDR_IN   : in    std_logic_vector (6 downto 0); 
            DCLK_IN    : in    std_logic; 
            DEN_IN     : in    std_logic; 
            DI_IN      : in    std_logic_vector (15 downto 0); 
            DWE_IN     : in    std_logic; 
            RST_IN     : in    std_logic; 
            CLKFX_OUT  : out   std_logic; 
            CLK0_OUT   : out   std_logic; 
            DRDY_OUT   : out   std_logic; 
            LOCKED_OUT : out   std_logic);
  end component;

  component fifo_128_16_2clk is
    port (
      valid : out STD_LOGIC; 
      rd_en : in STD_LOGIC := 'X'; 
      prog_full : out STD_LOGIC; 
      wr_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      wr_clk : in STD_LOGIC := 'X'; 
      rst : in STD_LOGIC := 'X'; 
      rd_clk : in STD_LOGIC := 'X'; 
      dout : out STD_LOGIC_VECTOR ( 15 downto 0 ); 
      din : in STD_LOGIC_VECTOR ( 127 downto 0 ) 
    );
  end component;

  component fifo_16_128_2clk is
    port (
      valid : out STD_LOGIC; 
      rd_en : in STD_LOGIC := 'X'; 
      prog_full : out STD_LOGIC; 
      wr_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      wr_clk : in STD_LOGIC := 'X'; 
      rst : in STD_LOGIC := 'X'; 
      rd_clk : in STD_LOGIC := 'X'; 
      dout : out STD_LOGIC_VECTOR ( 127 downto 0 ); 
      din : in STD_LOGIC_VECTOR ( 15 downto 0 ) 
    );
  end component;

  component fifo_32_32_2clk is
    port (
      valid : out STD_LOGIC; 
      rd_en : in STD_LOGIC := 'X'; 
      wr_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      wr_clk : in STD_LOGIC := 'X'; 
      rst : in STD_LOGIC := 'X'; 
      rd_clk : in STD_LOGIC := 'X'; 
      dout : out STD_LOGIC_VECTOR ( 31 downto 0 ); 
      din : in STD_LOGIC_VECTOR ( 31 downto 0 ) 
    );
  end component;

  component fifo_128_128_2clk is
    port (
      valid : out STD_LOGIC; 
      rd_en : in STD_LOGIC := 'X'; 
      wr_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      wr_clk : in STD_LOGIC := 'X'; 
      rst : in STD_LOGIC := 'X'; 
      rd_clk : in STD_LOGIC := 'X'; 
      dout : out STD_LOGIC_VECTOR ( 127 downto 0 ); 
      din : in STD_LOGIC_VECTOR ( 127 downto 0 ) 
    );
  end component;

  component fifo_128_128_dram2clk is
    port (
      rd_en : in STD_LOGIC := 'X'; 
      wr_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      wr_clk : in STD_LOGIC := 'X'; 
      rst : in STD_LOGIC := 'X'; 
      rd_clk : in STD_LOGIC := 'X'; 
      dout : out STD_LOGIC_VECTOR ( 127 downto 0 ); 
      din : in STD_LOGIC_VECTOR ( 127 downto 0 ) 
    );
  end component;

  component fifo_128_128_dram2clk_pfull is
    port (
      rd_en : in STD_LOGIC := 'X'; 
      prog_full : out STD_LOGIC; 
      wr_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      wr_clk : in STD_LOGIC := 'X'; 
      rst : in STD_LOGIC := 'X'; 
      rd_clk : in STD_LOGIC := 'X'; 
      dout : out STD_LOGIC_VECTOR ( 127 downto 0 ); 
      din : in STD_LOGIC_VECTOR ( 127 downto 0 ) 
    );
  end component;
END;
