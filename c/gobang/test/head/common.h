#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdio.h>
#include <stdlib.h>


#define MAX(x,y)  (x > y ? x:y)
 
typedef struct ts
{
    int i;
    int j;
    struct ts *next;
}*ts;
 
#ifdef _MAIN_C_
#define EXT  
#else
#define EXT extern
#endif

EXT int a;
EXT ts  test;
   

#define X 1
#define Y 4

extern void fun_src1();
extern void fun_src2();






#endif /* _COMMON_H_ */
