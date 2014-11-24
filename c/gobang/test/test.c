#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int str_in(char *in, char *str)
{
    int i = 0;
    while( (in=strstr(in, str)) != NULL )
    {
        in = in + strlen(str);
        i++;
    }
    
    return i;
}


int main()
{
    char *str = "he";
    char *in = "oadheachaceesheac";
    
    printf("happens=%d\n", str_in(in, str));
    
    int a = 3;

    while(a-- > 0)
    {
        printf("a=%d\n", a);
    }
    
    if(str=="he")
    {
        int a;
        a = 1;
    }
    printf("abb=%d\n", a);
}
