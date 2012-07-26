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
static const char *ng0 = "/homes/sf306/MMMGF/axel_tb/hdl/tb.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static unsigned int ng3[] = {9U, 0U};
static int ng4[] = {48, 0};
static int ng5[] = {16, 0};
static int ng6[] = {15, 0};
static int ng7[] = {7, 0};
static int ng8[] = {6, 0};
static int ng9[] = {1024, 0};
static const char *ng10 = "Simulation terminate normally.";
static const char *ng11 = "Simulation time out!!";



static void Always_98_0(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;

LAB0:    t1 = (t0 + 7016U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(99, ng0);
    t2 = (t0 + 6824);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(99, ng0);
    t4 = (t0 + 4824);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t0 + 4824);
    xsi_vlogvar_assign_value(t14, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

}

static void Always_101_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;

LAB0:    t1 = (t0 + 7264U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(102, ng0);
    t2 = (t0 + 7072);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(102, ng0);
    t4 = (t0 + 4984);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t0 + 4984);
    xsi_vlogvar_assign_value(t14, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

}

static void Initial_104_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;

LAB0:    t1 = (t0 + 7512U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(105, ng0);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, 111000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(105, ng0);
    t3 = ((char*)((ng1)));
    t4 = (t0 + 5144);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    goto LAB1;

}

static void Cont_109_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 7760U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(109, ng0);
    t2 = (t0 + 4824);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 9200);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 0);
    t18 = (t0 + 9072);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Initial_110_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;

LAB0:    t1 = (t0 + 8008U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(110, ng0);

LAB4:    xsi_set_current_line(111, ng0);
    t2 = (t0 + 7816);
    xsi_process_wait(t2, 144000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(111, ng0);
    t3 = ((char*)((ng2)));
    t4 = (t0 + 5624);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(112, ng0);
    t2 = (t0 + 7816);
    xsi_process_wait(t2, 33000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(112, ng0);
    t3 = ((char*)((ng3)));
    t4 = (t0 + 6104);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 4);
    goto LAB1;

}

static void Always_115_5(char *t0)
{
    char t4[8];
    char t12[8];
    char t13[8];
    char t14[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned int t21;
    int t22;
    char *t23;
    unsigned int t24;
    int t25;
    int t26;
    char *t27;
    unsigned int t28;
    int t29;
    int t30;
    unsigned int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    int t35;
    int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;

LAB0:    t1 = (t0 + 8256U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(115, ng0);
    t2 = (t0 + 9088);
    *((int *)t2) = 1;
    t3 = (t0 + 8288);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(116, ng0);

LAB5:    xsi_set_current_line(117, ng0);
    t5 = (t0 + 2504U);
    t6 = *((char **)t5);
    t5 = (t0 + 2464U);
    t7 = (t5 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    t10 = ((char*)((ng5)));
    xsi_vlog_get_indexed_partselect(t4, 16, t6, ((int*)(t8)), 2, t9, 32, 1, t10, 32, 1, 1);
    t11 = (t0 + 5784);
    t15 = (t0 + 5784);
    t16 = (t15 + 72U);
    t17 = *((char **)t16);
    t18 = ((char*)((ng6)));
    t19 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t12, t13, t14, ((int*)(t17)), 2, t18, 32, 1, t19, 32, 1);
    t20 = (t12 + 4);
    t21 = *((unsigned int *)t20);
    t22 = (!(t21));
    t23 = (t13 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (!(t24));
    t26 = (t22 && t25);
    t27 = (t14 + 4);
    t28 = *((unsigned int *)t27);
    t29 = (!(t28));
    t30 = (t26 && t29);
    if (t30 == 1)
        goto LAB6;

LAB7:    xsi_set_current_line(118, ng0);
    t2 = (t0 + 2664U);
    t3 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t5 = (t3 + 4);
    t21 = *((unsigned int *)t3);
    t24 = (t21 >> 6);
    *((unsigned int *)t4) = t24;
    t28 = *((unsigned int *)t5);
    t31 = (t28 >> 6);
    *((unsigned int *)t2) = t31;
    t33 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t33 & 3U);
    t34 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t34 & 3U);
    t6 = (t0 + 5944);
    t7 = (t0 + 5944);
    t8 = (t7 + 72U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng2)));
    t11 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t12, t13, t14, ((int*)(t9)), 2, t10, 32, 1, t11, 32, 1);
    t15 = (t12 + 4);
    t37 = *((unsigned int *)t15);
    t22 = (!(t37));
    t16 = (t13 + 4);
    t38 = *((unsigned int *)t16);
    t25 = (!(t38));
    t26 = (t22 && t25);
    t17 = (t14 + 4);
    t39 = *((unsigned int *)t17);
    t29 = (!(t39));
    t30 = (t26 && t29);
    if (t30 == 1)
        goto LAB8;

LAB9:    xsi_set_current_line(119, ng0);
    t2 = (t0 + 2504U);
    t3 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t5 = (t3 + 4);
    t21 = *((unsigned int *)t3);
    t24 = (t21 >> 0);
    *((unsigned int *)t4) = t24;
    t28 = *((unsigned int *)t5);
    t31 = (t28 >> 0);
    *((unsigned int *)t2) = t31;
    t33 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t33 & 65535U);
    t34 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t34 & 65535U);
    t6 = (t0 + 5784);
    t7 = (t0 + 5784);
    t8 = (t7 + 72U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng4)));
    t11 = ((char*)((ng5)));
    xsi_vlog_convert_indexed_partindices(t12, t13, t14, ((int*)(t9)), 2, t10, 32, 1, t11, 32, 1, 1);
    t15 = (t12 + 4);
    t37 = *((unsigned int *)t15);
    t22 = (!(t37));
    t16 = (t13 + 4);
    t38 = *((unsigned int *)t16);
    t25 = (!(t38));
    t26 = (t22 && t25);
    t17 = (t14 + 4);
    t39 = *((unsigned int *)t17);
    t29 = (!(t39));
    t30 = (t26 && t29);
    if (t30 == 1)
        goto LAB10;

LAB11:    xsi_set_current_line(120, ng0);
    t2 = (t0 + 2664U);
    t3 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t5 = (t3 + 4);
    t21 = *((unsigned int *)t3);
    t24 = (t21 >> 0);
    *((unsigned int *)t4) = t24;
    t28 = *((unsigned int *)t5);
    t31 = (t28 >> 0);
    *((unsigned int *)t2) = t31;
    t33 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t33 & 3U);
    t34 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t34 & 3U);
    t6 = (t0 + 5944);
    t7 = (t0 + 5944);
    t8 = (t7 + 72U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng7)));
    t11 = ((char*)((ng8)));
    xsi_vlog_convert_partindices(t12, t13, t14, ((int*)(t9)), 2, t10, 32, 1, t11, 32, 1);
    t15 = (t12 + 4);
    t37 = *((unsigned int *)t15);
    t22 = (!(t37));
    t16 = (t13 + 4);
    t38 = *((unsigned int *)t16);
    t25 = (!(t38));
    t26 = (t22 && t25);
    t17 = (t14 + 4);
    t39 = *((unsigned int *)t17);
    t29 = (!(t39));
    t30 = (t26 && t29);
    if (t30 == 1)
        goto LAB12;

LAB13:    goto LAB2;

LAB6:    t31 = *((unsigned int *)t14);
    t32 = (t31 + 0);
    t33 = *((unsigned int *)t12);
    t34 = *((unsigned int *)t13);
    t35 = (t33 - t34);
    t36 = (t35 + 1);
    xsi_vlogvar_wait_assign_value(t11, t4, t32, *((unsigned int *)t13), t36, 1000LL);
    goto LAB7;

LAB8:    t40 = *((unsigned int *)t14);
    t32 = (t40 + 0);
    t41 = *((unsigned int *)t12);
    t42 = *((unsigned int *)t13);
    t35 = (t41 - t42);
    t36 = (t35 + 1);
    xsi_vlogvar_wait_assign_value(t6, t4, t32, *((unsigned int *)t13), t36, 1000LL);
    goto LAB9;

LAB10:    t40 = *((unsigned int *)t14);
    t32 = (t40 + 0);
    t41 = *((unsigned int *)t12);
    t42 = *((unsigned int *)t13);
    t35 = (t41 - t42);
    t36 = (t35 + 1);
    xsi_vlogvar_wait_assign_value(t6, t4, t32, *((unsigned int *)t13), t36, 1000LL);
    goto LAB11;

LAB12:    t40 = *((unsigned int *)t14);
    t32 = (t40 + 0);
    t41 = *((unsigned int *)t12);
    t42 = *((unsigned int *)t13);
    t35 = (t41 - t42);
    t36 = (t35 + 1);
    xsi_vlogvar_wait_assign_value(t6, t4, t32, *((unsigned int *)t13), t36, 1000LL);
    goto LAB13;

}

static void Initial_129_6(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    int t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    t1 = (t0 + 8504U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(129, ng0);

LAB4:    xsi_set_current_line(130, ng0);

LAB5:    t2 = (t0 + 2184U);
    t3 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t5 = (t3 + 4);
    t6 = *((unsigned int *)t3);
    t7 = (t6 >> 0);
    t8 = (t7 & 1);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t5);
    t10 = (t9 >> 0);
    t11 = (t10 & 1);
    *((unsigned int *)t2) = t11;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t12);
    t14 = (~(t13));
    t15 = *((unsigned int *)t4);
    t16 = (t15 & t14);
    t17 = (t16 != 0);
    if (t17 > 0)
        goto LAB7;

LAB6:    t18 = (t0 + 9104);
    *((int *)t18) = 1;
    t19 = (t0 + 8504U);
    *((char **)t19) = &&LAB5;

LAB1:    return;
LAB7:    t20 = (t0 + 9104);
    *((int *)t20) = 0;
    xsi_set_current_line(131, ng0);
    t2 = (t0 + 9120);
    *((int *)t2) = 1;
    t3 = (t0 + 8536);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB8;
    goto LAB1;

LAB8:    xsi_set_current_line(132, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 8312);
    t5 = (t0 + 11800);
    t12 = *((char **)t5);
    t18 = (t0 + 11816);
    t19 = xsi_create_subprogram_invocation(t3, 0, *((char **)t18), ((char*)(t12)), 0, 0);
    xsi_vlog_subprogram_pushinvocation(((char*)(t12)), t19);
    t20 = (t0 + 11808);
    t21 = *((char **)t20);
    xsi_vlogvar_assign_value(((char*)(t21)), t2, 0, 0, 32);

LAB11:    t22 = (t0 + 8408);
    t23 = *((char **)t22);
    t24 = (t23 + 80U);
    t25 = *((char **)t24);
    t26 = (t25 + 272U);
    t27 = *((char **)t26);
    t28 = (t27 + 0U);
    t29 = *((char **)t28);
    t30 = (t0 + 11816);
    t31 = ((int  (*)(char *, char *))t29)(*((char **)t30), t23);

LAB13:    if (t31 != 0)
        goto LAB14;

LAB9:    t23 = (t0 + 11848);
    t32 = *((char **)t23);
    xsi_vlog_subprogram_popinvocation(((char*)(t32)));

LAB10:    t33 = (t0 + 8408);
    t34 = *((char **)t33);
    t33 = (t0 + 11848);
    t35 = *((char **)t33);
    t36 = (t0 + 8312);
    t37 = 0;
    xsi_delete_subprogram_invocation(((char*)(t35)), t34, t0, t36, t37);
    xsi_set_current_line(133, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 8312);
    t5 = (t0 + 11896);
    t12 = *((char **)t5);
    t18 = (t0 + 11912);
    t19 = xsi_create_subprogram_invocation(t3, 0, *((char **)t18), ((char*)(t12)), 0, 0);
    xsi_vlog_subprogram_pushinvocation(((char*)(t12)), t19);
    t20 = (t0 + 11904);
    t21 = *((char **)t20);
    xsi_vlogvar_assign_value(((char*)(t21)), t2, 0, 0, 32);

LAB17:    t22 = (t0 + 8408);
    t23 = *((char **)t22);
    t24 = (t23 + 80U);
    t25 = *((char **)t24);
    t26 = (t25 + 272U);
    t27 = *((char **)t26);
    t28 = (t27 + 0U);
    t29 = *((char **)t28);
    t30 = (t0 + 11912);
    t31 = ((int  (*)(char *, char *))t29)(*((char **)t30), t23);

LAB19:    if (t31 != 0)
        goto LAB20;

LAB15:    t23 = (t0 + 11944);
    t32 = *((char **)t23);
    xsi_vlog_subprogram_popinvocation(((char*)(t32)));

LAB16:    t33 = (t0 + 8408);
    t34 = *((char **)t33);
    t33 = (t0 + 11944);
    t35 = *((char **)t33);
    t36 = (t0 + 8312);
    t37 = 0;
    xsi_delete_subprogram_invocation(((char*)(t35)), t34, t0, t36, t37);
    xsi_set_current_line(134, ng0);
    xsi_vlogfile_write(1, 0, 0, ng10, 1, t0);
    xsi_set_current_line(135, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

LAB12:;
LAB14:    t22 = (t0 + 8504U);
    *((char **)t22) = &&LAB11;
    goto LAB1;

LAB18:;
LAB20:    t22 = (t0 + 8504U);
    *((char **)t22) = &&LAB17;
    goto LAB1;

}

static void Initial_138_7(char *t0)
{
    char *t1;
    char *t2;

LAB0:    t1 = (t0 + 8752U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(138, ng0);

LAB4:    xsi_set_current_line(139, ng0);
    t2 = (t0 + 8560);
    xsi_process_wait(t2, 15000000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(139, ng0);
    xsi_vlogfile_write(1, 0, 0, ng11, 1, t0);
    xsi_set_current_line(140, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}


extern void work_m_16838775355190604089_3671711236_init()
{
	static char *pe[] = {(void *)Always_98_0,(void *)Always_101_1,(void *)Initial_104_2,(void *)Cont_109_3,(void *)Initial_110_4,(void *)Always_115_5,(void *)Initial_129_6,(void *)Initial_138_7};
	xsi_register_didat("work_m_16838775355190604089_3671711236", "isim/tb.sim/work/m_16838775355190604089_3671711236.didat");
	xsi_register_executes(pe);
}
