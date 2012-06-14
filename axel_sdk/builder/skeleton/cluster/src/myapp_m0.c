/* <<<APPLICATION_NAME>>>_comp0.c 
 * Author : <<<EMAIL>>>
 * Date   : <<<DATE>>>
 */

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <mpi.h>

#include "<<<APPLICATION_NAME>>>.h"

void read_data(int *a, int *b);
void write_data(int *a);

int main(int argc, char *argv[]) {

  AXEL_appmap_t AXEL_appmap;            // map of the distributed application
  AXEL_wgroup_t *AXEL_group;            // pointer to current group

  int AXEL_mpi_rank=0, AXEL_mpi_size=0; // rank, size of the MPI COMM universe
  MPI_Request AXEL_mpi_req[AXEL_MAX_OUTPUT_PER_GROUP];  // MPI request info for async. I/O
  MPI_Status AXEL_mpi_status;           // status for send/recv function
  void *AXEL_mpi_data;                  // temporary data store for MPI

  msg_t AXEL_msg;                       // message for IPC communication

  int AXEL_cnt, AXEL_pid;

  // ---------- Application Specific Data ---------- begin ---------- //
  int *a;
  int *b;

  int iteration;
  int finish_cnt;
  // ---------- Application Specific Data ---------- end ---------- //

  // process command line arguments
  if (argc < 2) {
#ifdef __DEBUG__
    printf("usage: %s <app_map_file>\n", argv[0]);
#endif
    exit(EXIT_SUCCESS);
  }

  // create MPI channel
  MPI_Init(&argc, &argv);

  // get current MPI information
  MPI_Comm_rank(MPI_COMM_WORLD, &AXEL_mpi_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &AXEL_mpi_size);

  // process application map file
  AXEL_set_progname("<<<APPLICATION_NAME>>>");
  AXEL_read_xml(argv[1], (void *)(&AXEL_appmap), AXEL_FILE_APPMAP);

  // locate myself in the application map
  AXEL_group = AXEL_appmap.group;
  for (AXEL_cnt=0; AXEL_cnt<AXEL_appmap.group_cnt; AXEL_cnt++) {
    if (AXEL_group->id == AXEL_mpi_rank) break;
    AXEL_group++;
  }
  if (AXEL_group->id != AXEL_mpi_rank) {
    AXEL_log("Cannot find myself in the application map. Terminated!\n");
    exit(EXIT_SUCCESS);
  }
#ifdef __DEBUG__
  printf("AXEL_group [%d] has %d worker(s): ", AXEL_group->id, AXEL_group->worker_cnt);
  for (AXEL_cnt=0; AXEL_cnt<AXEL_group->worker_cnt; AXEL_cnt++)
    printf("%s ", AXEL_appmap.module[AXEL_group->worker[AXEL_cnt].mid].path);
  printf("and %d output(s): ", AXEL_group->output_cnt);
  for (AXEL_cnt=0; AXEL_cnt<AXEL_group->output_cnt; AXEL_cnt++)
    printf("%d ", AXEL_group->output[AXEL_cnt]);
  printf("\n");
#endif

  // launch the worker process
  // fix me: assume self is 0
  for (AXEL_cnt=1; AXEL_cnt<AXEL_group->worker_cnt; AXEL_cnt++) {
    AXEL_pid = fork();
    if (AXEL_pid < 0)             // error
      exit(EXIT_FAILURE); 
    else if (AXEL_pid == 0) {       // in child process
#ifdef __DEBUG__
      printf("Executable replace with child %s.\n", AXEL_appmap.module[AXEL_group->worker[AXEL_cnt].mid].path);
#endif
      execl(AXEL_appmap.module[AXEL_group->worker[AXEL_cnt].mid].path,
            AXEL_appmap.module[AXEL_group->worker[AXEL_cnt].mid].path, NULL);
      // impossible for execl to return unless error
      MPI_Finalize();
      exit(0);
    }
    else                   // in parent process
      AXEL_group->worker[AXEL_cnt].pid = AXEL_pid;
  }
  AXEL_pid = getpid();

#ifdef __DEBUG__
  printf("I am [%s] with PID = %d (%d/%d).\n", argv[0], AXEL_pid, AXEL_mpi_rank, AXEL_mpi_size);
#endif

  // initial IPC MSG channel
  AXEL_init_ipccom(AXEL_pid);

  // create MPI temporary data storage
  AXEL_mpi_data = malloc(sizeof(int)*20);

  // ---------- Application Specific Operation ---------- begin ---------- //

  // prepare the shared memory variable
  // fix me: this should be generated
  // fix me: assuming PID is in [0, 32767], i.e. < 32 bit
  a = AXEL_init_ipcshm(AXEL_pid<<8|0, 20);
  b = AXEL_init_ipcshm(AXEL_pid<<8|1, 20);

  // read data
  read_data(a, b);
#ifdef __DEBUG__
  printf("%s: read data from file.\n", argv[0]);
#endif

  for (iteration=0; iteration<3; iteration++) {

    // signal works for data ready
    // fix me: assume worker 0 is myself
    AXEL_msg.type = AXEL_MSG_DATRDY;
    for (AXEL_cnt=1; AXEL_cnt<AXEL_group->worker_cnt; AXEL_cnt++) {
      AXEL_msg.dest = AXEL_group->worker[AXEL_cnt].pid;
      memcpy(AXEL_msg.body, &(AXEL_group->worker[AXEL_cnt]), sizeof(AXEL_worker_t));
      AXEL_send_ipcmsg(AXEL_pid, &AXEL_msg);
#ifdef __DEBUG__
      printf("%s: send info to worker %d.\n", argv[0], AXEL_group->worker[AXEL_cnt].pid);
#endif
    }

    // wait all workers for result ready
    finish_cnt = 0;
    while (finish_cnt < AXEL_group->worker_cnt-1) {

      // receive message from compute worker(s)
      AXEL_recv_ipcmsg(AXEL_pid, &AXEL_msg);

      switch (AXEL_msg.type) {

        case AXEL_MSG_DATRDY:
          // fix me: should check for duplicate message
          finish_cnt++;
#ifdef __DEBUG__
          printf("%s: Worker %lu finished (%d/%d).\n", argv[0], AXEL_msg.orig, finish_cnt, AXEL_group->worker_cnt-1);
#endif
          break;

        default:
#ifdef __DEBUG__
          printf("%s: receive unknown message from %lu.\n", argv[0], AXEL_msg.orig);
#endif
          ;
      } // switch of message
    } // while loop waiting for workers
  } // main loop

  if (AXEL_mpi_rank) {
    for (AXEL_cnt=0; AXEL_cnt<AXEL_group->output_cnt; AXEL_cnt++)
      MPI_Isend(a+AXEL_group->ofst, AXEL_group->size, MPI_INTEGER, 
          AXEL_group->output[AXEL_cnt], 0, MPI_COMM_WORLD, 
          AXEL_mpi_req+AXEL_cnt);
    MPI_Waitall(AXEL_group->output_cnt, AXEL_mpi_req, MPI_STATUS_IGNORE);
  }
  else {
    AXEL_cnt = 0;
    while (AXEL_cnt < 20-AXEL_group->size) {
      MPI_Probe(MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, &AXEL_mpi_status);
      MPI_Recv(a+AXEL_appmap.group[AXEL_mpi_status.MPI_SOURCE].ofst, 
          20, MPI_INTEGER, MPI_ANY_SOURCE, 0, 
          MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      AXEL_cnt += AXEL_appmap.group[AXEL_mpi_status.MPI_SOURCE].size;
#ifdef __DEBUG__
      printf("Ready results : %d data (%d new from %d).\n", AXEL_cnt, AXEL_mpi_status._count, AXEL_mpi_status.MPI_SOURCE);
#endif
    }
  }

  if (!AXEL_mpi_rank)
    write_data(a);

  // ---------- Application Specific Operation ---------- end ---------- //

  // free temporary data store
  free(AXEL_mpi_data);

  // free shared memory
  AXEL_fini_allshm();

  // terminate all compute worker(s)
  // fix me: assume worker 0 is myself
  AXEL_msg.type = AXEL_MSG_APPEND;
  for (AXEL_cnt=1; AXEL_cnt<AXEL_group->worker_cnt; AXEL_cnt++) {
    AXEL_msg.dest = AXEL_group->worker[AXEL_cnt].pid;
    AXEL_send_ipcmsg(AXEL_pid, &AXEL_msg);
  }

  // wait for child processes finish
  for (AXEL_cnt=0; AXEL_cnt<AXEL_group->worker_cnt; AXEL_cnt++)
    waitpid(AXEL_group->worker[AXEL_cnt].pid, NULL, 0);
  AXEL_log("All workers terminated. Done!");

  // remove IPC MSG channel
  AXEL_fini_ipccom();

  // remove MPI channel
  MPI_Finalize();

  exit(EXIT_SUCCESS);
}

void read_data(int *a, int *b) {
  FILE *f;
  int i;

  f = fopen("dat/<<<APPLICATION_NAME>>>.dat", "r");
  if (f == NULL) {
    printf("Error: Cannot read data file!\n");
    AXEL_fini_ipccom();
    MPI_Finalize();
  }

  for (i=0; i<20; i++)
    fscanf(f, "%d", a+i);
  for (i=0; i<20; i++)
    fscanf(f, "%d", b+i);

  fclose(f);
}

void write_data(int *a) {
  FILE *f;
  int i;

  f = fopen("dat/<<<APPLICATION_NAME>>>_result.dat", "w");
  if (f == NULL) {
    printf("Error: Cannot read data file!\n");
    AXEL_fini_ipccom();
    MPI_Finalize();
  }

  for (i=0; i<20; i++)
    fprintf(f, "%2d ", a[i]);

  fclose(f);
}
