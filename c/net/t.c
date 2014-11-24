#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void stop(int signo)
{
    printf("stop\n");
    exit(0);
}

int main(int argc, char **argv)
{
    printf("argc=%d\n", argc);
    
    if (argc != 2)
    {
        fputs("usage: ./server port_number\n", stderr);
        exit(1);
    }
     
    signal(SIGINT, stop);
    printf("arg[1]=%s\n", argv[1]);
    while(1);
    {
    }
}
