/* axel_util.c ---- Brittlj 2009 */

#include "axel_util.h"

int node_cnt;

/* name of the current process using these utilities */
char AXEL_progname[20];

/* file storing the message log of current process */
FILE *AXEL_logfile = NULL;

/* socket file descriptor */
int sockfd;
/* message queue ID */
int msgid;
/* share memory variable count */
int shmcnt = 0;
int shmid[AXEL_MAX_SHMVAR];
void *shmpt[AXEL_MAX_SHMVAR];

void AXEL_set_progname(char *name) {
  strncpy(AXEL_progname, name, 9);
}

void AXEL_open_logfile(char *url) {
#ifndef __CONSOLE__
  AXEL_logfile = fopen(url, "a+");
  if (!AXEL_logfile) exit(EXIT_FAILURE);
#endif
}

void AXEL_close_logfile(void) {
#ifndef __CONSOLE__
  fclose(AXEL_logfile);
#endif
}

void AXEL_log(char *m, ...) {
  va_list ap;

  time_t t = time(NULL);
  char *s = ctime(&t);

#ifdef __CONSOLE__
  s[24] = 0;
  printf("%s (%s): ", s, AXEL_progname);
  va_start(ap, m);
  vprintf(m, ap);
  va_end(ap);
  printf("\n");
  fflush(stdout);
#else
  if (AXEL_logfile) {
    /* time (who): message */
    s[24] = 0;
    fprintf(AXEL_logfile, "%s (%s): ", s, AXEL_progname);
    va_start(ap, m);
    vfprintf(AXEL_logfile, m, ap);
    va_end(ap);
    fprintf(AXEL_logfile, "\n");
    fflush(AXEL_logfile);
  }
#endif
}

void AXEL_daemonize(void) {
  /* Our process ID and Session ID */
  pid_t pid, sid;

  /* Fork off the parent process */
  pid = fork();
  if (pid < 0) exit(EXIT_FAILURE);
  /* If we got a good PID, then we can exit the parent process. */
  if (pid > 0) exit(EXIT_SUCCESS);

  /* Change the file mode mask */
  //umask(0);

  /* Create a new SID for the child process */
  sid = setsid();
  if (sid < 0) exit(EXIT_FAILURE);

  /* Change the current working directory */
  if ((chdir("/")) < 0) exit(EXIT_FAILURE);

  /* Close out the standard file descriptors */
  close(STDIN_FILENO);
  close(STDOUT_FILENO);
  close(STDERR_FILENO);
}

int in_node = 0;

// 0: null, 1: application,  2: module  3: group,  4: worker
#define AXEL_XML 0
#define AXEL_XML_APPLICATION 1
#define AXEL_XML_MODULE 2
#define AXEL_XML_GROUP 3
#define AXEL_XML_WORKER 4
#define AXEL_XML_OUTPUT 5

int xml_current = AXEL_XML;

static void XMLCALL
AXEL_resmap_start(void *data, const char *el, const char **attr) {
  cn_t *cn;
  pe_t *pe;

  cn = (cn_t *)data;

  if (strncmp(el, "node", 4) == 0) { // <node>
    if (!in_node) {
      // initialize PE count of current Node
      cn[node_cnt].pe_cnt = 0;
      // set in_node flag
      in_node = 1;
    }
    else
      AXEL_log("Error: Too many <node> tag!");
  }
  else if (strncmp(el, "pe", 2) == 0) { // <pe>
    if (in_node) {
      if (cn[node_cnt].pe_cnt < AXEL_MAX_NODEPE) {
        //for (i = 0; attr[i]; i += 2)
        // printf(" %s='%s'", attr[i], attr[i + 1]);

        pe = &(cn[node_cnt].pe[cn[node_cnt].pe_cnt]);

        // set PE ID
        pe->id = cn[node_cnt].pe_cnt;

        // set PE Type
        switch (attr[1][0]) {
          case 'C' : pe->type = AXEL_PE_CPU; break;
          case 'G' : pe->type = AXEL_PE_GPU; break;
          case 'F' : pe->type = AXEL_PE_FPGA; break;
          default:   pe->type = AXEL_PE_NULL; break;
        }

        // set PE Part
        strncpy(pe->part, attr[3], 20);

        // set PE Core count
        pe->core = atoi(attr[5]);

        // set PE Frequency
        pe->freq = atoi(attr[7]);

        pe->status = AXEL_PEST_READY;
        pe->pid = 0;
        pe->uid = 0;

				AXEL_log("Found local PE [%s] as %s.", attr[3], attr[1]);
      }
      else
        AXEL_log("Error: Too many PE in current Node!");
    }
    else
      AXEL_log("Error: PE declaration outside Node!");
  }
  else {
    AXEL_log("Error: unknown element [%s] in map file!", el);
  }
}

static void XMLCALL
AXEL_resmap_end(void *data, const char *el) {
  cn_t *cn;

  cn = (cn_t *)data;

  if (strncmp(el, "node", 4) == 0) { // </node>
    if (in_node) {
      // set in_node flag
      in_node = 0;
      // increase total Node count
      node_cnt++;
    }
    else
      AXEL_log("Error: Too many </node> tag!");
  }
  else if (strncmp(el, "pe", 2) == 0) // </pe>
    // increase PE count of current Node
    cn[node_cnt].pe_cnt++;
}

static void XMLCALL
AXEL_appmap_start(void *data, const char *el, const char **attr) {
  AXEL_appmap_t *am;
  AXEL_wgroup_t *wg;
  AXEL_worker_t *wk;
  AXEL_module_t *md;

  am = (AXEL_appmap_t *)data;

  // <application>
  if (strncmp(el, "application", 5) == 0) {
    if (xml_current == AXEL_XML) {
      // initialize application map structure
      strncpy(am->name, attr[1], AXEL_MAX_NAME_LENGTH);
      am->group_cnt = 0;
      am->module_cnt = 0;
      xml_current = AXEL_XML_APPLICATION;
      AXEL_log("Processing map file of application [%s].", attr[1]);
    }
    else
      AXEL_log("Error: Misplaced many <%s> tag!", el);
  }

  // fix me: assume all module listed in order
  // <module>
  else if (strncmp(el, "module", 5) == 0) {
    md = &(am->module[am->module_cnt]);
    if (xml_current == AXEL_XML_APPLICATION)
      if (am->module_cnt < AXEL_MAX_MODULE_PER_APP) {
        strncpy(md->path, attr[3], AXEL_MAX_NAME_LENGTH);
        if (attr[5][0] == 'i')
          md->type = 0;
        else
          md->type = 1;
        switch (attr[7][0]) {
          case 'c':
          case 'C': md->pe = AXEL_PE_CPU; break;
          case 'g':
          case 'G': md->pe = AXEL_PE_GPU; break;
          case 'f':
          case 'F': md->pe = AXEL_PE_FPGA; break;
          default:
                    AXEL_log("Error: Unknown PE [%s]!", attr[7]);
        }
        xml_current = AXEL_XML_MODULE;
      }
      else
        AXEL_log("Error: Too many %s!", el);
    else
      AXEL_log("Error: Misplaced <%s> Tag!", el);
  }

  // <group>
  else if (strncmp(el, "group", 5) == 0) {
    if (xml_current == AXEL_XML_APPLICATION)
      if (am->group_cnt < AXEL_MAX_GROUP_PER_APP) {
        wg = &(am->group[am->group_cnt]);
        wg->id = atoi(attr[1]);
        wg->ofst = atoi(attr[3]);
        wg->size = atoi(attr[5]);
        wg->worker_cnt = 0;
        wg->output_cnt = 0;
        xml_current = AXEL_XML_GROUP;
      }
      else
        AXEL_log("Error: Too many %s!", el);
    else
      AXEL_log("Error: Misplaced <%s> Tag!", el);
  }

  // <worker>
  else if (strncmp(el, "worker", 5) == 0) {
    wg = &(am->group[am->group_cnt]);
    if (xml_current == AXEL_XML_GROUP)
      if (wg->worker_cnt < AXEL_MAX_WORKER_PER_GROUP) {
        wk = &(wg->worker[wg->worker_cnt]);
        wk->mid = atoi(attr[1]);
        wk->ofst = atoi(attr[3]);
        wk->size = atoi(attr[5]);
        xml_current = AXEL_XML_WORKER;
      }
      else
        AXEL_log("Error: Too many %s!", el);
    else
      AXEL_log("Error: Misplaced <%s> Tag!", el);
  }

  // <output>
  else if (strncmp(el, "output", 5) == 0) {
    wg = &(am->group[am->group_cnt]);
    if (xml_current == AXEL_XML_GROUP)
      if (wg->output_cnt < AXEL_MAX_OUTPUT_PER_GROUP) {

        if (attr[1][0] >= '0' && attr[1][0] <= '9')
          wg->output[wg->output_cnt] = atoi(attr[1]);
        else switch (attr[1][0]) {
          case 'A': // ALL
            wg->output[wg->output_cnt] = AXEL_GROUP_ALL;
            break;
          case 'S': // SELF
            wg->output[wg->output_cnt] = AXEL_GROUP_SELF;
            break;
          case 'P': // PREV
            wg->output[wg->output_cnt] = AXEL_GROUP_PREV;
            break;
          case 'N': // NEXT
            wg->output[wg->output_cnt] = AXEL_GROUP_NEXT;
            break;
          default:
            wg->output[wg->output_cnt] = AXEL_GROUP_NULL;
            AXEL_log("Error: unknow output type [%s]!", attr[1]);
            break;
        }

        xml_current = AXEL_XML_OUTPUT;
      }
      else
        AXEL_log("Error: Too many %s!", el);
    else
      AXEL_log("Error: Misplaced <%s> Tag!", el);
  }

  // unknown
  else
    AXEL_log("Error: Unknown <%s> tag!", el);

}

static void XMLCALL
AXEL_appmap_end(void *data, const char *el) {
  AXEL_appmap_t *am;

  am = (AXEL_appmap_t *)data;

  // </application>
  if (strncmp(el, "application", 5) == 0) {
    if (xml_current == AXEL_XML_APPLICATION) {
      xml_current = AXEL_XML;
      AXEL_log("%d groups in application %s read!", am->group_cnt, am->name);
    }
    else
      AXEL_log("Error: Misplaced </%s> tag!", el);
  }

  // </module>
  else if (strncmp(el, "module", 5) == 0) {
    if (xml_current == AXEL_XML_MODULE) {
      am->module_cnt++;
      xml_current = AXEL_XML_APPLICATION;
    }
    else
      AXEL_log("Error: Misplaced </%s> tag!", el);
  }

  // </group>
  else if (strncmp(el, "group", 5) == 0) {
    if (xml_current == AXEL_XML_GROUP) {
      am->group_cnt++;
      xml_current = AXEL_XML_APPLICATION;
    }
    else
      AXEL_log("Error: Misplaced </%s> tag!", el);
  }

  // </worker>
  else if (strncmp(el, "worker", 5) == 0) {
    if (xml_current == AXEL_XML_WORKER) {
      am->group[am->group_cnt].worker_cnt++;
      xml_current = AXEL_XML_GROUP;
    }
    else
      AXEL_log("Error: Misplaced </%s> tag!", el);
  }

  // </output>
  else if (strncmp(el, "output", 5) == 0) {
    if (xml_current == AXEL_XML_OUTPUT) {
      am->group[am->group_cnt].output_cnt++;
      xml_current = AXEL_XML_GROUP;
    }
    else
      AXEL_log("Error: Misplaced </%s> tag!", el);
  }

  // unknown
  else
    AXEL_log("Error: Unknown </%s> tag!", el);

}

void AXEL_parse_xml (FILE *f, void *UserData,
    XML_StartElementHandler start, XML_EndElementHandler end) {

  XML_Parser p;
  char Buff[AXEL_XML_BUFSIZE];

  int done;
  int len;

  // create parser object
  p = XML_ParserCreate(NULL);
  if (! p) {
    AXEL_log("Error: Couldn't allocate memory for parser!");
    exit(EXIT_FAILURE);
  }

  // set default handlers
  XML_SetUserData(p, UserData);
  XML_SetElementHandler(p, start, end);

  // parse the file
  do {
    len = (int)fread(Buff, 1, AXEL_XML_BUFSIZE, f);
    if (ferror(f)) {
      AXEL_log("Error: Map file read error!");
      exit(EXIT_FAILURE);
    }
    done = feof(f);

    if (XML_Parse(p, Buff, len, done) == XML_STATUS_ERROR) {
			AXEL_log("Error: Parsing at line %" XML_FMT_INT_MOD "u:%s",
              XML_GetCurrentLineNumber(p),
              XML_ErrorString(XML_GetErrorCode(p)));
      exit(EXIT_FAILURE);
    }
  } while (! done);

  XML_ParserFree(p);
}

void AXEL_read_xml(char *url, void *data, int file_type) {
  FILE *f;

  // open the configuration file
  f = fopen(url, "r");
  if (! f) {
    AXEL_log("Error: Couldn't open [%s] for parser!", url);
    exit(EXIT_FAILURE);
  }

  switch (file_type) {
    case AXEL_FILE_RESMAP:
      AXEL_parse_xml(f, data, AXEL_resmap_start, AXEL_resmap_end);
      break;
    case AXEL_FILE_APPMAP:
      AXEL_parse_xml(f, data, AXEL_appmap_start, AXEL_appmap_end);
      break;
    default:
      AXEL_log("Error: Unknow file type [%s]!", url);
  }

  fclose(f);
  
}

void AXEL_init_tcpcom(char *AXEL_hn_hostname) {

  struct addrinfo hints;
  struct addrinfo *res;
  int yes = 1;

  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_UNSPEC;  // use IPv4 or IPv6, whichever
  hints.ai_socktype = SOCK_STREAM;
  if (getaddrinfo(AXEL_hn_hostname, AXEL_HN_TCPPORT, &hints, &res)) {
    AXEL_log("Error: Cannot get address info!");
    exit(EXIT_FAILURE);
  }

  sockfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
  if (sockfd == -1) {
    AXEL_log("Error: Cannot get socket!");
    exit(EXIT_FAILURE);
  }

  if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int)) == -1) {
    AXEL_log("Error: Cannot set socket options!");
    exit(EXIT_FAILURE);
  }

  if (connect(sockfd, res->ai_addr, res->ai_addrlen) == -1) {
    AXEL_log("Error: Cannot connect to server!");
    exit(EXIT_FAILURE);
  }

  AXEL_log("Global communication channel ready.");

  freeaddrinfo(res);

}

void AXEL_fini_tcpcom(void) {
  close(sockfd);
}

void AXEL_send_tcpmsg(msg_t *msg) {
  ssize_t l=0, tl=0, ll=0;
  char *buf;

  buf = (char *)msg;
  ll = AXEL_MSG_SIZE;
  while (tl != AXEL_MSG_SIZE) {
    l = send(sockfd, (void *)(buf+tl), ll, 0);
    if (l < 0) {
      AXEL_log("Error: Cannot send to server!");
      break;
    }
    tl += l;
    ll -= l;
  }

}

void AXEL_recv_tcpmsg(msg_t *msg) {
  recv(sockfd, (void *)msg, AXEL_MSG_SIZE, MSG_WAITALL);
}

void AXEL_init_ipccom(int msgkey) {
  msgid = msgget(msgkey, IPC_CREAT | 0666);
  int mpi_ini = 0;
  if (msgid < 0) {
    AXEL_log("Error: Cannot setup local communication!");
    MPI_Initialized(&mpi_ini);
    if (mpi_ini) MPI_Finalize();
    exit(EXIT_FAILURE);
  }
  else
    AXEL_log("Local communication channel ready.");
}

void AXEL_fini_ipccom(void) {
  msgctl(msgid, IPC_RMID, NULL);
}

void AXEL_send_ipcmsg(int id, msg_t *msg) {
  msg->orig = id;
  msgsnd(msgid, msg, AXEL_MSG_BODY_SIZE+16, MSG_NOERROR);
}

void AXEL_recv_ipcmsg(int id, msg_t *msg) {
  int retval;
  retval = msgrcv(msgid, msg, AXEL_MSG_BODY_SIZE+16, id, MSG_NOERROR);
  if (retval < 0)
    msg->type = AXEL_MSG_DUMMY;
}

int AXEL_qnum_ipcmsg(void) {
  struct msqid_ds buf;
  msgctl(msgid, IPC_STAT, &buf);
  return buf.msg_qnum;
}

int AXEL_pid_dead(pid_t pid) {
  char s[40];

  snprintf(s, 40, "/proc/%d", pid);
  return access(s, F_OK);
}

void *AXEL_init_ipcshm(int shmkey, int size) {
  void *tmp;
  int mpi_ini = 0;

  if ((shmid[shmcnt] = shmget(shmkey, size, IPC_CREAT| 0666)) < 0) {
    AXEL_log("Error: Cannot create shared variable key = %d!", shmkey);
    AXEL_fini_allshm();
    MPI_Initialized(&mpi_ini);
    if (mpi_ini) MPI_Finalize();
    MPI_Initialized(&mpi_ini);
    if (mpi_ini) MPI_Finalize();
    exit(EXIT_FAILURE);
  }
  if ( (tmp = shmat(shmid[shmcnt], NULL, 0)) < 0) {
    AXEL_log("Error: Cannot attach shared variable!");
    shmctl(shmid[shmcnt], IPC_RMID, NULL);
    AXEL_fini_allshm();
    MPI_Initialized(&mpi_ini);
    if (mpi_ini) MPI_Finalize();
    exit(EXIT_FAILURE);
  }
  shmpt[shmcnt] = tmp;
  shmcnt++;

  return tmp;
}

void AXEL_fini_allshm(void) {
  int i;
  for (i=0; i<shmcnt; i++) {
    shmdt(shmpt[i]);
    shmctl(shmid[i], IPC_RMID, NULL);
  }
  shmcnt = 0;
}

typedef struct {
  int size;
  char data[512];
} PowerXML;

static size_t
WriteMemoryCallback(void *ptr, size_t size, size_t nmemb, void *data)
{
  size_t realsize = size * nmemb;
  PowerXML *mem = (PowerXML *)data;
 
  if (mem->size+realsize < 512) {
    memcpy(&(mem->data[mem->size]), ptr, realsize);
    mem->size += realsize;
    mem->data[mem->size] = 0;
  }
  return realsize;
}

static void XMLCALL
AXEL_power_start(void *data, const char *el, const char **attr) {
  AXEL_Power *pwdat = (AXEL_Power *)data;

  if (strncmp(el, "field", 5) == 0) { // <field ..>
    pwdat->v = atof(attr[1]);
    pwdat->a = atof(attr[3]);
    pwdat->p = atof(attr[5]);
    pwdat->e = atof(attr[7]);
    pwdat->f = atof(attr[9]);
    pwdat->t = atof(attr[11]);
  }
}

static void XMLCALL
AXEL_power_end(void *data, const char *el) {
  return;
}

int AXEL_get_power(int node_id, AXEL_Power *pwdat) {
  CURL *curl;
  CURLcode res;
  char url[64];

  PowerXML xmlfile;
  XML_Parser p;

  xmlfile.size = 0;
  snprintf(url, 64, "http://parakeet:1200%d/data.xml", node_id);
      
  curl = curl_easy_init();
  if(curl) {
    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 1L);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&xmlfile);
    res = curl_easy_perform(curl);
    curl_easy_cleanup(curl);

    if (res != CURLE_OK)
      AXEL_log("Error: Cannot attach shared variable!");
    else {
      pwdat->v = pwdat->a = pwdat->p = pwdat->e = pwdat->f = pwdat->t = 0;
      // create parser object
      p = XML_ParserCreate(NULL);
      if (! p) {
        AXEL_log("Error: Couldn't allocate memory for parser!");
        exit(EXIT_FAILURE);
      }

      // set default handlers
      XML_SetUserData(p, pwdat);
      XML_SetElementHandler(p, AXEL_power_start, AXEL_power_end);
      if (XML_Parse(p, xmlfile.data, xmlfile.size, 1) == XML_STATUS_ERROR) {
          AXEL_log("Error: Parsing at line %" XML_FMT_INT_MOD "u:%s",
                  XML_GetCurrentLineNumber(p),
                  XML_ErrorString(XML_GetErrorCode(p)));
      }
      XML_ParserFree(p);
    }
  }
  return 0;

}
