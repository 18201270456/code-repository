#include <stdio.h>
#include <stdlib.h>

typedef struct stu
{
    int x;
    struct stu *next;
}*stu;

int main()
{
    struct stu t;
    t.x = 1;
    t.next = NULL;
    
    printf("t.x=%d\n", t.x);
    
    stu s = malloc(sizeof(stu));
    s->x = 2;
    s->next = NULL;
    printf("s.x=%d\n", s->x);
}
