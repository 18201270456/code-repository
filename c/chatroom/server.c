#include <stdio.h> /* printf sprintf */
#include <unistd.h> /* close */
#include <stdlib.h> /* malloc free atoi */
#include <string.h> /* memset strcat bzero*/
#include <sys/socket.h> /* bind socket accept */
#include <sys/types.h> /* not required, just for application portable with <sys/socket.h> */
#include <sys/select.h> /* select FD_SET,FD_ZERO,... */
#include <time.h> /* localtime time */
#include <netinet/in.h>          //定义数据结构sockaddr_in

#define MAX_CLIENT  2
#define MAX_BUF     1024

#define MAX(a, b) (a > b) ? a : b


/*
DESCRIPTION
    write message "char *buf, int maxbuf" to all file descripters "int *fds"

*/
void forward_msg(int *fds, int maxfd, char *buf, int maxbuf)
{
    int i;
    printf("%s", buf);
    
    for (i=0; i<maxfd; i++)
    {
        if(fds[i] != 0)
        {
            write(fds[i], buf, maxbuf);
        }
    }
}


/*
DESCRIPTION
    return current time formated like "2012-08-08 11:23:5"

*/
char *get_time()
{
    time_t    timep;
    struct tm *curtime;
    char      *temp = (char *)malloc(3);
    char      *gettime;
    
    //memset(gettime, 0, 30);
    
    gettime = (char *)malloc(30);
    bzero(gettime, 30);
    
    time(&timep);
    curtime = localtime(&timep);
    
    sprintf(temp, "%d-", curtime->tm_year + 1900);
    strcat(gettime, temp);
    
    sprintf(temp, "%d-", curtime->tm_mon + 1);
    strcat(gettime, temp);
    
    sprintf(temp, "%d ", curtime->tm_mday);
    strcat(gettime, temp);
    
    sprintf(temp, "%d:", curtime->tm_hour);
    strcat(gettime, temp);
    
    sprintf(temp, "%d:", curtime->tm_min);
    strcat(gettime, temp);
    
    sprintf(temp, "%d", curtime->tm_sec);
    strcat(gettime, temp);
    
    free(temp);
    
    return gettime;
}

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Usage: $ ./server 1234\n");
        exit(0);
    }
 
    int   sevrfd;
    int   peerfd[MAX_CLIENT];
    char *peername[MAX_CLIENT];
    char *peerip[MAX_CLIENT];
    
    struct sockaddr_in sevr_addr;
    struct sockaddr_in peer_addr;
    
    char buf[MAX_BUF];
    char buf2[MAX_BUF];
    bzero(buf, MAX_BUF);
    bzero(buf2, MAX_BUF);
    
    
    //SO_REUSEADDR
    int optval = 1;
    setsockopt(sevrfd, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(optval)); 
    
    //sevr_addr
    bzero(&sevr_addr, sizeof(sevr_addr));
    
    sevr_addr.sin_family      = AF_INET;
    sevr_addr.sin_port        = htons((uint16_t)atoi(argv[1]));
    sevr_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    
    //server socket
    if ( (sevrfd = socket(AF_INET, SOCK_STREAM, 0)) < 0 )
    {
        perror("create sevrfd socket.");
        exit(1);
    }
    
    //bind
    if ( bind(sevrfd, (struct sockaddr *) &sevr_addr, sizeof(sevr_addr)) < 0 )
    {
        perror("bind sevrfd.");
        exit(1);
    }
    
    //listen
    if ( listen(sevrfd, 5) < 0 )
    {
        perror("listen.");
        exit(1);
    }
    
    printf("------ Chat Room Server Started ------\n");
    
    int            i, j, result, maxfd, newfd;
    struct timeval tv;
    fd_set         rset;
    socklen_t      peer_addr_len;
    char           ipstr[30];
    
    
    peer_addr_len = sizeof(peer_addr);
    bzero(&peer_addr, peer_addr_len);
    
    int conn_clients = 0;
    
    for(i=0; i<MAX_CLIENT; i++)
    {
        peerfd[i]   = 0;
        peername[i] = NULL;
        peerip[i]   = NULL;
    }
    
    while(1)
    {
        FD_ZERO(&rset);
        FD_SET(0, &rset);
        FD_SET(sevrfd, &rset);
        
        maxfd = MAX(maxfd, sevrfd);
        
        tv.tv_sec  = 1;
        tv.tv_usec = 0;
        
        for(i=0; i<MAX_CLIENT; i++)
        {
            if (peerfd[i] != 0)
            {
                FD_SET(peerfd[i], &rset);
                maxfd = MAX(maxfd, peerfd[i]);
            }
        }
        
        if ( select(maxfd+1, &rset, NULL, NULL, &tv) < 0 )
        {
            perror("select");
            exit(1);
        }
        
        //peerfd[]
        for(i=0; i<MAX_CLIENT; i++)
        {
            if(peerfd[i] != 0 && FD_ISSET(peerfd[i], &rset))
            {
                result = read(peerfd[i], buf, MAX_BUF);
                
                if (result == 0)
                {
                    FD_CLR(peerfd[i], &rset);
                    close(peerfd[i]);
                    peerfd[i] = 0;
                    
                    sprintf(buf2, "[SERVER]: [%s][%s] LEFT. BYE-BYE. [%s]\n", peerip[i], peername[i], get_time());
                    forward_msg(peerfd, MAX_CLIENT, buf2, MAX_BUF);
                    bzero(buf2, MAX_BUF);
                    bzero(buf, MAX_BUF);
                    
                    conn_clients--;
                }
                else if (result == -1)
                {
                    perror("read");
                    exit(1);
                }
                else
                {
                    sprintf(buf2, "[%s-%s]: %s (%s)\n", peerip[i], peername[i], buf, get_time());
                    forward_msg(peerfd, MAX_CLIENT, buf2, MAX_BUF);
                    bzero(buf2, MAX_BUF);
                    bzero(buf, MAX_BUF);
                }
            }
        }
        
        //sevrfd
        if( FD_ISSET(sevrfd, &rset) )
        {
            if ( (newfd=accept(sevrfd, (struct sockaddr *) &peer_addr, &peer_addr_len)) == -1 )
            {
                perror("accept.");
                continue;
            }
            
            read(newfd, buf, MAX_BUF);
            bzero(ipstr, 30);
            inet_ntop(AF_INET, (void *) &peer_addr.sin_addr, ipstr, 30);
            
            if (conn_clients >= MAX_CLIENT)
            {
                write(newfd, "Too many clients. Please wait then try again...", 60);
                printf("[SERVER]: NEW CLIENT [%s] FROM [%s] COME, BUT WE ARE ALREADY FULL.\n", buf, ipstr);
                close(newfd);
                continue;
            }
            
            
            write(newfd, "[SERVER]: WELCOME TO OUR CHATROOM!\n", 50);
            
            for(i=0; i<MAX_CLIENT; i++)
            {
                if(peerfd[i] == 0)
                {
                    peerfd[i] = newfd;
                    peername[i] = (char *)malloc(MAX_BUF);
                    strcpy(peername[i], buf);
                    
                    peerip[i] = (char *)malloc(16);
                    strcpy(peerip[i], ipstr);
                    
                    bzero(buf, MAX_BUF);
                    
		            sprintf(buf2, "[SERVER]: [%s][%s] JOINED. WELCOME!\n", peerip[i], peername[i]);
                    forward_msg(peerfd, MAX_CLIENT, buf2, MAX_BUF);
                    bzero(buf2, MAX_BUF);
                     
                    conn_clients++;
                    break;
                }
            }
        }
        
        //STDIN
        if (FD_ISSET(0, &rset))
        {
            read(0, buf, MAX_BUF);
            buf[strlen(buf) - 1] = '\0';
            sprintf(buf2, "[SERVER]: %s (%s)\n", buf, get_time());
            forward_msg(peerfd, MAX_CLIENT, buf2, MAX_BUF);
            bzero(buf, MAX_BUF);
            bzero(buf2, MAX_BUF);
        }
    }
    
    return 0;
}

