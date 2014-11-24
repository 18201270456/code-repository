#include <stdio.h>
#include <stdlib.h>

void set1(int *p)
{
    *p = 100;
}

void set2(int **p)
{
    *p = (int *)malloc(sizeof(int));
}

int main()
{
    int *a1, *a2;
    a1 = (int *)malloc(sizeof(int));
    a2 = (int *)malloc(sizeof(int));
    
    *a1 = 5;
    set1(a2);
    
    printf("a1=%d, a2=%d.\n", *a1, *a2);
 
}
