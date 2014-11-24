#include <stdio.h>
#include <pthread.h>




/* basic configurations */
struct conf_opts{
    char    cgi_root[256];
    char    html_root[256];
    char    log_info[256];
    char    log_err[256];
    int     port;
    int     max_client;
    int     init_thread;
}

struct conf_opts conf{
    "/var/www/cgi/",
    "/var/www/",
    "/tmp/http.loginfo",
    "/tmp/http.logerr",
    8080,
    128,
    4 
}





