#include <stdio.h> /* printf sprintf */
#include <unistd.h> /* close */
#include <stdlib.h> /* malloc free */
#include <string.h> /* memset strcat bzero*/
#include <sys/socket.h> /* bind socket accept */
#include <sys/types.h> /* not required, just for application portable with <sys/socket.h> */
#include <sys/select.h> /* select FD_SET,FD_ZERO,... */
#include <time.h> /* localtime time */
#include <netinet/in.h>          //定义数据结构sockaddr_in

#define MAX_BUF 1024

int main(int argc, char *argv[])
{
    if (argc != 4)
    {
        printf("Usage: $ ./client 192.168.35.100 1234 YourName \n");
        exit(0);
    }
    
    int conn_fd;
    struct sockaddr_in svr_addr;
    
    //svr_addr
    bzero(&svr_addr, sizeof(svr_addr));
    
    svr_addr.sin_family      = AF_INET;
    svr_addr.sin_port        = htons((uint16_t)atoi(argv[2]));
    
    inet_pton(AF_INET, argv[1], &svr_addr.sin_addr);
    
    
    if ((conn_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0 )
    {
        perror("socket");
        exit(1);
    }
    
    if (connect(conn_fd, (struct sockaddr *) &svr_addr, sizeof(svr_addr)) < 0)
    {
        perror("connect");
        exit(1);
    }
    
    //send user name to server
    write(conn_fd, argv[3], 10);
    
    struct timeval tv;
    int            i, result, maxfd;
    char           buf[MAX_BUF];
    fd_set         rset;
    
    bzero(buf, MAX_BUF);
    
    while(1)
    {
        FD_ZERO(&rset);
        FD_SET(0, &rset);
        FD_SET(conn_fd, &rset);
        
        maxfd = conn_fd;
        
        tv.tv_sec  = 1;
        tv.tv_usec = 0;
        
        select(maxfd+1, &rset, NULL, NULL, &tv);
        
        if (FD_ISSET(0, &rset))
        {
            read(0, buf, MAX_BUF);
            send(conn_fd, buf, strlen(buf)-1, 0);
            bzero(buf, MAX_BUF);
        }
        
        if (FD_ISSET(conn_fd, &rset))
        {
            result = read(conn_fd, buf, MAX_BUF);
            
            if(result == 0)
            {
                printf("Server Connection Stopped!\n");
                exit(0);
            }
            
            printf("%s", buf);
            bzero(buf, MAX_BUF);
        }
    }

}







