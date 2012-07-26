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
static const char *ng0 = "/homes/sf306/MMMGF/axel_tb/hdl/sim_extmem.v";
static const char *ng1 = "bank%1d_data.hex";
static const char *ng2 = "Loading %d bytes from %s to memory bank %1d.";
static const char *ng3 = "Displaying %d bytes in memory Bank %1d.";
static int ng4[] = {0, 0};
static int ng5[] = {16, 0};
static const char *ng6 = " %08X  %08X  %08X  %08X ";
static int ng7[] = {1, 0};
static int ng8[] = {8, 0};
static unsigned int ng9[] = {0U, 4294967295U};
static unsigned int ng10[] = {0U, 4294967295U, 0U, 4294967295U, 0U, 4294967295U, 0U, 4294967295U};
static const char *ng11 = "Assert (@ %dns): Illegal operation in Bank %d. Entering command while not ready for address %d.";



static int sp_load_mem(char *t1, char *t2)
{
    char t6[32];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1664);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(48, ng0);

LAB5:    xsi_set_current_line(49, ng0);
    t5 = (t1 + 5368);
    t7 = (t1 + 472);
    t8 = *((char **)t7);
    xsi_vlogfile_sformat_isreg(t6, 112, ng1, 0, 0, 2, t1, (char)119, t8, 32);
    xsi_vlogvar_assign_value(t5, t6, 0, 0, 112);
    xsi_set_current_line(50, ng0);
    t4 = (t1 + 608);
    t5 = *((char **)t4);
    t4 = (t1 + 5368);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t1 + 472);
    t10 = *((char **)t9);
    t9 = (t1 + 1664);
    xsi_vlogfile_write(1, 0, 0, ng2, 4, t9, (char)119, t5, 32, (char)118, t8, 112, (char)119, t10, 32);
    xsi_set_current_line(52, ng0);
    t4 = (t1 + 5368);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t1 + 5048);
    xsi_vlogfile_readmemh(t7, 112, t8, 0, 0, 0, 0);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_display_mem(char *t1, char *t2)
{
    char t11[8];
    char t12[8];
    char t25[32];
    char t35[8];
    char t48[32];
    char t58[8];
    char t71[32];
    char t81[8];
    char t94[32];
    char t104[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t36;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    char *t45;
    char *t46;
    char *t47;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t59;
    char *t60;
    char *t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    char *t68;
    char *t69;
    char *t70;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t82;
    char *t83;
    char *t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    char *t91;
    char *t92;
    char *t93;
    char *t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t105;
    char *t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    char *t113;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 2096);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(59, ng0);

LAB5:    xsi_set_current_line(60, ng0);
    t5 = (t1 + 5528);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t1 + 472);
    t9 = *((char **)t8);
    t8 = (t1 + 2096);
    xsi_vlogfile_write(1, 0, 0, ng3, 3, t8, (char)118, t7, 32, (char)119, t9, 32);
    xsi_set_current_line(61, ng0);
    xsi_set_current_line(61, ng0);
    t4 = ((char*)((ng4)));
    t5 = (t1 + 5688);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 32);

LAB6:    t4 = (t1 + 5688);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 5528);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng5)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_divide(t11, 32, t9, 32, t10, 32);
    memset(t12, 0, 8);
    t13 = (t6 + 4);
    if (*((unsigned int *)t13) != 0)
        goto LAB8;

LAB7:    t14 = (t11 + 4);
    if (*((unsigned int *)t14) != 0)
        goto LAB8;

LAB11:    if (*((unsigned int *)t6) < *((unsigned int *)t11))
        goto LAB9;

LAB10:    t16 = (t12 + 4);
    t17 = *((unsigned int *)t16);
    t18 = (~(t17));
    t19 = *((unsigned int *)t12);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB12;

LAB13:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t15 = (t12 + 4);
    *((unsigned int *)t12) = 1;
    *((unsigned int *)t15) = 1;
    goto LAB10;

LAB9:    *((unsigned int *)t12) = 1;
    goto LAB10;

LAB12:    xsi_set_current_line(62, ng0);
    t22 = (t1 + 5048);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t26 = (t1 + 5048);
    t27 = (t26 + 72U);
    t28 = *((char **)t27);
    t29 = (t1 + 5048);
    t30 = (t29 + 64U);
    t31 = *((char **)t30);
    t32 = (t1 + 5688);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    xsi_vlog_generic_get_array_select_value(t25, 128, t24, t28, t31, 2, 1, t34, 32, 1);
    memset(t35, 0, 8);
    t36 = (t35 + 4);
    t37 = (t25 + 24);
    t38 = (t25 + 28);
    t39 = *((unsigned int *)t37);
    t40 = (t39 >> 0);
    *((unsigned int *)t35) = t40;
    t41 = *((unsigned int *)t38);
    t42 = (t41 >> 0);
    *((unsigned int *)t36) = t42;
    t43 = *((unsigned int *)t35);
    *((unsigned int *)t35) = (t43 & 4294967295U);
    t44 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t44 & 4294967295U);
    t45 = (t1 + 5048);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t49 = (t1 + 5048);
    t50 = (t49 + 72U);
    t51 = *((char **)t50);
    t52 = (t1 + 5048);
    t53 = (t52 + 64U);
    t54 = *((char **)t53);
    t55 = (t1 + 5688);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    xsi_vlog_generic_get_array_select_value(t48, 128, t47, t51, t54, 2, 1, t57, 32, 1);
    memset(t58, 0, 8);
    t59 = (t58 + 4);
    t60 = (t48 + 16);
    t61 = (t48 + 20);
    t62 = *((unsigned int *)t60);
    t63 = (t62 >> 0);
    *((unsigned int *)t58) = t63;
    t64 = *((unsigned int *)t61);
    t65 = (t64 >> 0);
    *((unsigned int *)t59) = t65;
    t66 = *((unsigned int *)t58);
    *((unsigned int *)t58) = (t66 & 4294967295U);
    t67 = *((unsigned int *)t59);
    *((unsigned int *)t59) = (t67 & 4294967295U);
    t68 = (t1 + 5048);
    t69 = (t68 + 56U);
    t70 = *((char **)t69);
    t72 = (t1 + 5048);
    t73 = (t72 + 72U);
    t74 = *((char **)t73);
    t75 = (t1 + 5048);
    t76 = (t75 + 64U);
    t77 = *((char **)t76);
    t78 = (t1 + 5688);
    t79 = (t78 + 56U);
    t80 = *((char **)t79);
    xsi_vlog_generic_get_array_select_value(t71, 128, t70, t74, t77, 2, 1, t80, 32, 1);
    memset(t81, 0, 8);
    t82 = (t81 + 4);
    t83 = (t71 + 8);
    t84 = (t71 + 12);
    t85 = *((unsigned int *)t83);
    t86 = (t85 >> 0);
    *((unsigned int *)t81) = t86;
    t87 = *((unsigned int *)t84);
    t88 = (t87 >> 0);
    *((unsigned int *)t82) = t88;
    t89 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t89 & 4294967295U);
    t90 = *((unsigned int *)t82);
    *((unsigned int *)t82) = (t90 & 4294967295U);
    t91 = (t1 + 5048);
    t92 = (t91 + 56U);
    t93 = *((char **)t92);
    t95 = (t1 + 5048);
    t96 = (t95 + 72U);
    t97 = *((char **)t96);
    t98 = (t1 + 5048);
    t99 = (t98 + 64U);
    t100 = *((char **)t99);
    t101 = (t1 + 5688);
    t102 = (t101 + 56U);
    t103 = *((char **)t102);
    xsi_vlog_generic_get_array_select_value(t94, 128, t93, t97, t100, 2, 1, t103, 32, 1);
    memset(t104, 0, 8);
    t105 = (t104 + 4);
    t106 = (t94 + 4);
    t107 = *((unsigned int *)t94);
    t108 = (t107 >> 0);
    *((unsigned int *)t104) = t108;
    t109 = *((unsigned int *)t106);
    t110 = (t109 >> 0);
    *((unsigned int *)t105) = t110;
    t111 = *((unsigned int *)t104);
    *((unsigned int *)t104) = (t111 & 4294967295U);
    t112 = *((unsigned int *)t105);
    *((unsigned int *)t105) = (t112 & 4294967295U);
    t113 = (t1 + 2096);
    xsi_vlogfile_write(1, 0, 0, ng6, 5, t113, (char)118, t35, 32, (char)118, t58, 32, (char)118, t81, 32, (char)118, t104, 32);
    xsi_set_current_line(61, ng0);
    t4 = (t1 + 5688);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng7)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 5688);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);
    goto LAB6;

}

static void Initial_72_0(char *t0)
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
    char *t10;
    char *t11;
    char *t12;
    int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    t1 = (t0 + 6600U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(72, ng0);

LAB4:    xsi_set_current_line(73, ng0);
    t2 = (t0 + 6408);
    t3 = (t0 + 1664);
    t4 = xsi_create_subprogram_invocation(t2, 0, t0, t3, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t3, t4);

LAB7:    t5 = (t0 + 6504);
    t6 = *((char **)t5);
    t7 = (t6 + 80U);
    t8 = *((char **)t7);
    t9 = (t8 + 272U);
    t10 = *((char **)t9);
    t11 = (t10 + 0U);
    t12 = *((char **)t11);
    t13 = ((int  (*)(char *, char *))t12)(t0, t6);

LAB9:    if (t13 != 0)
        goto LAB10;

LAB5:    t6 = (t0 + 1664);
    xsi_vlog_subprogram_popinvocation(t6);

LAB6:    t14 = (t0 + 6504);
    t15 = *((char **)t14);
    t14 = (t0 + 1664);
    t16 = (t0 + 6408);
    t17 = 0;
    xsi_delete_subprogram_invocation(t14, t15, t0, t16, t17);

LAB1:    return;
LAB8:;
LAB10:    t5 = (t0 + 6600U);
    *((char **)t5) = &&LAB7;
    goto LAB1;

}

static void Always_76_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;

LAB0:    t1 = (t0 + 6848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(76, ng0);

LAB4:    xsi_set_current_line(77, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 4888);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(77, ng0);
    t2 = (t0 + 6656);
    xsi_process_wait(t2, 263500LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(78, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 4888);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(78, ng0);
    t2 = (t0 + 6656);
    xsi_process_wait(t2, 17200LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    goto LAB2;

}

static void Always_81_2(char *t0)
{
    char t6[8];
    char t26[8];
    char t59[8];
    char t93[8];
    char t96[8];
    char t97[8];
    char t106[8];
    char t107[8];
    char t108[8];
    char t115[8];
    char t131[32];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    char *t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    int t50;
    int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    char *t58;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    char *t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    char *t71;
    char *t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    int t81;
    int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t94;
    char *t95;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t109;
    char *t110;
    char *t111;
    char *t112;
    char *t113;
    char *t114;
    char *t116;
    char *t117;
    char *t118;
    char *t119;
    int t120;
    char *t121;
    int t122;
    int t123;
    char *t124;
    int t125;
    int t126;
    int t127;
    int t128;
    int t129;
    int t130;

LAB0:    t1 = (t0 + 7096U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(81, ng0);
    t2 = (t0 + 7664);
    *((int *)t2) = 1;
    t3 = (t0 + 7128);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(81, ng0);

LAB5:    xsi_set_current_line(83, ng0);
    t4 = (t0 + 2888U);
    t5 = *((char **)t4);
    t4 = (t0 + 4888);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    memset(t6, 0, 8);
    t9 = (t8 + 4);
    t10 = *((unsigned int *)t9);
    t11 = (~(t10));
    t12 = *((unsigned int *)t8);
    t13 = (t12 & t11);
    t14 = (t13 & 1U);
    if (t14 != 0)
        goto LAB9;

LAB7:    if (*((unsigned int *)t9) == 0)
        goto LAB6;

LAB8:    t15 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t15) = 1;

LAB9:    t16 = (t6 + 4);
    t17 = (t8 + 4);
    t18 = *((unsigned int *)t8);
    t19 = (~(t18));
    *((unsigned int *)t6) = t19;
    *((unsigned int *)t16) = 0;
    if (*((unsigned int *)t17) != 0)
        goto LAB11;

LAB10:    t24 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t24 & 1U);
    t25 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t25 & 1U);
    t27 = *((unsigned int *)t5);
    t28 = *((unsigned int *)t6);
    t29 = (t27 & t28);
    *((unsigned int *)t26) = t29;
    t30 = (t5 + 4);
    t31 = (t6 + 4);
    t32 = (t26 + 4);
    t33 = *((unsigned int *)t30);
    t34 = *((unsigned int *)t31);
    t35 = (t33 | t34);
    *((unsigned int *)t32) = t35;
    t36 = *((unsigned int *)t32);
    t37 = (t36 != 0);
    if (t37 == 1)
        goto LAB12;

LAB13:
LAB14:    t58 = (t0 + 4728);
    xsi_vlogvar_wait_assign_value(t58, t26, 0, 0, 1, 1000LL);
    xsi_set_current_line(84, ng0);
    t2 = (t0 + 3048U);
    t3 = *((char **)t2);
    t2 = (t0 + 3208U);
    t4 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t4 + 4);
    t10 = *((unsigned int *)t2);
    t11 = (~(t10));
    t12 = *((unsigned int *)t4);
    t13 = (t12 & t11);
    t14 = (t13 & 1U);
    if (t14 != 0)
        goto LAB18;

LAB16:    if (*((unsigned int *)t2) == 0)
        goto LAB15;

LAB17:    t5 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t5) = 1;

LAB18:    t7 = (t6 + 4);
    t8 = (t4 + 4);
    t18 = *((unsigned int *)t4);
    t19 = (~(t18));
    *((unsigned int *)t6) = t19;
    *((unsigned int *)t7) = 0;
    if (*((unsigned int *)t8) != 0)
        goto LAB20;

LAB19:    t24 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t24 & 1U);
    t25 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t25 & 1U);
    t27 = *((unsigned int *)t3);
    t28 = *((unsigned int *)t6);
    t29 = (t27 & t28);
    *((unsigned int *)t26) = t29;
    t9 = (t3 + 4);
    t15 = (t6 + 4);
    t16 = (t26 + 4);
    t33 = *((unsigned int *)t9);
    t34 = *((unsigned int *)t15);
    t35 = (t33 | t34);
    *((unsigned int *)t16) = t35;
    t36 = *((unsigned int *)t16);
    t37 = (t36 != 0);
    if (t37 == 1)
        goto LAB21;

LAB22:
LAB23:    t31 = (t0 + 4728);
    t32 = (t31 + 56U);
    t40 = *((char **)t32);
    t60 = *((unsigned int *)t26);
    t61 = *((unsigned int *)t40);
    t62 = (t60 & t61);
    *((unsigned int *)t59) = t62;
    t41 = (t26 + 4);
    t58 = (t40 + 4);
    t63 = (t59 + 4);
    t64 = *((unsigned int *)t41);
    t65 = *((unsigned int *)t58);
    t66 = (t64 | t65);
    *((unsigned int *)t63) = t66;
    t67 = *((unsigned int *)t63);
    t68 = (t67 != 0);
    if (t68 == 1)
        goto LAB24;

LAB25:
LAB26:    t89 = (t0 + 4248);
    xsi_vlogvar_wait_assign_value(t89, t59, 0, 0, 1, 1000LL);
    xsi_set_current_line(85, ng0);
    t2 = (t0 + 3048U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t10 = *((unsigned int *)t2);
    t11 = (~(t10));
    t12 = *((unsigned int *)t3);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB27;

LAB28:    xsi_set_current_line(96, ng0);

LAB49:    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 4408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 128, 1000LL);
    xsi_set_current_line(98, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 4568);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 1000LL);

LAB29:    goto LAB2;

LAB6:    *((unsigned int *)t6) = 1;
    goto LAB9;

LAB11:    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t17);
    *((unsigned int *)t6) = (t20 | t21);
    t22 = *((unsigned int *)t16);
    t23 = *((unsigned int *)t17);
    *((unsigned int *)t16) = (t22 | t23);
    goto LAB10;

LAB12:    t38 = *((unsigned int *)t26);
    t39 = *((unsigned int *)t32);
    *((unsigned int *)t26) = (t38 | t39);
    t40 = (t5 + 4);
    t41 = (t6 + 4);
    t42 = *((unsigned int *)t5);
    t43 = (~(t42));
    t44 = *((unsigned int *)t40);
    t45 = (~(t44));
    t46 = *((unsigned int *)t6);
    t47 = (~(t46));
    t48 = *((unsigned int *)t41);
    t49 = (~(t48));
    t50 = (t43 & t45);
    t51 = (t47 & t49);
    t52 = (~(t50));
    t53 = (~(t51));
    t54 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t54 & t52);
    t55 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t55 & t53);
    t56 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t56 & t52);
    t57 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t57 & t53);
    goto LAB14;

LAB15:    *((unsigned int *)t6) = 1;
    goto LAB18;

LAB20:    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    *((unsigned int *)t6) = (t20 | t21);
    t22 = *((unsigned int *)t7);
    t23 = *((unsigned int *)t8);
    *((unsigned int *)t7) = (t22 | t23);
    goto LAB19;

LAB21:    t38 = *((unsigned int *)t26);
    t39 = *((unsigned int *)t16);
    *((unsigned int *)t26) = (t38 | t39);
    t17 = (t3 + 4);
    t30 = (t6 + 4);
    t42 = *((unsigned int *)t3);
    t43 = (~(t42));
    t44 = *((unsigned int *)t17);
    t45 = (~(t44));
    t46 = *((unsigned int *)t6);
    t47 = (~(t46));
    t48 = *((unsigned int *)t30);
    t49 = (~(t48));
    t50 = (t43 & t45);
    t51 = (t47 & t49);
    t52 = (~(t50));
    t53 = (~(t51));
    t54 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t54 & t52);
    t55 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t55 & t53);
    t56 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t56 & t52);
    t57 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t57 & t53);
    goto LAB23;

LAB24:    t69 = *((unsigned int *)t59);
    t70 = *((unsigned int *)t63);
    *((unsigned int *)t59) = (t69 | t70);
    t71 = (t26 + 4);
    t72 = (t40 + 4);
    t73 = *((unsigned int *)t26);
    t74 = (~(t73));
    t75 = *((unsigned int *)t71);
    t76 = (~(t75));
    t77 = *((unsigned int *)t40);
    t78 = (~(t77));
    t79 = *((unsigned int *)t72);
    t80 = (~(t79));
    t81 = (t74 & t76);
    t82 = (t78 & t80);
    t83 = (~(t81));
    t84 = (~(t82));
    t85 = *((unsigned int *)t63);
    *((unsigned int *)t63) = (t85 & t83);
    t86 = *((unsigned int *)t63);
    *((unsigned int *)t63) = (t86 & t84);
    t87 = *((unsigned int *)t59);
    *((unsigned int *)t59) = (t87 & t83);
    t88 = *((unsigned int *)t59);
    *((unsigned int *)t59) = (t88 & t84);
    goto LAB26;

LAB27:    xsi_set_current_line(85, ng0);

LAB30:    xsi_set_current_line(86, ng0);
    xsi_set_current_line(86, ng0);
    t4 = ((char*)((ng4)));
    t5 = (t0 + 5208);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 32);

LAB31:    t2 = (t0 + 5208);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1152);
    t7 = *((char **)t5);
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t7, 32);
    t5 = (t6 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (~(t10));
    t12 = *((unsigned int *)t6);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB32;

LAB33:    xsi_set_current_line(95, ng0);
    t2 = (t0 + 3528U);
    t3 = *((char **)t2);
    t2 = (t0 + 4568);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 2, 1000LL);
    goto LAB29;

LAB32:    xsi_set_current_line(87, ng0);
    t8 = (t0 + 3848U);
    t9 = *((char **)t8);
    t8 = (t0 + 3808U);
    t15 = (t8 + 72U);
    t16 = *((char **)t15);
    t17 = (t0 + 5208);
    t30 = (t17 + 56U);
    t31 = *((char **)t30);
    xsi_vlog_generic_get_index_select_value(t26, 1, t9, t16, 2, t31, 32, 1);
    t32 = (t26 + 4);
    t18 = *((unsigned int *)t32);
    t19 = (~(t18));
    t20 = *((unsigned int *)t26);
    t21 = (t20 & t19);
    t22 = (t21 != 0);
    if (t22 > 0)
        goto LAB34;

LAB35:    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 4408);
    t4 = (t0 + 4408);
    t5 = (t4 + 72U);
    t7 = *((char **)t5);
    t8 = ((char*)((ng8)));
    t9 = (t0 + 5208);
    t15 = (t9 + 56U);
    t16 = *((char **)t15);
    memset(t93, 0, 8);
    xsi_vlog_signed_multiply(t93, 32, t8, 32, t16, 32);
    t17 = ((char*)((ng8)));
    xsi_vlog_convert_indexed_partindices(t6, t26, t59, ((int*)(t7)), 2, t93, 32, 1, t17, 32, 1, 1);
    t30 = (t6 + 4);
    t10 = *((unsigned int *)t30);
    t50 = (!(t10));
    t31 = (t26 + 4);
    t11 = *((unsigned int *)t31);
    t51 = (!(t11));
    t81 = (t50 && t51);
    t32 = (t59 + 4);
    t12 = *((unsigned int *)t32);
    t82 = (!(t12));
    t120 = (t81 && t82);
    if (t120 == 1)
        goto LAB47;

LAB48:
LAB36:    xsi_set_current_line(86, ng0);
    t2 = (t0 + 5208);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng7)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 5208);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB31;

LAB34:    xsi_set_current_line(88, ng0);
    t40 = (t0 + 3208U);
    t41 = *((char **)t40);
    t40 = (t41 + 4);
    t23 = *((unsigned int *)t40);
    t24 = (~(t23));
    t25 = *((unsigned int *)t41);
    t27 = (t25 & t24);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB37;

LAB38:    xsi_set_current_line(92, ng0);
    t2 = (t0 + 5048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 5048);
    t7 = (t5 + 72U);
    t8 = *((char **)t7);
    t9 = (t0 + 5048);
    t15 = (t9 + 64U);
    t16 = *((char **)t15);
    t17 = (t0 + 3368U);
    t30 = *((char **)t17);
    xsi_vlog_generic_get_array_select_value(t131, 128, t4, t8, t16, 2, 1, t30, 32, 2);
    t17 = (t0 + 5048);
    t31 = (t17 + 72U);
    t32 = *((char **)t31);
    t40 = ((char*)((ng8)));
    t41 = (t0 + 5208);
    t58 = (t41 + 56U);
    t63 = *((char **)t58);
    memset(t26, 0, 8);
    xsi_vlog_signed_multiply(t26, 32, t40, 32, t63, 32);
    t71 = ((char*)((ng8)));
    xsi_vlog_get_indexed_partselect(t6, 8, t131, ((int*)(t32)), 2, t26, 32, 1, t71, 32, 1, 1);
    t72 = (t0 + 4408);
    t89 = (t0 + 4408);
    t90 = (t89 + 72U);
    t91 = *((char **)t90);
    t92 = ((char*)((ng8)));
    t94 = (t0 + 5208);
    t95 = (t94 + 56U);
    t98 = *((char **)t95);
    memset(t97, 0, 8);
    xsi_vlog_signed_multiply(t97, 32, t92, 32, t98, 32);
    t99 = ((char*)((ng8)));
    xsi_vlog_convert_indexed_partindices(t59, t93, t96, ((int*)(t91)), 2, t97, 32, 1, t99, 32, 1, 1);
    t100 = (t59 + 4);
    t10 = *((unsigned int *)t100);
    t50 = (!(t10));
    t101 = (t93 + 4);
    t11 = *((unsigned int *)t101);
    t51 = (!(t11));
    t81 = (t50 && t51);
    t102 = (t96 + 4);
    t12 = *((unsigned int *)t102);
    t82 = (!(t12));
    t120 = (t81 && t82);
    if (t120 == 1)
        goto LAB45;

LAB46:
LAB39:    goto LAB36;

LAB37:    xsi_set_current_line(88, ng0);

LAB40:    xsi_set_current_line(89, ng0);
    t58 = (t0 + 3688U);
    t63 = *((char **)t58);
    t58 = (t0 + 3648U);
    t71 = (t58 + 72U);
    t72 = *((char **)t71);
    t89 = ((char*)((ng8)));
    t90 = (t0 + 5208);
    t91 = (t90 + 56U);
    t92 = *((char **)t91);
    memset(t93, 0, 8);
    xsi_vlog_signed_multiply(t93, 32, t89, 32, t92, 32);
    t94 = ((char*)((ng8)));
    xsi_vlog_get_indexed_partselect(t59, 8, t63, ((int*)(t72)), 2, t93, 32, 1, t94, 32, 1, 1);
    t95 = (t0 + 5048);
    t98 = (t0 + 5048);
    t99 = (t98 + 72U);
    t100 = *((char **)t99);
    t101 = (t0 + 5048);
    t102 = (t101 + 64U);
    t103 = *((char **)t102);
    t104 = (t0 + 3368U);
    t105 = *((char **)t104);
    xsi_vlog_generic_convert_array_indices(t96, t97, t100, t103, 2, 1, t105, 32, 2);
    t104 = (t0 + 5048);
    t109 = (t104 + 72U);
    t110 = *((char **)t109);
    t111 = ((char*)((ng8)));
    t112 = (t0 + 5208);
    t113 = (t112 + 56U);
    t114 = *((char **)t113);
    memset(t115, 0, 8);
    xsi_vlog_signed_multiply(t115, 32, t111, 32, t114, 32);
    t116 = ((char*)((ng8)));
    xsi_vlog_convert_indexed_partindices(t106, t107, t108, ((int*)(t110)), 2, t115, 32, 1, t116, 32, 1, 1);
    t117 = (t96 + 4);
    t29 = *((unsigned int *)t117);
    t50 = (!(t29));
    t118 = (t97 + 4);
    t33 = *((unsigned int *)t118);
    t51 = (!(t33));
    t81 = (t50 && t51);
    t119 = (t106 + 4);
    t34 = *((unsigned int *)t119);
    t82 = (!(t34));
    t120 = (t81 && t82);
    t121 = (t107 + 4);
    t35 = *((unsigned int *)t121);
    t122 = (!(t35));
    t123 = (t120 && t122);
    t124 = (t108 + 4);
    t36 = *((unsigned int *)t124);
    t125 = (!(t36));
    t126 = (t123 && t125);
    if (t126 == 1)
        goto LAB41;

LAB42:    xsi_set_current_line(90, ng0);
    t2 = (t0 + 3688U);
    t3 = *((char **)t2);
    t2 = (t0 + 3648U);
    t4 = (t2 + 72U);
    t5 = *((char **)t4);
    t7 = ((char*)((ng8)));
    t8 = (t0 + 5208);
    t9 = (t8 + 56U);
    t15 = *((char **)t9);
    memset(t26, 0, 8);
    xsi_vlog_signed_multiply(t26, 32, t7, 32, t15, 32);
    t16 = ((char*)((ng8)));
    xsi_vlog_get_indexed_partselect(t6, 8, t3, ((int*)(t5)), 2, t26, 32, 1, t16, 32, 1, 1);
    t17 = (t0 + 4408);
    t30 = (t0 + 4408);
    t31 = (t30 + 72U);
    t32 = *((char **)t31);
    t40 = ((char*)((ng8)));
    t41 = (t0 + 5208);
    t58 = (t41 + 56U);
    t63 = *((char **)t58);
    memset(t97, 0, 8);
    xsi_vlog_signed_multiply(t97, 32, t40, 32, t63, 32);
    t71 = ((char*)((ng8)));
    xsi_vlog_convert_indexed_partindices(t59, t93, t96, ((int*)(t32)), 2, t97, 32, 1, t71, 32, 1, 1);
    t72 = (t59 + 4);
    t10 = *((unsigned int *)t72);
    t50 = (!(t10));
    t89 = (t93 + 4);
    t11 = *((unsigned int *)t89);
    t51 = (!(t11));
    t81 = (t50 && t51);
    t90 = (t96 + 4);
    t12 = *((unsigned int *)t90);
    t82 = (!(t12));
    t120 = (t81 && t82);
    if (t120 == 1)
        goto LAB43;

LAB44:    goto LAB39;

LAB41:    t37 = *((unsigned int *)t108);
    t127 = (t37 + 0);
    t38 = *((unsigned int *)t97);
    t39 = *((unsigned int *)t107);
    t128 = (t38 + t39);
    t42 = *((unsigned int *)t106);
    t43 = *((unsigned int *)t107);
    t129 = (t42 - t43);
    t130 = (t129 + 1);
    xsi_vlogvar_wait_assign_value(t95, t59, t127, t128, t130, 1000LL);
    goto LAB42;

LAB43:    t13 = *((unsigned int *)t96);
    t122 = (t13 + 0);
    t14 = *((unsigned int *)t59);
    t18 = *((unsigned int *)t93);
    t123 = (t14 - t18);
    t125 = (t123 + 1);
    xsi_vlogvar_wait_assign_value(t17, t6, t122, *((unsigned int *)t93), t125, 1000LL);
    goto LAB44;

LAB45:    t13 = *((unsigned int *)t96);
    t122 = (t13 + 0);
    t14 = *((unsigned int *)t59);
    t18 = *((unsigned int *)t93);
    t123 = (t14 - t18);
    t125 = (t123 + 1);
    xsi_vlogvar_wait_assign_value(t72, t6, t122, *((unsigned int *)t93), t125, 1000LL);
    goto LAB46;

LAB47:    t13 = *((unsigned int *)t59);
    t122 = (t13 + 0);
    t14 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t26);
    t123 = (t14 - t18);
    t125 = (t123 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, t122, *((unsigned int *)t26), t125, 1000LL);
    goto LAB48;

}

static void Always_103_3(char *t0)
{
    char t6[8];
    char t17[8];
    char t28[8];
    char t36[8];
    char t74[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;
    char *t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    char *t50;
    char *t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    int t60;
    int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    char *t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    char *t75;
    char *t76;
    char *t77;
    char *t78;

LAB0:    t1 = (t0 + 7344U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(103, ng0);
    t2 = (t0 + 7680);
    *((int *)t2) = 1;
    t3 = (t0 + 7376);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(104, ng0);
    t4 = (t0 + 3048U);
    t5 = *((char **)t4);
    memset(t6, 0, 8);
    t4 = (t5 + 4);
    t7 = *((unsigned int *)t4);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB5;

LAB6:    if (*((unsigned int *)t4) != 0)
        goto LAB7;

LAB8:    t13 = (t6 + 4);
    t14 = *((unsigned int *)t6);
    t15 = *((unsigned int *)t13);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB9;

LAB10:    memcpy(t36, t6, 8);

LAB11:    t68 = (t36 + 4);
    t69 = *((unsigned int *)t68);
    t70 = (~(t69));
    t71 = *((unsigned int *)t36);
    t72 = (t71 & t70);
    t73 = (t72 != 0);
    if (t73 > 0)
        goto LAB23;

LAB24:
LAB25:    goto LAB2;

LAB5:    *((unsigned int *)t6) = 1;
    goto LAB8;

LAB7:    t12 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB8;

LAB9:    t18 = (t0 + 4728);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memset(t17, 0, 8);
    t21 = (t20 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t20);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB15;

LAB13:    if (*((unsigned int *)t21) == 0)
        goto LAB12;

LAB14:    t27 = (t17 + 4);
    *((unsigned int *)t17) = 1;
    *((unsigned int *)t27) = 1;

LAB15:    memset(t28, 0, 8);
    t29 = (t17 + 4);
    t30 = *((unsigned int *)t29);
    t31 = (~(t30));
    t32 = *((unsigned int *)t17);
    t33 = (t32 & t31);
    t34 = (t33 & 1U);
    if (t34 != 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t29) != 0)
        goto LAB18;

LAB19:    t37 = *((unsigned int *)t6);
    t38 = *((unsigned int *)t28);
    t39 = (t37 & t38);
    *((unsigned int *)t36) = t39;
    t40 = (t6 + 4);
    t41 = (t28 + 4);
    t42 = (t36 + 4);
    t43 = *((unsigned int *)t40);
    t44 = *((unsigned int *)t41);
    t45 = (t43 | t44);
    *((unsigned int *)t42) = t45;
    t46 = *((unsigned int *)t42);
    t47 = (t46 != 0);
    if (t47 == 1)
        goto LAB20;

LAB21:
LAB22:    goto LAB11;

LAB12:    *((unsigned int *)t17) = 1;
    goto LAB15;

LAB16:    *((unsigned int *)t28) = 1;
    goto LAB19;

LAB18:    t35 = (t28 + 4);
    *((unsigned int *)t28) = 1;
    *((unsigned int *)t35) = 1;
    goto LAB19;

LAB20:    t48 = *((unsigned int *)t36);
    t49 = *((unsigned int *)t42);
    *((unsigned int *)t36) = (t48 | t49);
    t50 = (t6 + 4);
    t51 = (t28 + 4);
    t52 = *((unsigned int *)t6);
    t53 = (~(t52));
    t54 = *((unsigned int *)t50);
    t55 = (~(t54));
    t56 = *((unsigned int *)t28);
    t57 = (~(t56));
    t58 = *((unsigned int *)t51);
    t59 = (~(t58));
    t60 = (t53 & t55);
    t61 = (t57 & t59);
    t62 = (~(t60));
    t63 = (~(t61));
    t64 = *((unsigned int *)t42);
    *((unsigned int *)t42) = (t64 & t62);
    t65 = *((unsigned int *)t42);
    *((unsigned int *)t42) = (t65 & t63);
    t66 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t66 & t62);
    t67 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t67 & t63);
    goto LAB22;

LAB23:    xsi_set_current_line(105, ng0);
    *((int *)t74) = xsi_vlog_stime(1000.0000000000000, 1000.0000000000000);
    t75 = (t74 + 4);
    *((int *)t75) = 0;
    t76 = (t0 + 472);
    t77 = *((char **)t76);
    t76 = (t0 + 3368U);
    t78 = *((char **)t76);
    xsi_vlogfile_write(1, 0, 0, ng11, 4, t0, (char)118, t74, 32, (char)119, t77, 32, (char)118, t78, 32);
    goto LAB25;

}


extern void work_m_13840993715240102430_0004118462_init()
{
	static char *pe[] = {(void *)Initial_72_0,(void *)Always_76_1,(void *)Always_81_2,(void *)Always_103_3};
	static char *se[] = {(void *)sp_load_mem,(void *)sp_display_mem};
	xsi_register_didat("work_m_13840993715240102430_0004118462", "isim/tb.sim/work/m_13840993715240102430_0004118462.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
