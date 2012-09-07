#include <stdio.h>
#include <getopt.h>


/*
 * DESCRIPTION
 *    Demonstrates how to use function getopt_long to parse cmd-line options.
 * 
 * EXAMPLE
 *     $ ./a.out --help --version --ip 127.0.0.1 --port 8080
 *     $ ./a.out -h -v -i 127.0.0.1 -p 8080
 *
 *     $ ./a.out --long -s
 * 
*/
int main(int argc, char * argv[])
{
    int option;
    
    static struct option long_options[] = {
         {"help",    no_argument,       NULL, 'h'},
         {"version", no_argument,       NULL, 'v'},
         {"ip",      required_argument, NULL, 'i'},
         {"port",    required_argument, NULL, 'p'},
         {"long",    no_argument,       NULL, 'l'}, /* only long option support for this one */
         {0, 0, 0, 0}
    };
    
    /* if argument needed, add char ':' after the short option item */
    const char *short_options = "hvi:p:s";
    
    while( ( option=getopt_long(argc, argv, short_options, long_options, NULL) ) != -1 )
    {
        printf("option is %c, arg is %s\n", option, optarg);
        
        switch(option)
        {
            case 'h':
                printf("this is help file\n");
                break;
                
            case 'v':
                printf("program version: v1.0.0.0\n");
                break;
                
            case 'i':
                printf("get ip=%s\n", optarg);
                break;
                
            case 'p':
                printf("get port=%s\n", optarg);
                break;
                
            case 'l':
                printf("this is a long option, no short one fot it.\n");
                break;
                
            case 's':
                printf("this is a short option, no long one fot it.\n");
                break;
                
        }
        
        printf("\n");
    }
}
