#include "common.h"

 
#define LOG_ERROR 0
#define LOG_INFO  1
#define LOG_PRINT 2
void writelog(const char *msg, int logtype)
{
    if (daemon_stat == 0)
    {
        perror(msg);
    }
    
    fputs(msg, logfile);
    fputs(strerror(errno), logfile);
    
    fflush(logfile);
    abort();
}


        /* 接受新连接请求 */
        if ( (client_socket_fd=accept(server_socket_fd, (struct sockaddr *)&server_addr, &server_addr_len)) == -1 )
        {
            writelog_error("new fd", daemon_stat);
            break;
        }
        
