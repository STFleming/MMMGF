////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: M.63c
//  \   \         Application: netgen
//  /   /         Filename: mem_fifo.v
// /___/   /\     Timestamp: Tue Oct  5 17:29:28 2010
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -w -sim -ofmt verilog ./tmp/_cg/mem_fifo.ngc ./tmp/_cg/mem_fifo.v 
// Device	: 5vlx330tff1738-2
// Input file	: ./tmp/_cg/mem_fifo.ngc
// Output file	: ./tmp/_cg/mem_fifo.v
// # of Modules	: 1
// Design Name	: mem_fifo
// Xilinx        : /opt/Xilinx/12.2/ISE_DS/ISE/
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module mem_fifo (
  valid, rd_en, prog_full, wr_en, full, empty, wr_clk, rst, rd_clk, dout, din
)/* synthesis syn_black_box syn_noprune=1 */;
  output valid;
  input rd_en;
  output prog_full;
  input wr_en;
  output full;
  output empty;
  input wr_clk;
  input rst;
  input rd_clk;
  output [127 : 0] dout;
  input [127 : 0] din;
  
  // synthesis translate_off
  
  wire \BU2/N39 ;
  wire \BU2/N38 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_127_rstpot_790 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_126_rstpot_789 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_125_rstpot_788 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_124_rstpot_787 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_123_rstpot_786 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_122_rstpot_785 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_121_rstpot_784 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_120_rstpot_783 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_119_rstpot_782 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_118_rstpot_781 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_117_rstpot_780 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_116_rstpot_779 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_115_rstpot_778 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_114_rstpot_777 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_113_rstpot_776 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_112_rstpot_775 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_111_rstpot_774 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_110_rstpot_773 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_109_rstpot_772 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_108_rstpot_771 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_107_rstpot_770 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_106_rstpot_769 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_105_rstpot_768 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_104_rstpot_767 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_103_rstpot_766 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_102_rstpot_765 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_101_rstpot_764 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_100_rstpot_763 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_99_rstpot_762 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_98_rstpot_761 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_97_rstpot_760 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_96_rstpot_759 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_95_rstpot_758 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_94_rstpot_757 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_93_rstpot_756 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_92_rstpot_755 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_91_rstpot_754 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_90_rstpot_753 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_89_rstpot_752 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_88_rstpot_751 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_87_rstpot_750 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_86_rstpot_749 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_85_rstpot_748 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_84_rstpot_747 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_83_rstpot_746 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_82_rstpot_745 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_81_rstpot_744 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_80_rstpot_743 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_79_rstpot_742 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_78_rstpot_741 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_77_rstpot_740 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_76_rstpot_739 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_75_rstpot_738 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_74_rstpot_737 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_73_rstpot_736 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_72_rstpot_735 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_71_rstpot_734 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_70_rstpot_733 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_69_rstpot_732 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_68_rstpot_731 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_67_rstpot_730 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_66_rstpot_729 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_65_rstpot_728 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_64_rstpot_727 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_63_rstpot_726 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_62_rstpot_725 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_61_rstpot_724 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_60_rstpot_723 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_59_rstpot_722 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_58_rstpot_721 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_57_rstpot_720 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_56_rstpot_719 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_55_rstpot_718 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_54_rstpot_717 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_53_rstpot_716 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_52_rstpot_715 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_51_rstpot_714 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_50_rstpot_713 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_49_rstpot_712 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_48_rstpot_711 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_47_rstpot_710 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_46_rstpot_709 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_45_rstpot_708 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_44_rstpot_707 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_43_rstpot_706 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_42_rstpot_705 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_41_rstpot_704 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_40_rstpot_703 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_39_rstpot_702 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_38_rstpot_701 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_37_rstpot_700 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_36_rstpot_699 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_35_rstpot_698 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_34_rstpot_697 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_33_rstpot_696 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_32_rstpot_695 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_31_rstpot_694 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_30_rstpot_693 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_29_rstpot_692 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_28_rstpot_691 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_27_rstpot_690 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_26_rstpot_689 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_25_rstpot_688 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_24_rstpot_687 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_23_rstpot_686 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_22_rstpot_685 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_21_rstpot_684 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_20_rstpot_683 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_19_rstpot_682 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_18_rstpot_681 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_17_rstpot_680 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_16_rstpot_679 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_15_rstpot_678 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_14_rstpot_677 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_13_rstpot_676 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_12_rstpot_675 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_11_rstpot_674 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_10_rstpot_673 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_9_rstpot_672 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_8_rstpot_671 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_7_rstpot_670 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_6_rstpot_669 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_5_rstpot_668 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_4_rstpot_667 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_3_rstpot_666 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_2_rstpot_665 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_1_rstpot_664 ;
  wire \BU2/U0/grf.rf/mem/gdm.dm/dout_i_0_rstpot_663 ;
  wire \BU2/N36 ;
  wire \BU2/N34 ;
  wire \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000176_659 ;
  wire \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000126_658 ;
  wire \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux000086_657 ;
  wire \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000176_656 ;
  wire \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000126_655 ;
  wire \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or000086_654 ;
  wire \BU2/U0/grf.rf/mem/dout_i_not0001 ;
  wire \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count2 ;
  wire \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count ;
  wire \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count1 ;
  wire \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count3 ;
  wire \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count4 ;
  wire \BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ;
  wire \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i_mux0003 ;
  wire \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i_not0001 ;
  wire \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_fb_362 ;
  wire \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_i_mux0000 ;
  wire \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count2 ;
  wire \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count ;
  wire \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count1 ;
  wire \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count3 ;
  wire \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count4 ;
  wire \BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ;
  wire \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0003 ;
  wire \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0002 ;
  wire \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0001 ;
  wire \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0000 ;
  wire \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0003 ;
  wire \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0002 ;
  wire \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0001 ;
  wire \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0000 ;
  wire \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0003 ;
  wire \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0002 ;
  wire \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0001 ;
  wire \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0000 ;
  wire \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0003 ;
  wire \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0002 ;
  wire \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0001 ;
  wire \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0000 ;
  wire \BU2/U0/grf.rf/rstblk/wr_rst_comb ;
  wire \BU2/U0/grf.rf/rstblk/rd_rst_comb ;
  wire \BU2/U0/grf.rf/rstblk/wr_rst_asreg_280 ;
  wire \BU2/U0/grf.rf/rstblk/rd_rst_asreg_279 ;
  wire \BU2/U0/grf.rf/rstblk/rst_d1_278 ;
  wire \BU2/U0/grf.rf/rstblk/wr_rst_asreg_d2_277 ;
  wire \BU2/U0/grf.rf/rstblk/wr_rst_asreg_d1_276 ;
  wire \BU2/U0/grf.rf/rstblk/rd_rst_asreg_d2_275 ;
  wire \BU2/U0/grf.rf/rstblk/rd_rst_asreg_d1_274 ;
  wire \BU2/U0/grf.rf/rstblk/RST_FULL_GEN_273 ;
  wire \BU2/U0/grf.rf/rstblk/rst_d3_272 ;
  wire \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_fb_i_271 ;
  wire \BU2/U0/grf.rf/rstblk/rst_d2_270 ;
  wire \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000 ;
  wire \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ;
  wire \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000 ;
  wire NLW_VCC_P_UNCONNECTED;
  wire NLW_GND_G_UNCONNECTED;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM222_SPO_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM221_SPO_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM21_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM21_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM19_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM19_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM18_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM18_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM20_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM20_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM16_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM16_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM15_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM15_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM17_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM17_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM13_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM13_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM12_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM12_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM14_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM14_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM11_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM11_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM10_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM10_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM8_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM8_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM7_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM7_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM9_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM9_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM5_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM5_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM4_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM4_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM6_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM6_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM2_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM2_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM1_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM1_DOD<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM3_DOD<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM3_DOD<0>_UNCONNECTED ;
  wire [127 : 0] din_2;
  wire [127 : 0] dout_3;
  wire [1 : 1] \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_cy ;
  wire [4 : 4] \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_lut ;
  wire [127 : 0] \BU2/U0/grf.rf/mem/gdm.dm/dout_i ;
  wire [127 : 0] \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 ;
  wire [4 : 0] \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 ;
  wire [4 : 0] \BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 ;
  wire [4 : 0] \BU2/U0/grf.rf/gl0.wr/wpntr/count ;
  wire [5 : 2] \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad ;
  wire [5 : 2] \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 ;
  wire [1 : 0] \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state ;
  wire [1 : 0] \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_mux0001 ;
  wire [4 : 0] \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 ;
  wire [4 : 0] \BU2/U0/grf.rf/gl0.rd/rpntr/count ;
  wire [4 : 0] \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc ;
  wire [4 : 0] \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc ;
  wire [4 : 0] \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 ;
  wire [4 : 0] \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg ;
  wire [4 : 0] \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 ;
  wire [4 : 0] \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg ;
  wire [4 : 0] \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin ;
  wire [4 : 0] \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin ;
  wire [1 : 0] \BU2/U0/grf.rf/rstblk/wr_rst_reg ;
  wire [2 : 0] \BU2/U0/grf.rf/rstblk/rd_rst_reg ;
  wire [0 : 0] \BU2/rd_data_count ;
  assign
    dout[127] = dout_3[127],
    dout[126] = dout_3[126],
    dout[125] = dout_3[125],
    dout[124] = dout_3[124],
    dout[123] = dout_3[123],
    dout[122] = dout_3[122],
    dout[121] = dout_3[121],
    dout[120] = dout_3[120],
    dout[119] = dout_3[119],
    dout[118] = dout_3[118],
    dout[117] = dout_3[117],
    dout[116] = dout_3[116],
    dout[115] = dout_3[115],
    dout[114] = dout_3[114],
    dout[113] = dout_3[113],
    dout[112] = dout_3[112],
    dout[111] = dout_3[111],
    dout[110] = dout_3[110],
    dout[109] = dout_3[109],
    dout[108] = dout_3[108],
    dout[107] = dout_3[107],
    dout[106] = dout_3[106],
    dout[105] = dout_3[105],
    dout[104] = dout_3[104],
    dout[103] = dout_3[103],
    dout[102] = dout_3[102],
    dout[101] = dout_3[101],
    dout[100] = dout_3[100],
    dout[99] = dout_3[99],
    dout[98] = dout_3[98],
    dout[97] = dout_3[97],
    dout[96] = dout_3[96],
    dout[95] = dout_3[95],
    dout[94] = dout_3[94],
    dout[93] = dout_3[93],
    dout[92] = dout_3[92],
    dout[91] = dout_3[91],
    dout[90] = dout_3[90],
    dout[89] = dout_3[89],
    dout[88] = dout_3[88],
    dout[87] = dout_3[87],
    dout[86] = dout_3[86],
    dout[85] = dout_3[85],
    dout[84] = dout_3[84],
    dout[83] = dout_3[83],
    dout[82] = dout_3[82],
    dout[81] = dout_3[81],
    dout[80] = dout_3[80],
    dout[79] = dout_3[79],
    dout[78] = dout_3[78],
    dout[77] = dout_3[77],
    dout[76] = dout_3[76],
    dout[75] = dout_3[75],
    dout[74] = dout_3[74],
    dout[73] = dout_3[73],
    dout[72] = dout_3[72],
    dout[71] = dout_3[71],
    dout[70] = dout_3[70],
    dout[69] = dout_3[69],
    dout[68] = dout_3[68],
    dout[67] = dout_3[67],
    dout[66] = dout_3[66],
    dout[65] = dout_3[65],
    dout[64] = dout_3[64],
    dout[63] = dout_3[63],
    dout[62] = dout_3[62],
    dout[61] = dout_3[61],
    dout[60] = dout_3[60],
    dout[59] = dout_3[59],
    dout[58] = dout_3[58],
    dout[57] = dout_3[57],
    dout[56] = dout_3[56],
    dout[55] = dout_3[55],
    dout[54] = dout_3[54],
    dout[53] = dout_3[53],
    dout[52] = dout_3[52],
    dout[51] = dout_3[51],
    dout[50] = dout_3[50],
    dout[49] = dout_3[49],
    dout[48] = dout_3[48],
    dout[47] = dout_3[47],
    dout[46] = dout_3[46],
    dout[45] = dout_3[45],
    dout[44] = dout_3[44],
    dout[43] = dout_3[43],
    dout[42] = dout_3[42],
    dout[41] = dout_3[41],
    dout[40] = dout_3[40],
    dout[39] = dout_3[39],
    dout[38] = dout_3[38],
    dout[37] = dout_3[37],
    dout[36] = dout_3[36],
    dout[35] = dout_3[35],
    dout[34] = dout_3[34],
    dout[33] = dout_3[33],
    dout[32] = dout_3[32],
    dout[31] = dout_3[31],
    dout[30] = dout_3[30],
    dout[29] = dout_3[29],
    dout[28] = dout_3[28],
    dout[27] = dout_3[27],
    dout[26] = dout_3[26],
    dout[25] = dout_3[25],
    dout[24] = dout_3[24],
    dout[23] = dout_3[23],
    dout[22] = dout_3[22],
    dout[21] = dout_3[21],
    dout[20] = dout_3[20],
    dout[19] = dout_3[19],
    dout[18] = dout_3[18],
    dout[17] = dout_3[17],
    dout[16] = dout_3[16],
    dout[15] = dout_3[15],
    dout[14] = dout_3[14],
    dout[13] = dout_3[13],
    dout[12] = dout_3[12],
    dout[11] = dout_3[11],
    dout[10] = dout_3[10],
    dout[9] = dout_3[9],
    dout[8] = dout_3[8],
    dout[7] = dout_3[7],
    dout[6] = dout_3[6],
    dout[5] = dout_3[5],
    dout[4] = dout_3[4],
    dout[3] = dout_3[3],
    dout[2] = dout_3[2],
    dout[1] = dout_3[1],
    dout[0] = dout_3[0],
    din_2[127] = din[127],
    din_2[126] = din[126],
    din_2[125] = din[125],
    din_2[124] = din[124],
    din_2[123] = din[123],
    din_2[122] = din[122],
    din_2[121] = din[121],
    din_2[120] = din[120],
    din_2[119] = din[119],
    din_2[118] = din[118],
    din_2[117] = din[117],
    din_2[116] = din[116],
    din_2[115] = din[115],
    din_2[114] = din[114],
    din_2[113] = din[113],
    din_2[112] = din[112],
    din_2[111] = din[111],
    din_2[110] = din[110],
    din_2[109] = din[109],
    din_2[108] = din[108],
    din_2[107] = din[107],
    din_2[106] = din[106],
    din_2[105] = din[105],
    din_2[104] = din[104],
    din_2[103] = din[103],
    din_2[102] = din[102],
    din_2[101] = din[101],
    din_2[100] = din[100],
    din_2[99] = din[99],
    din_2[98] = din[98],
    din_2[97] = din[97],
    din_2[96] = din[96],
    din_2[95] = din[95],
    din_2[94] = din[94],
    din_2[93] = din[93],
    din_2[92] = din[92],
    din_2[91] = din[91],
    din_2[90] = din[90],
    din_2[89] = din[89],
    din_2[88] = din[88],
    din_2[87] = din[87],
    din_2[86] = din[86],
    din_2[85] = din[85],
    din_2[84] = din[84],
    din_2[83] = din[83],
    din_2[82] = din[82],
    din_2[81] = din[81],
    din_2[80] = din[80],
    din_2[79] = din[79],
    din_2[78] = din[78],
    din_2[77] = din[77],
    din_2[76] = din[76],
    din_2[75] = din[75],
    din_2[74] = din[74],
    din_2[73] = din[73],
    din_2[72] = din[72],
    din_2[71] = din[71],
    din_2[70] = din[70],
    din_2[69] = din[69],
    din_2[68] = din[68],
    din_2[67] = din[67],
    din_2[66] = din[66],
    din_2[65] = din[65],
    din_2[64] = din[64],
    din_2[63] = din[63],
    din_2[62] = din[62],
    din_2[61] = din[61],
    din_2[60] = din[60],
    din_2[59] = din[59],
    din_2[58] = din[58],
    din_2[57] = din[57],
    din_2[56] = din[56],
    din_2[55] = din[55],
    din_2[54] = din[54],
    din_2[53] = din[53],
    din_2[52] = din[52],
    din_2[51] = din[51],
    din_2[50] = din[50],
    din_2[49] = din[49],
    din_2[48] = din[48],
    din_2[47] = din[47],
    din_2[46] = din[46],
    din_2[45] = din[45],
    din_2[44] = din[44],
    din_2[43] = din[43],
    din_2[42] = din[42],
    din_2[41] = din[41],
    din_2[40] = din[40],
    din_2[39] = din[39],
    din_2[38] = din[38],
    din_2[37] = din[37],
    din_2[36] = din[36],
    din_2[35] = din[35],
    din_2[34] = din[34],
    din_2[33] = din[33],
    din_2[32] = din[32],
    din_2[31] = din[31],
    din_2[30] = din[30],
    din_2[29] = din[29],
    din_2[28] = din[28],
    din_2[27] = din[27],
    din_2[26] = din[26],
    din_2[25] = din[25],
    din_2[24] = din[24],
    din_2[23] = din[23],
    din_2[22] = din[22],
    din_2[21] = din[21],
    din_2[20] = din[20],
    din_2[19] = din[19],
    din_2[18] = din[18],
    din_2[17] = din[17],
    din_2[16] = din[16],
    din_2[15] = din[15],
    din_2[14] = din[14],
    din_2[13] = din[13],
    din_2[12] = din[12],
    din_2[11] = din[11],
    din_2[10] = din[10],
    din_2[9] = din[9],
    din_2[8] = din[8],
    din_2[7] = din[7],
    din_2[6] = din[6],
    din_2[5] = din[5],
    din_2[4] = din[4],
    din_2[3] = din[3],
    din_2[2] = din[2],
    din_2[1] = din[1],
    din_2[0] = din[0];
  VCC   VCC_0 (
    .P(NLW_VCC_P_UNCONNECTED)
  );
  GND   GND_1 (
    .G(NLW_GND_G_UNCONNECTED)
  );
  INV   \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count_xor<0>11_INV_0  (
    .I(\BU2/U0/grf.rf/gl0.rd/rpntr/count [0]),
    .O(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count )
  );
  INV   \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count_xor<0>11_INV_0  (
    .I(\BU2/U0/grf.rf/gl0.wr/wpntr/count [0]),
    .O(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count )
  );
  LUT6 #(
    .INIT ( 64'h75108AEFF75108AE ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_xor<4>11  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [2]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [1]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [1]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [2]),
    .I4(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_lut [4]),
    .I5(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_cy [1]),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 [4])
  );
  LUT5 #(
    .INIT ( 32'h66969699 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_xor<3>11  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [2]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [2]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [1]),
    .I3(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [1]),
    .I4(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_cy [1]),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 [3])
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_127_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [127]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [127]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_127_rstpot_790 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_126_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [126]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [126]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_126_rstpot_789 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_125_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [125]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [125]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_125_rstpot_788 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_124_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [124]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [124]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_124_rstpot_787 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_123_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [123]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [123]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_123_rstpot_786 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_122_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [122]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [122]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_122_rstpot_785 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_121_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [121]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [121]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_121_rstpot_784 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_120_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [120]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [120]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_120_rstpot_783 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_119_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [119]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [119]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_119_rstpot_782 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_118_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [118]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [118]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_118_rstpot_781 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_117_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [117]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [117]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_117_rstpot_780 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_116_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [116]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [116]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_116_rstpot_779 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_115_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [115]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [115]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_115_rstpot_778 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_114_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [114]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [114]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_114_rstpot_777 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_113_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [113]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [113]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_113_rstpot_776 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_112_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [112]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [112]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_112_rstpot_775 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_111_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [111]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [111]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_111_rstpot_774 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_110_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [110]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [110]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_110_rstpot_773 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_109_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [109]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [109]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_109_rstpot_772 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_108_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [108]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [108]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_108_rstpot_771 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_107_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [107]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [107]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_107_rstpot_770 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_106_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [106]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [106]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_106_rstpot_769 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_105_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [105]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [105]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_105_rstpot_768 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_104_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [104]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [104]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_104_rstpot_767 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_103_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [103]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [103]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_103_rstpot_766 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_102_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [102]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [102]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_102_rstpot_765 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_101_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [101]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [101]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_101_rstpot_764 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_100_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [100]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [100]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_100_rstpot_763 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_99_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [99]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [99]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_99_rstpot_762 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_98_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [98]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [98]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_98_rstpot_761 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_97_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [97]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [97]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_97_rstpot_760 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_96_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [96]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [96]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_96_rstpot_759 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_95_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [95]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [95]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_95_rstpot_758 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_94_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [94]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [94]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_94_rstpot_757 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_93_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [93]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [93]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_93_rstpot_756 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_92_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [92]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [92]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_92_rstpot_755 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_91_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [91]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [91]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_91_rstpot_754 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_90_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [90]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [90]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_90_rstpot_753 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_89_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [89]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [89]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_89_rstpot_752 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_88_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [88]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [88]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_88_rstpot_751 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_87_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [87]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [87]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_87_rstpot_750 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_86_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [86]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [86]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_86_rstpot_749 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_85_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [85]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [85]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_85_rstpot_748 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_84_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [84]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [84]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_84_rstpot_747 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_83_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [83]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [83]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_83_rstpot_746 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_82_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [82]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [82]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_82_rstpot_745 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_81_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [81]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [81]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_81_rstpot_744 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_80_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [80]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [80]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_80_rstpot_743 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_79_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [79]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [79]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_79_rstpot_742 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_78_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [78]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [78]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_78_rstpot_741 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_77_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [77]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [77]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_77_rstpot_740 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_76_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [76]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [76]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_76_rstpot_739 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_75_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [75]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [75]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_75_rstpot_738 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_74_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [74]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [74]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_74_rstpot_737 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_73_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [73]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [73]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_73_rstpot_736 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_72_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [72]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [72]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_72_rstpot_735 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_71_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [71]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [71]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_71_rstpot_734 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_70_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [70]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [70]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_70_rstpot_733 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_69_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [69]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [69]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_69_rstpot_732 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_68_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [68]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [68]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_68_rstpot_731 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_67_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [67]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [67]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_67_rstpot_730 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_66_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [66]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [66]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_66_rstpot_729 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_65_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [65]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [65]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_65_rstpot_728 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_64_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [64]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [64]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_64_rstpot_727 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_63_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [63]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [63]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_63_rstpot_726 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_62_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [62]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [62]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_62_rstpot_725 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_61_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [61]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [61]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_61_rstpot_724 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_60_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [60]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [60]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_60_rstpot_723 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_59_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [59]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [59]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_59_rstpot_722 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_58_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [58]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [58]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_58_rstpot_721 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_57_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [57]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [57]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_57_rstpot_720 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_56_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [56]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [56]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_56_rstpot_719 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_55_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [55]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [55]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_55_rstpot_718 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_54_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [54]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [54]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_54_rstpot_717 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_53_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [53]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [53]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_53_rstpot_716 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_52_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [52]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [52]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_52_rstpot_715 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_51_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [51]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [51]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_51_rstpot_714 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_50_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [50]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [50]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_50_rstpot_713 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_49_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [49]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [49]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_49_rstpot_712 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_48_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [48]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [48]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_48_rstpot_711 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_47_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [47]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [47]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_47_rstpot_710 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_46_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [46]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [46]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_46_rstpot_709 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_45_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [45]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [45]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_45_rstpot_708 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_44_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [44]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [44]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_44_rstpot_707 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_43_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [43]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [43]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_43_rstpot_706 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_42_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [42]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [42]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_42_rstpot_705 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_41_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [41]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [41]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_41_rstpot_704 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_40_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [40]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [40]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_40_rstpot_703 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_39_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [39]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [39]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_39_rstpot_702 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_38_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [38]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [38]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_38_rstpot_701 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_37_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [37]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [37]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_37_rstpot_700 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_36_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [36]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [36]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_36_rstpot_699 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_35_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [35]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [35]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_35_rstpot_698 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_34_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [34]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [34]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_34_rstpot_697 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_33_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [33]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [33]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_33_rstpot_696 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_32_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [32]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [32]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_32_rstpot_695 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_31_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [31]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [31]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_31_rstpot_694 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_30_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [30]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [30]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_30_rstpot_693 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_29_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [29]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [29]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_29_rstpot_692 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_28_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [28]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [28]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_28_rstpot_691 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_27_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [27]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [27]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_27_rstpot_690 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_26_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [26]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [26]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_26_rstpot_689 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_25_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [25]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [25]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_25_rstpot_688 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_24_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [24]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [24]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_24_rstpot_687 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_23_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [23]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [23]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_23_rstpot_686 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_22_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [22]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [22]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_22_rstpot_685 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_21_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [21]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [21]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_21_rstpot_684 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_20_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [20]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [20]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_20_rstpot_683 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_19_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [19]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [19]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_19_rstpot_682 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_18_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [18]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [18]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_18_rstpot_681 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_17_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [17]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [17]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_17_rstpot_680 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_16_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [16]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [16]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_16_rstpot_679 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_15_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [15]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [15]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_15_rstpot_678 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_14_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [14]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [14]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_14_rstpot_677 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_13_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [13]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [13]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_13_rstpot_676 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_12_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [12]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [12]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_12_rstpot_675 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_11_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [11]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [11]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_11_rstpot_674 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_10_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [10]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [10]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_10_rstpot_673 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_9_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [9]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [9]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_9_rstpot_672 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_8_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [8]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [8]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_8_rstpot_671 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_7_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [7]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [7]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_7_rstpot_670 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_6_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [6]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [6]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_6_rstpot_669 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_5_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [5]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [5]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_5_rstpot_668 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_4_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [4]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [4]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_4_rstpot_667 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_3_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [3]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [3]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_3_rstpot_666 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_2_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [2]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [2]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_2_rstpot_665 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_1_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [1]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [1]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_1_rstpot_664 )
  );
  LUT6 #(
    .INIT ( 64'hFF00FFF7FF000800 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_0_rstpot  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [0]),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .I5(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [0]),
    .O(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_0_rstpot_663 )
  );
  LUT6 #(
    .INIT ( 64'hA659659AAA556699 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_xor<2>11  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [1]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [0]),
    .I2(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_fb_i_271 ),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [1]),
    .I4(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [0]),
    .I5(wr_en),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 [2])
  );
  LUT5 #(
    .INIT ( 32'h96696996 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_rd_pntr_bin_xor0003_Result1  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [4]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [1]),
    .I4(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [0]),
    .O(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0003 )
  );
  LUT5 #(
    .INIT ( 32'h96696996 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_wr_pntr_bin_xor0003_Result1  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [4]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [1]),
    .I4(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [0]),
    .O(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0003 )
  );
  LUT4 #(
    .INIT ( 16'h6996 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_rd_pntr_bin_xor0002_Result1  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [4]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [1]),
    .O(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0002 )
  );
  LUT4 #(
    .INIT ( 16'h6996 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_wr_pntr_bin_xor0002_Result1  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [4]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [1]),
    .O(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAA9A5965A65555 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_xor<5>11  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [4]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [1]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [1]),
    .I3(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_cy [1]),
    .I4(\BU2/N38 ),
    .I5(\BU2/N39 ),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 [5])
  );
  LUT5 #(
    .INIT ( 32'h6633C663 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_xor<5>11_SW1  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [4]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [3]),
    .I4(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [2]),
    .O(\BU2/N39 )
  );
  LUT5 #(
    .INIT ( 32'hA655AAA6 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_xor<5>11_SW0  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [4]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [2]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [3]),
    .I4(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [3]),
    .O(\BU2/N38 )
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_127  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_127_rstpot_790 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [127])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_126  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_126_rstpot_789 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [126])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_125  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_125_rstpot_788 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [125])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_124  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_124_rstpot_787 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [124])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_123  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_123_rstpot_786 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [123])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_122  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_122_rstpot_785 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [122])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_121  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_121_rstpot_784 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [121])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_120  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_120_rstpot_783 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [120])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_119  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_119_rstpot_782 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [119])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_118  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_118_rstpot_781 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [118])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_117  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_117_rstpot_780 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [117])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_116  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_116_rstpot_779 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [116])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_115  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_115_rstpot_778 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [115])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_114  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_114_rstpot_777 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [114])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_113  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_113_rstpot_776 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [113])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_112  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_112_rstpot_775 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [112])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_111  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_111_rstpot_774 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [111])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_110  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_110_rstpot_773 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [110])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_109  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_109_rstpot_772 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [109])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_108  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_108_rstpot_771 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [108])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_107  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_107_rstpot_770 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [107])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_106  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_106_rstpot_769 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [106])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_105  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_105_rstpot_768 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [105])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_104  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_104_rstpot_767 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [104])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_103  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_103_rstpot_766 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [103])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_102  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_102_rstpot_765 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [102])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_101  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_101_rstpot_764 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [101])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_100  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_100_rstpot_763 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [100])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_99  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_99_rstpot_762 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [99])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_98  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_98_rstpot_761 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [98])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_97  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_97_rstpot_760 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [97])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_96  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_96_rstpot_759 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [96])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_95  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_95_rstpot_758 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [95])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_94  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_94_rstpot_757 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [94])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_93  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_93_rstpot_756 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [93])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_92  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_92_rstpot_755 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [92])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_91  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_91_rstpot_754 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [91])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_90  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_90_rstpot_753 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [90])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_89  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_89_rstpot_752 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [89])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_88  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_88_rstpot_751 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [88])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_87  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_87_rstpot_750 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [87])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_86  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_86_rstpot_749 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [86])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_85  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_85_rstpot_748 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [85])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_84  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_84_rstpot_747 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [84])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_83  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_83_rstpot_746 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [83])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_82  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_82_rstpot_745 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [82])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_81  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_81_rstpot_744 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [81])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_80  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_80_rstpot_743 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [80])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_79  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_79_rstpot_742 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [79])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_78  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_78_rstpot_741 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [78])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_77  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_77_rstpot_740 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [77])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_76  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_76_rstpot_739 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [76])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_75  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_75_rstpot_738 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [75])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_74  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_74_rstpot_737 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [74])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_73  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_73_rstpot_736 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [73])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_72  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_72_rstpot_735 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [72])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_71  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_71_rstpot_734 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [71])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_70  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_70_rstpot_733 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [70])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_69  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_69_rstpot_732 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [69])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_68  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_68_rstpot_731 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [68])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_67  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_67_rstpot_730 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [67])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_66  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_66_rstpot_729 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [66])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_65  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_65_rstpot_728 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [65])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_64  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_64_rstpot_727 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [64])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_63  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_63_rstpot_726 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [63])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_62  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_62_rstpot_725 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [62])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_61  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_61_rstpot_724 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [61])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_60  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_60_rstpot_723 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [60])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_59  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_59_rstpot_722 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [59])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_58  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_58_rstpot_721 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [58])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_57  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_57_rstpot_720 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [57])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_56  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_56_rstpot_719 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [56])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_55  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_55_rstpot_718 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [55])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_54  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_54_rstpot_717 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [54])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_53  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_53_rstpot_716 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [53])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_52  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_52_rstpot_715 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [52])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_51  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_51_rstpot_714 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [51])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_50  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_50_rstpot_713 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [50])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_49  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_49_rstpot_712 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [49])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_48  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_48_rstpot_711 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [48])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_47  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_47_rstpot_710 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [47])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_46  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_46_rstpot_709 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [46])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_45  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_45_rstpot_708 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [45])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_44  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_44_rstpot_707 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [44])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_43  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_43_rstpot_706 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [43])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_42  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_42_rstpot_705 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [42])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_41  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_41_rstpot_704 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [41])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_40  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_40_rstpot_703 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [40])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_39  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_39_rstpot_702 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [39])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_38  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_38_rstpot_701 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [38])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_37  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_37_rstpot_700 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [37])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_36  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_36_rstpot_699 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [36])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_35  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_35_rstpot_698 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [35])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_34  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_34_rstpot_697 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [34])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_33  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_33_rstpot_696 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [33])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_32  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_32_rstpot_695 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [32])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_31  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_31_rstpot_694 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [31])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_30  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_30_rstpot_693 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [30])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_29  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_29_rstpot_692 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [29])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_28  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_28_rstpot_691 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [28])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_27  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_27_rstpot_690 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [27])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_26  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_26_rstpot_689 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [26])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_25  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_25_rstpot_688 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [25])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_24  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_24_rstpot_687 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [24])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_23  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_23_rstpot_686 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [23])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_22  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_22_rstpot_685 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [22])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_21  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_21_rstpot_684 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [21])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_20  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_20_rstpot_683 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [20])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_19  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_19_rstpot_682 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [19])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_18  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_18_rstpot_681 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [18])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_17  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_17_rstpot_680 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [17])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_16  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_16_rstpot_679 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [16])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_15  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_15_rstpot_678 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [15])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_14  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_14_rstpot_677 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [14])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_13  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_13_rstpot_676 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [13])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_12  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_12_rstpot_675 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [12])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_11  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_11_rstpot_674 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [11])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_10  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_10_rstpot_673 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [10])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_9  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_9_rstpot_672 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [9])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_8  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_8_rstpot_671 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [8])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_7  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_7_rstpot_670 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [7])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_6  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_6_rstpot_669 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [6])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_5  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_5_rstpot_668 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [5])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_4  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_4_rstpot_667 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_3  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_3_rstpot_666 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_2  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_2_rstpot_665 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_1  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_1_rstpot_664 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/gdm.dm/dout_i_0  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i_0_rstpot_663 ),
    .Q(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [0])
  );
  LUT6 #(
    .INIT ( 64'h5504550004040000 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000207  (
    .I0(\BU2/U0/grf.rf/rstblk/RST_FULL_GEN_273 ),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .I2(\BU2/N36 ),
    .I3(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000126_658 ),
    .I4(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux000086_657 ),
    .I5(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000176_659 ),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000 )
  );
  LUT4 #(
    .INIT ( 16'h6FF6 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux000036_SW0  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [0]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count [0]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [4]),
    .I3(\BU2/U0/grf.rf/gl0.wr/wpntr/count [4]),
    .O(\BU2/N36 )
  );
  LUT5 #(
    .INIT ( 32'hECCCA000 ))
  \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000192  (
    .I0(\BU2/N34 ),
    .I1(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000126_655 ),
    .I2(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .I3(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or000086_654 ),
    .I4(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000176_656 ),
    .O(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000 )
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or000036_SW0  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count [4]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [4]),
    .I2(\BU2/U0/grf.rf/gl0.rd/rpntr/count [0]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [0]),
    .O(\BU2/N34 )
  );
  LUT4 #(
    .INIT ( 16'h3B02 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_cy<1>11  (
    .I0(wr_en),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [0]),
    .I2(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_fb_i_271 ),
    .I3(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [0]),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_cy [1])
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_rd_pntr_bin_xor0001_Result1  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [4]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [2]),
    .O(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0001 )
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_wr_pntr_bin_xor0001_Result1  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [4]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [2]),
    .O(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0001 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \BU2/U0/grf.rf/gl0.wr/ram_wr_en_i1  (
    .I0(wr_en),
    .I1(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_fb_i_271 ),
    .O(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_rd_pntr_bin_xor0000_Result1  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [4]),
    .O(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0000 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_wr_pntr_bin_xor0000_Result1  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [4]),
    .O(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0000 )
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000176  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [3]),
    .I2(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [2]),
    .I4(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [1]),
    .I5(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [1]),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000176_659 )
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000126  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [0]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [0]),
    .I2(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [4]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [4]),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000126_658 )
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux000086  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [3]),
    .I2(\BU2/U0/grf.rf/gl0.wr/wpntr/count [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [2]),
    .I4(\BU2/U0/grf.rf/gl0.wr/wpntr/count [1]),
    .I5(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [1]),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux000086_657 )
  );
  LUT6 #(
    .INIT ( 64'h8040201008040201 ))
  \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000176  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [1]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [2]),
    .I2(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [3]),
    .I3(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1]),
    .I4(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2]),
    .I5(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3]),
    .O(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000176_656 )
  );
  LUT4 #(
    .INIT ( 16'h8421 ))
  \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000126  (
    .I0(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [4]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [0]),
    .I2(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4]),
    .I3(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]),
    .O(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000126_655 )
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or000086  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [3]),
    .I2(\BU2/U0/grf.rf/gl0.rd/rpntr/count [2]),
    .I3(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [2]),
    .I4(\BU2/U0/grf.rf/gl0.rd/rpntr/count [1]),
    .I5(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [1]),
    .O(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or000086_654 )
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_lut<4>1  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [3]),
    .I1(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [3]),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/Madd_diff_pntr_pad_add0000_lut [4])
  );
  LUT4 #(
    .INIT ( 16'h00BF ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/RAM_RD_EN_FWFT1  (
    .I0(rd_en),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I2(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I3(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .O(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 )
  );
  LUT3 #(
    .INIT ( 8'hB0 ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/RAM_REGOUT_EN1  (
    .I0(rd_en),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .O(\BU2/U0/grf.rf/mem/dout_i_not0001 )
  );
  LUT2 #(
    .INIT ( 4'hB ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i_not00011  (
    .I0(\BU2/U0/grf.rf/rstblk/RST_FULL_GEN_273 ),
    .I1(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_fb_i_271 ),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i_not0001 )
  );
  LUT5 #(
    .INIT ( 32'h6AAAAAAA ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count_xor<4>11  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count [4]),
    .I1(\BU2/U0/grf.rf/gl0.rd/rpntr/count [0]),
    .I2(\BU2/U0/grf.rf/gl0.rd/rpntr/count [1]),
    .I3(\BU2/U0/grf.rf/gl0.rd/rpntr/count [2]),
    .I4(\BU2/U0/grf.rf/gl0.rd/rpntr/count [3]),
    .O(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count4 )
  );
  LUT5 #(
    .INIT ( 32'h6AAAAAAA ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count_xor<4>11  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count [4]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count [0]),
    .I2(\BU2/U0/grf.rf/gl0.wr/wpntr/count [1]),
    .I3(\BU2/U0/grf.rf/gl0.wr/wpntr/count [2]),
    .I4(\BU2/U0/grf.rf/gl0.wr/wpntr/count [3]),
    .O(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count4 )
  );
  LUT5 #(
    .INIT ( 32'h55554440 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i_mux00031  (
    .I0(\BU2/U0/grf.rf/rstblk/RST_FULL_GEN_273 ),
    .I1(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad [4]),
    .I2(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad [2]),
    .I3(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad [3]),
    .I4(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad [5]),
    .O(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i_mux0003 )
  );
  LUT4 #(
    .INIT ( 16'h6AAA ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count_xor<3>11  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count [3]),
    .I1(\BU2/U0/grf.rf/gl0.rd/rpntr/count [0]),
    .I2(\BU2/U0/grf.rf/gl0.rd/rpntr/count [1]),
    .I3(\BU2/U0/grf.rf/gl0.rd/rpntr/count [2]),
    .O(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count3 )
  );
  LUT4 #(
    .INIT ( 16'h6AAA ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count_xor<3>11  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count [3]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count [0]),
    .I2(\BU2/U0/grf.rf/gl0.wr/wpntr/count [1]),
    .I3(\BU2/U0/grf.rf/gl0.wr/wpntr/count [2]),
    .O(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count3 )
  );
  LUT4 #(
    .INIT ( 16'h8E8A ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_i_mux00001  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_fb_362 ),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I3(rd_en),
    .O(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_i_mux0000 )
  );
  LUT4 #(
    .INIT ( 16'h08FF ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_mux0001<0>1  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I2(rd_en),
    .I3(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 ),
    .O(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_mux0001 [0])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count_xor<2>11  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count [2]),
    .I1(\BU2/U0/grf.rf/gl0.rd/rpntr/count [0]),
    .I2(\BU2/U0/grf.rf/gl0.rd/rpntr/count [1]),
    .O(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count2 )
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count_xor<2>11  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count [2]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count [0]),
    .I2(\BU2/U0/grf.rf/gl0.wr/wpntr/count [1]),
    .O(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count2 )
  );
  LUT3 #(
    .INIT ( 8'hF2 ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_mux0001<1>1  (
    .I0(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0]),
    .I1(rd_en),
    .I2(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1]),
    .O(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_mux0001 [1])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_rd_pntr_gc_xor0000_Result1  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4]),
    .I1(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3]),
    .O(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0000 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_rd_pntr_gc_xor0001_Result1  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3]),
    .I1(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2]),
    .O(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0001 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_rd_pntr_gc_xor0002_Result1  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2]),
    .I1(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1]),
    .O(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0002 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_rd_pntr_gc_xor0003_Result1  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1]),
    .I1(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]),
    .O(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0003 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_wr_pntr_gc_xor0000_Result1  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3]),
    .O(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0000 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_wr_pntr_gc_xor0001_Result1  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2]),
    .O(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0001 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_wr_pntr_gc_xor0002_Result1  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1]),
    .O(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0002 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gcx.clkx/Mxor_wr_pntr_gc_xor0003_Result1  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]),
    .O(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0003 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count_xor<1>11  (
    .I0(\BU2/U0/grf.rf/gl0.rd/rpntr/count [0]),
    .I1(\BU2/U0/grf.rf/gl0.rd/rpntr/count [1]),
    .O(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count1 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count_xor<1>11  (
    .I0(\BU2/U0/grf.rf/gl0.wr/wpntr/count [1]),
    .I1(\BU2/U0/grf.rf/gl0.wr/wpntr/count [0]),
    .O(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count1 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \BU2/U0/grf.rf/rstblk/rd_rst_comb1  (
    .I0(\BU2/U0/grf.rf/rstblk/rd_rst_asreg_279 ),
    .I1(\BU2/U0/grf.rf/rstblk/rd_rst_asreg_d2_275 ),
    .O(\BU2/U0/grf.rf/rstblk/rd_rst_comb )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \BU2/U0/grf.rf/rstblk/wr_rst_comb1  (
    .I0(\BU2/U0/grf.rf/rstblk/wr_rst_asreg_280 ),
    .I1(\BU2/U0/grf.rf/rstblk/wr_rst_asreg_d2_277 ),
    .O(\BU2/U0/grf.rf/rstblk/wr_rst_comb )
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_0  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [0]),
    .Q(dout_3[0])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_1  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [1]),
    .Q(dout_3[1])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_2  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [2]),
    .Q(dout_3[2])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_3  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [3]),
    .Q(dout_3[3])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_4  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [4]),
    .Q(dout_3[4])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_5  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [5]),
    .Q(dout_3[5])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_6  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [6]),
    .Q(dout_3[6])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_7  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [7]),
    .Q(dout_3[7])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_8  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [8]),
    .Q(dout_3[8])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_9  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [9]),
    .Q(dout_3[9])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_10  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [10]),
    .Q(dout_3[10])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_11  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [11]),
    .Q(dout_3[11])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_12  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [12]),
    .Q(dout_3[12])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_13  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [13]),
    .Q(dout_3[13])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_14  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [14]),
    .Q(dout_3[14])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_15  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [15]),
    .Q(dout_3[15])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_16  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [16]),
    .Q(dout_3[16])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_17  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [17]),
    .Q(dout_3[17])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_18  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [18]),
    .Q(dout_3[18])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_19  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [19]),
    .Q(dout_3[19])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_20  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [20]),
    .Q(dout_3[20])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_21  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [21]),
    .Q(dout_3[21])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_22  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [22]),
    .Q(dout_3[22])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_23  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [23]),
    .Q(dout_3[23])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_24  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [24]),
    .Q(dout_3[24])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_25  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [25]),
    .Q(dout_3[25])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_26  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [26]),
    .Q(dout_3[26])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_27  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [27]),
    .Q(dout_3[27])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_28  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [28]),
    .Q(dout_3[28])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_29  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [29]),
    .Q(dout_3[29])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_30  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [30]),
    .Q(dout_3[30])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_31  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [31]),
    .Q(dout_3[31])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_32  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [32]),
    .Q(dout_3[32])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_33  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [33]),
    .Q(dout_3[33])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_34  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [34]),
    .Q(dout_3[34])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_35  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [35]),
    .Q(dout_3[35])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_36  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [36]),
    .Q(dout_3[36])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_37  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [37]),
    .Q(dout_3[37])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_38  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [38]),
    .Q(dout_3[38])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_39  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [39]),
    .Q(dout_3[39])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_40  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [40]),
    .Q(dout_3[40])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_41  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [41]),
    .Q(dout_3[41])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_42  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [42]),
    .Q(dout_3[42])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_43  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [43]),
    .Q(dout_3[43])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_44  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [44]),
    .Q(dout_3[44])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_45  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [45]),
    .Q(dout_3[45])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_46  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [46]),
    .Q(dout_3[46])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_47  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [47]),
    .Q(dout_3[47])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_48  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [48]),
    .Q(dout_3[48])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_49  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [49]),
    .Q(dout_3[49])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_50  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [50]),
    .Q(dout_3[50])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_51  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [51]),
    .Q(dout_3[51])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_52  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [52]),
    .Q(dout_3[52])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_53  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [53]),
    .Q(dout_3[53])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_54  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [54]),
    .Q(dout_3[54])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_55  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [55]),
    .Q(dout_3[55])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_56  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [56]),
    .Q(dout_3[56])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_57  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [57]),
    .Q(dout_3[57])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_58  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [58]),
    .Q(dout_3[58])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_59  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [59]),
    .Q(dout_3[59])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_60  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [60]),
    .Q(dout_3[60])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_61  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [61]),
    .Q(dout_3[61])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_62  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [62]),
    .Q(dout_3[62])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_63  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [63]),
    .Q(dout_3[63])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_64  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [64]),
    .Q(dout_3[64])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_65  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [65]),
    .Q(dout_3[65])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_66  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [66]),
    .Q(dout_3[66])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_67  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [67]),
    .Q(dout_3[67])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_68  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [68]),
    .Q(dout_3[68])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_69  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [69]),
    .Q(dout_3[69])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_70  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [70]),
    .Q(dout_3[70])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_71  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [71]),
    .Q(dout_3[71])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_72  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [72]),
    .Q(dout_3[72])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_73  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [73]),
    .Q(dout_3[73])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_74  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [74]),
    .Q(dout_3[74])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_75  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [75]),
    .Q(dout_3[75])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_76  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [76]),
    .Q(dout_3[76])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_77  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [77]),
    .Q(dout_3[77])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_78  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [78]),
    .Q(dout_3[78])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_79  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [79]),
    .Q(dout_3[79])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_80  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [80]),
    .Q(dout_3[80])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_81  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [81]),
    .Q(dout_3[81])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_82  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [82]),
    .Q(dout_3[82])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_83  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [83]),
    .Q(dout_3[83])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_84  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [84]),
    .Q(dout_3[84])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_85  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [85]),
    .Q(dout_3[85])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_86  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [86]),
    .Q(dout_3[86])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_87  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [87]),
    .Q(dout_3[87])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_88  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [88]),
    .Q(dout_3[88])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_89  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [89]),
    .Q(dout_3[89])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_90  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [90]),
    .Q(dout_3[90])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_91  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [91]),
    .Q(dout_3[91])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_92  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [92]),
    .Q(dout_3[92])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_93  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [93]),
    .Q(dout_3[93])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_94  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [94]),
    .Q(dout_3[94])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_95  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [95]),
    .Q(dout_3[95])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_96  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [96]),
    .Q(dout_3[96])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_97  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [97]),
    .Q(dout_3[97])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_98  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [98]),
    .Q(dout_3[98])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_99  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [99]),
    .Q(dout_3[99])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_100  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [100]),
    .Q(dout_3[100])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_101  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [101]),
    .Q(dout_3[101])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_102  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [102]),
    .Q(dout_3[102])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_103  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [103]),
    .Q(dout_3[103])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_104  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [104]),
    .Q(dout_3[104])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_105  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [105]),
    .Q(dout_3[105])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_106  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [106]),
    .Q(dout_3[106])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_107  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [107]),
    .Q(dout_3[107])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_108  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [108]),
    .Q(dout_3[108])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_109  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [109]),
    .Q(dout_3[109])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_110  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [110]),
    .Q(dout_3[110])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_111  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [111]),
    .Q(dout_3[111])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_112  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [112]),
    .Q(dout_3[112])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_113  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [113]),
    .Q(dout_3[113])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_114  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [114]),
    .Q(dout_3[114])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_115  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [115]),
    .Q(dout_3[115])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_116  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [116]),
    .Q(dout_3[116])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_117  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [117]),
    .Q(dout_3[117])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_118  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [118]),
    .Q(dout_3[118])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_119  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [119]),
    .Q(dout_3[119])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_120  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [120]),
    .Q(dout_3[120])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_121  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [121]),
    .Q(dout_3[121])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_122  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [122]),
    .Q(dout_3[122])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_123  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [123]),
    .Q(dout_3[123])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_124  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [124]),
    .Q(dout_3[124])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_125  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [125]),
    .Q(dout_3[125])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_126  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [126]),
    .Q(dout_3[126])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/mem/dout_i_127  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/mem/dout_i_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0]),
    .D(\BU2/U0/grf.rf/mem/gdm.dm/dout_i [127]),
    .Q(dout_3[127])
  );
  RAM32X1D   \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM222  (
    .A0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]),
    .A1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1]),
    .A2(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2]),
    .A3(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3]),
    .A4(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4]),
    .D(din_2[127]),
    .DPRA0(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]),
    .DPRA1(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1]),
    .DPRA2(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2]),
    .DPRA3(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3]),
    .DPRA4(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4]),
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .SPO(\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM222_SPO_UNCONNECTED ),
    .DPO(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [127])
  );
  RAM32X1D   \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM221  (
    .A0(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]),
    .A1(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1]),
    .A2(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2]),
    .A3(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3]),
    .A4(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4]),
    .D(din_2[126]),
    .DPRA0(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]),
    .DPRA1(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1]),
    .DPRA2(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2]),
    .DPRA3(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3]),
    .DPRA4(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4]),
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .SPO(\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM221_SPO_UNCONNECTED ),
    .DPO(\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [126])
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM21  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[121], din_2[120]}),
    .DIB({din_2[123], din_2[122]}),
    .DIC({din_2[125], din_2[124]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [121], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [120]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [123], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [122]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [125], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [124]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM21_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM21_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM19  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[109], din_2[108]}),
    .DIB({din_2[111], din_2[110]}),
    .DIC({din_2[113], din_2[112]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [109], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [108]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [111], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [110]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [113], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [112]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM19_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM19_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM18  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[103], din_2[102]}),
    .DIB({din_2[105], din_2[104]}),
    .DIC({din_2[107], din_2[106]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [103], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [102]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [105], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [104]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [107], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [106]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM18_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM18_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM20  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[115], din_2[114]}),
    .DIB({din_2[117], din_2[116]}),
    .DIC({din_2[119], din_2[118]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [115], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [114]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [117], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [116]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [119], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [118]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM20_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM20_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM16  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[91], din_2[90]}),
    .DIB({din_2[93], din_2[92]}),
    .DIC({din_2[95], din_2[94]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [91], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [90]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [93], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [92]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [95], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [94]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM16_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM16_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM15  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[85], din_2[84]}),
    .DIB({din_2[87], din_2[86]}),
    .DIC({din_2[89], din_2[88]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [85], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [84]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [87], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [86]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [89], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [88]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM15_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM15_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM17  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[97], din_2[96]}),
    .DIB({din_2[99], din_2[98]}),
    .DIC({din_2[101], din_2[100]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [97], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [96]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [99], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [98]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [101], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [100]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM17_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM17_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM13  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[73], din_2[72]}),
    .DIB({din_2[75], din_2[74]}),
    .DIC({din_2[77], din_2[76]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [73], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [72]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [75], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [74]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [77], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [76]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM13_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM13_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM12  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[67], din_2[66]}),
    .DIB({din_2[69], din_2[68]}),
    .DIC({din_2[71], din_2[70]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [67], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [66]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [69], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [68]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [71], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [70]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM12_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM12_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM14  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[79], din_2[78]}),
    .DIB({din_2[81], din_2[80]}),
    .DIC({din_2[83], din_2[82]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [79], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [78]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [81], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [80]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [83], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [82]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM14_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM14_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM11  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[61], din_2[60]}),
    .DIB({din_2[63], din_2[62]}),
    .DIC({din_2[65], din_2[64]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [61], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [60]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [63], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [62]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [65], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [64]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM11_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM11_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM10  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[55], din_2[54]}),
    .DIB({din_2[57], din_2[56]}),
    .DIC({din_2[59], din_2[58]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [55], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [54]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [57], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [56]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [59], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [58]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM10_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM10_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM8  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[43], din_2[42]}),
    .DIB({din_2[45], din_2[44]}),
    .DIC({din_2[47], din_2[46]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [43], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [42]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [45], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [44]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [47], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [46]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM8_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM8_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM7  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[37], din_2[36]}),
    .DIB({din_2[39], din_2[38]}),
    .DIC({din_2[41], din_2[40]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [37], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [36]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [39], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [38]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [41], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [40]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM7_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM7_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM9  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[49], din_2[48]}),
    .DIB({din_2[51], din_2[50]}),
    .DIC({din_2[53], din_2[52]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [49], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [48]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [51], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [50]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [53], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [52]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM9_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM9_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM5  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[25], din_2[24]}),
    .DIB({din_2[27], din_2[26]}),
    .DIC({din_2[29], din_2[28]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [25], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [24]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [27], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [26]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [29], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [28]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM5_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM5_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM4  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[19], din_2[18]}),
    .DIB({din_2[21], din_2[20]}),
    .DIC({din_2[23], din_2[22]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [19], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [18]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [21], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [20]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [23], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [22]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM4_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM4_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM6  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[31], din_2[30]}),
    .DIB({din_2[33], din_2[32]}),
    .DIC({din_2[35], din_2[34]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [31], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [30]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [33], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [32]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [35], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [34]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM6_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM6_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM2  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[7], din_2[6]}),
    .DIB({din_2[9], din_2[8]}),
    .DIC({din_2[11], din_2[10]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [7], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [6]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [9], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [8]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [11], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [10]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM2_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM2_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM1  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[1], din_2[0]}),
    .DIB({din_2[3], din_2[2]}),
    .DIC({din_2[5], din_2[4]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [1], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [0]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [3], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [2]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [5], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [4]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM1_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM1_DOD<0>_UNCONNECTED })
  );
  RAM32M #(
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ),
    .INIT_A ( 64'h0000000000000000 ))
  \BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM3  (
    .WCLK(wr_clk),
    .WE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .DIA({din_2[13], din_2[12]}),
    .DIB({din_2[15], din_2[14]}),
    .DIC({din_2[17], din_2[16]}),
    .DID({\BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .ADDRA({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRB({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRC({\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2], 
\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1], \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0]}),
    .ADDRD({\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2], 
\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1], \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0]}),
    .DOA({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [13], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [12]}),
    .DOB({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [15], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [14]}),
    .DOC({\BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [17], \BU2/U0/grf.rf/mem/gdm.dm/_varindex0000 [16]}),
    .DOD({\NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM3_DOD<1>_UNCONNECTED , \NLW_BU2/U0/grf.rf/mem/gdm.dm/Mram_RAM3_DOD<0>_UNCONNECTED })
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2_0  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [0]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [0])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2_1  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [1]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [1])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2_2  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [2]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [2])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2_3  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [3]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [3])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d2_4  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [4]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d1_4  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count [4]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [4])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d1_3  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count [3]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [3])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d1_1  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count [1]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [1])
  );
  FDPE #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d1_0  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count [0]),
    .PRE(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [0])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_d1_2  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count [2]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d1 [2])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_2  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count2 ),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count [2])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_0  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count ),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count [0])
  );
  FDPE #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_1  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count1 ),
    .PRE(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count [1])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_3  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count3 ),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count [3])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/wpntr/count_4  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/wpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/Mcount_count4 ),
    .Q(\BU2/U0/grf.rf/gl0.wr/wpntr/count [4])
  );
  FDPE #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i_not0001 ),
    .D(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/prog_full_i_mux0003 ),
    .PRE(\BU2/U0/grf.rf/rstblk/rst_d2_270 ),
    .Q(prog_full)
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_2  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 [2]),
    .Q(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_3  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 [3]),
    .Q(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_4  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 [4]),
    .Q(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_5  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad_add0000 [5]),
    .Q(\BU2/U0/grf.rf/gl0.wr/gwas.gpf.wrpf/diff_pntr_pad [5])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_0  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_mux0001 [1]),
    .Q(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_1  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_mux0001 [0]),
    .Q(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state [1])
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_i  (
    .C(rd_clk),
    .D(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_i_mux0000 ),
    .PRE(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .Q(empty)
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_fb  (
    .C(rd_clk),
    .D(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_i_mux0000 ),
    .PRE(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .Q(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/empty_fwft_fb_362 )
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/gr1.rfwft/user_valid  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/gr1.rfwft/curr_fwft_state_mux0001 [1]),
    .Q(valid)
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1_0  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/count [0]),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [0])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1_1  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/count [1]),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [1])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1_2  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/count [2]),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [2])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1_3  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/count [3]),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [3])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_d1_4  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/count [4]),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_2  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count2 ),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count [2])
  );
  FDPE #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_0  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count ),
    .PRE(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count [0])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_1  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count1 ),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count [1])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_3  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count3 ),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count [3])
  );
  FDCE #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gl0.rd/rpntr/count_4  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/gl0.rd/rpntr/count_not0001 ),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/Mcount_count4 ),
    .Q(\BU2/U0/grf.rf/gl0.rd/rpntr/count [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_0  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0003 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_1  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0002 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_2  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0001 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_3  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_xor0000 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_4  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gl0.wr/wpntr/count_d2 [4]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_0  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0003 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_1  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0002 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_2  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0001 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_3  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_xor0000 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_4  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gl0.rd/rpntr/count_d1 [4]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_0  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [0]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_1  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [1]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_2  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [2]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_3  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [3]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_4  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc [4]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_0  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [0]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_1  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [1]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_2  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [2]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_3  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [3]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_4  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc [4]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1_0  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [0]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1_1  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [1]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1_2  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [2]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1_3  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [3]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1_4  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg [4]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1_0  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [0]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1_1  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [1]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1_2  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [2]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1_3  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [3]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1_4  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg [4]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_0  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0003 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_1  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0002 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_2  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0001 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_3  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_xor0000 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin_4  (
    .C(rd_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1]),
    .D(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc_asreg_d1 [4]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/wr_pntr_bin [4])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_0  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0003 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [0])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_1  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0002 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_2  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0001 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [2])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_3  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_xor0000 ),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [3])
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin_4  (
    .C(wr_clk),
    .CLR(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0]),
    .D(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc_asreg_d1 [4]),
    .Q(\BU2/U0/grf.rf/gcx.clkx/rd_pntr_bin [4])
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/rstblk/wr_rst_reg_0  (
    .C(wr_clk),
    .D(\BU2/rd_data_count [0]),
    .PRE(\BU2/U0/grf.rf/rstblk/wr_rst_comb ),
    .Q(\BU2/U0/grf.rf/rstblk/wr_rst_reg [0])
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/rstblk/wr_rst_reg_1  (
    .C(wr_clk),
    .D(\BU2/rd_data_count [0]),
    .PRE(\BU2/U0/grf.rf/rstblk/wr_rst_comb ),
    .Q(\BU2/U0/grf.rf/rstblk/wr_rst_reg [1])
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/rstblk/rd_rst_reg_0  (
    .C(rd_clk),
    .D(\BU2/rd_data_count [0]),
    .PRE(\BU2/U0/grf.rf/rstblk/rd_rst_comb ),
    .Q(\BU2/U0/grf.rf/rstblk/rd_rst_reg [0])
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/rstblk/rd_rst_reg_1  (
    .C(rd_clk),
    .D(\BU2/rd_data_count [0]),
    .PRE(\BU2/U0/grf.rf/rstblk/rd_rst_comb ),
    .Q(\BU2/U0/grf.rf/rstblk/rd_rst_reg [1])
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/rstblk/rd_rst_reg_2  (
    .C(rd_clk),
    .D(\BU2/rd_data_count [0]),
    .PRE(\BU2/U0/grf.rf/rstblk/rd_rst_comb ),
    .Q(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2])
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/rstblk/rst_d1  (
    .C(wr_clk),
    .D(\BU2/rd_data_count [0]),
    .PRE(rst),
    .Q(\BU2/U0/grf.rf/rstblk/rst_d1_278 )
  );
  FDPE   \BU2/U0/grf.rf/rstblk/rd_rst_asreg  (
    .C(rd_clk),
    .CE(\BU2/U0/grf.rf/rstblk/rd_rst_asreg_d1_274 ),
    .D(\BU2/rd_data_count [0]),
    .PRE(rst),
    .Q(\BU2/U0/grf.rf/rstblk/rd_rst_asreg_279 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/rstblk/wr_rst_asreg_d1  (
    .C(wr_clk),
    .D(\BU2/U0/grf.rf/rstblk/wr_rst_asreg_280 ),
    .Q(\BU2/U0/grf.rf/rstblk/wr_rst_asreg_d1_276 )
  );
  FDPE   \BU2/U0/grf.rf/rstblk/wr_rst_asreg  (
    .C(wr_clk),
    .CE(\BU2/U0/grf.rf/rstblk/wr_rst_asreg_d1_276 ),
    .D(\BU2/rd_data_count [0]),
    .PRE(rst),
    .Q(\BU2/U0/grf.rf/rstblk/wr_rst_asreg_280 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/rstblk/rd_rst_asreg_d1  (
    .C(rd_clk),
    .D(\BU2/U0/grf.rf/rstblk/rd_rst_asreg_279 ),
    .Q(\BU2/U0/grf.rf/rstblk/rd_rst_asreg_d1_274 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/rstblk/rst_d2  (
    .C(wr_clk),
    .D(\BU2/U0/grf.rf/rstblk/rst_d1_278 ),
    .PRE(rst),
    .Q(\BU2/U0/grf.rf/rstblk/rst_d2_270 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/rstblk/wr_rst_asreg_d2  (
    .C(wr_clk),
    .D(\BU2/U0/grf.rf/rstblk/wr_rst_asreg_d1_276 ),
    .Q(\BU2/U0/grf.rf/rstblk/wr_rst_asreg_d2_277 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/rstblk/rd_rst_asreg_d2  (
    .C(rd_clk),
    .D(\BU2/U0/grf.rf/rstblk/rd_rst_asreg_d1_274 ),
    .Q(\BU2/U0/grf.rf/rstblk/rd_rst_asreg_d2_275 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/rstblk/rst_d3  (
    .C(wr_clk),
    .D(\BU2/U0/grf.rf/rstblk/rst_d2_270 ),
    .PRE(rst),
    .Q(\BU2/U0/grf.rf/rstblk/rst_d3_272 )
  );
  FDC #(
    .INIT ( 1'b0 ))
  \BU2/U0/grf.rf/rstblk/RST_FULL_GEN  (
    .C(wr_clk),
    .CLR(rst),
    .D(\BU2/U0/grf.rf/rstblk/rst_d3_272 ),
    .Q(\BU2/U0/grf.rf/rstblk/RST_FULL_GEN_273 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_fb_i  (
    .C(wr_clk),
    .D(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000 ),
    .PRE(\BU2/U0/grf.rf/rstblk/rst_d2_270 ),
    .Q(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_fb_i_271 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i  (
    .C(wr_clk),
    .D(\BU2/U0/grf.rf/gl0.wr/gwas.wsts/ram_full_i_mux0000 ),
    .PRE(\BU2/U0/grf.rf/rstblk/rst_d2_270 ),
    .Q(full)
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i  (
    .C(rd_clk),
    .D(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_or0000 ),
    .PRE(\BU2/U0/grf.rf/rstblk/rd_rst_reg [2]),
    .Q(\BU2/U0/grf.rf/gl0.rd/gras.rsts/ram_empty_fb_i_268 )
  );
  GND   \BU2/XST_GND  (
    .G(\BU2/rd_data_count [0])
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
