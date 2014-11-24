#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sys/wait.h>

#define MAXLINE 80
#define SERV_PORT 1234

void * thread_socket_read(void * fd);
void * thread_socket_write(void * fd);
void stop(int);

int main(int argc, char * argv[])
{
    struct  sockaddr_in server_addr;
    char    buf[MAXLINE], c, d;
    int     sockfd, n, r1, r2;
    char *  str;
    pthread_t thread_getc, thread_putc;
    
    if (argc != 3)
    {
        fputs("usage: ./client ip_addr port\n", stderr);
        exit(1);
    }
    
    char * server_ip = argv[1];
    int server_port = atoi(argv[2]);
    
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    
    bzero(&server_addr, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    inet_pton(AF_INET, server_ip, &server_addr.sin_addr);
    server_addr.sin_port = htons(server_port);
    
    signal(SIGINT, stop);
    if ( connect(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr)) == -1 )
    {
        perror("connection failure");
        exit(1);
    }
    
    if ( pthread_create(&thread_getc, NULL, thread_socket_read, &sockfd) != 0 )
    {
        perror("create read thread failure");
        exit(1);
    }
    
    if ( pthread_create(&thread_putc, NULL, thread_socket_write, &sockfd) != 0 )
    {
        perror("create write thread failure");
        exit(1);
    }
	
    pthread_join(thread_getc, NULL);
    pthread_join(thread_putc, NULL);
     
    close(sockfd);
    return 0;
}

/*
void * thread_socket_read(void * sockfd)
{
    char msg[256];
    
    while(1)
    {
        if (read( *(int *)sockfd, msg, 255) > 0 );
        {
            printf("server: %s\n", msg);
        }
    }
}
 
  
void * thread_socket_write(void * sockfd)
{
    char msg[256];
    
    while( fgets(msg, 256, stdin) != NULL )
    {
        write( *(int *)sockfd, msg, 256);
    }
}

*/
 
void * thread_socket_read(void * sockfd)
{
    char buffer[1024];
    
    while(1)
    {
        if (read( *(int *)sockfd, buffer, 1024) > 0 );
        {
            write(1, buffer, 1024);
        }
    }
    
    pthread_exit(NULL); 
}

 
void * thread_socket_write(void * sockfd)
{
    char buffer[1024];
    
    while( read(0, buffer, 1024) > 0 )
    {
        write( *(int *)sockfd, buffer, 1024);
    }
    
    pthread_exit(NULL); 
}



void stop(int signo)
{
    printf("client set stop.\n");
    
    _exit(0);
}


