#include <stdio.h>


void prints(FILE **stream)
{
    fputs("haha\0\n", stream);
}
int main()
{
    char msg[256];
    FILE *test;

    prints(&test);
    fread(msg, 250, 1, test);
    printf("msg=%s", msg);


    if (-1)
    {
//        fputs(msg, stdout);

    }
}


