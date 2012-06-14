/* axel_user.h ---- Brittle 2009 */

/*
 * AXEL API for normal user applications.
 */

#ifndef __AXEL_USER_H__
#define __AXEL_USER_H__

#include <sys/ipc.h>
#include <sys/msg.h>

#include "axel_common.h"

void axel_user_init_app(void);
void axel_user_init_ipcmsg(void);

int axel_user_resreq(int id);
int axel_user_resrel(int id);

#endif
