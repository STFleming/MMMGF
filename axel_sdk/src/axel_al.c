/* axel_cli.c ---- Brittle 2009 */

/*
 * AXEL Command Line Interface: a command line application to accept
 * user command and get cluster status.
 */

#include "axel_cli.h"

int node_cnt = 0;

int main(int argc, char *argv[]) {

  cn_t *cn;
  msg_t msg;

  int i, j;

  char axel_hn_hostname[40] = "";

  // process command line arguments
  for (i=1; i<argc; i++)
    if (strncmp(argv[i], "-help", 5) == 0) {
      axel_cli_help();
      exit(EXIT_SUCCESS);
    }
    else if (strncmp(argv[i], "-host", 5) == 0) {
      if (i < argc-1) {
        i++;
        argv[39] = 0;
        strncpy(axel_hn_hostname, argv[i], 39);
      }
      else {
        printf("axel_cli: Cannot find head node hostname!\n");
        exit(EXIT_SUCCESS);
      }
    }
    else {
      printf("axel_cli: Unknown argument [%s]! Try -help instead.\n", argv[i]);
      axel_cli_help();
      exit(EXIT_SUCCESS);
    }

  if (axel_hn_hostname[0] == 0) {
    printf("axel_rm: Too few arguments!\n");
    exit(EXIT_SUCCESS);
  }

  axel_init_tcpcom(axel_hn_hostname);

  for (i=0; i<5; i++) {
    // request node info
    msg.from = -1;
    msg.type = AXEL_MSG_CNINFO_REQ;
    snprintf(msg.body, 10, "%d", i);
    axel_send_tcpmsg(&msg);

    // receive node info
    axel_recv_tcpmsg(&msg);
    if (msg.type == AXEL_MSG_CNINFO) {
      printf("CN_%d : ", i);
      cn = (cn_t *)msg.body;
      if (cn->status == AXEL_CNST_EMPTY)
        printf("not exist!\n");
      else {
        switch (cn->status) {
          case  AXEL_CNST_READY:  printf("ready\n"); break;
          case  AXEL_CNST_LOCKED: printf("locked\n"); break;
          default: printf("unknown state\n");
        }

        printf("# of PE : %d\n", cn->pe_cnt);
        for (j=0; j<cn->pe_cnt; j++)
          if (cn->pe[j].status != AXEL_PEST_EMPTY) {
            printf("PE_%d : ", j);
            switch (cn->pe[j].status) {
              case  AXEL_CNST_READY:  printf("(RDY) "); break;
              case  AXEL_CNST_LOCKED: printf("(LCK) "); break;
              default: printf("(\?\?\?) ");
            }
            printf("%s\n", cn->pe[j].part);
          }
      }
    }
    else {
      printf("*** Unknown message ****\n");
      break;
    }
  }

  axel_fini_tcpcom();
  exit(EXIT_SUCCESS);
}

void axel_cli_help() {
  printf("Usage: axel_cli [OPTIONS]\n");
  printf("Command line user interface for AXEL Cluster. Version %s\n\n", AXEL_RT_VERSION);
  printf("-host hostname : specify the name of central server\n");
  printf("-help          : print this help\n\n");
}
