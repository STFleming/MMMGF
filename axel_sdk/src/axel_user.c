/* axel_user.c ---- Brittlj 2009 */

#include "axel_user.h"

/* message queue ID */
int msgid;
/* process ID */
int pid;
/* user ID */
int uid;

void axel_user_init_app(void) {
  pid = getuid();
  pid = getpid();
}

void axel_user_init_ipcmsg(void) {
  msgid = msgget(AXEL_IPC_MSGKEY, 0666);
}

int axel_user_resreq(int id) {
  msg_t msg;
  pe_t *pe;

  pe = (pe_t *)msg.body;
  msg.from = 1;
  msg.type = AXEL_MSG_RESREQ;
  pe->id = id;
  pe->pid = pid;
  pe->uid = uid;

  msgsnd(msgid, &msg, AXEL_MSG_BODY_SIZE+8, MSG_NOERROR);

  msgrcv(msgid, &msg, AXEL_MSG_BODY_SIZE+8, pe->pid, MSG_NOERROR);

  if (msg.type == AXEL_MSG_RESGNT)
    return 0;
  else
    return -1;
}

int axel_user_resrel(int id) {
  msg_t msg;
  pe_t *pe;

  pe = (pe_t *)msg.body;
  msg.from = 1;
  msg.type = AXEL_MSG_RESREL;
  pe->id = id;
  pe->pid = pid;
  pe->uid = uid;

  msgsnd(msgid, &msg, AXEL_MSG_BODY_SIZE+8, MSG_NOERROR);

  msgrcv(msgid, &msg, AXEL_MSG_BODY_SIZE+8, pe->pid, MSG_NOERROR);

  if (msg.type == AXEL_MSG_RESGNT)
    return 0;
  else
    return -1;
}
