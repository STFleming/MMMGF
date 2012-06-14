/*
 * userapp.c
 *
 * User Application for Alpha-Data ADM-XRC-5T2 accelerator.
 *
 * App  : <<<APPLICATION_NAME>>>
 * User : <<<EMAIL>>>
 * Date : <<<DATE>>>
 */

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#include <admxrc2.h>
#include "userapp.h"
#include "fpga_util.h"

#include <time.h>
#include <sys/time.h>

volatile uint32_t* fpgaReg;
volatile uint8_t*  fpgaMem;

int main(int argc, char *argv[])
{
  uint32_t           regval;
  int                i;
  <<<VAR_DEC>>>

  struct timeval tv1, tv2, tv3, tv4;
  long long tv_compu, tv_total;

  gettimeofday(&tv3, NULL);

  // initial hardware
  if (fpga_init()) {
    fpga_cleanup();
    return -1;
  }

  // initial data
  <<<DAT_INI>>>

  // write data to 5T2
  <<<DATA_HOST2FPGA>>>
  gettimeofday(&tv1, NULL);

  // kick start FPGA
  <<<KICK_START>>>

  // wait for FPGA complete
  <<<WAIT_FINISH>>>

  // read data from 5T2
  gettimeofday(&tv2, NULL);
  <<<DATA_FPGA2HOST>>>

  // cleanup
  fpga_finalize();
  fpga_cleanup();

  // finalize data
  <<<DAT_FIN>>>

  gettimeofday(&tv4, NULL);

  tv_compu = (tv2.tv_sec - tv1.tv_sec) * 1000000 + (tv2.tv_usec - tv1.tv_usec);
  tv_total = (tv4.tv_sec - tv3.tv_sec) * 1000000 + (tv4.tv_usec - tv3.tv_usec);
  printf("write time = %lld usec (%lldMbps)\n", tv_write, 0x200000*8/tv_write);
  printf("read time = %lld usec (%lldMbps)\n", tv_read, 0x200000*8/tv_read);
	
  return 0;
}

