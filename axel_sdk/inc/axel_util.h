/* axel_util.h ---- Brittle 2009 */

/*
 * AXEL System Utilities.
 */

#ifndef __AXEL_UTIL_H__
#define __AXEL_UTIL_H__

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include <expat.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/shm.h>

#include <mpi.h>

#include "axel_common.h"

#include <curl/curl.h>
#include <curl/types.h>
#include <curl/easy.h>

void AXEL_set_progname(char *name);

void AXEL_open_logfile(char *url);
void AXEL_close_logfile(void);
void AXEL_log(char *m, ...);

void AXEL_daemonize(void);
void AXEL_read_xml(char *url, void *data, int file_type);

void AXEL_init_tcpcom(char *AXEL_hn_hostname);
void AXEL_fini_tcpcom(void);
void AXEL_send_tcpmsg(msg_t *msg);
void AXEL_recv_tcpmsg(msg_t *msg);

void AXEL_init_ipccom(int msgkey);
void AXEL_fini_ipccom(void);
void AXEL_send_ipcmsg(int id, msg_t *msg);
void AXEL_recv_ipcmsg(int id, msg_t *msg);
int  AXEL_qnum_ipcmsg(void);

void *AXEL_init_ipcshm(int shmkey, int size);
void AXEL_fini_allshm(void);

int AXEL_pid_dead(pid_t pid);

int AXEL_get_power(int node_id, AXEL_Power *pwdat);

#endif
