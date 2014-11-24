#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>


void replace(char *dest, char *old, char *new)
{
    int i, len;
    len = strlen(new);
    
    for(i=0; i<strlen(dest) - len; i++)
    {

}

int main()
{
    char data[12];
    char *d[2];
    int i;
    
    for(i=0; i<12; i++)
    {
        data[i] = 'a';
    }
    
    d[1] = data;

    printf("d1=%s\n", d[1]);
    
    /*
    d = "haha";
    char d2[12];
    bzero(&d2, 12);
    
    strcpy(data, "strcpy");
    strcpy(d2, "strcpy");
    strcat(d2, data);
    
    printf("data=%s\n", data);
    printf("d=%s\n", d);
    printf("d2=%s\n", d2);
    */
    
}
