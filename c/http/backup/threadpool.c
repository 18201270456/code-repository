#include "common.h"

struct worker_opts{
    pthread_t           id;     /* thread id */
    int                 flags;  /* thread flag */
    pthread_mutex_t     mutex;
    struct worker_ctl   *pool;
};

struct worker_ctl{
    struct worker_opts opts;
    struct worker_conn conn;
};

struct worker_conn{
#define K 1024
    char data_req[16*k]; /* request data */
    char data_res[16*k]; /* response data */
    int  client_sock;
    int  client_timeout;
    struct conn_response con_res;
    struct conn_request  con_req;
    struct worker_ctl    *work;
};

memset


