#include <stdio.h> /* printf sprintf */
#include <unistd.h> /* close */
#include <stdlib.h> /* malloc free atoi */
#include <string.h> /* memset strcat bzero*/
#include <sys/socket.h> /* bind socket accept */
#include <sys/types.h> /* not required, just for application portable with <sys/socket.h> */
#include <sys/select.h> /* select FD_SET,FD_ZERO,... */
#include <time.h> /* localtime time */
#include <netinet/in.h>   /* sockaddr_in */
#include <sys/stat.h> /* stat info */
#include <errno.h>  /* errno */
#include <fcntl.h>  /* 0_RDONLY */
#include <dirent.h> /* DIR */
#include <assert.h> /* assert */

#define MAX_CLIENT  2
#define MAX_BUF     1024

#define MAX_THREAD  10

#define MAX(a, b) (a > b) ? a : b
#define SEVR_HOST "127.0.0.1"
#define SEVR_PORT "8081"
#define SEVR_DIR  "/home/henry"

void pool_init(int max_thread_num);
int pool_add_worker(void *(*process) (void *arg), void *arg);
void *thread_routine(void *arg);
int pool_destroy();
void *handle_connection(void *arg);
char *parent_path(char *path);
void server_response(int fd, char *path);



typedef struct worker
{
    void *(*process) (void *arg);
    void *arg;
    struct worker *next;

} thread_worker;

typedef struct
{
    pthread_t *thread_id;
    
    pthread_mutex_t queue_lock;
    pthread_cond_t  queue_ready;
    
    thread_worker  *queue_head;
    
    int shutdown;
    int max_thread_num;
    int cur_queue_size;

} thread_pool;

static thread_pool *pool = NULL;

void pool_init(int max_thread_num)
{
    pool = (thread_pool *) malloc (sizeof (thread_pool));
    
    pthread_mutex_init(&(pool->queue_lock), NULL);
    pthread_cond_init(&(pool->queue_ready), NULL);
    
    pool->queue_head = NULL;
    
    pool->max_thread_num = max_thread_num;
    pool->cur_queue_size = 0;
    
    pool->shutdown = 0;
    
    pool->thread_id =
         (pthread_t *) malloc (max_thread_num * sizeof (pthread_t));
    
    int i = 0;
    for (i = 0; i < max_thread_num; i++)
    {
        pthread_create (&(pool->thread_id[i]), NULL, thread_routine,
                 NULL);
    }
}

int pool_add_worker(void *(*process) (void *arg), void *arg)
{
    thread_worker *new_worker =
        (thread_worker *) malloc(sizeof(thread_worker));
    new_worker->process = process;
    new_worker->arg     = arg;
    new_worker->next    = NULL;
    
    pthread_mutex_lock(&(pool->queue_lock));
    
    thread_worker *member = pool->queue_head;
    if (member != NULL)
    {
        while (member->next != NULL)
        {
            member = member->next;
        }
        
        member->next = new_worker;
    }
    else
    {
        pool->queue_head = new_worker;
    }
    
    assert(pool->queue_head != NULL);
    
    pool->cur_queue_size++;
    
    pthread_mutex_unlock(&(pool->queue_lock));
    pthread_cond_signal(&(pool->queue_ready));
    
    return 0;
}


int pool_destroy()
{
    if (pool->shutdown)
        return -1;
    
    pool->shutdown = 1;
    
    /*唤醒所有等待线程，线程池要销毁了 */
    pthread_cond_broadcast(&(pool->queue_ready));
    
    /*阻塞等待线程退出，否则就成僵尸了 */
    int i;
    for (i = 0; i < pool->max_thread_num; i++)
        pthread_join(pool->thread_id[i], NULL);
    
    free(pool->thread_id);
    
    /*销毁等待队列 */
    thread_worker *head = NULL;
    while (pool->queue_head != NULL)
    {
        head = pool->queue_head;
        pool->queue_head = pool->queue_head->next;
        free(head);
    }
    
    /*条件变量和互斥量也别忘了销毁 */
    pthread_mutex_destroy(&(pool->queue_lock));
    pthread_cond_destroy(&(pool->queue_ready));
    
    free(pool);
    
    /*销毁后指针置空是个好习惯 */
    pool = NULL;
    
    return 0;
}

void *thread_routine(void *arg)
{
    printf("starting thread 0x%x\n", pthread_self());
    
    while (1)
    {
        pthread_mutex_lock(&(pool->queue_lock));
        /*如果等待队列为0并且不销毁线程池，则处于阻塞状态; 注意
           pthread_cond_wait是一个原子操作，等待前会解锁，唤醒后会加锁 */
        while (pool->cur_queue_size == 0 && !pool->shutdown)
        {
            printf("thread 0x%x is waiting\n", pthread_self());
            pthread_cond_wait(&(pool->queue_ready), &(pool->queue_lock));
        }
        
        /*线程池要销毁了 */
        if (pool->shutdown)
        {
            /*遇到break,continue,return等跳转语句，千万不要忘记先解锁 */
            pthread_mutex_unlock(&(pool->queue_lock));
            printf("thread 0x%x will exit\n", pthread_self());
            pthread_exit(NULL);
        }
        
        printf("thread 0x%x is starting to work\n", pthread_self());
        
        /*assert是调试的好帮手 */
        assert(pool->cur_queue_size != 0);
        assert(pool->queue_head != NULL);
        
        /*等待队列长度减去1，并取出链表中的头元素 */
        pool->cur_queue_size--;
        thread_worker *worker = pool->queue_head;
        pool->queue_head = worker->next;
        pthread_mutex_unlock(&(pool->queue_lock));
        
        /*调用回调函数，执行任务 */
        (*(worker->process)) (worker->arg);
        free(worker);
        worker = NULL;
    }
    
    /*这一句应该是不可达的 */
    pthread_exit(NULL);
}


void *handle_connection(void *arg)
{
    printf("threadid is 0x%x, working on task %d\n", pthread_self(),
           *(int *) arg);
    int peerfd = *(int *) arg;
    char *buf = (char *)malloc(MAX_BUF);
    char *req_path = (char *)malloc(MAX_BUF);
    
    bzero(buf, MAX_BUF);
    read(peerfd, buf, MAX_BUF);
    
    sscanf(buf, "GET %s HTTP", req_path);
    printf("request for file: [%s]\n", req_path);
    
    server_response(peerfd, req_path);
    
    return NULL;
}


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

   
    
/*
   * DESCRIPTION
   *     Get file of parameter "fullname", and response HTTP to
   *     file descripter "int fd".
   * 
   * EXAMPLE
   *     server_response(clientfd, "/test/1.html");
   *     server_response(clientfd, "/test/");
*/
void server_response(int fd, char *path)
{
    struct stat info;
    
    char *fullname = (char *)malloc(strlen(SEVR_DIR) + strlen(path) + 2);
    sprintf(fullname, "%s%s", SEVR_DIR, path);
    
    if ( stat(fullname, &info) == -1 ) /* if can NOT get file info, show err msg to client */
    {
        dprintf(fd,
                "HTTP/1.1 200 OK\r\n"
                "Server: Henry's HTTP Server\r\n"
                "Connection: close\r\n"
                "\r\n"
                
                "<html>"
                "<head><title>%d - %s</title>"
                "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />"
                "</head>"
                
                "<body>"
                "<h1>Linux Web DIR Server</h1>"
                "<br /><hr width=\"100%%\"><br />"
                "<h4>Please consult your administrator for this error：\n%s %s<h4>"
                "</body>"
                "</html>",
                errno, strerror(errno), fullname, strerror(errno));
        
    } 
    
    if( S_ISREG(info.st_mode) ) /* if is regular file, download it */
    {
        int  openfd   = open(fullname, O_RDONLY);
        int  filelen  = lseek(openfd, 0, SEEK_END);
        char *buf     = malloc(filelen + 1);
        
        read(openfd, buf, filelen);
        
        dprintf(fd,
                "HTTP/1.1 200 OK\r\n"
                "Server: Henry's HTTP Server\r\n"
                "Connection: keep-alive\r\n"
                "Content-type: application/*\r\n"
                "Content-Length:%d\r\n"
                "\r\n",
                filelen);
        
        write(fd, buf, MAX_BUF);
        
        close(openfd);
    }
    else if( S_ISDIR(info.st_mode) ) /* if is dir, browse it */
    {
        DIR *getdir;
        getdir = opendir(fullname);
        
        dprintf(fd,
                "HTTP/1.1 200 OK\r\n"
                "Server: Henry's HTTP Server\r\n"
                "Connection: close\r\n"
                "\r\n"
                "<html><head><title>%s</title></head>"
                "<body><h2>Linux Web Server<h2><br><hr /><br><center>"
                "<table border cols=3 width=\"100%%\">", fullname);
        
        dprintf(fd,
                "<caption><font size=+3>DIR %s</font></caption>\n",
                fullname);
        
        dprintf(fd,
                "<tr><td>NAME</td><td>SIZE</td><td>MODIFY TIME</td></tr>\n");
        
        if (getdir == 0)
        {
            dprintf(fd,
                    "</table><font color=\"CC0000\" size=+2>%s</font></body></html>",
                    strerror(errno));
            
        }
        
        struct dirent *dirent;
        
        while ((dirent = readdir(getdir)) != 0)
        {
            dprintf(fd, "<tr>");
            
            if (stat(fullname, &info) == 0) {
                if (strcmp(dirent->d_name, "..") == 0)
                    dprintf(fd,
                            "<td><a href=\"http://%s:%s%s\">(parent)</a></td>",
                            SEVR_HOST, SEVR_PORT, parent_path(path));
                else
                    dprintf(fd,
                            "<td><a href=\"http://%s:%s%s\">%s</a></td>",
                            SEVR_HOST, SEVR_PORT, path, dirent->d_name);
                
                if (S_ISDIR(info.st_mode))
                    dprintf(fd, "<td>DIR</td>");
                    
                else if (S_ISREG(info.st_mode))
                    dprintf(fd, "<td>%d</td>", (int)info.st_size);
                    
                else if (S_ISLNK(info.st_mode))
                    dprintf(fd, "<td>LINK</td>");
                    
                else if (S_ISCHR(info.st_mode))
                    dprintf(fd, "<td>CHR</td>");
                    
                else if (S_ISBLK(info.st_mode))
                    dprintf(fd, "<td>BLOCK</td>");
                    
                else if (S_ISFIFO(info.st_mode))
                    dprintf(fd, "<td>FIFO</td>");
                    
                else if (S_ISSOCK(info.st_mode))
                    dprintf(fd, "<td>Socket</td>");
                    
                else
                    dprintf(fd, "<td>(UNKNOWN)</td>");
                    
                dprintf(fd, "<td>%s</td>", ctime(&info.st_ctime));
            }
            dprintf(fd, "</tr>\n");
        }
        dprintf(fd, "</table></center></body></html>");
    }
}




int main(int argc, char *argv[])
{
/*
    if (argc != 2)
    {
        printf("Usage: $ ./server 1234\n");
        exit(0);
    }
*/
    
    int   sevrfd;
    int   peerfd;
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
    sevr_addr.sin_port        = htons((uint16_t)atoi(SEVR_PORT));
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
    
    pool_init(3);               /*线程池中最多三个活动线程 */
    
    socklen_t peer_len;
    peer_len = sizeof(struct sockaddr_in);
    
    while(1)
    {
        /* 接受新连接请求 */
        if ( (peerfd=accept(sevrfd, (struct sockaddr *)&peer_addr, &peer_len)) == -1 )
        {
            perror("accept");
            exit(1);
        }
        
        pool_add_worker(handle_connection, &peerfd);
    }
    
    /*销毁线程池 */
    pool_destroy();
    
    
}
