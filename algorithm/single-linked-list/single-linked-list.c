/*
* FILE NAME
*    single-slisted-list.c
*
* DESCRIPTION
*     Demonstrates the basic opreations of Single-Linked-List.
*
* AUTHOR
*     W.HW (2012-08-29)
*
*/
#include <stdio.h>
#include <stdlib.h>

typedef struct node {
    char        *item;
    struct node *next;
} *slist;


slist initialize();
void  insert(slist, int, char *);
void  push(slist, char *);
void  pop(slist);
slist search(slist, char *);
void  traverse(slist);
void  delete(slist, int);
void  destroy(slist);

int main()
{
    slist head = initialize();
    pop(head);
    
    push(head, "test1");
    push(head, "test2");
    push(head, "test3");
    push(head, "test4");
    push(head, "test5");
    push(head, "test2");
    push(head, "test7");
    
    pop(head);
    push(head, "test3");
    delete(head, 3);
    
    traverse(head);
    
    insert(head, 2, "insert to position 2");
    traverse(head);
    
    search(head, "test2");
    
    destroy(head);
    
}


void destroy(slist head)
{
    printf("destroy(slist)\n");
    
    slist temp = head;
    slist t    = head;
    for(;;)
    {
        t = temp;
        temp = temp->next;
        
        printf("free item => [%s]\n", t->item);
        free(t);
        
        if (temp == NULL)
            break;
    }
    
    printf("\n");
}

slist initialize()
{
    printf("initialize()\n");
    
    slist head = malloc(sizeof(slist));
    
    head->item = "I'm the head!";
    head->next = NULL;
    
    printf("\n");
    
    return head;
}

void delete(slist head, int i)
{
    printf("delete(slist, int); delete the [%d]'th item.\n", i);
    
    slist temp    = head;
    
    int j = 0;
    
    for(;;)
    {
        if (temp->next == NULL)
        {
            break;
        }
        
        if ((i-1) == j)
        {
            temp->next = temp->next->next;
            break;
        }
        
        temp = temp->next;
        j++;
    }
    
    printf("\n");
}


void insert(slist head, int i, char *item)
{
    printf("insert(slist, int, char *); insert item => [%s] as the [%d]'th.\n", item, i);
    
    slist temp    = head;
    slist newitem = malloc(sizeof(slist));
    
    newitem->item = item;
    
    int j = 0;
    
    for(;;)
    {
        if (temp->next == NULL)
        {
            break;
        }
        
        if ((i-1) == j)
        {
            newitem->next = temp->next;
            temp->next = newitem;
            break;
        }
        
        temp = temp->next;
        j++;
    }
    
    printf("\n");
}

slist search(slist head, char *item)
{
    printf("search(slist, item); item => [%s]\n", item);
    
    slist temp = head;
    int  i    = 0;
     
    for(;;)
    {
        if (strcmp(temp->item, item) == 0)
        {
            printf("found item [%s] at the %d'th item.\n", temp->item, i);
        }
        
        if (temp->next == NULL)
        {
            break;
        }
        
        temp = temp->next;
        i++;
    }
    
    printf("\n");
}

void pop(slist head)
{
    printf("pop(slist)\n");
    
    slist temp = head;
    
    for(;;)
    {
        if (temp->next == NULL)
        {
            printf("only head item exist. so, don't pop.\n");
            break;
        }
        else if (temp->next->next == NULL)
        {
            printf("pop item: %s\n", temp->next->item);
            temp->next = NULL;
            break;
        }
        
        temp = temp->next;
    }
    
    printf("\n");
}

void push(slist head, char *item)
{
    printf("push(slist, item); item => '%s'\n", item);
    
    slist newitem = malloc(sizeof(struct node)); 
    slist temp    = head;
    
    newitem->item = item;
    newitem->next = NULL;
    
    for(;;)
    {
        if(temp->next == NULL)
        {
            printf("puch item %s\n", item);
            temp->next = newitem;
            break;
        }
        
        temp = temp->next;
    }
    
    printf("\n");
}

void traverse(slist head)
{
    printf("traverse(slist)\n");

    if (head == NULL)
    {
        printf("head is NULL!\n");
        exit(0);
    }
    
    slist temp = head;
    for(;;)
    {
        if(temp->next == NULL)
            break;
        
        /* print all, except head. */
        temp = temp->next;
        printf("get item = %s\n", temp->item);
    }
    
    printf("\n");
}

