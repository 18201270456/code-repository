#include <stdio.h> /* printf */
#include <stdlib.h> /* malloc */
#include <unistd.h>
#include <string.h> /* memset strcat */
#include <signal.h>
#include <stdarg.h> /* va_start va_arg va_list */
#include <time.h>

#define MAX(a, b) (a > b) ? a : b

char *get_time()
{
    time_t    *timep;
    struct tm *curtime;
    char      *temp = (char *)malloc(3);
    char      *gettime = (char *)malloc(30);
    
    time(timep);
    memset(gettime, 0, 30);
    
    curtime = localtime(timep);
    
    sprintf(temp, "%d-", curtime->tm_year + 1900);
    strcat(gettime, temp);
    
    sprintf(temp, "%d-", curtime->tm_mon + 1);
    strcat(gettime, temp);
    
    sprintf(temp, "%d ", curtime->tm_mday);
    strcat(gettime, temp);
    
    sprintf(temp, "%d:", curtime->tm_hour);
    strcat(gettime, temp);
    
    sprintf(temp, "%d:", curtime->tm_min);
    strcat(gettime, temp);
    
    sprintf(temp, "%d", curtime->tm_sec);
    strcat(gettime, temp);
    
    free(temp);
    
    return gettime;
}


/*
DESCRIPTION
    string combination, save result to string: *dest

EXAMPLE
    char *str  = NULL;
    char *str1 = "str111";
    char *str2 = "str222";
    char *str3 = "str333";
    
    str_comb(&str, 3, str1, str2, str3);
    str_comb(&str, 2, str1, str2);

PARAMETERS
    int num: the number of strings to combine.

*/
void str_comb(char **dest, int num, ...)
{
    int   i, str_len;
    char *str;
    
    va_list ap;
    
    va_start(ap, num);
    
    str_len = 0;
    
    for(i=0; i<num; i++)
    {
        str = va_arg(ap, char *);
        str_len = str_len + sizeof(str);
    }
    
    va_end(ap);
    
    *dest = (char *)malloc(str_len);
    memset(*dest, 0, str_len);
    
    va_start(ap, num);
    
    for(i=0; i<num; i++)
    {
        str = va_arg(ap, char *);
        strcat(*dest, str);
    }
    
    va_end(ap);
    
}

int main()
{
    printf("time=[%s]\n", get_time());
    
    char *str  = NULL;
    char *str1 = "str111";
    char *str2 = "str222";
    char *str3 = "str333";
    
    printf("str=%s\n", str);
    str_comb(&str, 3, str1, str2, str3);
    printf("str=%s\n", str);
    
    str_comb(&str, 2, str1, str2);
    printf("str=%s\n", str);
    
    int i, t[10];
    memset(t, 0, 10);
    for(i=1; i<10; i++)
        printf("t[%d]=%d\n", i, t[i]);
    
    char *test;
    test = (char *)malloc(20);
    
    memset(test, 2, 20);
    printf("test=%s\n", test);
    
    memset(test, 0, 20);
    printf("test=%s\n", test);
    for(i=1; i<10; i++)
        printf("test[%d]=%d\n", i, test[i]);
    
    strcat(test, "hehe");
    printf("test=%s\n", test);
    
    int a, b;
    
    a = 2;
    b = 3;
    printf("max(a,b)=%d\n", MAX(a, b));
    
    return 0;
}



