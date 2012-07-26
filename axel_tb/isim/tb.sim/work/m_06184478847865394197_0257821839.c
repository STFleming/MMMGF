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
static const char *ng0 = "/homes/sf306/MMMGF/axel_tb/hdl/sim_host.v";
static unsigned int ng1[] = {0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U};
static unsigned int ng2[] = {0U, 4294967295U, 0U, 4294967295U};
static const char *ng3 = "sim_host.cmd";
static const char *ng4 = "r";
static int ng5[] = {0, 0};
static const char *ng6 = "%s";
static int ng7[] = {1919246692, 0, 0, 0, 0, 0, 0, 0};
static const char *ng8 = "%h";
static int ng9[] = {1919513701, 0, 119, 0, 0, 0, 0, 0};
static const char *ng10 = "%h %h";
static unsigned int ng11[] = {15U, 0U};
static int ng12[] = {4, 0};
static int ng13[] = {1, 0};
static unsigned int ng14[] = {0U, 0U};
static int ng15[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static int ng16[] = {2002872692, 0, 0, 0, 0, 0, 0, 0};
static const char *ng17 = "unknown command %s";



static void Initial_32_0(char *t0)
{
    char t6[8];
    char t13[8];
    char t22[32];
    char t29[8];
    char t32[8];
    char t59[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t23;
    int t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t30;
    char *t31;
    int t33;
    int t34;
    int t35;
    int t36;
    int t37;
    int t38;
    int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    char *t60;

LAB0:    t1 = (t0 + 3912U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);

LAB4:    t2 = (t0 + 280);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB5);
    t3 = (t0 + 3720);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB6:    xsi_set_current_line(33, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 2200);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 256, 0LL);
    xsi_set_current_line(34, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2040);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 64, 0LL);
    xsi_set_current_line(35, ng0);
    t2 = (t0 + 3720);
    xsi_process_wait(t2, 114000LL);
    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB5:    t3 = (t0 + 3720);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB1;

LAB7:    xsi_set_current_line(37, ng0);
    t2 = (t0 + 4232);
    *((int *)t2) = 1;
    t3 = (t0 + 3944);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB8;
    goto LAB1;

LAB8:    xsi_set_current_line(38, ng0);
    *((int *)t6) = xsi_vlogfile_file_open_of_cname_ctype(ng3, ng4);
    t2 = (t6 + 4);
    *((int *)t2) = 0;
    t3 = (t0 + 2360);
    xsi_vlogvar_assign_value(t3, t6, 0, 0, 32);
    xsi_set_current_line(39, ng0);
    t2 = (t0 + 2360);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng5)));
    memset(t6, 0, 8);
    xsi_vlog_signed_equal(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB9;

LAB10:
LAB11:    xsi_set_current_line(42, ng0);

LAB13:    t2 = (t0 + 2360);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    *((int *)t13) = xsi_vlogfile_feof(*((unsigned int *)t4));
    t5 = (t13 + 4);
    *((int *)t5) = 0;
    memset(t6, 0, 8);
    t7 = (t13 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t13);
    t11 = (t10 & t9);
    t12 = (t11 & 4294967295U);
    if (t12 != 0)
        goto LAB17;

LAB15:    if (*((unsigned int *)t7) == 0)
        goto LAB14;

LAB16:    t14 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t14) = 1;

LAB17:    t15 = (t6 + 4);
    t16 = *((unsigned int *)t15);
    t17 = (~(t16));
    t18 = *((unsigned int *)t6);
    t19 = (t18 & t17);
    t20 = (t19 != 0);
    if (t20 > 0)
        goto LAB18;

LAB19:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 2360);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    xsi_vlogfile_fclose(*((unsigned int *)t5));
    t2 = (t0 + 280);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB5;

LAB9:    xsi_set_current_line(40, ng0);
    goto LAB5;

LAB12:    goto LAB11;

LAB14:    *((unsigned int *)t6) = 1;
    goto LAB17;

LAB18:    xsi_set_current_line(42, ng0);

LAB20:    xsi_set_current_line(43, ng0);
    t21 = (t0 + 3720);
    xsi_process_wait(t21, 10000LL);
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB21:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 2360);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 2520);
    t7 = (t5 + 56U);
    t14 = *((char **)t7);
    xsi_vlog_bit_copy(t22, 0, t14, 0, 128);
    *((int *)t6) = xsi_vlogfile_fscanf(*((unsigned int *)t4), ng6, 2, t0, (char)118, t22, 128);
    t15 = (t6 + 4);
    *((int *)t15) = 0;
    t21 = (t0 + 2520);
    xsi_vlogvar_assign_value(t21, t22, 0, 0, 128);
    t23 = (t0 + 3000);
    xsi_vlogvar_assign_value(t23, t6, 0, 0, 32);
    xsi_set_current_line(46, ng0);
    t2 = (t0 + 2520);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB22:    t5 = ((char*)((ng7)));
    t24 = xsi_vlog_unsigned_case_compare(t4, 128, t5, 128);
    if (t24 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng9)));
    t24 = xsi_vlog_unsigned_case_compare(t4, 128, t2, 128);
    if (t24 == 1)
        goto LAB25;

LAB26:    t2 = ((char*)((ng16)));
    t24 = xsi_vlog_unsigned_case_compare(t4, 128, t2, 128);
    if (t24 == 1)
        goto LAB27;

LAB28:
LAB30:
LAB29:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 2520);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = (t0 + 280);
    xsi_vlogfile_write(1, 0, 0, ng17, 2, t7, (char)118, t5, 128);

LAB31:    goto LAB13;

LAB23:    xsi_set_current_line(48, ng0);
    t7 = (t0 + 2360);
    t14 = (t7 + 56U);
    t15 = *((char **)t14);
    t21 = (t0 + 2680);
    t23 = (t21 + 56U);
    t25 = *((char **)t23);
    xsi_vlog_bit_copy(t6, 0, t25, 0, 32);
    *((int *)t13) = xsi_vlogfile_fscanf(*((unsigned int *)t15), ng8, 2, t0, (char)118, t6, 32);
    t26 = (t13 + 4);
    *((int *)t26) = 0;
    t27 = (t0 + 2680);
    xsi_vlogvar_assign_value(t27, t6, 0, 0, 32);
    t28 = (t0 + 3000);
    xsi_vlogvar_assign_value(t28, t13, 0, 0, 32);
    goto LAB31;

LAB25:    xsi_set_current_line(50, ng0);

LAB32:    xsi_set_current_line(51, ng0);
    t3 = (t0 + 2360);
    t5 = (t3 + 56U);
    t7 = *((char **)t5);
    t14 = (t0 + 2680);
    t15 = (t14 + 56U);
    t21 = *((char **)t15);
    xsi_vlog_bit_copy(t6, 0, t21, 0, 32);
    t23 = (t0 + 2840);
    t25 = (t23 + 56U);
    t26 = *((char **)t25);
    xsi_vlog_bit_copy(t13, 0, t26, 0, 32);
    *((int *)t29) = xsi_vlogfile_fscanf(*((unsigned int *)t7), ng10, 3, t0, (char)118, t6, 32, (char)118, t13, 32);
    t27 = (t29 + 4);
    *((int *)t27) = 0;
    t28 = (t0 + 2680);
    xsi_vlogvar_assign_value(t28, t6, 0, 0, 32);
    t30 = (t0 + 2840);
    xsi_vlogvar_assign_value(t30, t13, 0, 0, 32);
    t31 = (t0 + 3000);
    xsi_vlogvar_assign_value(t31, t29, 0, 0, 32);
    xsi_set_current_line(52, ng0);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 2200);
    t5 = (t0 + 2200);
    t7 = (t5 + 72U);
    t14 = *((char **)t7);
    t15 = ((char*)((ng12)));
    t21 = (t0 + 2680);
    t23 = (t21 + 56U);
    t25 = *((char **)t23);
    memset(t32, 0, 8);
    xsi_vlog_unsigned_multiply(t32, 32, t15, 32, t25, 32);
    t26 = ((char*)((ng12)));
    xsi_vlog_convert_indexed_partindices(t6, t13, t29, ((int*)(t14)), 2, t32, 32, 2, t26, 32, 1, 1);
    t27 = (t6 + 4);
    t8 = *((unsigned int *)t27);
    t24 = (!(t8));
    t28 = (t13 + 4);
    t9 = *((unsigned int *)t28);
    t33 = (!(t9));
    t34 = (t24 && t33);
    t30 = (t29 + 4);
    t10 = *((unsigned int *)t30);
    t35 = (!(t10));
    t36 = (t34 && t35);
    if (t36 == 1)
        goto LAB33;

LAB34:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 2680);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = ((char*)((ng13)));
    t8 = *((unsigned int *)t5);
    t9 = *((unsigned int *)t7);
    t10 = (t8 & t9);
    *((unsigned int *)t6) = t10;
    t14 = (t5 + 4);
    t15 = (t7 + 4);
    t21 = (t6 + 4);
    t11 = *((unsigned int *)t14);
    t12 = *((unsigned int *)t15);
    t16 = (t11 | t12);
    *((unsigned int *)t21) = t16;
    t17 = *((unsigned int *)t21);
    t18 = (t17 != 0);
    if (t18 == 1)
        goto LAB35;

LAB36:
LAB37:    t26 = (t6 + 4);
    t54 = *((unsigned int *)t26);
    t55 = (~(t54));
    t56 = *((unsigned int *)t6);
    t57 = (t56 & t55);
    t58 = (t57 != 0);
    if (t58 > 0)
        goto LAB38;

LAB39:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 2840);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = ((char*)((ng14)));
    xsi_vlogtype_concat(t59, 64, 64, 2U, t7, 32, t5, 32);
    t14 = (t0 + 2040);
    xsi_vlogvar_wait_assign_value(t14, t59, 0, 0, 64, 1000LL);

LAB40:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 3720);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB41;
    goto LAB1;

LAB27:    xsi_set_current_line(60, ng0);

LAB42:    xsi_set_current_line(61, ng0);
    t3 = (t0 + 2360);
    t5 = (t3 + 56U);
    t7 = *((char **)t5);
    t14 = (t0 + 2840);
    t15 = (t14 + 56U);
    t21 = *((char **)t15);
    xsi_vlog_bit_copy(t6, 0, t21, 0, 32);
    *((int *)t13) = xsi_vlogfile_fscanf(*((unsigned int *)t7), ng8, 2, t0, (char)118, t6, 32);
    t23 = (t13 + 4);
    *((int *)t23) = 0;
    t25 = (t0 + 2840);
    xsi_vlogvar_assign_value(t25, t6, 0, 0, 32);
    t26 = (t0 + 3000);
    xsi_vlogvar_assign_value(t26, t13, 0, 0, 32);
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 2840);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = (t5 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t5);
    t24 = (t10 & t9);
    t14 = (t0 + 5760);
    *((int *)t14) = t24;

LAB43:    t15 = (t0 + 5760);
    if (*((int *)t15) > 0)
        goto LAB44;

LAB45:    goto LAB31;

LAB33:    t11 = *((unsigned int *)t29);
    t37 = (t11 + 0);
    t12 = *((unsigned int *)t6);
    t16 = *((unsigned int *)t13);
    t38 = (t12 - t16);
    t39 = (t38 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, t37, *((unsigned int *)t13), t39, 1000LL);
    goto LAB34;

LAB35:    t19 = *((unsigned int *)t6);
    t20 = *((unsigned int *)t21);
    *((unsigned int *)t6) = (t19 | t20);
    t23 = (t5 + 4);
    t25 = (t7 + 4);
    t40 = *((unsigned int *)t5);
    t41 = (~(t40));
    t42 = *((unsigned int *)t23);
    t43 = (~(t42));
    t44 = *((unsigned int *)t7);
    t45 = (~(t44));
    t46 = *((unsigned int *)t25);
    t47 = (~(t46));
    t24 = (t41 & t43);
    t33 = (t45 & t47);
    t48 = (~(t24));
    t49 = (~(t33));
    t50 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t50 & t48);
    t51 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t51 & t49);
    t52 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t52 & t48);
    t53 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t53 & t49);
    goto LAB37;

LAB38:    xsi_set_current_line(54, ng0);
    t27 = ((char*)((ng14)));
    t28 = (t0 + 2840);
    t30 = (t28 + 56U);
    t31 = *((char **)t30);
    xsi_vlogtype_concat(t59, 64, 64, 2U, t31, 32, t27, 32);
    t60 = (t0 + 2040);
    xsi_vlogvar_wait_assign_value(t60, t59, 0, 0, 64, 1000LL);
    goto LAB40;

LAB41:    xsi_set_current_line(57, ng0);
    t2 = ((char*)((ng15)));
    t3 = (t0 + 2200);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 256, 1000LL);
    xsi_set_current_line(57, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2040);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 64, 1000LL);
    goto LAB31;

LAB44:    xsi_set_current_line(62, ng0);
    t21 = (t0 + 3720);
    xsi_process_wait(t21, 10000LL);
    *((char **)t1) = &&LAB46;
    goto LAB1;

LAB46:    t2 = (t0 + 5760);
    t24 = *((int *)t2);
    *((int *)t2) = (t24 - 1);
    goto LAB43;

}


extern void work_m_06184478847865394197_0257821839_init()
{
	static char *pe[] = {(void *)Initial_32_0};
	xsi_register_didat("work_m_06184478847865394197_0257821839", "isim/tb.sim/work/m_06184478847865394197_0257821839.didat");
	xsi_register_executes(pe);
}
