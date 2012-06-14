--------------------------------------------------------------------------------
-- Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: L.57
--  \   \         Application: netgen
--  /   /         Filename: bram_1w1r.vhd
-- /___/   /\     Timestamp: Wed Dec  2 17:42:36 2009
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl ./tmp/_cg/bram_1w1r.ngc ./tmp/_cg/bram_1w1r.vhd 
-- Device	: 5vlx330tff1738-2
-- Input file	: ./tmp/_cg/bram_1w1r.ngc
-- Output file	: ./tmp/_cg/bram_1w1r.vhd
-- # of Entities	: 1
-- Design Name	: bram_1w1r
-- Xilinx	: /vol/cc/opt/Xilinx/11.1/ISE
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

entity bram_1w1r is
  port (
    clka : in STD_LOGIC := 'X'; 
    wea : in STD_LOGIC_VECTOR ( 0 downto 0 ); 
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 ); 
    douta : out STD_LOGIC_VECTOR ( 15 downto 0 ); 
    dina : in STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end bram_1w1r;

architecture STRUCTURE of bram_1w1r is
  signal BU2_N1 : STD_LOGIC; 
  signal NLW_VCC_P_UNCONNECTED : STD_LOGIC; 
  signal NLW_GND_G_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOPA_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOPA_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOPB_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOPB_0_UNCONNECTED : STD_LOGIC; 
  signal wea_2 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal addra_3 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal dina_4 : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal douta_5 : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal BU2_doutb : STD_LOGIC_VECTOR ( 0 downto 0 ); 
begin
  wea_2(0) <= wea(0);
  addra_3(9) <= addra(9);
  addra_3(8) <= addra(8);
  addra_3(7) <= addra(7);
  addra_3(6) <= addra(6);
  addra_3(5) <= addra(5);
  addra_3(4) <= addra(4);
  addra_3(3) <= addra(3);
  addra_3(2) <= addra(2);
  addra_3(1) <= addra(1);
  addra_3(0) <= addra(0);
  douta(15) <= douta_5(15);
  douta(14) <= douta_5(14);
  douta(13) <= douta_5(13);
  douta(12) <= douta_5(12);
  douta(11) <= douta_5(11);
  douta(10) <= douta_5(10);
  douta(9) <= douta_5(9);
  douta(8) <= douta_5(8);
  douta(7) <= douta_5(7);
  douta(6) <= douta_5(6);
  douta(5) <= douta_5(5);
  douta(4) <= douta_5(4);
  douta(3) <= douta_5(3);
  douta(2) <= douta_5(2);
  douta(1) <= douta_5(1);
  douta(0) <= douta_5(0);
  dina_4(15) <= dina(15);
  dina_4(14) <= dina(14);
  dina_4(13) <= dina(13);
  dina_4(12) <= dina(12);
  dina_4(11) <= dina(11);
  dina_4(10) <= dina(10);
  dina_4(9) <= dina(9);
  dina_4(8) <= dina(8);
  dina_4(7) <= dina(7);
  dina_4(6) <= dina(6);
  dina_4(5) <= dina(5);
  dina_4(4) <= dina(4);
  dina_4(3) <= dina(3);
  dina_4(2) <= dina(2);
  dina_4(1) <= dina(1);
  dina_4(0) <= dina(0);
  VCC_0 : VCC
    port map (
      P => NLW_VCC_P_UNCONNECTED
    );
  GND_1 : GND
    port map (
      G => NLW_GND_G_UNCONNECTED
    );
  BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP : RAMB18
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      INIT_A => X"00000",
      INIT_B => X"00000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL_A => X"00000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_FILE => "NONE",
      READ_WIDTH_A => 18,
      READ_WIDTH_B => 18,
      SIM_COLLISION_CHECK => "ALL",
      SIM_MODE => "SAFE",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 18,
      WRITE_WIDTH_B => 18,
      SRVAL_B => X"00000"
    )
    port map (
      CLKA => clka,
      CLKB => BU2_doutb(0),
      ENA => BU2_N1,
      ENB => BU2_doutb(0),
      REGCEA => BU2_doutb(0),
      REGCEB => BU2_doutb(0),
      SSRA => BU2_doutb(0),
      SSRB => BU2_doutb(0),
      ADDRA(13) => addra_3(9),
      ADDRA(12) => addra_3(8),
      ADDRA(11) => addra_3(7),
      ADDRA(10) => addra_3(6),
      ADDRA(9) => addra_3(5),
      ADDRA(8) => addra_3(4),
      ADDRA(7) => addra_3(3),
      ADDRA(6) => addra_3(2),
      ADDRA(5) => addra_3(1),
      ADDRA(4) => addra_3(0),
      ADDRA(3) => BU2_doutb(0),
      ADDRA(2) => BU2_doutb(0),
      ADDRA(1) => BU2_doutb(0),
      ADDRA(0) => BU2_doutb(0),
      ADDRB(13) => BU2_doutb(0),
      ADDRB(12) => BU2_doutb(0),
      ADDRB(11) => BU2_doutb(0),
      ADDRB(10) => BU2_doutb(0),
      ADDRB(9) => BU2_doutb(0),
      ADDRB(8) => BU2_doutb(0),
      ADDRB(7) => BU2_doutb(0),
      ADDRB(6) => BU2_doutb(0),
      ADDRB(5) => BU2_doutb(0),
      ADDRB(4) => BU2_doutb(0),
      ADDRB(3) => BU2_doutb(0),
      ADDRB(2) => BU2_doutb(0),
      ADDRB(1) => BU2_doutb(0),
      ADDRB(0) => BU2_doutb(0),
      DIA(15) => dina_4(15),
      DIA(14) => dina_4(14),
      DIA(13) => dina_4(13),
      DIA(12) => dina_4(12),
      DIA(11) => dina_4(11),
      DIA(10) => dina_4(10),
      DIA(9) => dina_4(9),
      DIA(8) => dina_4(8),
      DIA(7) => dina_4(7),
      DIA(6) => dina_4(6),
      DIA(5) => dina_4(5),
      DIA(4) => dina_4(4),
      DIA(3) => dina_4(3),
      DIA(2) => dina_4(2),
      DIA(1) => dina_4(1),
      DIA(0) => dina_4(0),
      DIB(15) => BU2_doutb(0),
      DIB(14) => BU2_doutb(0),
      DIB(13) => BU2_doutb(0),
      DIB(12) => BU2_doutb(0),
      DIB(11) => BU2_doutb(0),
      DIB(10) => BU2_doutb(0),
      DIB(9) => BU2_doutb(0),
      DIB(8) => BU2_doutb(0),
      DIB(7) => BU2_doutb(0),
      DIB(6) => BU2_doutb(0),
      DIB(5) => BU2_doutb(0),
      DIB(4) => BU2_doutb(0),
      DIB(3) => BU2_doutb(0),
      DIB(2) => BU2_doutb(0),
      DIB(1) => BU2_doutb(0),
      DIB(0) => BU2_doutb(0),
      DIPA(1) => BU2_doutb(0),
      DIPA(0) => BU2_doutb(0),
      DIPB(1) => BU2_doutb(0),
      DIPB(0) => BU2_doutb(0),
      DOA(15) => douta_5(15),
      DOA(14) => douta_5(14),
      DOA(13) => douta_5(13),
      DOA(12) => douta_5(12),
      DOA(11) => douta_5(11),
      DOA(10) => douta_5(10),
      DOA(9) => douta_5(9),
      DOA(8) => douta_5(8),
      DOA(7) => douta_5(7),
      DOA(6) => douta_5(6),
      DOA(5) => douta_5(5),
      DOA(4) => douta_5(4),
      DOA(3) => douta_5(3),
      DOA(2) => douta_5(2),
      DOA(1) => douta_5(1),
      DOA(0) => douta_5(0),
      DOB(15) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_15_UNCONNECTED,
      DOB(14) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_14_UNCONNECTED,
      DOB(13) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_13_UNCONNECTED,
      DOB(12) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_12_UNCONNECTED,
      DOB(11) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_11_UNCONNECTED,
      DOB(10) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_10_UNCONNECTED,
      DOB(9) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_9_UNCONNECTED,
      DOB(8) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_8_UNCONNECTED,
      DOB(7) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_7_UNCONNECTED,
      DOB(6) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_6_UNCONNECTED,
      DOB(5) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_5_UNCONNECTED,
      DOB(4) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_4_UNCONNECTED,
      DOB(3) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_3_UNCONNECTED,
      DOB(2) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_2_UNCONNECTED,
      DOB(1) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_1_UNCONNECTED,
      DOB(0) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOB_0_UNCONNECTED,
      DOPA(1) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOPA_1_UNCONNECTED,
      DOPA(0) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOPA_0_UNCONNECTED,
      DOPB(1) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOPB_1_UNCONNECTED,
      DOPB(0) => NLW_BU2_U0_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SP_SINGLE_PRIM18_SP_DOPB_0_UNCONNECTED,
      WEA(1) => wea_2(0),
      WEA(0) => wea_2(0),
      WEB(1) => BU2_doutb(0),
      WEB(0) => BU2_doutb(0)
    );
  BU2_XST_VCC : VCC
    port map (
      P => BU2_N1
    );
  BU2_XST_GND : GND
    port map (
      G => BU2_doutb(0)
    );

end STRUCTURE;

-- synthesis translate_on
