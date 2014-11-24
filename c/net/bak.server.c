#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sys/wait.h>

#define MAXLINE 80

int thread_status = 1;

void * thread_socket_read(void * fd);
void * thread_socket_write(void * fd);
void connection_stop(int);


int main(int argc, char **argv)
{
    if (argc != 2)
    {
        fputs("usage: ./server port_number\n", stderr);
        exit(1);
    }
     
    int listen_port = atoi(argv[1]);
    
    struct sockaddr_in server_addr, client_addr;
    
    socklen_t client_addr_len;
    int listenfd, connfd;
    
    char buf[MAXLINE], c, d;
    
    /* netinet/in.h:#define INET_ADDRSTRLEN 16  */
    char str[INET_ADDRSTRLEN];
    int i, n;
    
    pthread_t thread_getc, thread_putc;
    int r1, r2;
    
    
    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    
    bzero(&server_addr, sizeof(server_addr));
    
    
    server_addr.sin_family = AF_INET;
    
    //<netinet/in.h> #define INADDR_ANY ((in_addr_t) 0x00000000) 
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    
    server_addr.sin_port = htons(listen_port);
    
    
    if ( bind(listenfd, (struct sockaddr *) &server_addr, sizeof(server_addr)) == -1 )
    {
        perror("bind failure");
        exit(1);
    }
    
    if ( listen(listenfd, 5) == -1 )
    {
        perror("listen failure");
        exit(1);
    }
    
    while(1)
    {
        signal(SIGPIPE, connection_stop);
        
        printf("waiting for connections...\n");
        
        client_addr_len = sizeof(client_addr);
        
        if ( (connfd = accept(listenfd, (struct sockaddr *)&client_addr, &client_addr_len)) == -1 )
        {
            perror("accept failure");
            continue;
        }
        
        
        if ( pthread_create(&thread_getc, NULL, thread_socket_read, &connfd) != 0 )
        {
            perror("create thread failure");
            exit(1);
        }
        
        if ( pthread_create(&thread_putc, NULL, thread_socket_write, &connfd) != 0 )
        {
            perror("create thread failure");
            exit(1);
        }
         
        //pthread_join(thread_getc, NULL);
        //pthread_join(thread_putc, NULL);
    }
    
    close(connfd);

    return 0;
}



void * thread_socket_read(void * sockfd)
{
    char buffer[1024];
    
    while(thread_status)
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
    
    while( read(0, buffer, 1024) > 0 && thread_status == 1 )
    {
        write( *(int *)sockfd, buffer, 1024);
    }
    
    pthread_exit(NULL); 
}

   
void connection_stop(int signo)
{
    printf("client connection stopped.\n");
    thread_status = 0;
}


