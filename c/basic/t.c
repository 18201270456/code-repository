#include<stdio.h>

void write_log (int priority, char *ss)
{
    syslog(priority, ss);
    printf("ss=%s", ss);
    return;
}

void write_log(int priority, char *fmt, char **ss)
{

}
void main()
{
    char buf[1024];
    sprintf(buf, "this is %s", "jack");
    write_log(1, buf);
    return;
}

recvfrom
