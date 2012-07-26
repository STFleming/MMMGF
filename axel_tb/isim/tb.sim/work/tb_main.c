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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_1242562249;
char *IEEE_P_3972351953;
char *WORK_P_2201091880;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_08645547221600682309_2961730482_init();
    unisims_ver_m_06313320939402315622_1593237687_init();
    unisims_ver_m_06312903236042698045_1759035934_init();
    unisims_ver_m_03367362533346577578_2449448540_init();
    unisims_ver_m_01800859709588301718_0844448017_init();
    unisims_ver_m_01800859709588301718_0632917475_init();
    unisims_ver_m_01800859709588301718_1455922738_init();
    unisims_ver_m_01800859709588301718_0104238261_init();
    unisims_ver_m_01800859709588301718_3623847340_init();
    unisims_ver_m_01800859709588301718_1484263714_init();
    unisims_ver_m_01800859709588301718_0231310229_init();
    unisims_ver_m_12401042393677147747_1699806862_init();
    unisims_ver_m_12401042393677147747_0038257065_init();
    unisims_ver_m_12401042393677147747_1755510367_init();
    unisims_ver_m_12401042393677147747_0747620993_init();
    unisims_ver_m_12401042393677147747_0111138847_init();
    unisims_ver_m_12401042393677147747_1714536552_init();
    unisims_ver_m_12401042393677147747_2212573436_init();
    unisims_ver_m_03463500734955659081_1838972761_init();
    unisims_ver_m_03463500734955659081_1567287260_init();
    unisims_ver_m_03463500734955659081_0332431339_init();
    unisims_ver_m_03463500734955659081_2386941132_init();
    unisims_ver_m_03463500734955659081_2389569782_init();
    unisims_ver_m_03463500734955659081_1821691480_init();
    unisims_ver_m_03463500734955659081_2871483747_init();
    unisims_ver_m_03463500734955659081_0113286018_init();
    unisims_ver_m_03463500734955659081_1434184990_init();
    unisims_ver_m_00510582496031726769_0227661056_init();
    unisims_ver_m_01125403920832684742_2467748173_init();
    unisims_ver_m_01125403920832684742_2350899115_init();
    unisims_ver_m_01125403920832684742_2687523668_init();
    unisims_ver_m_01125403920832684742_1098364162_init();
    unisims_ver_m_00008807476459290298_3668270966_init();
    unisims_ver_m_00008807476459290298_2336946039_init();
    unisims_ver_m_00008807476459290298_0374334164_init();
    unisims_ver_m_00008807476459290298_0395151587_init();
    unisims_ver_m_12026317184123736351_2607553651_init();
    unisims_ver_m_13583590171986783474_4240213822_init();
    unisims_ver_m_00084870983251175091_1489144173_init();
    unisims_ver_m_03299173101559445957_4202913249_init();
    unisims_ver_m_10230182487176987991_2301596894_init();
    unisims_ver_m_16269261957556079018_3852734344_init();
    work_m_06012456305642189191_4165820827_init();
    work_m_18003253532646240572_3189189748_init();
    work_m_16260947313290180104_2634652297_init();
    work_m_13840993715240102430_1051778683_init();
    work_m_13840993715240102430_0627692422_init();
    work_m_06184478847865394197_0257821839_init();
    work_m_16838775355190604089_3671711236_init();
    work_m_04775788163700154299_2073120511_init();
    ieee_p_2592010699_init();
    ieee_p_1242562249_init();
    ieee_p_3972351953_init();
    work_p_2201091880_init();
    work_a_4048717907_1516540902_init();


    xsi_register_tops("work_m_16838775355190604089_3671711236");
    xsi_register_tops("work_m_04775788163700154299_2073120511");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    IEEE_P_3972351953 = xsi_get_engine_memory("ieee_p_3972351953");
    WORK_P_2201091880 = xsi_get_engine_memory("work_p_2201091880");

    return xsi_run_simulation(argc, argv);

}
