#include <stdio.h> /* printf */
#include <stdlib.h> /* malloc */
#include <unistd.h>
#include <string.h> /* memset strcat */
#include <signal.h>

#define MAX(a, b) (a > b) ? a : b
int main()
{
    pid_t pid, ppid;
    
    ppid = getpid();
    printf("parent pid=%d\n", ppid);
    
    system("pstree | grep bash");
    if(fork()==0)
    {
        printf("child pid=%d\n", getpid());
        system("pstree -p| grep bash");
        sleep(5);
        kill(ppid, SIGINT);
        printf("TEST:child pid=%d\n", getpid());
        exit(0);
    }
    
    sleep(5);
    int i, t[10];
    for(i=1; i<10; i++)
        printf("t[%d]=%d\n", i, t[i]);
    
    char *test;
    test = (char *)malloc(20);
    
    memset(test, 2, 20);
    printf("test=%s\n", test);
    
    memset(test, 0, 20);
    printf("test=%s\n", test);
    
    strcat(test, "hehe");
    printf("test=%s\n", test);
    
    int a, b;
    
    a = 2;
    b = 3;
    printf("max(a,b)=%d\n", MAX(a, b));
    
    return 0;
}
