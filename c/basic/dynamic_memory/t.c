#include <stdio.h>
#include <stdlib.h>

void set1(int *p)
{
    p = (int *)malloc(sizeof(int));
}

void set2(int **p)
{
    *p = (int *)malloc(sizeof(int));
}

int main()
{
    int *a1;
    /*
    int *a2;
     
    set2(&a2);
    printf("set2 -> a2\n");
    
    *a2 = 2;
    printf("a2=%d\n", *a2);
    free(a2);
    */
    
    
    set1(a1);
    printf("set1 -> a1\n");
    
    *a1 = 1;
    printf("a1=%d\n", *a1);
    free(a1);
    
    return 0;
}

