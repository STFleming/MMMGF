/* axel_hn.h ---- Brittle 2009 */

/*
 * AXEL Head Node: a daemon process to manage all computation and
 * communication resources in in all nodes of the AXEL cluster.
 */

#ifndef __AXEL_HN_H__
#define __AXEL_HN_H__

#include <pwd.h>

#include "axel_common.h"
#include "axel_util.h"

#define AXEL_HN_VERSION "0.1.0"
#define AXEL_HN_MAXCON 999

void axel_hn_help();
void *get_in_addr(struct sockaddr *sa); // get sockaddr, IPv4 or IPv6:
int recv_rm_data(int rm_fd, cn_t cn[]);

#endif
