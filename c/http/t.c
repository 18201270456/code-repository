#include <stdio.h> /* printf sprintf */
#include <unistd.h> /* close */
#include <stdlib.h> /* malloc free atoi */
#include <string.h> /* memset strcat bzero*/
#include <sys/socket.h> /* bind socket accept */
#include <sys/types.h> /* not required, just for application portable with <sys/socket.h> */
#include <sys/select.h> /* select FD_SET,FD_ZERO,... */
#include <time.h> /* localtime time */
#include <netinet/in.h>          //定义数据结构sockaddr_in


void catprintf(char **dest, char *fmt, ...)
{
    char *p, *sval;
    int ival;
    
    va_list ap;
    
    va_start(ap, fmt);
    
    for (p=fmt; *p; p++)
    {
        if (*p != '%')
        {
            strcat(*dest, *p);
            continue;
        }
        
        switch (*++p)
        {
            case 'd':
                ival = va_arg(ap, int);
                printf("%d", ival);
                break;
                
            case 's':
                for ( sval=va_arg(ap, char *); *sval; *sval++)
                    putchar(*sval);
                break;
                
            default:
                putchar(*p);
                break;
        }
    }
    
    va_end(ap);
}   

int main()
{
    char *str1 = (char *)malloc(1024);
    
    str1 = "this is str1";
    printf("str1=%s\n", str1);
    
    catprintf(&str1, "hehe");
    printf("str1=%s\n", str1);
    
    catprintf(&str1, "uuu%s", "test string");
    printf("str1=%s\n", str1);
    
    return 0;
}
 
