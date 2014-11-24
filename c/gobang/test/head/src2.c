#include "common.h"

void fun_src2()
{
    printf("this is fun in src2.c\n");
    
    int i;
    
    test = (ts)malloc(sizeof(ts));
    test->i = 1;
    test->j = 1;
    test->next = NULL;
    
    char *str = malloc(120);
    printf("str=%s\n", str);
    
    printf("MAX(X, Y)=%d\n\n", MAX(X, Y));
}




