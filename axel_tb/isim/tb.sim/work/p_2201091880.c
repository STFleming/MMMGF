/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ddf5b5d */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif




void ieee_p_2592010699_sub_7991387870887201249_503743352();

extern void work_p_2201091880_init()
{
	xsi_register_didat("work_p_2201091880", "isim/tb.sim/work/p_2201091880.didat");
	xsi_register_resolution_function(4, 2, (void *)ieee_p_2592010699_sub_7991387870887201249_503743352, 8);
}
