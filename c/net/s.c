#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sys/wait.h>
#include <signal.h>

#define MAX_BUF 80

int CONNFD;

void signal_handler(int signo)
{
    switch (signo)
    {
        case SIGINT:
            printf("pid=[%d] get SIGINT, exit. CONNFD=%d\n", getpid(), CONNFD);
            if (close(CONNFD) == -1)
            {
                printf("CONNFD=%d", CONNFD);
                perror("close CONNFD");
            }
            exit(0);
        
        default:
            printf("default, pid=[%d],signo=[%d]\n", getpid(), signo);
            exit(0);
    }
}


int main()
{
    char buf[MAX_BUF];
    char buf2[MAX_BUF];
    bzero(buf, MAX_BUF);
    bzero(buf2, MAX_BUF);
    
    int svrfd, connfd;
    
    struct sockaddr_in svr_addr;
    struct sockaddr_in cli_addr;
    
    socklen_t cli_addr_len;
    
    //cli_addr_len
    cli_addr_len = sizeof(cli_addr);
    
    //svr_addr
    bzero(&svr_addr, sizeof(svr_addr));
    
    svr_addr.sin_family      = AF_INET;
    svr_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    svr_addr.sin_port        = htons(1235);
    
    //svrfd
    svrfd = socket(AF_INET, SOCK_STREAM, 0);
    
    if ( bind(svrfd, (struct sockaddr *) &svr_addr, sizeof(svr_addr)) == -1 )
    {
        perror("bind failure");
        exit(1);
    }
    
    if ( listen(svrfd, 5) == -1 )
    {
        perror("listen failure");
        exit(1);
    }
    
    signal(SIGINT, signal_handler);
    
    printf("waiting for connections...\n");
    
    if ( (connfd = accept(svrfd, (struct sockaddr *)&cli_addr, &cli_addr_len)) == -1 )
    {
        perror("accept failure");
    }
    
    printf("connfd=%d\n", connfd);
    CONNFD = connfd;
    int ret;
    pid_t ppid = getpid();
    
    if(fork() == 0)
    {
        while ((ret=read(connfd, buf, MAX_BUF)) >= 0 )
        {
            if (ret==0)
            {
                printf("client closed!\n");
                close(connfd);
                
                kill(ppid, SIGINT);
                exit(0);
            }
            
            write(1, buf, MAX_BUF);
        }
    
    }
    else
    {
        while( (ret=read(0, buf, MAX_BUF)) >= 0 )
        {
            strcpy(buf2, "SERVER: ");
            strcat(buf2, buf);
            write(1, buf2, MAX_BUF);
            write(connfd, buf2, MAX_BUF);
            
            bzero(buf, MAX_BUF);
            bzero(buf2, MAX_BUF);
        }
    }
    
    close(connfd);
    
    return 0;
}



