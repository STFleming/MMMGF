--------------------------------------------------------------------------------
-- Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: M.53d
--  \   \         Application: netgen
--  /   /         Filename: fifo_32_32_2clk.vhd
-- /___/   /\     Timestamp: Thu Jul  8 14:35:21 2010
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl ./tmp/_cg/fifo_32_32_2clk.ngc ./tmp/_cg/fifo_32_32_2clk.vhd 
-- Device	: 5vlx330tff1738-2
-- Input file	: ./tmp/_cg/fifo_32_32_2clk.ngc
-- Output file	: ./tmp/_cg/fifo_32_32_2clk.vhd
-- # of Entities	: 1
-- Design Name	: fifo_32_32_2clk
-- Xilinx	: /vol/cc/opt/Xilinx/12/ISE_DS/ISE
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity fifo_32_32_2clk is
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
end fifo_32_32_2clk;

architecture STRUCTURE of fifo_32_32_2clk is
  signal BU2_N21 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_274 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_273 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_272 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_271 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_270 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_269 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_268 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_267 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_266 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_265 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_264 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_263 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_262 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_261 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_260 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_259 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_258 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_257 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_256 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_255 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_254 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_253 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_252 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_251 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_250 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_249 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_248 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_247 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_246 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_245 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_244 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_243 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000144_242 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000098_241 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000058_240 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000135_239 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_dout_i_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_154 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_87 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_86 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d1_85 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_84 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_83 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_82 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_81 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_RST_FULL_GEN_80 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d3_79 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_78 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d2_77 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000 : STD_LOGIC; 
  signal NLW_VCC_P_UNCONNECTED : STD_LOGIC; 
  signal NLW_GND_G_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM62_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM61_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal din_2 : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal dout_3 : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal BU2_U0_grf_rf_mem_gdm_dm_varindex0000 : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d2 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d1 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001 : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_d1 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_rstblk_wr_rst_reg : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_rstblk_rd_rst_reg : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal BU2_rd_data_count : STD_LOGIC_VECTOR ( 0 downto 0 ); 
begin
  dout(31) <= dout_3(31);
  dout(30) <= dout_3(30);
  dout(29) <= dout_3(29);
  dout(28) <= dout_3(28);
  dout(27) <= dout_3(27);
  dout(26) <= dout_3(26);
  dout(25) <= dout_3(25);
  dout(24) <= dout_3(24);
  dout(23) <= dout_3(23);
  dout(22) <= dout_3(22);
  dout(21) <= dout_3(21);
  dout(20) <= dout_3(20);
  dout(19) <= dout_3(19);
  dout(18) <= dout_3(18);
  dout(17) <= dout_3(17);
  dout(16) <= dout_3(16);
  dout(15) <= dout_3(15);
  dout(14) <= dout_3(14);
  dout(13) <= dout_3(13);
  dout(12) <= dout_3(12);
  dout(11) <= dout_3(11);
  dout(10) <= dout_3(10);
  dout(9) <= dout_3(9);
  dout(8) <= dout_3(8);
  dout(7) <= dout_3(7);
  dout(6) <= dout_3(6);
  dout(5) <= dout_3(5);
  dout(4) <= dout_3(4);
  dout(3) <= dout_3(3);
  dout(2) <= dout_3(2);
  dout(1) <= dout_3(1);
  dout(0) <= dout_3(0);
  din_2(31) <= din(31);
  din_2(30) <= din(30);
  din_2(29) <= din(29);
  din_2(28) <= din(28);
  din_2(27) <= din(27);
  din_2(26) <= din(26);
  din_2(25) <= din(25);
  din_2(24) <= din(24);
  din_2(23) <= din(23);
  din_2(22) <= din(22);
  din_2(21) <= din(21);
  din_2(20) <= din(20);
  din_2(19) <= din(19);
  din_2(18) <= din(18);
  din_2(17) <= din(17);
  din_2(16) <= din(16);
  din_2(15) <= din(15);
  din_2(14) <= din(14);
  din_2(13) <= din(13);
  din_2(12) <= din(12);
  din_2(11) <= din(11);
  din_2(10) <= din(10);
  din_2(9) <= din(9);
  din_2(8) <= din(8);
  din_2(7) <= din(7);
  din_2(6) <= din(6);
  din_2(5) <= din(5);
  din_2(4) <= din(4);
  din_2(3) <= din(3);
  din_2(2) <= din(2);
  din_2(1) <= din(1);
  din_2(0) <= din(0);
  VCC_0 : VCC
    port map (
      P => NLW_VCC_P_UNCONNECTED
    );
  GND_1 : GND
    port map (
      G => NLW_GND_G_UNCONNECTED
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_0_11_INV_0 : INV
    port map (
      I => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_0_11_INV_0 : INV
    port map (
      I => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(31),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(31),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_274
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(30),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(30),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_273
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(29),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(29),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_272
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(28),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(28),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_271
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(27),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(27),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_270
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(26),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(26),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_269
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(25),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(25),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_268
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(24),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(24),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_267
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(23),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(23),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_266
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(22),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(22),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_265
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(21),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(21),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_264
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(20),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(20),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_263
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(19),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(19),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_262
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(18),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(18),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_261
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(17),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(17),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_260
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(16),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(16),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_259
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(15),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(15),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_258
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(14),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(14),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_257
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(13),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(13),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_256
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(12),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(12),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_255
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(11),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(11),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_254
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(10),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(10),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_253
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(9),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(9),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_252
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(8),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(8),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_251
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(7),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(7),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_250
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(6),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(6),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_249
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(5),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(5),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_248
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(4),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(4),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_247
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(3),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(3),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_246
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(2),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(2),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_245
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(1),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(1),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_244
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(0),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(0),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_243
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_bin_xor0002_Result1 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(0),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0002_Result1 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(1),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(0),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_bin_xor0001_Result1 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0001_Result1 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(1),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000178 : LUT6
    generic map(
      INIT => X"5541414155000000"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_RST_FULL_GEN_80,
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000098_241,
      I4 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000144_242,
      I5 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000058_240,
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000153 : LUT6
    generic map(
      INIT => X"9900BDA50000A5A5"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      I4 => BU2_N21,
      I5 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000135_239,
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000153_SW0 : LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I4 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2),
      I5 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      O => BU2_N21
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_31 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_274,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(31)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_30 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_273,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(30)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_29 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_272,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(29)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_28 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_271,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(28)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_27 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_270,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(27)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_26 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_269,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(26)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_25 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_268,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(25)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_24 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_267,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(24)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_23 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_266,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(23)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_22 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_265,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(22)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_21 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_264,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(21)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_20 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_263,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(20)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_19 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_262,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(19)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_18 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_261,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(18)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_17 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_260,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(17)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_16 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_259,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(16)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_15 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_258,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(15)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_14 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_257,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(14)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_13 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_256,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(13)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_12 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_255,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(12)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_11 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_254,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(11)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_10 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_253,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(10)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_9 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_252,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(9)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_251,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(8)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_250,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(7)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_249,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(6)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_248,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(5)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_247,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(4)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_246,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(3)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_245,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(2)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_244,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(1)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_243,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000144 : LUT6
    generic map(
      INIT => X"2000002002000002"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_78,
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I5 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000144_242
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000098 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000098_241
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000058 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      I5 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000058_240
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000135 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I5 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000135_239
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_bin_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_RAM_RD_EN_FWFT1 : LUT4
    generic map(
      INIT => X"00BF"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I3 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001
    );
  BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_78,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_RAM_REGOUT_EN1 : LUT3
    generic map(
      INIT => X"B0"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      O => BU2_U0_grf_rf_mem_dout_i_not0001
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_3_11 : LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_3_11 : LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux00001 : LUT4
    generic map(
      INIT => X"8E8A"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_154,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I3 => rd_en,
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001_0_1 : LUT4
    generic map(
      INIT => X"08FF"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75,
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_2_11 : LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_2_11 : LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001_1_1 : LUT3
    generic map(
      INIT => X"F2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I1 => rd_en,
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(1)
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0002_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0002_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_1_11 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_1_11 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1
    );
  BU2_U0_grf_rf_rstblk_rd_rst_comb1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_82,
      I1 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_86,
      O => BU2_U0_grf_rf_rstblk_rd_rst_comb
    );
  BU2_U0_grf_rf_rstblk_wr_rst_comb1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_84,
      I1 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_87,
      O => BU2_U0_grf_rf_rstblk_wr_rst_comb
    );
  BU2_U0_grf_rf_mem_dout_i_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(0),
      Q => dout_3(0)
    );
  BU2_U0_grf_rf_mem_dout_i_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(1),
      Q => dout_3(1)
    );
  BU2_U0_grf_rf_mem_dout_i_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(2),
      Q => dout_3(2)
    );
  BU2_U0_grf_rf_mem_dout_i_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(3),
      Q => dout_3(3)
    );
  BU2_U0_grf_rf_mem_dout_i_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(4),
      Q => dout_3(4)
    );
  BU2_U0_grf_rf_mem_dout_i_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(5),
      Q => dout_3(5)
    );
  BU2_U0_grf_rf_mem_dout_i_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(6),
      Q => dout_3(6)
    );
  BU2_U0_grf_rf_mem_dout_i_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(7),
      Q => dout_3(7)
    );
  BU2_U0_grf_rf_mem_dout_i_8 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(8),
      Q => dout_3(8)
    );
  BU2_U0_grf_rf_mem_dout_i_9 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(9),
      Q => dout_3(9)
    );
  BU2_U0_grf_rf_mem_dout_i_10 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(10),
      Q => dout_3(10)
    );
  BU2_U0_grf_rf_mem_dout_i_11 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(11),
      Q => dout_3(11)
    );
  BU2_U0_grf_rf_mem_dout_i_12 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(12),
      Q => dout_3(12)
    );
  BU2_U0_grf_rf_mem_dout_i_13 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(13),
      Q => dout_3(13)
    );
  BU2_U0_grf_rf_mem_dout_i_14 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(14),
      Q => dout_3(14)
    );
  BU2_U0_grf_rf_mem_dout_i_15 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(15),
      Q => dout_3(15)
    );
  BU2_U0_grf_rf_mem_dout_i_16 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(16),
      Q => dout_3(16)
    );
  BU2_U0_grf_rf_mem_dout_i_17 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(17),
      Q => dout_3(17)
    );
  BU2_U0_grf_rf_mem_dout_i_18 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(18),
      Q => dout_3(18)
    );
  BU2_U0_grf_rf_mem_dout_i_19 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(19),
      Q => dout_3(19)
    );
  BU2_U0_grf_rf_mem_dout_i_20 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(20),
      Q => dout_3(20)
    );
  BU2_U0_grf_rf_mem_dout_i_21 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(21),
      Q => dout_3(21)
    );
  BU2_U0_grf_rf_mem_dout_i_22 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(22),
      Q => dout_3(22)
    );
  BU2_U0_grf_rf_mem_dout_i_23 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(23),
      Q => dout_3(23)
    );
  BU2_U0_grf_rf_mem_dout_i_24 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(24),
      Q => dout_3(24)
    );
  BU2_U0_grf_rf_mem_dout_i_25 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(25),
      Q => dout_3(25)
    );
  BU2_U0_grf_rf_mem_dout_i_26 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(26),
      Q => dout_3(26)
    );
  BU2_U0_grf_rf_mem_dout_i_27 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(27),
      Q => dout_3(27)
    );
  BU2_U0_grf_rf_mem_dout_i_28 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(28),
      Q => dout_3(28)
    );
  BU2_U0_grf_rf_mem_dout_i_29 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(29),
      Q => dout_3(29)
    );
  BU2_U0_grf_rf_mem_dout_i_30 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(30),
      Q => dout_3(30)
    );
  BU2_U0_grf_rf_mem_dout_i_31 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(31),
      Q => dout_3(31)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM62 : RAM32X1D
    port map (
      A0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      A1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      A2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      A3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      A4 => BU2_rd_data_count(0),
      D => din_2(31),
      DPRA0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      DPRA1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      DPRA2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      DPRA3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      DPRA4 => BU2_rd_data_count(0),
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      SPO => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM62_SPO_UNCONNECTED,
      DPO => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(31)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM61 : RAM32X1D
    port map (
      A0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      A1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      A2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      A3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      A4 => BU2_rd_data_count(0),
      D => din_2(30),
      DPRA0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      DPRA1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      DPRA2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      DPRA3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      DPRA4 => BU2_rd_data_count(0),
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      SPO => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM61_SPO_UNCONNECTED,
      DPO => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(30)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(25),
      DIA(0) => din_2(24),
      DIB(1) => din_2(27),
      DIB(0) => din_2(26),
      DIC(1) => din_2(29),
      DIC(0) => din_2(28),
      DID(1) => BU2_rd_data_count(0),
      DID(0) => BU2_rd_data_count(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(4) => BU2_rd_data_count(0),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(4) => BU2_rd_data_count(0),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(25),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(24),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(27),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(26),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(29),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(28),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(19),
      DIA(0) => din_2(18),
      DIB(1) => din_2(21),
      DIB(0) => din_2(20),
      DIC(1) => din_2(23),
      DIC(0) => din_2(22),
      DID(1) => BU2_rd_data_count(0),
      DID(0) => BU2_rd_data_count(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(4) => BU2_rd_data_count(0),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(4) => BU2_rd_data_count(0),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(19),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(18),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(21),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(20),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(23),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(22),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(7),
      DIA(0) => din_2(6),
      DIB(1) => din_2(9),
      DIB(0) => din_2(8),
      DIC(1) => din_2(11),
      DIC(0) => din_2(10),
      DID(1) => BU2_rd_data_count(0),
      DID(0) => BU2_rd_data_count(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(4) => BU2_rd_data_count(0),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(4) => BU2_rd_data_count(0),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(7),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(6),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(9),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(8),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(11),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(10),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(1),
      DIA(0) => din_2(0),
      DIB(1) => din_2(3),
      DIB(0) => din_2(2),
      DIC(1) => din_2(5),
      DIC(0) => din_2(4),
      DID(1) => BU2_rd_data_count(0),
      DID(0) => BU2_rd_data_count(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(4) => BU2_rd_data_count(0),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(4) => BU2_rd_data_count(0),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(1),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(0),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(3),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(2),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(5),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(4),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(13),
      DIA(0) => din_2(12),
      DIB(1) => din_2(15),
      DIB(0) => din_2(14),
      DIC(1) => din_2(17),
      DIC(0) => din_2(16),
      DID(1) => BU2_rd_data_count(0),
      DID(0) => BU2_rd_data_count(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(4) => BU2_rd_data_count(0),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(4) => BU2_rd_data_count(0),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(13),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(12),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(15),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(14),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(17),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(16),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_0 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_1 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(3)
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(1),
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0)
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(0),
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1)
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => empty
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_154
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_user_valid : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(1),
      Q => valid
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_0 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(1)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(0),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(1),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(2),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(3),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(0),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(1),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(2),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(3),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(0),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(1),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(2),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(3),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(0),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(1),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(2),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(3),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3)
    );
  BU2_U0_grf_rf_rstblk_wr_rst_reg_0 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_reg(0)
    );
  BU2_U0_grf_rf_rstblk_wr_rst_reg_1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_reg(1)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_0 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(0)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(1)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_2 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(2)
    );
  BU2_U0_grf_rf_rstblk_rst_d1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rst_d1_85
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg : FDPE
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_81,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_86
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_87,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_83
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg : FDPE
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_83,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_87
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_86,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_81
    );
  BU2_U0_grf_rf_rstblk_rst_d2 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_rst_d1_85,
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rst_d2_77
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_83,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_84
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_81,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_82
    );
  BU2_U0_grf_rf_rstblk_rst_d3 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_rst_d2_77,
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rst_d3_79
    );
  BU2_U0_grf_rf_rstblk_RST_FULL_GEN : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => rst,
      D => BU2_U0_grf_rf_rstblk_rst_d3_79,
      Q => BU2_U0_grf_rf_rstblk_RST_FULL_GEN_80
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rst_d2_77,
      Q => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_78
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rst_d2_77,
      Q => full
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_75
    );
  BU2_XST_GND : GND
    port map (
      G => BU2_rd_data_count(0)
    );

end STRUCTURE;

-- synthesis translate_on
