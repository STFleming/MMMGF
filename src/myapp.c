/*
 * Application: myapp
 * Author:      K.H. Tsoi
 * Date:        Nov 2009
 * 
*/
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

#include "myapp.h"

volatile uint32_t* fpgaReg;
volatile uint8_t*  fpgaMem;

#define N 9
#define NUM_PARAMETERS 1
#define SIZE 4*N

int main(int argc, char *argv[]) {

  int a[SIZE + 4*NUM_PARAMETERS];
  int b[SIZE];
  int i;
  int config[4*NUM_PARAMETERS]; //The config reg has to be 4 in length to take up a whole entry of the memory bank

//Initialise the config array
for(i = 0; i<4*NUM_PARAMETERS; i++){config[i] = 0;}
config[0] = 100;

//Initialise the upload array
  for (i=0; i<SIZE + 4*NUM_PARAMETERS; i++) {
    a[i] = 0;
  }

//Initialise second upload array
for (i=0;i<SIZE;i++)
	{ b[i] = 0; }

//------------------Create the array to upload-----------------------------
//The array contains the config parameters at the start and then the matrix data
int j =0;
   for (i=0; i<SIZE + 4*NUM_PARAMETERS; i+=4) {
	if(i < 4)
	{	//In this section we load in the configuration parameters
  		a[i] = config[i];
	}
	else
	{	//This section loads in the matrix data
	 	a[i] = j; j++;
	}
}

j=0;
   for (i=0; i < SIZE; i+=4)
	{
		b[i] = j; j++;
	}
//-------------------------------------------------------------------------

  // initial hardware
  if (fpga_init("admxrc5t2.bit", 300)) {
    fpga_cleanup();
    return -1;
  }

  // write data to FPGA
  if (fpga_dmawrite(a, (SIZE + 4*NUM_PARAMETERS)*sizeof(int), BANK0_ADDR)) {   // write a[]
    fpga_cleanup();
    return -1;
  }
  
  if (fpga_dmawrite(b, SIZE*sizeof(int), BANK1_ADDR)) { //write b[]
    fpga_cleanup();
    return -1;
  }

fpgaReg[USER_REG+2] = 0;
fpgaReg[USER_REG+3] = N;
fpgaReg[USER_REG+4] = 0; 
fpgaReg[USER_REG+5] = N-1; 
fpgaReg[USER_REG+6] = 0; 
fpgaReg[USER_REG+7] = N;
fpgaReg[USER_REG+8] = 0;
fpgaReg[USER_REG+9] = 0;

  // kick start FPGA
  fpgaReg[USER_REG] = 0x00C;
sleep_ms(200);
  // wait for FPGA
  while (fpgaReg[USER_REG] &1) {
    printf("status = %08X\n", fpgaReg[USER_REG]);
    sleep_us(2);
  }
  printf("status = %08X\n", fpgaReg[USER_REG]);

  // get data from FPGA
  if (fpga_dmaread(a, (SIZE)*sizeof(int), BANK0_ADDR)) {
    fpga_cleanup();
    return -1;
  }

  if (fpga_dmaread(b, SIZE*sizeof(int), BANK1_ADDR)) {
    fpga_cleanup();
    return -1;
  }

  // cleanup FPGA
  fpga_finalize();
  fpga_cleanup();

  // print out data
  for (i=0; i<SIZE; i++) {
    printf("%u ", a[i]);
    if (i % 16 == 15) printf("\n");
  }
  printf("----------\n");

  for(i=0; i<SIZE; i++) {
    printf("%u ", b[i]);
    if (i % 16 == 15) printf("\n");
  }
  return 0;
}
