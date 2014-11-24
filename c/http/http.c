#include <stdlib.h> /* abort, exit */
#include <stdarg.h>
#include <errno.h>
#include <stdio.h> /* printf, sprintf, sscanf, perror, fflush, fputs, fclose */
#include <fcntl.h>
#include <unistd.h> /* getpid, close */
#include <string.h> /* strcpy, bzero */
#include <time.h> /* ctime */
#include <sys/stat.h>
#include <sys/types.h> /* opendir, getpid */
#include <dirent.h> /* DIR dirent opendir */
#include <sys/socket.h> /* inet_addr */
#include <netinet/in.h> /* inet_addr */
#include <arpa/inet.h> /* inet_addr */
#include <resolv.h>
#include <signal.h> /* signal */
#include <getopt.h> /* getopt_long */


#define DEF_IP   "127.0.0.1"
#define DEF_PORT "80"
#define DEF_DIR  "/home"
#define DEF_LOG  "/tmp/http-server.log"

char *host  = "127.0.0.1";
char *port  = "8080";
char *dir   = "/home/study";
int  daemon_stat = 0; /* 0: front-end running  1: back-end running */
FILE *logfile;

void writelog_error(const char *msg, int daemon_stat)
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

void writelog_info(const char *msg, int daemon_stat)
{
    if (daemon_stat == 0)
    {
        fputs(msg, stdout);
    }
    fputs(msg, logfile);
    fflush(logfile);
}

#define PATH_MAX_LENGTH 128
#define MAXBUF        1024

/*
  * DESCRIPTION
  *     return the parent path of the given path. 
  *    
  * EXAMPLE
  *     char *pdir;
  *
  *     pdir = parent_path("/home/test/td");
  *     //now pdir = "/home/test/"
  *
  *     pdir = parent_path("/home/test/td/");
  *     //now pdir = "/home/test/"
*/
char *parent_path(char *path)
{
    int len;
    
    len = strlen(path);
    
    if (len > 1 && path[len - 1] == '/')
        len--;
    
    while (path[len - 1] != '/' && len > 1)
        len--;
    
    return strncpy(malloc(len), path, len);
}



void alloc_memory(char **s, int l, char *d)
{
    *s = malloc(l + 1);
    bzero(*s, l + 1);
    memcpy(*s, d, l);
}


/*



*/
void server_response(FILE *client_sock, char *path)
{
    struct stat info; /* status of the file: *path */
    char filename[PATH_MAX_LENGTH];
    DIR    *getdir;
    char *realpath, *realfilename, *realport;
    
    realpath = malloc(strlen(dir) + strlen(path) + 2);
    sprintf(realpath, "%s/%s", dir, path);
    
    realport = malloc(strlen(port) + 2);
    sprintf(realport, ":%s", port);
    
    printf("realpath=%s\n", realpath);
    printf("realport=%s\n", realport);
    
    /* if can NOT get info of the file */
    if (stat(realpath, &info) != 0 ) 
    {
        fprintf(client_sock,
                "HTTP/1.1 200 OK\r\nServer: Server Henry\r\nConnection: close\r\n\r\n"
                "<html><head><title>%d - %s</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /></head>"
                "<body><font size=+4>Linux Web DIR Server</font><br><hr width=\"100%%\"><br><center>"
                "<table border cols=3 width=\"100%%\">", errno,
                strerror(errno));
        
        fprintf(client_sock,
                "</table><font color=\"CC0000\" size=+2>Please consult your administrator for this error：\n%s %s</font>"
                "</body></html>",
                path, strerror(errno));
        
        free(realpath);
        free(realport);
        
        return;
    } 
    
    
    if (S_ISREG(info.st_mode)) /* if is regular file, download it */
    {
        int  openfd  = open(realpath, O_RDONLY);
        int  filelen = lseek(openfd, 0, SEEK_END);
        char *buf    = malloc(filelen + 1);
        
        if ( read(openfd, buf, filelen) == -1 )
            writelog_error("read file", daemon_stat);
        
        fprintf(client_sock,
                "HTTP/1.1 200 OK\r\nServer: Henry\r\nConnection: keep-alive\r\n"
                "Content-type: application/*\r\nContent-Length:%d\r\n\r\n",
                filelen);
        
        fwrite(buf, filelen, 1, client_sock);
        
        close(openfd);
        free(buf);
    }
    else if (S_ISDIR(info.st_mode)) /* if is dir, browse it */
    {
        getdir = opendir(realpath);
        
        fprintf(client_sock,
                "HTTP/1.1 200 OK\r\nServer: DAS by ZhouLifa\r\nConnection: close\r\n\r\n<html><head><title>%s</title></head>"
                "<body><font size=+4>Linux Web Server</font><br><hr width=\"100%%\"><br><center>"
                "<table border cols=3 width=\"100%%\">", path);
        
        fprintf(client_sock,
                "<caption><font size=+3>DIR %s</font></caption>\n",
                path);
        
        fprintf(client_sock,
                "<tr><td>NAME</td><td>SIZE</td><td>MODIFY TIME</td></tr>\n");
        
        if (getdir == 0)
        {
            fprintf(client_sock,
                    "</table><font color=\"CC0000\" size=+2>%s</font></body></html>",
                    strerror(errno));
            
            return;
        }
        
        struct dirent *dirent;
        
        while ((dirent = readdir(getdir)) != 0)
        {
            if (strcmp(path, "/") == 0)
                sprintf(filename, "/%s", dirent->d_name);
            else
                sprintf(filename, "%s/%s", path, dirent->d_name);
            
            fprintf(client_sock, "<tr>");
            
            realfilename = malloc(strlen(dir) + strlen(filename) + 2);
            sprintf(realfilename, "%s/%s", dir, filename);
            
            
            if (stat(realfilename, &info) == 0) {
                if (strcmp(dirent->d_name, "..") == 0)
                    fprintf(client_sock,
                            "<td><a href=\"http://%s%s%s\">(parent)</a></td>",
                            host, realport, parent_path(path));
                else
                    fprintf(client_sock,
                            "<td><a href=\"http://%s%s%s\">%s</a></td>",
                            host, realport, filename, dirent->d_name);
                
                if (S_ISDIR(info.st_mode))
                    fprintf(client_sock, "<td>DIR</td>");
                    
                else if (S_ISREG(info.st_mode))
                    fprintf(client_sock, "<td>%d</td>", (int)info.st_size);
                    
                else if (S_ISLNK(info.st_mode))
                    fprintf(client_sock, "<td>LINK</td>");
                    
                else if (S_ISCHR(info.st_mode))
                    fprintf(client_sock, "<td>CHR</td>");
                    
                else if (S_ISBLK(info.st_mode))
                    fprintf(client_sock, "<td>BLOCK</td>");
                    
                else if (S_ISFIFO(info.st_mode))
                    fprintf(client_sock, "<td>FIFO</td>");
                    
                else if (S_ISSOCK(info.st_mode))
                    fprintf(client_sock, "<td>Socket</td>");
                    
                else
                    fprintf(client_sock, "<td>(UNKNOWN)</td>");
                    
                fprintf(client_sock, "<td>%s</td>", ctime(&info.st_ctime));
            }
            fprintf(client_sock, "</tr>\n");
            free(realfilename);
        }
        
        fprintf(client_sock, "</table></center></body></html>");
    }
    else /* if it is not a regular file, nor dir, browse forbidden */
    {
        fprintf(client_sock,
                "HTTP/1.1 200 OK\r\nServer: DAS by ZhouLifa\r\nConnection: close\r\n\r\n"
                "<html><head><title>permission denied</title></head>"
                "<body><font size=+4>Linux Web Server</font><br><hr width=\"100%%\"><br><center>"
                "<table border cols=3 width=\"100%%\">");
        fprintf(client_sock,
                "</table><font color=\"CC0000\" size=+2>Source '%s' is forbidden, please consult your admin!</font></body></html>",
                path);
    }
}


/*
 * DESCRIPTION
 *     parse options of command-ling arguments
 * 
 * ITEMS
 *     --host or -h    host IP address
 *     --port or -p    port number
 *     --dir  or -d    root dir of the web server
 *     --daemon_stat        let the program run in back-end
 * 
*/
void parse_options(int argc, char **argv)
{
    int option;
    
    static struct option long_options[] = {
         {"host",   required_argument, NULL, 'h'},
         {"port",   required_argument, NULL, 'p'},
         {"dir",    required_argument, NULL, 'd'},
         {"daemon", no_argument,       NULL, 'm'},
         {0, 0, 0, 0}
    };
    
    const char *short_options = "h:p:b:d:l:";
    
    while( ( option=getopt_long(argc, argv, short_options, long_options, NULL) ) != -1 )
    {
        switch(option)
        {
            case 'h':
                strcpy((host=malloc(strlen(optarg))), optarg);
                break;
                
            case 'p':
                strcpy((port=malloc(strlen(optarg))), optarg);
                break;
                
            case 'd':
                strcpy((dir=malloc(strlen(optarg))), optarg);
                break;
                
            case 'm':
                daemon_stat = 1;
                break;
        }
    }
}


int main(int argc, char **argv)
{
    struct sockaddr_in  server_addr;
    socklen_t           server_addr_len;
    int                 server_socket_fd;
    
    parse_options(argc, argv);
    
    printf("host=%s port=%s dir=%s daemon_stat=%d pid=%d\n",
        host, port, dir, daemon_stat, getpid());
    
    if (daemon_stat == 1)
    {
        if (fork() != 0 )
            exit(0);
        
        close(0);
        close(1);
        close(2);
        
        
    }
    
    if ( (logfile = fopen(DEF_LOG, "a+")) == NULL )
        exit(0);
    /* 处理子进程退出以免产生僵尸进程 */
    signal(SIGCHLD, SIG_IGN);
    
    if ( (server_socket_fd = socket(AF_INET, SOCK_STREAM, 0)) == -1 )
    {
        writelog_error("create socket", daemon_stat);
    }
    
    server_addr_len = 1;
    setsockopt(server_socket_fd, SOL_SOCKET, SO_REUSEADDR, &server_addr_len,
               sizeof(server_addr_len));
    
    server_addr.sin_family      = AF_INET;
    server_addr.sin_port        = htons(atoi(port));
    server_addr.sin_addr.s_addr = inet_addr(host);
    
    server_addr_len             = sizeof(server_addr);
    
    if ( bind(server_socket_fd, (struct sockaddr *) &server_addr, server_addr_len) == -1 )
    {
        writelog_error("binding socket", daemon_stat);
    }
    
    if ( listen(server_socket_fd, 128) == -1 )
    {
        writelog_error("listen",  daemon_stat);
    }
    
    while(1)
    {
        int client_len;
        int client_socket_fd;
        client_len = sizeof(struct sockaddr_in);
        
        /* 接受新连接请求 */
        if ( (client_socket_fd=accept(server_socket_fd, (struct sockaddr *)&server_addr, &server_addr_len)) == -1 )
        {
            writelog_error("new fd", daemon_stat);
            break;
        }
        
        char buffer[256];
        sprintf(buffer, "connection from %s:%d\n",
                inet_ntoa(server_addr.sin_addr), ntohs(server_addr.sin_port));
        
        writelog_info(buffer,  daemon_stat);
        
        /* 产生一个子进程去处理请求，当前进程继续等待新的连接到来 */
        if (fork() == 0)
        {
            char *buf = malloc(1024);
            if (recv(client_socket_fd, buf, 1024, 0) > 0) {
                
                FILE *client_fp;
                
                if ( (client_fp = fdopen(client_socket_fd, "w")) == NULL )
                {
                    writelog_error("new fd",  daemon_stat);
                }
                else
                {
                    char *req = malloc(PATH_MAX_LENGTH);
                    
                    sscanf(buf, "GET %s HTTP", req);
                    sprintf(buf, "request for file: \"%s\"\n", req);
                    writelog_info(buf, daemon_stat);
                    
                    server_response(client_fp, req);
                    
                    fclose(client_fp);
                }
            }
            
            exit(0);
        }
        
        close(client_socket_fd);
    }
    
    close(server_socket_fd);
    return 0;
}



