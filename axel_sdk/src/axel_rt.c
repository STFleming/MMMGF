/* axel_rt.c ---- Brittle 2009 */

/*
 * AXEL Runtime: Runtime Launcher on each compute node.
 */

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "axel_rt.h"

axel_wgroup_t *group;

int main(int argc, char *argv[]) {

  axel_appmap_t appmap;

  msg_t msg;

  int i, j;

  // process command line arguments
  if (argc < 2) {
#ifdef __DEBUG__
    printf("usage: %s <app_map_file>\n", argv[0]);
#endif
    exit(EXIT_SUCCESS);
  }

  // process application map file
  axel_set_progname("axel_rt");
  axel_read_xml(argv[1], (void *)(&appmap), AXEL_FILE_APPMAP);

  // get self node ID
  if (gethostname(msg.body, AXEL_MSG_BODY_SIZE)) {
    axel_log("Error: cannot get local host name!\n");
    exit(EXIT_SUCCESS);
  }
  msg.dest = atoi(&(msg.body[4])); // hard code to "axelxx"

  // locate myself in the application map
  for (i=0; i<appmap.group_cnt; i++) {
    group = &(appmap.group[i]);
    if (group->id == msg.dest) break;
  }
  if (group->id != msg.dest) {
    axel_log("Cannot find myself in the application map. Terminated!\n");
    exit(EXIT_SUCCESS);
  }
#ifdef __DEBUG__
  printf("group [%d] has %d worker(s): ", group->id, group->worker_cnt);
  for (j=0; j<group->worker_cnt; j++)
    printf("%s ", appmap.module[group->worker[j].mid].path);
  printf("\n");
#endif

  axel_set_pid();
  // launch the worker process
  for (i=0; i<group->worker_cnt; i++) {
    j = fork();
    if (j < 0)             // error
      exit(EXIT_FAILURE); 
    else if (j == 0)       // in child process
      execl(appmap.module[group->worker[i].mid].path,
            appmap.module[group->worker[i].mid].path, NULL);
    else                   // in parent process
      group->worker[i].pid = j;
  }

  // initial IPC MSG channel
  axel_init_ipccom(getpid());

  // sent worker info to the I/O worker
  // fix me: assume worker 0 is the I/O worker
  msg.dest = group->worker[0].pid;
  msg.type = AXEL_MSG_WGINFO;
  memcpy(msg.body, group, sizeof(axel_wgroup_t));
  axel_send_ipcmsg(&msg);

  // wait for child processes finish
  for (i=0; i<group->worker_cnt; i++)
    waitpid(group->worker[i].pid, NULL, 0);
  axel_log("All workers terminated. Done!");

  // remove IPC MSG channel
  axel_fini_ipccom();

  exit(EXIT_SUCCESS);
}
