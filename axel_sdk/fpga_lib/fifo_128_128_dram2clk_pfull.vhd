--------------------------------------------------------------------------------
-- Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: L.57
--  \   \         Application: netgen
--  /   /         Filename: fifo_128_128_dram2clk_pfull.vhd
-- /___/   /\     Timestamp: Wed Mar 17 17:02:54 2010
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl ./tmp/_cg/fifo_128_128_dram2clk_pfull.ngc ./tmp/_cg/fifo_128_128_dram2clk_pfull.vhd 
-- Device	: 5vlx330tff1738-2
-- Input file	: ./tmp/_cg/fifo_128_128_dram2clk_pfull.ngc
-- Output file	: ./tmp/_cg/fifo_128_128_dram2clk_pfull.vhd
-- # of Entities	: 1
-- Design Name	: fifo_128_128_dram2clk_pfull
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

entity fifo_128_128_dram2clk_pfull is
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
end fifo_128_128_dram2clk_pfull;

architecture STRUCTURE of fifo_128_128_dram2clk_pfull is
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_127_rstpot_815 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_126_rstpot_814 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_125_rstpot_813 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_124_rstpot_812 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_123_rstpot_811 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_122_rstpot_810 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_121_rstpot_809 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_120_rstpot_808 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_119_rstpot_807 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_118_rstpot_806 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_117_rstpot_805 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_116_rstpot_804 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_115_rstpot_803 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_114_rstpot_802 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_113_rstpot_801 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_112_rstpot_800 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_111_rstpot_799 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_110_rstpot_798 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_109_rstpot_797 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_108_rstpot_796 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_107_rstpot_795 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_106_rstpot_794 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_105_rstpot_793 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_104_rstpot_792 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_103_rstpot_791 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_102_rstpot_790 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_101_rstpot_789 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_100_rstpot_788 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_99_rstpot_787 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_98_rstpot_786 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_97_rstpot_785 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_96_rstpot_784 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_95_rstpot_783 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_94_rstpot_782 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_93_rstpot_781 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_92_rstpot_780 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_91_rstpot_779 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_90_rstpot_778 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_89_rstpot_777 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_88_rstpot_776 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_87_rstpot_775 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_86_rstpot_774 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_85_rstpot_773 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_84_rstpot_772 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_83_rstpot_771 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_82_rstpot_770 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_81_rstpot_769 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_80_rstpot_768 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_79_rstpot_767 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_78_rstpot_766 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_77_rstpot_765 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_76_rstpot_764 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_75_rstpot_763 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_74_rstpot_762 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_73_rstpot_761 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_72_rstpot_760 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_71_rstpot_759 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_70_rstpot_758 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_69_rstpot_757 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_68_rstpot_756 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_67_rstpot_755 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_66_rstpot_754 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_65_rstpot_753 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_64_rstpot_752 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_63_rstpot_751 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_62_rstpot_750 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_61_rstpot_749 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_60_rstpot_748 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_59_rstpot_747 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_58_rstpot_746 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_57_rstpot_745 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_56_rstpot_744 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_55_rstpot_743 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_54_rstpot_742 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_53_rstpot_741 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_52_rstpot_740 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_51_rstpot_739 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_50_rstpot_738 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_49_rstpot_737 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_48_rstpot_736 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_47_rstpot_735 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_46_rstpot_734 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_45_rstpot_733 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_44_rstpot_732 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_43_rstpot_731 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_42_rstpot_730 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_41_rstpot_729 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_40_rstpot_728 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_39_rstpot_727 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_38_rstpot_726 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_37_rstpot_725 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_36_rstpot_724 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_35_rstpot_723 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_34_rstpot_722 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_33_rstpot_721 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_32_rstpot_720 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_719 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_718 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_717 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_716 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_715 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_714 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_713 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_712 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_711 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_710 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_709 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_708 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_707 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_706 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_705 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_704 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_703 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_702 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_701 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_700 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_699 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_698 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_697 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_696 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_695 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_694 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_693 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_692 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_691 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_690 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_689 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_688 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000225_687 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000175_686 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000112_685 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000049_684 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000225_683 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000175_682 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000112_681 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or000049_680 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_dout_i_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1_402 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_371 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count5 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_276 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_275 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_274 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_273 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_272 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_271 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_270 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_267 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000 : STD_LOGIC; 
  signal NLW_VCC_P_UNCONNECTED : STD_LOGIC; 
  signal NLW_GND_G_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM432_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM431_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM42_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM40_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM39_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM41_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM38_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM37_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM35_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM34_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM36_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM33_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM32_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM30_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM29_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM31_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM27_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM26_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM28_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM24_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM23_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM25_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM22_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM21_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM19_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM18_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM20_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM16_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM15_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM17_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM13_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM12_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM14_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM11_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM10_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM8_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM7_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM9_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM6_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1_DOD_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3_DOD_UNCONNECTED : STD_LOGIC; 
  signal din_2 : STD_LOGIC_VECTOR ( 127 downto 0 ); 
  signal dout_3 : STD_LOGIC_VECTOR ( 127 downto 0 ); 
  signal BU2_U0_grf_rf_mem_gdm_dm_dout_i : STD_LOGIC_VECTOR ( 127 downto 0 ); 
  signal BU2_U0_grf_rf_mem_gdm_dm_varindex0000 : STD_LOGIC_VECTOR ( 127 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d2 : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d1 : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad : STD_LOGIC_VECTOR ( 6 downto 3 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut : STD_LOGIC_VECTOR ( 6 downto 1 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000 : STD_LOGIC_VECTOR ( 6 downto 3 ); 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001 : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_d1 : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1 : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1 : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin : STD_LOGIC_VECTOR ( 5 downto 0 ); 
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
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000242 : LUT6
    generic map(
      INIT => X"F222F000F000F000"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_270,
      I2 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000175_682,
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000225_683,
      I4 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000112_681,
      I5 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or000049_680,
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_127_rstpot_815
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_126_rstpot_814
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_125_rstpot_813
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_124_rstpot_812
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_123_rstpot_811
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_122_rstpot_810
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_121_rstpot_809
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_120_rstpot_808
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_119_rstpot_807
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_118_rstpot_806
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_117_rstpot_805
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_116_rstpot_804
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_115_rstpot_803
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_114_rstpot_802
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_113_rstpot_801
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_112_rstpot_800
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_111_rstpot_799
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_110_rstpot_798
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_109_rstpot_797
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_108_rstpot_796
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_107_rstpot_795
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_106_rstpot_794
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_105_rstpot_793
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_104_rstpot_792
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_103_rstpot_791
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_102_rstpot_790
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_101_rstpot_789
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_100_rstpot_788
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_99_rstpot_787
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_98_rstpot_786
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_97_rstpot_785
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_96_rstpot_784
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_95_rstpot_783
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_94_rstpot_782
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_93_rstpot_781
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_92_rstpot_780
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_91_rstpot_779
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_90_rstpot_778
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_89_rstpot_777
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_88_rstpot_776
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_87_rstpot_775
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_86_rstpot_774
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_85_rstpot_773
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_84_rstpot_772
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_83_rstpot_771
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_82_rstpot_770
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_81_rstpot_769
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_80_rstpot_768
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_79_rstpot_767
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_78_rstpot_766
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_77_rstpot_765
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_76_rstpot_764
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_75_rstpot_763
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_74_rstpot_762
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_73_rstpot_761
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_72_rstpot_760
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_71_rstpot_759
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_70_rstpot_758
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_69_rstpot_757
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_68_rstpot_756
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_67_rstpot_755
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_66_rstpot_754
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_65_rstpot_753
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_64_rstpot_752
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_63_rstpot_751
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_62_rstpot_750
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_61_rstpot_749
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_60_rstpot_748
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_59_rstpot_747
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_58_rstpot_746
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_57_rstpot_745
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_56_rstpot_744
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_55_rstpot_743
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_54_rstpot_742
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_53_rstpot_741
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_52_rstpot_740
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_51_rstpot_739
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_50_rstpot_738
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_49_rstpot_737
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_48_rstpot_736
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_47_rstpot_735
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_46_rstpot_734
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_45_rstpot_733
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_44_rstpot_732
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_43_rstpot_731
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_42_rstpot_730
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_41_rstpot_729
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_40_rstpot_728
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_39_rstpot_727
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_38_rstpot_726
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_37_rstpot_725
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_36_rstpot_724
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_35_rstpot_723
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_34_rstpot_722
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_33_rstpot_721
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_32_rstpot_720
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_719
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_718
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_717
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_716
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_715
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_714
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_713
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_712
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_711
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_710
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_709
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_708
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_707
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_706
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_705
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_704
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_703
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_702
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_701
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_700
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_699
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_698
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_697
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_696
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_695
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_694
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_693
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_692
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_691
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_690
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_689
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
      O => BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_688
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_bin_xor0004_Result1 : LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I4 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1),
      I5 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(0),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0004
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0004_Result1 : LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      I4 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(1),
      I5 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(0),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0004
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_bin_xor0003_Result1 : LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I4 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0003_Result1 : LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      I4 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(1),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_bin_xor0002_Result1 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0002_Result1 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_bin_xor0001_Result1 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0001_Result1 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_127 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_127_rstpot_815,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(127)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_126 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_126_rstpot_814,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(126)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_125 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_125_rstpot_813,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(125)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_124 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_124_rstpot_812,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(124)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_123 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_123_rstpot_811,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(123)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_122 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_122_rstpot_810,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(122)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_121 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_121_rstpot_809,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(121)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_120 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_120_rstpot_808,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(120)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_119 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_119_rstpot_807,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(119)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_118 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_118_rstpot_806,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(118)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_117 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_117_rstpot_805,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(117)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_116 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_116_rstpot_804,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(116)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_115 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_115_rstpot_803,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(115)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_114 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_114_rstpot_802,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(114)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_113 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_113_rstpot_801,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(113)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_112 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_112_rstpot_800,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(112)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_111 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_111_rstpot_799,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(111)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_110 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_110_rstpot_798,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(110)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_109 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_109_rstpot_797,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(109)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_108 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_108_rstpot_796,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(108)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_107 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_107_rstpot_795,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(107)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_106 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_106_rstpot_794,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(106)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_105 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_105_rstpot_793,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(105)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_104 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_104_rstpot_792,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(104)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_103 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_103_rstpot_791,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(103)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_102 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_102_rstpot_790,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(102)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_101 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_101_rstpot_789,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(101)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_100 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_100_rstpot_788,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(100)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_99 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_99_rstpot_787,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(99)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_98 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_98_rstpot_786,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(98)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_97 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_97_rstpot_785,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(97)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_96 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_96_rstpot_784,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(96)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_95 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_95_rstpot_783,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(95)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_94 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_94_rstpot_782,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(94)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_93 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_93_rstpot_781,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(93)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_92 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_92_rstpot_780,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(92)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_91 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_91_rstpot_779,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(91)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_90 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_90_rstpot_778,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(90)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_89 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_89_rstpot_777,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(89)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_88 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_88_rstpot_776,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(88)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_87 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_87_rstpot_775,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(87)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_86 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_86_rstpot_774,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(86)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_85 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_85_rstpot_773,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(85)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_84 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_84_rstpot_772,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(84)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_83 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_83_rstpot_771,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(83)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_82 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_82_rstpot_770,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(82)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_81 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_81_rstpot_769,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(81)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_80 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_80_rstpot_768,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(80)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_79 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_79_rstpot_767,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(79)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_78 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_78_rstpot_766,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(78)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_77 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_77_rstpot_765,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(77)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_76 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_76_rstpot_764,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(76)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_75 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_75_rstpot_763,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(75)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_74 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_74_rstpot_762,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(74)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_73 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_73_rstpot_761,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(73)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_72 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_72_rstpot_760,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(72)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_71 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_71_rstpot_759,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(71)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_70 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_70_rstpot_758,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(70)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_69 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_69_rstpot_757,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(69)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_68 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_68_rstpot_756,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(68)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_67 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_67_rstpot_755,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(67)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_66 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_66_rstpot_754,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(66)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_65 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_65_rstpot_753,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(65)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_64 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_64_rstpot_752,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(64)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_63 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_63_rstpot_751,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(63)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_62 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_62_rstpot_750,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(62)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_61 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_61_rstpot_749,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(61)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_60 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_60_rstpot_748,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(60)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_59 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_59_rstpot_747,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(59)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_58 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_58_rstpot_746,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(58)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_57 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_57_rstpot_745,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(57)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_56 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_56_rstpot_744,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(56)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_55 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_55_rstpot_743,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(55)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_54 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_54_rstpot_742,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(54)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_53 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_53_rstpot_741,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(53)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_52 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_52_rstpot_740,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(52)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_51 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_51_rstpot_739,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(51)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_50 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_50_rstpot_738,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(50)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_49 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_49_rstpot_737,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(49)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_48 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_48_rstpot_736,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(48)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_47 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_47_rstpot_735,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(47)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_46 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_46_rstpot_734,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(46)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_45 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_45_rstpot_733,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(45)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_44 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_44_rstpot_732,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(44)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_43 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_43_rstpot_731,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(43)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_42 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_42_rstpot_730,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(42)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_41 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_41_rstpot_729,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(41)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_40 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_40_rstpot_728,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(40)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_39 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_39_rstpot_727,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(39)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_38 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_38_rstpot_726,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(38)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_37 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_37_rstpot_725,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(37)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_36 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_36_rstpot_724,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(36)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_35 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_35_rstpot_723,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(35)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_34 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_34_rstpot_722,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(34)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_33 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_33_rstpot_721,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(33)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_32 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_32_rstpot_720,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(32)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_31 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_31_rstpot_719,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(31)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_30 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_30_rstpot_718,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(30)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_29 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_29_rstpot_717,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(29)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_28 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_28_rstpot_716,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(28)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_27 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_27_rstpot_715,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(27)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_26 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_26_rstpot_714,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(26)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_25 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_25_rstpot_713,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(25)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_24 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_24_rstpot_712,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(24)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_23 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_23_rstpot_711,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(23)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_22 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_22_rstpot_710,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(22)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_21 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_21_rstpot_709,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(21)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_20 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_20_rstpot_708,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(20)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_19 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_19_rstpot_707,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(19)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_18 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_18_rstpot_706,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(18)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_17 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_17_rstpot_705,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(17)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_16 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_16_rstpot_704,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(16)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_15 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_15_rstpot_703,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(15)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_14 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_14_rstpot_702,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(14)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_13 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_13_rstpot_701,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(13)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_12 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_12_rstpot_700,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(12)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_11 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_11_rstpot_699,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(11)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_10 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_10_rstpot_698,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(10)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_9 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_9_rstpot_697,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(9)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_8_rstpot_696,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(8)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_7_rstpot_695,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(7)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_6_rstpot_694,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(6)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_5_rstpot_693,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(5)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_4_rstpot_692,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(4)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_3_rstpot_691,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(3)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_2_rstpot_690,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(2)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_1_rstpot_689,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(1)
    );
  BU2_U0_grf_rf_mem_gdm_dm_dout_i_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      D => BU2_U0_grf_rf_mem_gdm_dm_dout_i_0_rstpot_688,
      Q => BU2_U0_grf_rf_mem_gdm_dm_dout_i(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_6_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(5),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(6)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_5_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(5)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_4_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_3_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_2_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(2)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_1_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(1)
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_bin_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000242 : LUT5
    generic map(
      INIT => X"ECA0CC00"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      I1 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000175_686,
      I2 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000112_685,
      I3 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000225_687,
      I4 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000049_684,
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000225 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I5 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000225_687
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000175 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      I5 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000175_686
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000112 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I5 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000112_685
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000049 : LUT6
    generic map(
      INIT => X"8040201008040201"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count(5),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      I5 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000049_684
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000225 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      I5 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000225_683
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000175 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(5),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      I5 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000175_682
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000112 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I5 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000112_681
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or000049 : LUT6
    generic map(
      INIT => X"8200410000820041"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(5),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      I5 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or000049_680
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
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_not00011 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1_402,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_270,
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_not0001
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_5_11 : LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(5),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I5 => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count5
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_5_11 : LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I5 => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_4_11 : LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_4_11 : LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux00031 : LUT5
    generic map(
      INIT => X"55554440"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1_402,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(5),
      I2 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(3),
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(4),
      I4 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(6),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux0003
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
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_371,
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
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0002_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0003_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0004_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0004
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0002_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0003_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0004_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004
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
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_275,
      I1 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_272,
      O => BU2_U0_grf_rf_rstblk_rd_rst_comb
    );
  BU2_U0_grf_rf_rstblk_wr_rst_comb1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_276,
      I1 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_274,
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
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM432 : RAM64X1D
    port map (
      A0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      A1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      A2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      A3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      A4 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      A5 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      D => din_2(127),
      DPRA0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      DPRA1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      DPRA2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      DPRA3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      DPRA4 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      DPRA5 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      SPO => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM432_SPO_UNCONNECTED,
      DPO => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(127)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM431 : RAM64X1D
    port map (
      A0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      A1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      A2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      A3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      A4 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      A5 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      D => din_2(126),
      DPRA0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      DPRA1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      DPRA2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      DPRA3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      DPRA4 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      DPRA5 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      SPO => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM431_SPO_UNCONNECTED,
      DPO => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(126)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM42 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(123),
      DIB => din_2(124),
      DIC => din_2(125),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(123),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(124),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(125),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM42_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM40 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(117),
      DIB => din_2(118),
      DIC => din_2(119),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(117),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(118),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(119),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM40_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM39 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(114),
      DIB => din_2(115),
      DIC => din_2(116),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(114),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(115),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(116),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM39_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM41 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(120),
      DIB => din_2(121),
      DIC => din_2(122),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(120),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(121),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(122),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM41_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM38 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(111),
      DIB => din_2(112),
      DIC => din_2(113),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(111),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(112),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(113),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM38_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM37 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(108),
      DIB => din_2(109),
      DIC => din_2(110),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(108),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(109),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(110),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM37_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM35 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(102),
      DIB => din_2(103),
      DIC => din_2(104),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(102),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(103),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(104),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM35_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM34 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(99),
      DIB => din_2(100),
      DIC => din_2(101),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(99),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(100),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(101),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM34_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM36 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(105),
      DIB => din_2(106),
      DIC => din_2(107),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(105),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(106),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(107),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM36_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM33 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(96),
      DIB => din_2(97),
      DIC => din_2(98),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(96),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(97),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(98),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM33_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM32 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(93),
      DIB => din_2(94),
      DIC => din_2(95),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(93),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(94),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(95),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM32_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM30 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(87),
      DIB => din_2(88),
      DIC => din_2(89),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(87),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(88),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(89),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM30_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM29 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(84),
      DIB => din_2(85),
      DIC => din_2(86),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(84),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(85),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(86),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM29_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM31 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(90),
      DIB => din_2(91),
      DIC => din_2(92),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(90),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(91),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(92),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM31_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM27 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(78),
      DIB => din_2(79),
      DIC => din_2(80),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(78),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(79),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(80),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM27_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM26 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(75),
      DIB => din_2(76),
      DIC => din_2(77),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(75),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(76),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(77),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM26_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM28 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(81),
      DIB => din_2(82),
      DIC => din_2(83),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(81),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(82),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(83),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM28_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM24 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(69),
      DIB => din_2(70),
      DIC => din_2(71),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(69),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(70),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(71),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM24_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM23 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(66),
      DIB => din_2(67),
      DIC => din_2(68),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(66),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(67),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(68),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM23_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM25 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(72),
      DIB => din_2(73),
      DIC => din_2(74),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(72),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(73),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(74),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM25_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM22 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(63),
      DIB => din_2(64),
      DIC => din_2(65),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(63),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(64),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(65),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM22_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM21 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(60),
      DIB => din_2(61),
      DIC => din_2(62),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(60),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(61),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(62),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM21_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM19 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(54),
      DIB => din_2(55),
      DIC => din_2(56),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(54),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(55),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(56),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM19_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM18 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(51),
      DIB => din_2(52),
      DIC => din_2(53),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(51),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(52),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(53),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM18_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM20 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(57),
      DIB => din_2(58),
      DIC => din_2(59),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(57),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(58),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(59),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM20_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM16 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(45),
      DIB => din_2(46),
      DIC => din_2(47),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(45),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(46),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(47),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM16_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM15 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(42),
      DIB => din_2(43),
      DIC => din_2(44),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(42),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(43),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(44),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM15_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM17 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(48),
      DIB => din_2(49),
      DIC => din_2(50),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(48),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(49),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(50),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM17_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM13 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(36),
      DIB => din_2(37),
      DIC => din_2(38),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(36),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(37),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(38),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM13_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM12 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(33),
      DIB => din_2(34),
      DIC => din_2(35),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(33),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(34),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(35),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM12_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM14 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(39),
      DIB => din_2(40),
      DIC => din_2(41),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(39),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(40),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(41),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM14_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM11 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(30),
      DIB => din_2(31),
      DIC => din_2(32),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(30),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(31),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(32),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM11_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM10 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(27),
      DIB => din_2(28),
      DIC => din_2(29),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(27),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(28),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(29),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM10_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM8 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(21),
      DIB => din_2(22),
      DIC => din_2(23),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(21),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(22),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(23),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM8_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM7 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(18),
      DIB => din_2(19),
      DIC => din_2(20),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(18),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(19),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(20),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM7_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM9 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(24),
      DIB => din_2(25),
      DIC => din_2(26),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(24),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(25),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(26),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM9_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(12),
      DIB => din_2(13),
      DIC => din_2(14),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(12),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(13),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(14),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM5_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(9),
      DIB => din_2(10),
      DIC => din_2(11),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(9),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(10),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(11),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM4_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM6 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(15),
      DIB => din_2(16),
      DIC => din_2(17),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(15),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(16),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(17),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM6_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(3),
      DIB => din_2(4),
      DIC => din_2(5),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(3),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(4),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(5),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM2_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(0),
      DIB => din_2(1),
      DIC => din_2(2),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(0),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(1),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(2),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM1_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3 : RAM64M
    generic map(
      INIT_C => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_D => X"0000000000000000",
      INIT_A => X"0000000000000000"
    )
    port map (
      WCLK => wr_clk,
      WE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      DIA => din_2(6),
      DIB => din_2(7),
      DIC => din_2(8),
      DID => BU2_rd_data_count(0),
      DOA => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(6),
      DOB => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(7),
      DOC => BU2_U0_grf_rf_mem_gdm_dm_varindex0000(8),
      DOD => NLW_BU2_U0_grf_rf_mem_gdm_dm_Mram_RAM3_DOD_UNCONNECTED,
      ADDRA(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRA(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRA(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRA(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRA(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRA(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRC(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRC(4) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRC(3) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRC(2) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRC(1) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRC(0) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRD(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRD(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRD(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRD(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRD(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRD(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
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
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4)
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
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5)
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
  BU2_U0_grf_rf_gl0_wr_wpntr_count_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(5)
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
  BU2_U0_grf_rf_gl0_wr_wpntr_count_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_not0001,
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux0003,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => prog_full
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1_402
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(3),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(4),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(5),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(5)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(6),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(6)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_0_Q : MUXCY
    port map (
      CI => BU2_rd_data_count(0),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      S => BU2_rd_data_count(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(0),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(1)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(1),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(2)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(2),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(3),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(2),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(3),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(3),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(3),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(4),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(5),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(5)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(4),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(5),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(5)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(5),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(6),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(6)
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
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_371
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
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(5),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5)
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
  BU2_U0_grf_rf_gl0_rd_rpntr_count_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count5,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(5)
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
  BU2_U0_grf_rf_gl0_rd_rpntr_count_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(5)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(5)
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
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(4),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(5),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(5)
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
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(4),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(5),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(5)
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
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(4),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(5),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5)
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
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(4),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(5),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(5)
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
  BU2_U0_grf_rf_rstblk_rd_rst_asreg : FDPE
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_271,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_275
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_276,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_273
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg : FDPE
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_273,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_276
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_275,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_271
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_273,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_274
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_271,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_272
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_270
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
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
