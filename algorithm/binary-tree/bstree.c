#include <stdio.h>
#include <stdlib.h>

/*

binary search tree
binary search tree

*/

typedef struct binary_search_tree {
    int                       data;
    struct binary_search_tree *lchild;
    struct binary_search_tree *rchild;
} *bstree;


bstree create();
bstree insert(bstree, int);
bstree search(bstree, int);

/* ldr: left-middle-right */
/* dlr: middle-left-right */
void traverse_ldr(bstree);
void traverse_dlr(bstree);


void destroy(bstree);
void delete(bstree, int);

/*
void destroy(bstree);
void delete(bstree, int);
bstree search(bstree, char *);
void pop(bstree);
void push(bstree, char *);
*/

void delete(bstree root, int data)
{
    btree getroot = search(root, data)
    if (getroot->rchild == NULL && getroot->lchild == NULL)
    {
        getroot = NULL
    }
    else if(getroot->rchild = NULL || getroot->lchild == NULL)
    {
        getroot->rchild
    }
}

bstree find_parent(bstree root)
{
    
}

void destroy(bstree root)
{
    if(root != NULL)
    {
        destroy(root->lchild);
        destroy(root->rchild);
        free(root);
    }
}

bstree search(bstree root, int data)
{
    if(root == NULL)
    {
        printf("root is NULL\n", data);
    }
    else if( data < (root->data) )
    {
        printf("left:  ");
        root = search(root->lchild, data);
    }
    else if( data > (root->data) )
    {
        printf("right: ");
        root = search(root->rchild, data);
    }
    else
    {
        printf("find, root->data=[%d]\n", root->data);
    }
    
    return root;
}

bstree create()
{
    printf("create()\n\n");
    
    bstree root = NULL;
    
    return root;
}

bstree insert(bstree root, int data)
{
    if(root == NULL)
    {
        root = malloc(sizeof(bstree));
        
        root->data   = data;
        root->lchild = NULL;
        root->rchild = NULL;
        
        printf("[%d]\n", data);
    }
    else if( data < (root->data) )
    {
        printf("left  ");
        root->lchild = insert(root->lchild, data);
    }
    else
    {
        printf("right ");
        root->rchild = insert(root->rchild, data);
    }
    
    return root;
}

void traverse_ldr(bstree root)
{
    if(root != NULL)
    {
        traverse_ldr(root->lchild);
        printf("DATA: %d\n", root->data);
        traverse_ldr(root->rchild);
    }
}

void traverse_dlr(bstree root)
{
    if(root != NULL)
    {
        printf("DATA: %d\n", root->data);
        traverse_dlr(root->lchild);
        traverse_dlr(root->rchild);
    }
}

int main()
{
    bstree root = create();
    
    printf("insert:\n");
    root = insert(root, 3);
    root = insert(root, 1);
    root = insert(root, 2);
    root = insert(root, 5);
    root = insert(root, 7);
    root = insert(root, 22);
    root = insert(root, 4);
    printf("\n");
    
    printf("traverse_ldr(bstree):\n");
    traverse_ldr(root);
    printf("\n");
    
    printf("traverse_dlr(bstree):\n");
    traverse_dlr(root);
    printf("\n");
    
    bstree temp;
    temp = search(root, 4);
    
    destroy(root);
    
}
