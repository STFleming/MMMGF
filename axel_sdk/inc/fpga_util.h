/*
 * fpga_util.h
 *
 * Utility functions for Alpha-Data ADM-XRC-5T2 accelerator.
 *
 * App  : myapp
 * User : khtsoi@gmail.com
 * Date : Tue Oct 27 14:30:42 2009
 */

#ifndef __FPGA_UTIL_H__
#define __FPGA_UTIL_H__

#define BANK_REG                        (0x0)      /* Bank select register */
#define BANK_REG_BANKMASK               (0xfU << 0)

#define PAGE_REG                        (0x1)      /* Page register */
#define PAGE_REG_PAGEMASK               (0x7ffU << 0)

#define MEMCTL_REG                      (0x2)      /* Memory control register */
#define MEMCTL_REG_MEMRST               (0x1U << 0)

#define STATUS_REG                      (0x4)      /* Status register */
#define STATUS_REG_LCLKLOCKED           (0x1U << 0)
#define STATUS_REG_LCLKSTICKY           (0x1U << 1)
#define STATUS_REG_SHIFT_LOCKED         (8)
#define STATUS_REG_SHIFT_STICKY         (16)

#define MEMSTAT_REG                     (0x6)      /* Memory status register */
#define MEMSTAT_REG_SHIFT_TRAINED       (0)

#define MODEx_REG(n)                    (0x10 + (n))/* Bank 'n' mode register */
#define MODEx_REG_DDR2SSRAM_BLMASK      (0x3U << 0)/* DDR2 SSRAM burst length mask */
#define MODEx_REG_DDR2SSRAM_BL2         (0x0U << 0)/* DDR2 SSRAM burst length 2 */
#define MODEx_REG_DDR2SSRAM_BL4         (0x1U << 0)/* DDR2 SSRAM burst length 4 */
#define MODEx_REG_DDR2SSRAM_DLLON       (0x0U << 2)/* DDR2 SSRAM DLL enable */
#define MODEx_REG_DDR2SSRAM_DLLOFF      (0x1U << 2)/* DDR2 SSRAM DLL disable */

#define MODEx_REG_ZBTSSRAM_FLOWTHRU     (0x0U << 0)/* ZBT SSRAM pipelined mode disable */
#define MODEx_REG_ZBTSSRAM_PIPELINE     (0x1U << 0)/* ZBT SSRAM pipelined mode enable */

#define MODEx_REG_DDRSDRAM_UNBUFFERED   (0x0U << 0)
#define MODEx_REG_DDRSDRAM_REGISTERED   (0x1U << 0)
#define MODEx_REG_DDRSDRAM_X8X16        (0x0U << 1)
#define MODEx_REG_DDRSDRAM_X4           (0x1U << 1)
#define MODEx_REG_DDRSDRAM_ROWBITS_12   (0x0U << 2)
#define MODEx_REG_DDRSDRAM_ROWBITS_13   (0x1U << 2)
#define MODEx_REG_DDRSDRAM_ROWBITS_14   (0x2U << 2)
#define MODEx_REG_DDRSDRAM_ROWBITS_15   (0x3U << 2)
#define MODEx_REG_DDRSDRAM_COLBITS_M4   (0x0U << 4)/* col bits = row bits - 4 */
#define MODEx_REG_DDRSDRAM_COLBITS_M3   (0x1U << 4)/* col bits = row bits - 3 */
#define MODEx_REG_DDRSDRAM_COLBITS_M2   (0x2U << 4)/* col bits = row bits - 2 */
#define MODEx_REG_DDRSDRAM_COLBITS_M1   (0x3U << 4)/* col bits = row bits - 1 */
#define MODEx_REG_DDRSDRAM_BANKBITS_0   (0x0U << 6)
#define MODEx_REG_DDRSDRAM_BANKBITS_1   (0x1U << 6)
#define MODEx_REG_DDRSDRAM_BANKBITS_2   (0x2U << 6)
#define MODEx_REG_DDRSDRAM_BANKBITS_3   (0x3U << 6)
#define MODEx_REG_DDRSDRAM_PHYSBANKS_1  (0x0U << 8)
#define MODEx_REG_DDRSDRAM_PHYSBANKS_2  (0x1U << 8)
#define MODEx_REG_DDRSDRAM_PHYSBANKS_4  (0x2U << 8)
#define MODEx_REG_DDRSDRAM_PHYSBANKS_8  (0x3U << 8)

#define SPD_REG                         (0x5)
#define SPD_REG_DO                      (0x1U << 31)
#define SPD_REG_BUSY                    (0x1U << 31)
#define SPD_REG_SHIFT_ADDR              (0)
#define SPD_REG_SHIFT_WRDATA            (8)
#define SPD_REG_SHIFT_RDDATA            (16)
#define SPD_REG_ERR                     (0x1U << 24)
#define SPD_REG_SHIFT_SLOT              (25)

#define ERRATA_REG                      (0x8)      /* Errata register */
#define ERRATA_REG_220MHZREFCLK         (0x1U << 0)

#define USER_REG                        (0x40)

#define cardID       0
#define LCLK_FREQ    80.0 // 66.67
#define MCLK_FREQ    333.33
#define WINDOW_SIZE  0x200000 // 2MB
#define MCLK_MASK    0x0300
#define MEMSTAT_MASK 0x03f

#define SDRAM_MODE MODEx_REG_DDRSDRAM_UNBUFFERED | \
                   MODEx_REG_DDRSDRAM_ROWBITS_13 | \
                   MODEx_REG_DDRSDRAM_COLBITS_M3 | \
                   MODEx_REG_DDRSDRAM_BANKBITS_3 | \
                   MODEx_REG_DDRSDRAM_PHYSBANKS_1

#define SSRAM_MODE MODEx_REG_DDR2SSRAM_BL4 | \
                   MODEx_REG_DDR2SSRAM_DLLON

#define DMA_MODE   ADMXRC2_DMAMODE_USEREADY | \
                   ADMXRC2_DMAMODE_USEBTERM | \
                   ADMXRC2_DMAMODE_BURSTENABLE

#define fpga_setbank(bankIdx) fpgaReg[BANK_REG] = bankIdx; fpgaReg[BANK_REG]
#define fpga_setpage(pageIdx) fpgaReg[PAGE_REG] = pageIdx; fpgaReg[PAGE_REG]

#define BANK0_ADDR 0
#define BANK1_ADDR 0x10000000
#define BANK2_ADDR 0x20000000
#define BANK3_ADDR 0x30000000
#define BANK4_ADDR 0x40000000
#define BANK5_ADDR 0x40400000

int  fpga_init(char *bitfilename, float freq);
int  fpga_dmawrite(void *buf, unsigned long size, uint32_t addr);
int  fpga_dmaread(void *buf, unsigned long size, uint32_t addr);
int  fpga_finalize(void);
void fpga_cleanup(void);

int  sleep_ms(unsigned long ms);
int  sleep_us(unsigned long us);

#endif
