/*
 * fpga_util.c
 *
 * Utility functions for Alpha-Data ADM-XRC-5T2 accelerator.
 *
 * App  : myapp
 * User : khtsoi@gmail.com
 * Date : Tue Oct 27 14:30:42 2009
 */

/*
 *  Bank 0 (DDR-II SDRAM): unbuffered, row 13, col 10, bank 3, phys banks 1
 *  Bank 1 (DDR-II SDRAM): unbuffered, row 13, col 10, bank 3, phys banks 1
 *  Bank 2 (DDR-II SDRAM): unbuffered, row 13, col 10, bank 3, phys banks 1
 *  Bank 3 (DDR-II SDRAM): unbuffered, row 13, col 10, bank 3, phys banks 1
 *  Bank 4 (DDR-II SRAM): burst length 4, DLL enabled
 *  Bank 5 (DDR-II SRAM): burst length 4, DLL enabled
 */

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <sys/time.h>

#include <admxrc2.h>
#include "fpga_util.h"

extern volatile uint32_t* fpgaReg;
extern volatile uint8_t*  fpgaMem;

ADMXRC2_HANDLE     card = ADMXRC2_HANDLE_INVALID_VALUE;
uint32_t           dmaModeWord;

int fpga_init(char *bitfilename, float freq) {
  ADMXRC2_STATUS     status;
  ADMXRC2_CARD_INFO  cardInfo;
  ADMXRC2_SPACE_INFO spInfo;
  volatile void*     fpgaSpace;
  uint32_t           regval;
  double             tmpd;

  /* Open accelerator card. */
  status = ADMXRC2_OpenCard(cardID, &card);
  if (status != ADMXRC2_SUCCESS) {
    printf("Failed to open card with ID %ld: %s\n",
     (unsigned long) cardID, ADMXRC2_GetStatusString(status));
    return -1;
  }

  /* Check validity of card */
  status = ADMXRC2_GetCardInfo(card, &cardInfo);
  if (status != ADMXRC2_SUCCESS) {
    printf("Failed to get card info: %s\n", ADMXRC2_GetStatusString(status));
    return -1;
  }
  if (cardInfo.BoardType != ADMXRC2_BOARD_ADMXRC5T2) {
    printf("Cannot find a ADM-XRC-5T2 card.\n");
    return -1;
  }

  /* Get the address of FPGA space */
  status = ADMXRC2_GetSpaceInfo(card, 0, &spInfo);
  if (status != ADMXRC2_SUCCESS) {
    printf("Failed to get space 0 info: %s\n",
	   ADMXRC2_GetStatusString(status));
    return -1;
  }
  fpgaSpace = spInfo.VirtualBase;
  if (fpgaSpace == NULL) {
    printf("Failed to get valid space pointer.\n");
    return -1;
  }
  fpgaReg = (volatile uint32_t *)fpgaSpace;
  fpgaMem = (volatile uint8_t *)fpgaSpace + WINDOW_SIZE;

  /* Set local bus clock to nominal frequency */
  status = ADMXRC2_SetClockRate(card, ADMXRC2_CLOCK_LCLK, LCLK_FREQ*1e6, &tmpd);
  if (status != ADMXRC2_SUCCESS) {
    printf("Failed to set LCLK to %.1fMHz: %s\n",
	   LCLK_FREQ, ADMXRC2_GetStatusString(status));
    return -1;
  }
#ifdef __DEBUG__
  printf("LCLK = %lfMHz\n", tmpd/1000000);
#endif

  /* Set memory clock to nominal frequency */
  status = ADMXRC2_SetClockRate(card, 1, freq*1e6, &tmpd);
  if (status != ADMXRC2_SUCCESS) {
    printf("Failed to set LCLK to %.1fMHz: %s\n",
	   MCLK_FREQ, ADMXRC2_GetStatusString(status));
    return -1;
  }
#ifdef __DEBUG__
  printf("MCLK = %lfMHz\n", tmpd/1000000);
#endif
	
  /* Configure FPGA device using the bit file. */
  status = ADMXRC2_ConfigureFromFile(card, bitfilename);
  if (status != ADMXRC2_SUCCESS) {
    printf ("Failed to load the bitstream '%s': %s\n",
	    bitfilename, ADMXRC2_GetStatusString(status));
    return -1;
  }

  /* Wait until LCLK locked. */
  sleep_ms(500);
  regval = fpgaReg[STATUS_REG];
  if (!(regval & STATUS_REG_LCLKLOCKED)) {
    printf("*** LCLK DCM not locked: status = 0x%08x\n", regval);
    return -1;
  }
#ifdef __DEBUG__
  printf("STATUS_REG = %08X\n", regval);
#endif
  /* Clear old sticky unlock value */
  fpgaReg[STATUS_REG] = STATUS_REG_LCLKSTICKY;
  fpgaReg[STATUS_REG];


  /* Set card in 64-bit mode */
  status = ADMXRC2_SetSpaceConfig(card, 0, 
      ADMXRC2_SPACE_SET_WIDTH | ADMXRC2_SPACE_WIDTH_64);
  if (status != ADMXRC2_SUCCESS) {
    printf ("*** Failed to set space configuration: %s\n",
      ADMXRC2_GetStatusString(status));
    return -1;
  }
  dmaModeWord = ADMXRC2_BuildDMAModeWord(ADMXRC2_BOARD_ADMXRC5T2,
      ADMXRC2_IOWIDTH_64, 0, DMA_MODE);

  /* Set correct mode to memory ports */
  fpgaReg[MODEx_REG(0)] = SDRAM_MODE;
  fpgaReg[MODEx_REG(1)] = SDRAM_MODE;
  fpgaReg[MODEx_REG(2)] = SDRAM_MODE;
  fpgaReg[MODEx_REG(3)] = SDRAM_MODE;
  fpgaReg[MODEx_REG(4)] = SSRAM_MODE;
  fpgaReg[MODEx_REG(5)] = SSRAM_MODE;

  /* Reset Memory subsystem */
  fpgaReg[MEMCTL_REG] = 1;
  fpgaReg[MEMCTL_REG];
  sleep_ms(1);
  fpgaReg[MEMCTL_REG] = 0;
  fpgaReg[MEMCTL_REG];
  sleep_ms(500);

  /* Check MCLK DCM locked and memory ready */
  regval = fpgaReg[STATUS_REG];
  if ((regval & MCLK_MASK) != MCLK_MASK) {
    printf("*** MCLK DCM not locked: status = 0x%08x\n", regval);
    return -1;
  }
#ifdef __DEBUG__
  printf("STATUS_REG = %08X\n", regval);
#endif
  regval = 0xffU << STATUS_REG_SHIFT_STICKY;
  fpgaReg[STATUS_REG] = regval;
  fpgaReg[STATUS_REG];
  regval = fpgaReg[MEMSTAT_REG];
  if ((regval & MEMSTAT_MASK) != MEMSTAT_MASK) {
    printf("*** Memory not ready: status = 0x%08x\n", regval);
    return -1;
  }
#ifdef __DEBUG__
  printf("MEMSTAT_REG = %08X\n", regval);
#endif

  return 0;
}

int fpga_dmawrite(void *buf, unsigned long size, uint32_t addr) {
  ADMXRC2_STATUS     status;
  int bank, page;
  uint32_t local_bus_addr;
  unsigned long available_space;

  while (size > 0) {

    bank =  addr / 0x10000000;
    page = (addr & 0x0fffffff) / 0x200000;
    local_bus_addr = WINDOW_SIZE + (addr & 0x1fffff);
    available_space = 2*WINDOW_SIZE - local_bus_addr;

    fpga_setbank(bank);
    fpga_setpage(page);

    status = ADMXRC2_DoDMAImmediate(card, 
        buf, size<available_space?size:available_space, local_bus_addr,
        ADMXRC2_PCITOLOCAL, ADMXRC2_DMACHAN_ANY, dmaModeWord, 0, NULL, NULL);
    if (status != ADMXRC2_SUCCESS) {
      printf ("Failed to write to FPGA memory bank %d page %d: %s\n",
        bank, page, ADMXRC2_GetStatusString(status));
//        fpgaReg[BANK_REG], fpgaReg[PAGE_REG], ADMXRC2_GetStatusString(status));
      return -1;
    }

    if (size > WINDOW_SIZE)
      size = size - WINDOW_SIZE;
    else
      size = 0;
    addr = addr + WINDOW_SIZE;

  }

  return 0;
}

int fpga_dmaread(void *buf, unsigned long size, uint32_t addr) {
  ADMXRC2_STATUS     status;
  int bank, page;
  uint32_t local_bus_addr;
  unsigned long available_space;

  while (size > 0) {

    bank =  addr / 0x10000000;
    page = (addr & 0x0fffffff) / 0x200000;
    local_bus_addr = WINDOW_SIZE + (addr & 0x1fffff);
    available_space = 2*WINDOW_SIZE - local_bus_addr;

    fpga_setbank(bank);
    fpga_setpage(page);

    status = ADMXRC2_DoDMAImmediate(card, 
        buf, size<available_space?size:available_space, local_bus_addr,
        ADMXRC2_LOCALTOPCI, ADMXRC2_DMACHAN_ANY, dmaModeWord, 0, NULL, NULL);
    if (status != ADMXRC2_SUCCESS) {
      printf ("Failed to read from FPGA memory bank %d page %d: %s\n",
        fpgaReg[BANK_REG], fpgaReg[PAGE_REG], ADMXRC2_GetStatusString(status));
      return -1;
    }

    if (size > WINDOW_SIZE)
      size = size - WINDOW_SIZE;
    else
      size = 0;
    addr = addr + WINDOW_SIZE;
  }

  return 0;
}

int fpga_finalize(void) {
  uint32_t           regval;
  regval = fpgaReg[STATUS_REG];
  if ((regval & MCLK_MASK) != MCLK_MASK) {
    printf("*** MCLK DCM not locked: status = 0x%08x\n", regval);
    return -1;
  }
  regval = fpgaReg[STATUS_REG];
  if (!(regval & STATUS_REG_LCLKLOCKED)) {
    printf("*** LCLK DCM not locked: status = 0x%08x\n", regval);
    return -1;
  }
  return 0;
}

void fpga_cleanup(void) {
  if (card != ADMXRC2_HANDLE_INVALID_VALUE)
    ADMXRC2_CloseCard(card);
}

int sleep_ms(unsigned long ms) {
  struct timeval to;
  fd_set zero;

  FD_ZERO(&zero);
  to.tv_sec = ms / 1000;
  to.tv_usec = (ms % 1000) * 1000;
  return select(0, &zero, &zero, &zero, &to) == 0;
}

int sleep_us(unsigned long us) {
  struct timeval to;
  fd_set zero;

  FD_ZERO(&zero);
  to.tv_sec = us / 1000 / 1000;
  to.tv_usec = us % 1000;
  return select(0, &zero, &zero, &zero, &to) == 0;
}
