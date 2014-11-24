#include <stdio.h> /* printf sprintf */
#include <unistd.h> /* close */
#include <stdlib.h> /* malloc free */
#include <string.h> /* memset strcat bzero*/
#include <sys/socket.h> /* bind socket accept */
#include <sys/types.h> /* not required, just for application portable with <sys/socket.h> */
#include <linux/in.h> /* sockaddr_in INADDR_ANY */
#include <sys/wait.h>
#include <signal.h>

#define MAX_BUF 80
#define SERV_PORT 1234

int CONNFD;
void signal_handler(int signo)
{
    switch (signo)
    {
        case SIGINT:
            printf("pid=[%d] get SIGINT, exit.\n", getpid());
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


int main(int argc, char * argv[])
{
    char buf[MAX_BUF];
    char buf2[MAX_BUF];
    bzero(buf, MAX_BUF);
    bzero(buf2, MAX_BUF);
    
    int sockfd;
    
    struct  sockaddr_in svr_addr;
    
    //sockfd
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    
    //svr_addr
    bzero(&svr_addr, sizeof(svr_addr));
    
    svr_addr.sin_family = AF_INET;
    svr_addr.sin_port   = htons(1235);
    
    inet_pton(AF_INET, "127.0.0.1", &svr_addr.sin_addr);
    
    signal(SIGINT, signal_handler);
    
    if ( connect(sockfd, (struct sockaddr *)&svr_addr, sizeof(svr_addr)) == -1 )
    {
        perror("connection failure");
        exit(1);
    }
     
    int ret;
    CONNFD=sockfd;
    
    pid_t ppid = getpid();
    
    if(fork() == 0)
    {
        while ((ret=read(sockfd, buf, MAX_BUF)) >= 0 )
        {
            if (ret==0)
            {
                printf("server closed!\n");
                close(sockfd);
                kill(ppid, SIGINT);
                exit(0);
            }
            
            write(1, buf, MAX_BUF);
        }
    }
    else
    {
        while( read(0, buf, MAX_BUF) >= 0 )
        {
            strcpy(buf2, "CLIENT: ");
            strcat(buf2, buf);
            write(1, buf2, MAX_BUF);
            write(sockfd, buf2, MAX_BUF);
            
            bzero(buf, MAX_BUF);
            bzero(buf2, MAX_BUF);
        }
    }
    
    return 0;
}


