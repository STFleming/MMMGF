/* axel_rm.c ---- Brittle 2009 */

/*
 * AXEL Resource Manager: a daemon process to manage computation and
 * communication resources in a compute node (CN) of the AXEL cluster.
 *
 * 1. Read local node configuration file into internal map structure.
 * 2. Send updated information of this request to head nodes.
 * 3. Wait for the AXEL Application Launcher to request resource.
 * 4. Process (grant/deny) Launcher request and acknowledge Launcher.
 * 5. Periodically check the statuses of processes in map.
 * 6. Update internal map to reflect the request (PID + resources).
 * 7. Send updated information of this request to head nodes.
 */

#include "axel_rm.h"

int node_cnt = 0;

int main(int argc, char *argv[]) {

  cn_t cn;
  msg_t msg;
  int done = 0;

  int i;
  uid_t uid;
  pid_t pid;

  int mode = 0;
  char axel_hn_hostname[40] = "";

  // process command line arguments
  for (i=1; i<argc; i++)
    if (strncmp(argv[i], "-help", 5) == 0) {
      axel_rm_help();
      exit(EXIT_SUCCESS);
    }
    else if (strncmp(argv[i], "-daemon", 7) == 0) {
      mode = 1;
    }
    else if (strncmp(argv[i], "-host", 5) == 0) {
      if (i < argc-1) {
        i++;
        argv[39] = 0;
        strncpy(axel_hn_hostname, argv[i], 39);
      }
      else {
        printf("axel_rm: Cannot find head node hostname!\n");
        exit(EXIT_SUCCESS);
      }
    }
    else {
      printf("axel_rm: Unknown argument [%s]! Try -help instead.\n", argv[i]);
      exit(EXIT_SUCCESS);
    }

  if (axel_hn_hostname[0] == 0) {
    printf("axel_rm: Too few arguments!\n");
    exit(EXIT_SUCCESS);
  }

  if (mode) axel_daemonize();

  // program initialization
  axel_set_progname(argv[0]);
  axel_open_logfile(AXEL_RM_LOG);
  axel_log("---- logger start ----");

  // read map of local node
  axel_read_map(AXEL_CN_CONF, &cn);
  cn.status = AXEL_CNST_READY;

  axel_init_tcpcom(axel_hn_hostname);

  // ask "Who am I?"
  msg.from = -1;
  msg.type = AXEL_MSG_WHOAMI;
  gethostname(msg.body, AXEL_MSG_BODY_SIZE);
  axel_send_tcpmsg(&msg);
  axel_recv_tcpmsg(&msg);
  cn.id = msg.from;
  axel_log("Got host ID : %d", cn.id);

  // notify head node for available resource
  msg.type = AXEL_MSG_PEINFO;
  for (i=0; i<cn.pe_cnt; i++) {
    memcpy(msg.body, &(cn.pe[i]), sizeof(pe_t));
    axel_send_tcpmsg(&msg);
  }

  // initial IPC communication channel
  axel_init_ipccom();

  while (!done) {
    // check status of process
    for (i=0; i<cn.pe_cnt; i++)
      if ( (cn.pe[i].status == AXEL_PEST_LOCKED) &&
           axel_pid_dead(cn.pe[i].pid) ) {
        axel_log("Process [%d] is dead!", cn.pe[i].pid);
        cn.pe[i].status = AXEL_PEST_READY;
        msg.from = cn.id;
        msg.type = AXEL_MSG_PEINFO;
        memcpy(msg.body, &(cn.pe[i]), sizeof(pe_t));
        axel_send_tcpmsg(&msg);
      }

    // process user message
    while (axel_qnum_ipcmsg()) {
      axel_recv_ipcmsg(&msg); // get the message
      switch (msg.type) {
        case AXEL_MSG_RESREQ: // request fmt [pe uid login]
          i = ((pe_t *)msg.body)->id;
          pid = ((pe_t *)msg.body)->pid;
          uid = ((pe_t *)msg.body)->uid;
          axel_log("PE[%d] L requested by pid=%lu uid=%lu (%s).",
              i, pid, uid, getpwuid(uid)->pw_name );

          msg.from = pid;
          if ((i >= 0) && (i < cn.pe_cnt) && // check PE status
              (cn.pe[i].status == AXEL_PEST_READY) ) {
            cn.pe[i].status = AXEL_PEST_LOCKED;
            cn.pe[i].pid = pid;
            cn.pe[i].uid = uid;
            msg.type = AXEL_MSG_RESGNT; // grant
            axel_log("PE[%d] granted to pid=%lu.", i, pid);
          }
          else {
            msg.type = AXEL_MSG_RESDNY; // deny
            axel_log("PE[%d] denied to pid=%lu.", i, pid);
          }
          axel_send_ipcmsg(&msg); // acknowledge process

          if (msg.type == AXEL_MSG_RESGNT) { // notify head node
            msg.from = cn.id;
            msg.type = AXEL_MSG_PEINFO;
            memcpy(msg.body, &(cn.pe[i]), sizeof(pe_t));
            axel_send_tcpmsg(&msg);
          }
          break;

        case AXEL_MSG_RESREL: // release
          i = ((pe_t *)msg.body)->id;
          pid = ((pe_t *)msg.body)->pid;
          uid = ((pe_t *)msg.body)->uid;
          axel_log("PE[%d] R requested by pid=%lu uid=%lu (%s).",
              i, pid, uid, getpwuid(uid)->pw_name );

          msg.from = pid;
          if ((i >= 0) && (i < cn.pe_cnt) && // check status
              (cn.pe[i].status == AXEL_PEST_LOCKED) &&
              (cn.pe[i].pid == pid) ) {
            cn.pe[i].status = AXEL_PEST_READY;
            msg.type = AXEL_MSG_RESGNT; // grant
            axel_log("PE[%d] released by pid=%lu.", i, pid);
          }
          else {
            msg.type = AXEL_MSG_RESDNY; // deny
            axel_log("PE[%d] denied to pid=%lu.", i, pid);
          }
          axel_send_ipcmsg(&msg); // acknowledge process

          if (msg.type == AXEL_MSG_RESGNT) { // notify head node
            msg.from = cn.id;
            msg.type = AXEL_MSG_PEINFO;
            memcpy(msg.body, &(cn.pe[i]), sizeof(pe_t));
            axel_send_tcpmsg(&msg);
          }
          break;

        case AXEL_MSG_RMEND:
          axel_log("Terminate!");
          done = 1;
          break;

        default:
          axel_log("Unknown command!");
      } // switch
    } // while (!empty)

    sleep(3);

  } // while (!done)

  axel_fini_ipccom();

  msg.from = cn.id;
  msg.type = AXEL_MSG_RMEND;
  axel_send_tcpmsg(&msg);
  axel_fini_tcpcom();

  axel_log("---- logger end ----");
  exit(EXIT_SUCCESS);
}

void axel_rm_help() {
  printf("Usage: axel_rm [OPTIONS]\n");
  printf("Per compute node resource manager for the AXEL Cluster. Version %s\n\n", AXEL_RT_VERSION);
  printf("-host hostname : specify the name of central server\n");
  printf("-help          : print this help\n");
  printf("-daemon        : run in daemon mode\n\n");
}
