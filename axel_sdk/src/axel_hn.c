/* axel_hn.c ---- Brittle 2009 */

/*
 * AXEL Head Node: a daemon process to manage all computation and
 * communication resources in in all nodes of the AXEL cluster.
 *
 */

#include "axel_hn.h"

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>

#include <fcntl.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

int node_cnt = 0;
int done = 0;

int main(int argc, char *argv[])
{
  cn_t cn[AXEL_MAX_CN];

  int sockfd;
  int fd_list[AXEL_HN_MAXCON], fd_max, fd_cnt, fd_tmp;
  fd_set read_fds, fds_tmp;
  struct addrinfo hints, *res, *res_ptr;
  int yes=1;

  struct timeval tv;
  struct sockaddr rm_addr; // connector's address information
  socklen_t addrlen;
  char ipstr[INET6_ADDRSTRLEN];

  int i, j;
  int mode = 0;
  int event = 0;


  // process command line arguments
  for (i=1; i<argc; i++)
    if (strncmp(argv[i], "-help", 5) == 0) {
      axel_hn_help();
      exit(EXIT_SUCCESS);
    }
    else if (strncmp(argv[i], "-daemon", 7) == 0) {
      mode = 1;
    }
    else {
      printf("axel_hn: Unknown argument [%s]!\n", argv[i]);
      axel_hn_help();
      exit(EXIT_SUCCESS);
    }

  if (mode) axel_daemonize();

  // program initialization
  axel_set_progname(argv[0]);
  axel_open_logfile(AXEL_HN_LOG);
  axel_log("---- logger start ----");

  for (i=0; i<AXEL_MAX_CN; i++) {
    cn[i].status = AXEL_CNST_EMPTY;
    for (j=0; j<AXEL_MAX_NODEPE; j++)
      cn[i].pe[j].status = AXEL_PEST_EMPTY;
  }

  // prepare address info
  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE; // use my IP

  if (getaddrinfo(NULL, AXEL_HN_TCPPORT, &hints, &res)) {
    axel_log("Error: Cannot get address info!");
    exit(EXIT_FAILURE);
  }

  for(res_ptr = res; res_ptr != NULL; res_ptr = res_ptr->ai_next) {
    // get socket
    sockfd = socket(res_ptr->ai_family, res_ptr->ai_socktype,
        res_ptr->ai_protocol);
    if (sockfd < 0) continue;

    // set reuse address
    if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int)) < 0) {
      close(sockfd);
      continue;
    }

    if (bind(sockfd, res->ai_addr, res->ai_addrlen) < 0) {
      close(sockfd);
      continue;
    }

    break;
  }

  // check socket
  if (res_ptr == NULL) {
    axel_log("Error: Cannot get socket!");
    exit(EXIT_FAILURE);
  }

  freeaddrinfo(res); // all done with this structure

  axel_log("Global communication channel ready.");

  // listen on socket
  if (listen(sockfd, AXEL_HN_MAXCON) < 0) {
    axel_log("Error: Cannot listen main socket!");
    close(sockfd);
    exit(EXIT_FAILURE);
  }

  axel_log("Waiting for global connections...");

  // initial FD list and set
  memset((void *)fd_list, 0, sizeof(int)*AXEL_HN_MAXCON);
  fd_max = sockfd;
  fd_list[0] = sockfd;
  fd_cnt = 1;

  FD_ZERO(&fds_tmp);
  FD_ZERO(&read_fds);
  FD_SET(sockfd, &read_fds);

  while (!done) {

    fds_tmp = read_fds;
    tv.tv_sec = 60; tv.tv_usec = 0;
    event = select(fd_max+1, &fds_tmp, NULL, NULL, &tv);

    if (event < 0) {
      axel_log("Error: Cannot multiplex sockets using select()!");
      exit(EXIT_FAILURE);
    }
    else if (event > 0)
      for (i=0; i<AXEL_HN_MAXCON; i++)
        if ( (fd_list[i] > 0) && // valid FD in list
             FD_ISSET(fd_list[i], &fds_tmp)) { // pending event for this socket 
          if (fd_list[i] == sockfd) { // new connection

            // accept connection
            addrlen = sizeof(rm_addr);
            fd_tmp = accept(sockfd, &rm_addr, &addrlen);

            if (fd_tmp < 0) // check if invalid
              axel_log("Error: Accept connection failed [%s]!",
                  inet_ntop(rm_addr.sa_family, get_in_addr(&rm_addr),
                    ipstr, INET6_ADDRSTRLEN));
            else if (fd_cnt < AXEL_HN_MAXCON) { // enough space for new FD
              // set reuse address
              setsockopt(fd_tmp, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int));

              for (j=0; j<AXEL_HN_MAXCON; j++)
                if (fd_list[j] == 0) {
                  fd_list[j] = fd_tmp; // add to FD list
                  j = AXEL_HN_MAXCON;
                }
              FD_SET(fd_tmp, &read_fds); // add to FD set
              if (fd_max < fd_tmp) fd_max = fd_tmp; // update max. FD
              fd_cnt++; // increase FD count
              axel_log("Accept connection from [%s] as FD_%d.",
                  inet_ntop(rm_addr.sa_family, get_in_addr(&rm_addr),
                    ipstr, INET6_ADDRSTRLEN), fd_tmp);
            }
            else { // FD list is full
              close(fd_tmp);
              axel_log("Error: Connection list is full!");
            }

          }
          else // data from clients
            if (recv_rm_data(fd_list[i], cn) == 0) { // connection closed
              axel_log("Disconnect from FD_%d.", fd_list[i]);
              FD_CLR(fd_list[i], &read_fds); // clear from FD set
              close(fd_list[i]); // close socket
              // remove FD from list
              fd_list[i] = 0;
              fd_cnt--;
              fd_max = -1;
              for (j=0; j<AXEL_HN_MAXCON; j++)
                if (fd_max < fd_list[j]) fd_max = fd_list[j];
            }
        } // finish event
  } // main loop

  for (i=0; i<fd_cnt; i++)
    close(fd_list[i]);

  return 0;
}

void axel_hn_help() {
  printf("Usage: axel_hn [OPTIONS]\n");
  printf("Head node resource manager for the AXEL Cluster. Version %s\n\n", AXEL_HN_VERSION);
  printf("-help          : print this help\n");
  printf("-daemon        : run in daemon mode\n\n");
}

void *get_in_addr(struct sockaddr *sa) {
  if (sa->sa_family == AF_INET) {
    return &(((struct sockaddr_in*)sa)->sin_addr);
  }

  return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

int recv_rm_data(int rm_fd, cn_t cn[]) {
  msg_t msg;
  pe_t *pe;
  int msglen;
  int i;

  msglen = recv(rm_fd, (void *)&msg, AXEL_MSG_SIZE, MSG_WAITALL);
  if (msglen <= 0) return msglen;

  axel_log("CN_%ld [%03ld] %d bytes : ", msg.from, msg.type, msglen);
  switch (msg.type) {

    case AXEL_MSG_WHOAMI:
      axel_log(" > ID for %s?", msg.body);

      // reply client
      msg.type = AXEL_MSG_NODEID;
      msg.from = atoi(msg.body+4);
      send(rm_fd, (void *)&msg, AXEL_MSG_SIZE, 0);

      // initial/reset node
      if (cn[msg.from].status == AXEL_CNST_EMPTY)
        node_cnt++;
      cn[msg.from].id = msg.from;
      cn[msg.from].status = AXEL_CNST_READY;
      cn[msg.from].pe_cnt = 0;
      for (i=0; i<AXEL_MAX_NODEPE; i++)
        cn[msg.from].pe[i].status = AXEL_PEST_EMPTY;

      break;

    case AXEL_MSG_PEINFO:
      pe = (pe_t *)(msg.body);
      axel_log(" > PE_%d @ CN_%ld: %s", pe->id, msg.from, pe->part);
      axel_log(" > type=%d, core=%d, freq=%d, status=%d, pid=%lu, uid=%lu",
          pe->type, pe->core, pe->freq, pe->status, pe->pid, pe->uid);

      // initial/reset pe
      if (cn[msg.from].pe[pe->id].status == AXEL_PEST_EMPTY)
        cn[msg.from].pe_cnt++;
      memcpy(&(cn[msg.from].pe[pe->id]), pe, sizeof(pe_t));

      break;

    case AXEL_MSG_CNINFO_REQ:
      // reply with node info
      msg.from = 0;
      msg.type = AXEL_MSG_CNINFO;
      i = atoi(msg.body);
      if ( (i<0) || (i>=AXEL_MAX_CN) ) i = 0;
      memcpy(msg.body, (void *)&(cn[i]), sizeof(cn_t));
      send(rm_fd, (void *)&msg, AXEL_MSG_SIZE, 0);

      axel_log(" > Send info of CN_%d", i);

      break;

    case AXEL_MSG_RMEND:
      axel_log(" > Terminate!");
      done = 1;
      break;

    default:
      axel_log(" > Unknown message!");
  }

  return msglen;
}
