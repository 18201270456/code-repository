#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>
#include <pthread.h>

typedef struct link_node
{
    pthread_t         tid;
    struct link_node *next;
}lnode;

struct timeval begintime;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
/*
//OR:
pthread_mutex_t mutex;

//in main():
    pthread_mutex_init(&mutex, NULL);
*/

void insert_node(lnode *head, pthread_t tid)
{
    lnode *last_node, *new_node;
    
    new_node = (lnode *)malloc(sizeof(lnode));
    
    new_node->next = NULL;
    new_node->tid  = tid;
    
    
    if(head == NULL)
    {
        head = new_node;
    }
    else
    {
        last_node = head;
        
        while(last_node->next != NULL)
        {
            last_node = last_node->next;
        }
        
        last_node->next = new_node;
    }
}

void free_node(lnode *head)
{
    lnode *node, *temp_node;
    
    for(node = head; node != NULL;)
    {
        temp_node = node;
        node=node->next;
        
        free(temp_node);
    }
}


void print_nodes(lnode *head)
{
    int i = 0;
    lnode *node;
    
    for(node = head; node != NULL; node = node->next)
    {
        printf("i = %d, thread = %x \n", i, node->tid);
        i++;
    }
}

void *browse_nodes(void *arg)
{
    struct timeval endtime;
    
    pthread_t tid   = pthread_self();
    long long count = 0;
    
    while(count < 100000000)
    {
        if(pthread_mutex_trylock(&mutex) == 0)
        {
            lnode *node = (lnode *)arg; 
            
            while(node != NULL)
            {
                if(tid == node->tid)
                {
                    count++;
                }
                
                node = node->next;
            }
            
            pthread_mutex_unlock(&mutex);
        }
    }
    
    gettimeofday(&endtime, NULL);
    
    float elapsetime = 1000000 * (endtime.tv_sec - begintime.tv_sec) + endtime.tv_usec - begintime.tv_usec;
    elapsetime = elapsetime / 1000000;

    printf("tid: %x total used time = %f seconds.\n", tid, elapsetime);

    return NULL;
}

int main()
{
    lnode *node;
    pthread_t tid1, tid2;
    int i;
    
    gettimeofday(&begintime, NULL);
    
    node = (lnode *)malloc(sizeof(lnode));
    node->next = NULL;
    node->tid = -1;

    pthread_create(&tid1, NULL, browse_nodes, node);
    pthread_create(&tid2, NULL, browse_nodes, node);

    pthread_mutex_lock(&mutex);
    for(i = 0; i < 2; i++)
    {
        insert_node(node, tid1);
        insert_node(node, tid2);
    }
    
    insert_node(node, tid1);
    pthread_mutex_unlock(&mutex);


    pthread_mutex_lock(&mutex);
    insert_node(node, tid2);
    pthread_mutex_unlock(&mutex);
    
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);

    pthread_mutex_destroy(&mutex);
    print_nodes(node);
    printf("main thread done\n");

    return 0;

}
