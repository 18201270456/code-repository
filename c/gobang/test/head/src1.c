#include "common.h"



void fun_src1()
{
    char *s1 = "s1";
    char *s2 = "s2";
    char *s[] = {s1, s2};
    int i;

    for (i=0; i<2; i++)
    {
        printf("s[%d]=%s\n", i, s[X]);
    }
    
    s2 = "news2";
    s[1] = s2;
    
    for (i=0; i<2; i++)
    {
        printf("s[%d]=%s\n", i, s[i]);
    }
    
    printf("this is fun in src1.c\n");
}


