#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

#include "myapp.h"

int main(int argc, char *argv[]) {
  msg_t msg;
  int iworker_id;
  AXEL_worker_t *worker;
  int AXEL_pid;
  int AXEL_ppid;

  int *a;
  int *b;
  int ofst, size;
  int i;

  int done;

  AXEL_pid = getpid();
  AXEL_ppid = getppid();

#ifdef __DEBUG__
  printf("Child [%s] PID = %d, PPID = %d.\n", argv[0], AXEL_pid, AXEL_ppid);
#endif

  AXEL_init_ipccom(AXEL_ppid);

  worker = (AXEL_worker_t *)(msg.body);

  // prepare the shared memory variable
  // fix me: this should be generated
  // fix me: assuming PID is in [0, 32767], i.e. < 32 bit
  a = AXEL_init_ipcshm(AXEL_ppid<<8|0, 20);
  b = AXEL_init_ipcshm(AXEL_ppid<<8|1, 20);

  done = 0;
  while (!done) {
    // wait for message from I/O worker
    AXEL_recv_ipcmsg(AXEL_pid, &msg);
#ifdef __DEBUG__
    printf("%s: MSG(%lu) from process %lu.\n", argv[0], msg.type, msg.orig);
#endif
    iworker_id = msg.orig;

    switch (msg.type) {

      case AXEL_MSG_DATRDY:
        // mark data segment to be processed
        ofst = worker->ofst;
        size = worker->size;
#ifdef __DEBUG__
        printf("%s: %d MDU starting from %d.\n", argv[0], size, ofst);
#endif

        // process the data
        printf("a in %s = ", argv[0]);
        for (i=ofst; i<ofst+size; i++)
          printf("%2d ", a[i]);
        printf("\n");
        printf("b in %s = ", argv[0]);
        for (i=ofst; i<ofst+size; i++)
          printf("%2d ", b[i]);
        printf("\n");

        for (i=ofst; i<ofst+size; i++)
          a[i] += b[i];

        // acknowledge I/O worker when finished
        msg.dest = iworker_id;
        msg.type = AXEL_MSG_DATRDY;
        AXEL_send_ipcmsg(AXEL_pid, &msg);

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

  AXEL_fini_allshm();

  return 0;
}
