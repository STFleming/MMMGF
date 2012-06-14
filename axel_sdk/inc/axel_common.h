/* axel_common.h ---- Brittle 2009 */

/*
 * AXEL common structures and constants.
 */

#ifndef __AXEL_COMMON_H__
#define __AXEL_COMMON_H__

#include <stdint.h>

/* Processing Element Type */
#define AXEL_PE_NULL          0
#define AXEL_PE_CPU           1
#define AXEL_PE_GPU           2
#define AXEL_PE_FPGA          3
#define AXEL_PE_DSP           4
#define AXEL_PE_ASIC          5
#define AXEL_PE_USER          6

/* Resource Manager Message Type */
#define AXEL_MSG_DUMMY        0   // dummy

#define AXEL_MSG_WHOAMI       100 // ask head node for id
#define AXEL_MSG_NODEID       101 // assign id to compute node

#define AXEL_MSG_PEINFO_REQ   200 // request info of PE
#define AXEL_MSG_PEINFO       201 // post info of PE
#define AXEL_MSG_CNINFO_REQ   202 // request info of Node
#define AXEL_MSG_CNINFO       203 // post info of Node
#define AXEL_MSG_WGINFO_REQ   204 // request info of worker group
#define AXEL_MSG_WGINFO       205 // post info of worker group
#define AXEL_MSG_WKINFO_REQ   204 // request info of worker
#define AXEL_MSG_WKINFO       205 // post info of worker

#define AXEL_MSG_RESREQ       300 // module request a resource
#define AXEL_MSG_RESGNT       301 // resource resource granted
#define AXEL_MSG_RESDNY       302 // resource resource denied
#define AXEL_MSG_RESREL       303 // module release a resource

#define AXEL_MSG_MODINF       400 // module information
#define AXEL_MSG_MODACT       401 // module active
#define AXEL_MSG_MODEND       402 // module end

#define AXEL_MSG_DATRDY       500 // data/results are ready
#define AXEL_MSG_APPEND       501 // application end

#define AXEL_MSG_RMEND        999

/* PE Status */
#define AXEL_PEST_READY       0    // PE ready
#define AXEL_PEST_LOCKED      1    // PE locked
#define AXEL_PEST_EMPTY       9    // PE not exist

/* Node Status */
#define AXEL_CNST_READY       0    // Node ready
#define AXEL_CNST_LOCKED      1    // Node locked
#define AXEL_CNST_EMPTY       9    // Node not exist

#define AXEL_CN_CONF          "/etc/axel/node.xml"
#define AXEL_MAX_CN           32

#define AXEL_RM_LOG           "/var/log/axel/axel_rm.log"
#define AXEL_HN_LOG           "/var/log/axel/axel_hn.log"
#define AXEL_LOG_MSGLEN       200

/* file type */
#define AXEL_FILE_RESMAP      0
#define AXEL_FILE_APPMAP      1


#ifdef XML_LARGE_SIZE
#if defined(XML_USE_MSC_EXTENSIONS) && _MSC_VER < 1400
#define XML_FMT_INT_MOD "I64"
#else
#define XML_FMT_INT_MOD "ll"
#endif
#else
#define XML_FMT_INT_MOD "l"
#endif
#define AXEL_XML_BUFSIZE      1024

#define AXEL_MAX_NODEPE       10
#define AXEL_HN_TCPPORT       "5999"

#define AXEL_IPC_MSGKEY       9990

#define AXEL_MAX_SHMVAR       256

typedef struct {
  int id;
  int type;
  char part[20];
  int core;
  int freq;
  int status;
  long unsigned pid;
  long unsigned uid;
} pe_t;

typedef struct {
  int id;
  int status;
  int pe_cnt;
  pe_t pe[AXEL_MAX_NODEPE];
} cn_t;

/* ---------- AXEL Message Packet Structure ---------- */
#define AXEL_MSG_SIZE 1024
#define AXEL_MSG_BODY_SIZE 1000
typedef struct {
  uint64_t dest; // destination of the message
  uint64_t orig; // source of the message
  uint64_t type; // message type
  char     body[AXEL_MSG_BODY_SIZE]; // message data
} msg_t;

/* ---------- AXEL Application Map Structure ---------- */
#define AXEL_MAX_NAME_LENGTH 100
#define AXEL_MAX_WORKER_PER_GROUP 5
#define AXEL_MAX_GROUP_PER_APP 16
#define AXEL_MAX_MODULE_PER_APP 16
#define AXEL_MAX_OUTPUT_PER_GROUP 16

// information of a module
typedef struct {
  char path[AXEL_MAX_NAME_LENGTH];  // path to the executable
  int  type;                        // type of the worker (0: I/O,  1: compute)
  int  pe;                          // targeted hardware
} AXEL_module_t;

// information of a worker process
typedef struct {
  int pid;                          // PID of the worker process
  int mid;                          // module ID
  int ofst;                         // offset of the data chunk assigned
  int size;                         // size measure in MDU 
} AXEL_worker_t;

#define AXEL_GROUP_ALL -1
#define AXEL_GROUP_ANY -2
#define AXEL_GROUP_SELF -3
#define AXEL_GROUP_NEXT -4
#define AXEL_GROUP_PREV -5
#define AXEL_GROUP_NULL -99

// information of a group of worker processes
typedef struct {
  int id;         // same as the node id the group residents in
  int ofst;       // offset of the data chunk assigned
  int size;       // size measure in MDU 
  int worker_cnt; // number of workers in the group
  AXEL_worker_t worker[AXEL_MAX_WORKER_PER_GROUP]; // list of the workers
  int output_cnt; // number of output destinations
  int output[AXEL_MAX_OUTPUT_PER_GROUP]; // list of group id for output
} AXEL_wgroup_t;

// mapping of application to the Axel cluster hardware
typedef struct {
  char name[AXEL_MAX_NAME_LENGTH]; // name of the applications
  int  module_cnt; // number of modules in the application
  AXEL_module_t module[AXEL_MAX_MODULE_PER_APP]; // list of modules
  int  group_cnt; // groups (i.e. nodes) spanned in the cluster
  AXEL_wgroup_t group[AXEL_MAX_GROUP_PER_APP]; // list of worker groups
} AXEL_appmap_t;

typedef struct {
  float v, a, p, e, f, t;
} AXEL_Power;

#endif
