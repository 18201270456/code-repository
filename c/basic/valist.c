#include <stdio.h>

typedef char * va_list;

#define _INTSIZEOF(n) ((sizeof(n) + sizeof(int) - 1)  &  ~(sizeof(int)-1))
#define va_start(ap, v) (ap = (va_list)&v + _INTSIZEOF(v))
#define va_arg(ap, t) ( *( t * ) ((ap += _INTSIZEOF(t)) - _INTSIZEOF(t)) )
#define va_end(ap)  (ap = (va_list)0)


void mprintf(char *, ...);

int main()
{
    int i;
    char *s;
    
    mprintf("test start...\n");
    
    i = 1;
    s = "hello world!";
    mprintf("i=%d, s=%s\n", i, s);
    
    s = "second test!";
    mprintf("s=%s\n", s);
}

void mprintf(char *fmt, ...)
{
    char *p, *sval;
    int ival;
    
    va_list ap;
    
    va_start(ap, fmt);
    
    for (p=fmt; *p; p++)
    {
        if (*p != '%')
        {
            putchar(*p);
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


