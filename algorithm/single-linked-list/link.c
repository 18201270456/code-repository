#include <stdio.h>
#include <stdlib.h>

typedef struct node {
    char        *item;
    struct node *next;
} *link;


void destroy(link);
link initialize();
void delete(link, int);
void insert(link, int, char *);
link search(link, char *);
void pop(link);
void push(link, char *);
void traverse(link);

int main()
{
    link linkhead = initialize();
    pop(linkhead);
    
    push(linkhead, "test1");
    push(linkhead, "test2");
    push(linkhead, "test3");
    push(linkhead, "test4");
    push(linkhead, "test5");
    push(linkhead, "test2");
    push(linkhead, "test7");
    
    pop(linkhead);
    push(linkhead, "test3");
    delete(linkhead, 3);
    
    traverse(linkhead);
    
    insert(linkhead, 2, "replace 2");
    traverse(linkhead);
    
    search(linkhead, "test2");
    
    destroy(linkhead);
    
}


void destroy(link head)
{
    printf("destroy(link)\n");
    
    link temp = head;
    link t    = head;
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

link initialize()
{
    printf("initialize()\n");
    
    link head = malloc(sizeof(link));
    
    head->item = "I'm the head!";
    head->next = NULL;
    
    printf("\n");
    
    return head;
}

void delete(link head, int i)
{
    printf("delete(link, int); delete the [%d]'th item.\n", i);
    
    link temp    = head;
    
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


void insert(link head, int i, char *item)
{
    printf("insert(link, int, char *); insert item => [%s] as the [%d]'th.\n", item, i);
    
    link temp    = head;
    link newitem = malloc(sizeof(link));
    
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

link search(link head, char *item)
{
    printf("search(link, item); item => [%s]\n", item);
    
    link temp = head;
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

void pop(link head)
{
    printf("pop(link)\n");
    
    link temp = head;
    
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

void push(link head, char *item)
{
    printf("push(link, item); item => '%s'\n", item);
    
    link newitem = malloc(sizeof(struct node)); 
    link temp    = head;
    
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

void traverse(link head)
{
    printf("traverse(link)\n");

    if (head == NULL)
    {
        printf("linkhead is NULL!\n");
        exit(0);
    }
    
    link temp = head;
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

