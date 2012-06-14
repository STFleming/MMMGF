--------------------------------------------------------------------------------
-- Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: M.53d
--  \   \         Application: netgen
--  /   /         Filename: fifo_128_128_2clk.vhd
-- /___/   /\     Timestamp: Mon May 24 15:32:52 2010
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl ./tmp/_cg/fifo_128_128_2clk.ngc ./tmp/_cg/fifo_128_128_2clk.vhd 
-- Device	: 5vlx330tff1738-2
-- Input file	: ./tmp/_cg/fifo_128_128_2clk.ngc
-- Output file	: ./tmp/_cg/fifo_128_128_2clk.vhd
-- # of Entities	: 1
-- Design Name	: fifo_128_128_2clk
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

entity fifo_128_128_2clk is
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
end fifo_128_128_2clk;

architecture STRUCTURE of fifo_128_128_2clk is
  signal BU2_N21 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_127_rstpot_754 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_126_rstpot_753 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_125_rstpot_752 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_124_rstpot_751 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_123_rstpot_750 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_122_rstpot_749 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_121_rstpot_748 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_120_rstpot_747 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_119_rstpot_746 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_118_rstpot_745 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_117_rstpot_744 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_116_rstpot_743 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_115_rstpot_742 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_114_rstpot_741 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_113_rstpot_740 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_112_rstpot_739 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_111_rstpot_738 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_110_rstpot_737 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_109_rstpot_736 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_108_rstpot_735 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_107_rstpot_734 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_106_rstpot_733 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_105_rstpot_732 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_104_rstpot_731 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_103_rstpot_730 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_102_rstpot_729 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_101_rstpot_728 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_100_rstpot_727 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_99_rstpot_726 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_98_rstpot_725 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_97_rstpot_724 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_96_rstpot_723 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_95_rstpot_722 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_94_rstpot_721 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_93_rstpot_720 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_92_rstpot_719 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_91_rstpot_718 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_90_rstpot_717 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_89_rstpot_716 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_88_rstpot_715 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_87_rstpot_714 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_86_rstpot_713 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_85_rstpot_712 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_84_rstpot_711 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_83_rstpot_710 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_82_rstpot_709 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_81_rstpot_708 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_80_rstpot_707 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_79_rstpot_706 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_78_rstpot_705 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_77_rstpot_704 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_76_rstpot_703 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_75_rstpot_702 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_74_rstpot_701 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_73_rstpot_700 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_72_rstpot_699 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_71_rstpot_698 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_70_rstpot_697 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_69_rstpot_696 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_68_rstpot_695 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_67_rstpot_694 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_66_rstpot_693 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_65_rstpot_692 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_64_rstpot_691 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_63_rstpot_690 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_62_rstpot_689 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_61_rstpot_688 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_60_rstpot_687 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_59_rstpot_686 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_58_rstpot_685 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_57_rstpot_684 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_56_rstpot_683 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_55_rstpot_682 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_54_rstpot_681 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_53_rstpot_680 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_52_rstpot_679 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_51_rstpot_678 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_50_rstpot_677 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_49_rstpot_676 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_48_rstpot_675 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_47_rstpot_674 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_46_rstpot_673 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_45_rstpot_672 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_44_rstpot_671 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_43_rstpot_670 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_42_rstpot_669 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_41_rstpot_668 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_40_rstpot_667 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_39_rstpot_666 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_38_rstpot_665 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_37_rstpot_664 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_36_rstpot_663 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_35_rstpot_662 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_34_rstpot_661 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_33_rstpot_660 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_32_rstpot_659 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_658 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_657 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_656 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_655 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_654 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_653 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_652 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_651 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_650 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_649 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_648 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_647 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_646 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_645 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_644 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_643 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_642 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_641 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_640 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_639 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_638 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_637 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_636 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_635 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_634 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_633 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_632 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_631 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_630 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_629 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_628 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_627 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000144_626 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000098_625 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000058_624 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000135_623 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_dout_i_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_346 : STD_LOGIC; 
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
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_279 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_278 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d1_277 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_276 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_275 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_274 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_273 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_RST_FULL_GEN_272 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d3_271 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_270 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d2_269 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000 : STD_LOGIC; 
  signal NLW_VCC_P_UNCONNECTED : STD_LOGIC; 
  signal NLW_GND_G_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM222_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM221_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM21_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM21_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM19_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM19_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM18_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM18_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM20_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM20_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM16_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM16_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM15_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM15_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM17_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM17_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM13_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM13_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM12_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM12_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM14_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM14_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM11_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM11_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM10_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM10_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM8_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM8_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM7_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM7_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM9_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM9_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM6_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM6_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3_DOD_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3_DOD_0_UNCONNECTED : STD_LOGIC; 
  signal din_2 : STD_LOGIC_VECTOR ( 127 downto 0 ); 
  signal dout_3 : STD_LOGIC_VECTOR ( 127 downto 0 ); 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i : STD_LOGIC_VECTOR ( 127 downto 0 ); 
  signal BU2_U0_grf_rf_mem_gdm_dm_varindex0000 : STD_LOGIC_VECTOR ( 127 downto 0 ); 
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
  dout(127) <= dout_3(127);
  dout(126) <= dout_3(126);
  dout(125) <= dout_3(125);
  dout(124) <= dout_3(124);
  dout(123) <= dout_3(123);
  dout(122) <= dout_3(122);
  dout(121) <= dout_3(121);
  dout(120) <= dout_3(120);
  dout(119) <= dout_3(119);
  dout(118) <= dout_3(118);
  dout(117) <= dout_3(117);
  dout(116) <= dout_3(116);
  dout(115) <= dout_3(115);
  dout(114) <= dout_3(114);
  dout(113) <= dout_3(113);
  dout(112) <= dout_3(112);
  dout(111) <= dout_3(111);
  dout(110) <= dout_3(110);
  dout(109) <= dout_3(109);
  dout(108) <= dout_3(108);
  dout(107) <= dout_3(107);
  dout(106) <= dout_3(106);
  dout(105) <= dout_3(105);
  dout(104) <= dout_3(104);
  dout(103) <= dout_3(103);
  dout(102) <= dout_3(102);
  dout(101) <= dout_3(101);
  dout(100) <= dout_3(100);
  dout(99) <= dout_3(99);
  dout(98) <= dout_3(98);
  dout(97) <= dout_3(97);
  dout(96) <= dout_3(96);
  dout(95) <= dout_3(95);
  dout(94) <= dout_3(94);
  dout(93) <= dout_3(93);
  dout(92) <= dout_3(92);
  dout(91) <= dout_3(91);
  dout(90) <= dout_3(90);
  dout(89) <= dout_3(89);
  dout(88) <= dout_3(88);
  dout(87) <= dout_3(87);
  dout(86) <= dout_3(86);
  dout(85) <= dout_3(85);
  dout(84) <= dout_3(84);
  dout(83) <= dout_3(83);
  dout(82) <= dout_3(82);
  dout(81) <= dout_3(81);
  dout(80) <= dout_3(80);
  dout(79) <= dout_3(79);
  dout(78) <= dout_3(78);
  dout(77) <= dout_3(77);
  dout(76) <= dout_3(76);
  dout(75) <= dout_3(75);
  dout(74) <= dout_3(74);
  dout(73) <= dout_3(73);
  dout(72) <= dout_3(72);
  dout(71) <= dout_3(71);
  dout(70) <= dout_3(70);
  dout(69) <= dout_3(69);
  dout(68) <= dout_3(68);
  dout(67) <= dout_3(67);
  dout(66) <= dout_3(66);
  dout(65) <= dout_3(65);
  dout(64) <= dout_3(64);
  dout(63) <= dout_3(63);
  dout(62) <= dout_3(62);
  dout(61) <= dout_3(61);
  dout(60) <= dout_3(60);
  dout(59) <= dout_3(59);
  dout(58) <= dout_3(58);
  dout(57) <= dout_3(57);
  dout(56) <= dout_3(56);
  dout(55) <= dout_3(55);
  dout(54) <= dout_3(54);
  dout(53) <= dout_3(53);
  dout(52) <= dout_3(52);
  dout(51) <= dout_3(51);
  dout(50) <= dout_3(50);
  dout(49) <= dout_3(49);
  dout(48) <= dout_3(48);
  dout(47) <= dout_3(47);
  dout(46) <= dout_3(46);
  dout(45) <= dout_3(45);
  dout(44) <= dout_3(44);
  dout(43) <= dout_3(43);
  dout(42) <= dout_3(42);
  dout(41) <= dout_3(41);
  dout(40) <= dout_3(40);
  dout(39) <= dout_3(39);
  dout(38) <= dout_3(38);
  dout(37) <= dout_3(37);
  dout(36) <= dout_3(36);
  dout(35) <= dout_3(35);
  dout(34) <= dout_3(34);
  dout(33) <= dout_3(33);
  dout(32) <= dout_3(32);
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
  din_2(127) <= din(127);
  din_2(126) <= din(126);
  din_2(125) <= din(125);
  din_2(124) <= din(124);
  din_2(123) <= din(123);
  din_2(122) <= din(122);
  din_2(121) <= din(121);
  din_2(120) <= din(120);
  din_2(119) <= din(119);
  din_2(118) <= din(118);
  din_2(117) <= din(117);
  din_2(116) <= din(116);
  din_2(115) <= din(115);
  din_2(114) <= din(114);
  din_2(113) <= din(113);
  din_2(112) <= din(112);
  din_2(111) <= din(111);
  din_2(110) <= din(110);
  din_2(109) <= din(109);
  din_2(108) <= din(108);
  din_2(107) <= din(107);
  din_2(106) <= din(106);
  din_2(105) <= din(105);
  din_2(104) <= din(104);
  din_2(103) <= din(103);
  din_2(102) <= din(102);
  din_2(101) <= din(101);
  din_2(100) <= din(100);
  din_2(99) <= din(99);
  din_2(98) <= din(98);
  din_2(97) <= din(97);
  din_2(96) <= din(96);
  din_2(95) <= din(95);
  din_2(94) <= din(94);
  din_2(93) <= din(93);
  din_2(92) <= din(92);
  din_2(91) <= din(91);
  din_2(90) <= din(90);
  din_2(89) <= din(89);
  din_2(88) <= din(88);
  din_2(87) <= din(87);
  din_2(86) <= din(86);
  din_2(85) <= din(85);
  din_2(84) <= din(84);
  din_2(83) <= din(83);
  din_2(82) <= din(82);
  din_2(81) <= din(81);
  din_2(80) <= din(80);
  din_2(79) <= din(79);
  din_2(78) <= din(78);
  din_2(77) <= din(77);
  din_2(76) <= din(76);
  din_2(75) <= din(75);
  din_2(74) <= din(74);
  din_2(73) <= din(73);
  din_2(72) <= din(72);
  din_2(71) <= din(71);
  din_2(70) <= din(70);
  din_2(69) <= din(69);
  din_2(68) <= din(68);
  din_2(67) <= din(67);
  din_2(66) <= din(66);
  din_2(65) <= din(65);
  din_2(64) <= din(64);
  din_2(63) <= din(63);
  din_2(62) <= din(62);
  din_2(61) <= din(61);
  din_2(60) <= din(60);
  din_2(59) <= din(59);
  din_2(58) <= din(58);
  din_2(57) <= din(57);
  din_2(56) <= din(56);
  din_2(55) <= din(55);
  din_2(54) <= din(54);
  din_2(53) <= din(53);
  din_2(52) <= din(52);
  din_2(51) <= din(51);
  din_2(50) <= din(50);
  din_2(49) <= din(49);
  din_2(48) <= din(48);
  din_2(47) <= din(47);
  din_2(46) <= din(46);
  din_2(45) <= din(45);
  din_2(44) <= din(44);
  din_2(43) <= din(43);
  din_2(42) <= din(42);
  din_2(41) <= din(41);
  din_2(40) <= din(40);
  din_2(39) <= din(39);
  din_2(38) <= din(38);
  din_2(37) <= din(37);
  din_2(36) <= din(36);
  din_2(35) <= din(35);
  din_2(34) <= din(34);
  din_2(33) <= din(33);
  din_2(32) <= din(32);
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
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_127_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(127),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(127),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_127_rstpot_754
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_126_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(126),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(126),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_126_rstpot_753
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_125_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(125),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(125),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_125_rstpot_752
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_124_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(124),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(124),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_124_rstpot_751
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_123_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(123),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(123),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_123_rstpot_750
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_122_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(122),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(122),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_122_rstpot_749
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_121_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(121),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(121),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_121_rstpot_748
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_120_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(120),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(120),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_120_rstpot_747
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_119_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(119),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(119),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_119_rstpot_746
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_118_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(118),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(118),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_118_rstpot_745
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_117_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(117),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(117),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_117_rstpot_744
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_116_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(116),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(116),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_116_rstpot_743
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_115_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(115),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(115),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_115_rstpot_742
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_114_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(114),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(114),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_114_rstpot_741
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_113_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(113),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(113),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_113_rstpot_740
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_112_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(112),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(112),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_112_rstpot_739
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_111_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(111),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(111),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_111_rstpot_738
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_110_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(110),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(110),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_110_rstpot_737
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_109_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(109),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(109),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_109_rstpot_736
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_108_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(108),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(108),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_108_rstpot_735
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_107_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(107),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(107),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_107_rstpot_734
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_106_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(106),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(106),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_106_rstpot_733
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_105_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(105),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(105),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_105_rstpot_732
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_104_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(104),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(104),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_104_rstpot_731
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_103_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(103),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(103),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_103_rstpot_730
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_102_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(102),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(102),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_102_rstpot_729
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_101_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(101),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(101),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_101_rstpot_728
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_100_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(100),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(100),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_100_rstpot_727
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_99_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(99),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(99),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_99_rstpot_726
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_98_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(98),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(98),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_98_rstpot_725
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_97_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(97),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(97),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_97_rstpot_724
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_96_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(96),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(96),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_96_rstpot_723
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_95_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(95),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(95),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_95_rstpot_722
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_94_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(94),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(94),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_94_rstpot_721
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_93_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(93),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(93),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_93_rstpot_720
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_92_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(92),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(92),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_92_rstpot_719
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_91_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(91),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(91),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_91_rstpot_718
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_90_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(90),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(90),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_90_rstpot_717
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_89_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(89),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(89),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_89_rstpot_716
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_88_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(88),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(88),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_88_rstpot_715
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_87_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(87),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(87),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_87_rstpot_714
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_86_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(86),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(86),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_86_rstpot_713
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_85_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(85),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(85),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_85_rstpot_712
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_84_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(84),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(84),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_84_rstpot_711
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_83_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(83),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(83),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_83_rstpot_710
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_82_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(82),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(82),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_82_rstpot_709
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_81_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(81),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(81),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_81_rstpot_708
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_80_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(80),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(80),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_80_rstpot_707
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_79_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(79),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(79),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_79_rstpot_706
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_78_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(78),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(78),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_78_rstpot_705
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_77_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(77),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(77),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_77_rstpot_704
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_76_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(76),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(76),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_76_rstpot_703
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_75_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(75),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(75),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_75_rstpot_702
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_74_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(74),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(74),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_74_rstpot_701
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_73_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(73),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(73),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_73_rstpot_700
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_72_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(72),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(72),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_72_rstpot_699
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_71_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(71),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(71),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_71_rstpot_698
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_70_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(70),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(70),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_70_rstpot_697
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_69_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(69),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(69),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_69_rstpot_696
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_68_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(68),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(68),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_68_rstpot_695
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_67_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(67),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(67),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_67_rstpot_694
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_66_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(66),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(66),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_66_rstpot_693
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_65_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(65),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(65),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_65_rstpot_692
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_64_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(64),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(64),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_64_rstpot_691
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_63_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(63),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(63),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_63_rstpot_690
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_62_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(62),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(62),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_62_rstpot_689
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_61_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(61),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(61),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_61_rstpot_688
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_60_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(60),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(60),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_60_rstpot_687
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_59_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(59),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(59),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_59_rstpot_686
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_58_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(58),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(58),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_58_rstpot_685
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_57_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(57),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(57),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_57_rstpot_684
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_56_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(56),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(56),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_56_rstpot_683
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_55_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(55),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(55),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_55_rstpot_682
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_54_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(54),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(54),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_54_rstpot_681
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_53_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(53),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(53),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_53_rstpot_680
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_52_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(52),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(52),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_52_rstpot_679
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_51_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(51),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(51),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_51_rstpot_678
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_50_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(50),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(50),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_50_rstpot_677
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_49_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(49),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(49),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_49_rstpot_676
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_48_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(48),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(48),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_48_rstpot_675
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_47_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(47),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(47),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_47_rstpot_674
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_46_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(46),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(46),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_46_rstpot_673
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_45_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(45),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(45),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_45_rstpot_672
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_44_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(44),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(44),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_44_rstpot_671
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_43_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(43),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(43),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_43_rstpot_670
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_42_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(42),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(42),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_42_rstpot_669
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_41_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(41),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(41),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_41_rstpot_668
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_40_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(40),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(40),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_40_rstpot_667
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_39_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(39),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(39),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_39_rstpot_666
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_38_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(38),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(38),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_38_rstpot_665
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_37_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(37),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(37),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_37_rstpot_664
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_36_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(36),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(36),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_36_rstpot_663
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_35_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(35),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(35),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_35_rstpot_662
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_34_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(34),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(34),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_34_rstpot_661
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_33_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(33),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(33),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_33_rstpot_660
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_32_rstpot : LUT6
    generic map(
      INIT => X"FF00FFF7FF000800"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => rd_en,
      I3 => BU2_U0_grf_rf_mem_gdm_dm_dout_i(32),
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(32),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_32_rstpot_659
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(31),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_658
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(30),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_657
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(29),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_656
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(28),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_655
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(27),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_654
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(26),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_653
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(25),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_652
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(24),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_651
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(23),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_650
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(22),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_649
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(21),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_648
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(20),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_647
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(19),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_646
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(18),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_645
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(17),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_644
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(16),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_643
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(15),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_642
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(14),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_641
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(13),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_640
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(12),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_639
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(11),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_638
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(10),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_637
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(9),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_636
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(8),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_635
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(7),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_634
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(6),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_633
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(5),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_632
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(4),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_631
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(3),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_630
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(2),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_629
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(1),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_628
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
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      I5 => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(0),
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_627
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
      I0 => BU2_U0_grf_rf_rstblk_RST_FULL_GEN_272,
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000098_625,
      I4 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000144_626,
      I5 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000058_624,
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000153 : LUT6
    generic map(
      INIT => X"99000000BDA5A5A5"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000135_623,
      I5 => BU2_N21,
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000153_SW0 : LUT6
    generic map(
      INIT => X"7FBFDFEFF7FBFDFE"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I5 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      O => BU2_N21
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_127 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_127_rstpot_754,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(127)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_126 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_126_rstpot_753,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(126)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_125 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_125_rstpot_752,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(125)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_124 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_124_rstpot_751,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(124)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_123 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_123_rstpot_750,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(123)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_122 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_122_rstpot_749,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(122)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_121 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_121_rstpot_748,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(121)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_120 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_120_rstpot_747,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(120)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_119 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_119_rstpot_746,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(119)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_118 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_118_rstpot_745,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(118)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_117 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_117_rstpot_744,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(117)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_116 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_116_rstpot_743,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(116)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_115 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_115_rstpot_742,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(115)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_114 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_114_rstpot_741,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(114)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_113 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_113_rstpot_740,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(113)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_112 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_112_rstpot_739,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(112)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_111 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_111_rstpot_738,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(111)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_110 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_110_rstpot_737,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(110)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_109 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_109_rstpot_736,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(109)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_108 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_108_rstpot_735,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(108)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_107 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_107_rstpot_734,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(107)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_106 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_106_rstpot_733,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(106)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_105 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_105_rstpot_732,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(105)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_104 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_104_rstpot_731,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(104)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_103 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_103_rstpot_730,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(103)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_102 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_102_rstpot_729,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(102)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_101 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_101_rstpot_728,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(101)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_100 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_100_rstpot_727,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(100)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_99 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_99_rstpot_726,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(99)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_98 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_98_rstpot_725,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(98)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_97 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_97_rstpot_724,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(97)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_96 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_96_rstpot_723,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(96)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_95 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_95_rstpot_722,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(95)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_94 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_94_rstpot_721,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(94)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_93 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_93_rstpot_720,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(93)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_92 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_92_rstpot_719,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(92)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_91 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_91_rstpot_718,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(91)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_90 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_90_rstpot_717,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(90)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_89 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_89_rstpot_716,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(89)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_88 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_88_rstpot_715,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(88)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_87 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_87_rstpot_714,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(87)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_86 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_86_rstpot_713,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(86)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_85 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_85_rstpot_712,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(85)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_84 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_84_rstpot_711,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(84)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_83 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_83_rstpot_710,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(83)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_82 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_82_rstpot_709,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(82)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_81 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_81_rstpot_708,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(81)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_80 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_80_rstpot_707,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(80)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_79 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_79_rstpot_706,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(79)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_78 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_78_rstpot_705,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(78)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_77 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_77_rstpot_704,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(77)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_76 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_76_rstpot_703,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(76)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_75 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_75_rstpot_702,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(75)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_74 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_74_rstpot_701,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(74)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_73 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_73_rstpot_700,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(73)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_72 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_72_rstpot_699,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(72)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_71 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_71_rstpot_698,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(71)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_70 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_70_rstpot_697,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(70)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_69 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_69_rstpot_696,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(69)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_68 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_68_rstpot_695,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(68)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_67 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_67_rstpot_694,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(67)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_66 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_66_rstpot_693,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(66)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_65 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_65_rstpot_692,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(65)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_64 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_64_rstpot_691,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(64)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_63 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_63_rstpot_690,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(63)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_62 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_62_rstpot_689,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(62)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_61 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_61_rstpot_688,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(61)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_60 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_60_rstpot_687,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(60)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_59 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_59_rstpot_686,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(59)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_58 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_58_rstpot_685,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(58)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_57 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_57_rstpot_684,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(57)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_56 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_56_rstpot_683,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(56)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_55 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_55_rstpot_682,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(55)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_54 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_54_rstpot_681,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(54)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_53 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_53_rstpot_680,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(53)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_52 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_52_rstpot_679,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(52)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_51 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_51_rstpot_678,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(51)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_50 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_50_rstpot_677,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(50)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_49 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_49_rstpot_676,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(49)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_48 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_48_rstpot_675,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(48)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_47 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_47_rstpot_674,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(47)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_46 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_46_rstpot_673,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(46)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_45 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_45_rstpot_672,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(45)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_44 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_44_rstpot_671,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(44)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_43 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_43_rstpot_670,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(43)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_42 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_42_rstpot_669,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(42)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_41 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_41_rstpot_668,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(41)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_40 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_40_rstpot_667,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(40)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_39 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_39_rstpot_666,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(39)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_38 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_38_rstpot_665,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(38)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_37 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_37_rstpot_664,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(37)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_36 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_36_rstpot_663,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(36)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_35 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_35_rstpot_662,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(35)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_34 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_34_rstpot_661,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(34)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_33 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_33_rstpot_660,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(33)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_32 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_32_rstpot_659,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(32)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_31 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_658,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(31)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_30 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_657,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(30)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_29 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_656,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(29)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_28 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_655,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(28)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_27 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_654,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(27)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_26 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_653,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(26)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_25 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_652,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(25)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_24 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_651,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(24)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_23 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_650,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(23)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_22 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_649,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(22)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_21 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_648,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(21)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_20 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_647,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(20)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_19 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_646,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(19)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_18 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_645,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(18)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_17 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_644,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(17)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_16 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_643,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(16)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_15 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_642,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(15)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_14 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_641,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(14)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_13 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_640,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(13)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_12 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_639,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(12)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_11 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_638,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(11)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_10 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_637,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(10)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_9 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_636,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(9)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_635,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(8)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_634,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(7)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_633,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(6)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_632,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(5)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_631,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(4)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_630,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(3)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_629,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(2)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_628,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(1)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_627,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000144 : LUT6
    generic map(
      INIT => X"2000002002000002"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_270,
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I5 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000144_626
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
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000098_625
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
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000058_624
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
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000135_623
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
      I3 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001
    );
  BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_270,
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
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_346,
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
      I3 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267,
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
      I0 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_274,
      I1 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_278,
      O => BU2_U0_grf_rf_rstblk_rd_rst_comb
    );
  BU2_U0_grf_rf_rstblk_wr_rst_comb1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_276,
      I1 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_279,
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
  BU2_U0_grf_rf_mem_dout_i_32 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(32),
      Q => dout_3(32)
    );
  BU2_U0_grf_rf_mem_dout_i_33 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(33),
      Q => dout_3(33)
    );
  BU2_U0_grf_rf_mem_dout_i_34 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(34),
      Q => dout_3(34)
    );
  BU2_U0_grf_rf_mem_dout_i_35 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(35),
      Q => dout_3(35)
    );
  BU2_U0_grf_rf_mem_dout_i_36 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(36),
      Q => dout_3(36)
    );
  BU2_U0_grf_rf_mem_dout_i_37 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(37),
      Q => dout_3(37)
    );
  BU2_U0_grf_rf_mem_dout_i_38 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(38),
      Q => dout_3(38)
    );
  BU2_U0_grf_rf_mem_dout_i_39 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(39),
      Q => dout_3(39)
    );
  BU2_U0_grf_rf_mem_dout_i_40 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(40),
      Q => dout_3(40)
    );
  BU2_U0_grf_rf_mem_dout_i_41 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(41),
      Q => dout_3(41)
    );
  BU2_U0_grf_rf_mem_dout_i_42 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(42),
      Q => dout_3(42)
    );
  BU2_U0_grf_rf_mem_dout_i_43 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(43),
      Q => dout_3(43)
    );
  BU2_U0_grf_rf_mem_dout_i_44 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(44),
      Q => dout_3(44)
    );
  BU2_U0_grf_rf_mem_dout_i_45 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(45),
      Q => dout_3(45)
    );
  BU2_U0_grf_rf_mem_dout_i_46 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(46),
      Q => dout_3(46)
    );
  BU2_U0_grf_rf_mem_dout_i_47 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(47),
      Q => dout_3(47)
    );
  BU2_U0_grf_rf_mem_dout_i_48 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(48),
      Q => dout_3(48)
    );
  BU2_U0_grf_rf_mem_dout_i_49 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(49),
      Q => dout_3(49)
    );
  BU2_U0_grf_rf_mem_dout_i_50 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(50),
      Q => dout_3(50)
    );
  BU2_U0_grf_rf_mem_dout_i_51 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(51),
      Q => dout_3(51)
    );
  BU2_U0_grf_rf_mem_dout_i_52 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(52),
      Q => dout_3(52)
    );
  BU2_U0_grf_rf_mem_dout_i_53 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(53),
      Q => dout_3(53)
    );
  BU2_U0_grf_rf_mem_dout_i_54 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(54),
      Q => dout_3(54)
    );
  BU2_U0_grf_rf_mem_dout_i_55 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(55),
      Q => dout_3(55)
    );
  BU2_U0_grf_rf_mem_dout_i_56 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(56),
      Q => dout_3(56)
    );
  BU2_U0_grf_rf_mem_dout_i_57 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(57),
      Q => dout_3(57)
    );
  BU2_U0_grf_rf_mem_dout_i_58 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(58),
      Q => dout_3(58)
    );
  BU2_U0_grf_rf_mem_dout_i_59 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(59),
      Q => dout_3(59)
    );
  BU2_U0_grf_rf_mem_dout_i_60 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(60),
      Q => dout_3(60)
    );
  BU2_U0_grf_rf_mem_dout_i_61 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(61),
      Q => dout_3(61)
    );
  BU2_U0_grf_rf_mem_dout_i_62 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(62),
      Q => dout_3(62)
    );
  BU2_U0_grf_rf_mem_dout_i_63 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(63),
      Q => dout_3(63)
    );
  BU2_U0_grf_rf_mem_dout_i_64 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(64),
      Q => dout_3(64)
    );
  BU2_U0_grf_rf_mem_dout_i_65 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(65),
      Q => dout_3(65)
    );
  BU2_U0_grf_rf_mem_dout_i_66 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(66),
      Q => dout_3(66)
    );
  BU2_U0_grf_rf_mem_dout_i_67 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(67),
      Q => dout_3(67)
    );
  BU2_U0_grf_rf_mem_dout_i_68 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(68),
      Q => dout_3(68)
    );
  BU2_U0_grf_rf_mem_dout_i_69 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(69),
      Q => dout_3(69)
    );
  BU2_U0_grf_rf_mem_dout_i_70 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(70),
      Q => dout_3(70)
    );
  BU2_U0_grf_rf_mem_dout_i_71 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(71),
      Q => dout_3(71)
    );
  BU2_U0_grf_rf_mem_dout_i_72 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(72),
      Q => dout_3(72)
    );
  BU2_U0_grf_rf_mem_dout_i_73 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(73),
      Q => dout_3(73)
    );
  BU2_U0_grf_rf_mem_dout_i_74 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(74),
      Q => dout_3(74)
    );
  BU2_U0_grf_rf_mem_dout_i_75 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(75),
      Q => dout_3(75)
    );
  BU2_U0_grf_rf_mem_dout_i_76 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(76),
      Q => dout_3(76)
    );
  BU2_U0_grf_rf_mem_dout_i_77 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(77),
      Q => dout_3(77)
    );
  BU2_U0_grf_rf_mem_dout_i_78 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(78),
      Q => dout_3(78)
    );
  BU2_U0_grf_rf_mem_dout_i_79 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(79),
      Q => dout_3(79)
    );
  BU2_U0_grf_rf_mem_dout_i_80 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(80),
      Q => dout_3(80)
    );
  BU2_U0_grf_rf_mem_dout_i_81 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(81),
      Q => dout_3(81)
    );
  BU2_U0_grf_rf_mem_dout_i_82 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(82),
      Q => dout_3(82)
    );
  BU2_U0_grf_rf_mem_dout_i_83 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(83),
      Q => dout_3(83)
    );
  BU2_U0_grf_rf_mem_dout_i_84 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(84),
      Q => dout_3(84)
    );
  BU2_U0_grf_rf_mem_dout_i_85 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(85),
      Q => dout_3(85)
    );
  BU2_U0_grf_rf_mem_dout_i_86 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(86),
      Q => dout_3(86)
    );
  BU2_U0_grf_rf_mem_dout_i_87 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(87),
      Q => dout_3(87)
    );
  BU2_U0_grf_rf_mem_dout_i_88 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(88),
      Q => dout_3(88)
    );
  BU2_U0_grf_rf_mem_dout_i_89 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(89),
      Q => dout_3(89)
    );
  BU2_U0_grf_rf_mem_dout_i_90 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(90),
      Q => dout_3(90)
    );
  BU2_U0_grf_rf_mem_dout_i_91 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(91),
      Q => dout_3(91)
    );
  BU2_U0_grf_rf_mem_dout_i_92 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(92),
      Q => dout_3(92)
    );
  BU2_U0_grf_rf_mem_dout_i_93 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(93),
      Q => dout_3(93)
    );
  BU2_U0_grf_rf_mem_dout_i_94 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(94),
      Q => dout_3(94)
    );
  BU2_U0_grf_rf_mem_dout_i_95 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(95),
      Q => dout_3(95)
    );
  BU2_U0_grf_rf_mem_dout_i_96 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(96),
      Q => dout_3(96)
    );
  BU2_U0_grf_rf_mem_dout_i_97 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(97),
      Q => dout_3(97)
    );
  BU2_U0_grf_rf_mem_dout_i_98 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(98),
      Q => dout_3(98)
    );
  BU2_U0_grf_rf_mem_dout_i_99 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(99),
      Q => dout_3(99)
    );
  BU2_U0_grf_rf_mem_dout_i_100 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(100),
      Q => dout_3(100)
    );
  BU2_U0_grf_rf_mem_dout_i_101 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(101),
      Q => dout_3(101)
    );
  BU2_U0_grf_rf_mem_dout_i_102 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(102),
      Q => dout_3(102)
    );
  BU2_U0_grf_rf_mem_dout_i_103 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(103),
      Q => dout_3(103)
    );
  BU2_U0_grf_rf_mem_dout_i_104 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(104),
      Q => dout_3(104)
    );
  BU2_U0_grf_rf_mem_dout_i_105 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(105),
      Q => dout_3(105)
    );
  BU2_U0_grf_rf_mem_dout_i_106 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(106),
      Q => dout_3(106)
    );
  BU2_U0_grf_rf_mem_dout_i_107 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(107),
      Q => dout_3(107)
    );
  BU2_U0_grf_rf_mem_dout_i_108 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(108),
      Q => dout_3(108)
    );
  BU2_U0_grf_rf_mem_dout_i_109 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(109),
      Q => dout_3(109)
    );
  BU2_U0_grf_rf_mem_dout_i_110 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(110),
      Q => dout_3(110)
    );
  BU2_U0_grf_rf_mem_dout_i_111 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(111),
      Q => dout_3(111)
    );
  BU2_U0_grf_rf_mem_dout_i_112 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(112),
      Q => dout_3(112)
    );
  BU2_U0_grf_rf_mem_dout_i_113 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(113),
      Q => dout_3(113)
    );
  BU2_U0_grf_rf_mem_dout_i_114 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(114),
      Q => dout_3(114)
    );
  BU2_U0_grf_rf_mem_dout_i_115 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(115),
      Q => dout_3(115)
    );
  BU2_U0_grf_rf_mem_dout_i_116 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(116),
      Q => dout_3(116)
    );
  BU2_U0_grf_rf_mem_dout_i_117 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(117),
      Q => dout_3(117)
    );
  BU2_U0_grf_rf_mem_dout_i_118 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(118),
      Q => dout_3(118)
    );
  BU2_U0_grf_rf_mem_dout_i_119 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(119),
      Q => dout_3(119)
    );
  BU2_U0_grf_rf_mem_dout_i_120 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(120),
      Q => dout_3(120)
    );
  BU2_U0_grf_rf_mem_dout_i_121 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(121),
      Q => dout_3(121)
    );
  BU2_U0_grf_rf_mem_dout_i_122 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(122),
      Q => dout_3(122)
    );
  BU2_U0_grf_rf_mem_dout_i_123 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(123),
      Q => dout_3(123)
    );
  BU2_U0_grf_rf_mem_dout_i_124 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(124),
      Q => dout_3(124)
    );
  BU2_U0_grf_rf_mem_dout_i_125 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(125),
      Q => dout_3(125)
    );
  BU2_U0_grf_rf_mem_dout_i_126 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(126),
      Q => dout_3(126)
    );
  BU2_U0_grf_rf_mem_dout_i_127 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_mem_dout_i_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i(127),
      Q => dout_3(127)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM222 : RAM32X1D
    port map (
      A0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      A1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      A2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      A3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      A4 => BU2_rd_data_count(0),
      D => din_2(127),
      DPRA0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      DPRA1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      DPRA2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      DPRA3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      DPRA4 => BU2_rd_data_count(0),
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      SPO => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM222_SPO_UNCONNECTED,
      DPO => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(127)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM221 : RAM32X1D
    port map (
      A0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      A1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      A2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      A3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      A4 => BU2_rd_data_count(0),
      D => din_2(126),
      DPRA0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      DPRA1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      DPRA2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      DPRA3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      DPRA4 => BU2_rd_data_count(0),
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      SPO => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM221_SPO_UNCONNECTED,
      DPO => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(126)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM21 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(121),
      DIA(0) => din_2(120),
      DIB(1) => din_2(123),
      DIB(0) => din_2(122),
      DIC(1) => din_2(125),
      DIC(0) => din_2(124),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(121),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(120),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(123),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(122),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(125),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(124),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM21_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM21_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM19 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(109),
      DIA(0) => din_2(108),
      DIB(1) => din_2(111),
      DIB(0) => din_2(110),
      DIC(1) => din_2(113),
      DIC(0) => din_2(112),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(109),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(108),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(111),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(110),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(113),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(112),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM19_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM19_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM18 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(103),
      DIA(0) => din_2(102),
      DIB(1) => din_2(105),
      DIB(0) => din_2(104),
      DIC(1) => din_2(107),
      DIC(0) => din_2(106),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(103),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(102),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(105),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(104),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(107),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(106),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM18_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM18_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM20 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(115),
      DIA(0) => din_2(114),
      DIB(1) => din_2(117),
      DIB(0) => din_2(116),
      DIC(1) => din_2(119),
      DIC(0) => din_2(118),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(115),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(114),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(117),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(116),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(119),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(118),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM20_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM20_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM16 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(91),
      DIA(0) => din_2(90),
      DIB(1) => din_2(93),
      DIB(0) => din_2(92),
      DIC(1) => din_2(95),
      DIC(0) => din_2(94),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(91),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(90),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(93),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(92),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(95),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(94),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM16_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM16_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM15 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(85),
      DIA(0) => din_2(84),
      DIB(1) => din_2(87),
      DIB(0) => din_2(86),
      DIC(1) => din_2(89),
      DIC(0) => din_2(88),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(85),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(84),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(87),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(86),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(89),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(88),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM15_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM15_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM17 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(97),
      DIA(0) => din_2(96),
      DIB(1) => din_2(99),
      DIB(0) => din_2(98),
      DIC(1) => din_2(101),
      DIC(0) => din_2(100),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(97),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(96),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(99),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(98),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(101),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(100),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM17_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM17_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM13 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(73),
      DIA(0) => din_2(72),
      DIB(1) => din_2(75),
      DIB(0) => din_2(74),
      DIC(1) => din_2(77),
      DIC(0) => din_2(76),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(73),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(72),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(75),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(74),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(77),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(76),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM13_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM13_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM12 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(67),
      DIA(0) => din_2(66),
      DIB(1) => din_2(69),
      DIB(0) => din_2(68),
      DIC(1) => din_2(71),
      DIC(0) => din_2(70),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(67),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(66),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(69),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(68),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(71),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(70),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM12_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM12_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM14 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(79),
      DIA(0) => din_2(78),
      DIB(1) => din_2(81),
      DIB(0) => din_2(80),
      DIC(1) => din_2(83),
      DIC(0) => din_2(82),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(79),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(78),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(81),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(80),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(83),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(82),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM14_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM14_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM11 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(61),
      DIA(0) => din_2(60),
      DIB(1) => din_2(63),
      DIB(0) => din_2(62),
      DIC(1) => din_2(65),
      DIC(0) => din_2(64),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(61),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(60),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(63),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(62),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(65),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(64),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM11_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM11_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM10 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(55),
      DIA(0) => din_2(54),
      DIB(1) => din_2(57),
      DIB(0) => din_2(56),
      DIC(1) => din_2(59),
      DIC(0) => din_2(58),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(55),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(54),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(57),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(56),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(59),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(58),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM10_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM10_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM8 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(43),
      DIA(0) => din_2(42),
      DIB(1) => din_2(45),
      DIB(0) => din_2(44),
      DIC(1) => din_2(47),
      DIC(0) => din_2(46),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(43),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(42),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(45),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(44),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(47),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(46),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM8_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM8_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM7 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(37),
      DIA(0) => din_2(36),
      DIB(1) => din_2(39),
      DIB(0) => din_2(38),
      DIC(1) => din_2(41),
      DIC(0) => din_2(40),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(37),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(36),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(39),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(38),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(41),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(40),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM7_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM7_DOD_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM9 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(49),
      DIA(0) => din_2(48),
      DIB(1) => din_2(51),
      DIB(0) => din_2(50),
      DIC(1) => din_2(53),
      DIC(0) => din_2(52),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(49),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(48),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(51),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(50),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(53),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(52),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM9_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM9_DOD_0_UNCONNECTED
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
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM6 : RAM32M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA(1) => din_2(31),
      DIA(0) => din_2(30),
      DIB(1) => din_2(33),
      DIB(0) => din_2(32),
      DIC(1) => din_2(35),
      DIC(0) => din_2(34),
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
      DOA(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(31),
      DOA(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(30),
      DOB(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(33),
      DOB(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(32),
      DOC(1) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(35),
      DOC(0) => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(34),
      DOD(1) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM6_DOD_1_UNCONNECTED,
      DOD(0) => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM6_DOD_0_UNCONNECTED
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
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_346
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
      Q => BU2_U0_grf_rf_rstblk_rst_d1_277
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg : FDPE
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_273,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_278
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_279,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_275
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg : FDPE
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_275,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_279
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_278,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_273
    );
  BU2_U0_grf_rf_rstblk_rst_d2 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_rst_d1_277,
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rst_d2_269
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_275,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_276
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_273,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_274
    );
  BU2_U0_grf_rf_rstblk_rst_d3 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_rst_d2_269,
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rst_d3_271
    );
  BU2_U0_grf_rf_rstblk_RST_FULL_GEN : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => rst,
      D => BU2_U0_grf_rf_rstblk_rst_d3_271,
      Q => BU2_U0_grf_rf_rstblk_RST_FULL_GEN_272
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rst_d2_269,
      Q => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_270
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rst_d2_269,
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
      Q => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267
    );
  BU2_XST_GND : GND
    port map (
      G => BU2_rd_data_count(0)
    );

end STRUCTURE;

-- synthesis translate_on
