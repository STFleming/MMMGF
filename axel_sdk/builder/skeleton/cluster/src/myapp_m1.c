/* myapp_m1.cu ---- Brittle */
/* GPU version */

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

#include "myapp.h"

#include <cuda_runtime.h>

/*
__global__ void kernel(int *a, int *b) {
  a[threadIdx.x] += b[threadIdx.x];
}
*/
extern void cukernel(int *a, int *b, int size);

int main(int argc, char *argv[]) {
  msg_t AXEL_msg;
  int   AXEL_dest_id;
  int   AXEL_pid;
  int   AXEL_ppid;
  int   AXEL_cnt;

  // ---------- Application Specific Data ---------- begin ---------- //
  int *a;
  int *b;
  int ofst, size;
  int old_size;
  int i;

  int *cuda_a;
  int *cuda_b;

  int done;
  // ---------- Application Specific Data ---------- end ---------- //

  // mark parent and self PID
  AXEL_pid = getpid();
  AXEL_ppid = getppid();
#ifdef __DEBUG__
  printf("Child [%s] PID = %d, PPID = %d.\n", argv[0], AXEL_pid, AXEL_ppid);
#endif

  // initial IPC channel
  AXEL_init_ipccom(AXEL_ppid);

  // prepare the shared memory variable
  // fix me: this should be generated
  // fix me: assuming PID is in [0, 32767], i.e. < 32 bit
  a = (int *)AXEL_init_ipcshm(AXEL_ppid<<8|0, 20);
  b = (int *)AXEL_init_ipcshm(AXEL_ppid<<8|1, 20);

  // ---------- Application Specific Operation ---------- begin ---------- //
  done = 0;
  old_size = -1;
  while (!done) {

    // wait for message from I/O worker
    AXEL_recv_ipcmsg(AXEL_pid, &AXEL_msg);
#ifdef __DEBUG__
    printf("%s: MSG(%lu) from process %lu.\n", argv[0], AXEL_msg.type, AXEL_msg.orig);
#endif
    AXEL_dest_id = AXEL_msg.orig;

    switch (AXEL_msg.type) {

      case AXEL_MSG_DATRDY:
        // mark data segment to be processed
        ofst = ((AXEL_worker_t *)(AXEL_msg.body))->ofst;
        size = ((AXEL_worker_t *)(AXEL_msg.body))->size;
#ifdef __DEBUG__
        printf("%s: %d MDU starting from %d.\n", argv[0], size, ofst);
        printf("a in %s = ", argv[0]);
        for (i=ofst; i<ofst+size; i++)
          printf("%2d ", a[i]);
        printf("\n");
        printf("b in %s = ", argv[0]);
        for (i=ofst; i<ofst+size; i++)
          printf("%2d ", b[i]);
        printf("\n");
#endif

        // allocate GPU memory storage
        if (old_size != size) {
          if (old_size > 0) {
            cudaFree(cuda_a);
            cudaFree(cuda_b);
          }
          cudaMalloc((void **)&cuda_a, sizeof(int)*size);
          cudaMalloc((void **)&cuda_b, sizeof(int)*size);
          old_size = size;
        }

        // copy data from SHM to PE local memory
        cudaMemcpy(cuda_a, a+ofst, sizeof(int)*size, cudaMemcpyHostToDevice);
        cudaMemcpy(cuda_b, b+ofst, sizeof(int)*size, cudaMemcpyHostToDevice);

        // process the data
        /*
        for (i=ofst; i<ofst+size; i++)
          a[i] += b[i];
          */
        cukernel(cuda_a, cuda_b, size);

        printf("before : ");
        for (i=0; i<size; i++) printf("%d ", a[ofst+i]);
        printf("\n");
        // copy data from PE local memory to SHM
        cudaMemcpy(a+ofst, cuda_a, sizeof(int)*size, cudaMemcpyDeviceToHost);
        printf("after : ");
        for (i=0; i<size; i++) printf("%d ", a[ofst+i]);
        printf("\n");

        // acknowledge I/O worker when finished
        AXEL_msg.dest = AXEL_dest_id;
        AXEL_msg.type = AXEL_MSG_DATRDY;
        AXEL_send_ipcmsg(AXEL_pid, &AXEL_msg);

        break;

      case AXEL_MSG_APPEND:
        done = 1;
#ifdef __DEBUG__
        printf("%s: Terminates.\n", argv[0]);
#endif

        break;

      default:
        ;
#ifdef __DEBUG__
        printf("%s: Message ignored.\n", argv[0]);
#endif
    }

  }
  // ---------- Application Specific Operation ---------- end ---------- //

  // release PE space
  cudaFree(cuda_a);
  cudaFree(cuda_b);

  // release SHM space
  AXEL_fini_allshm();

  return 0;
}
