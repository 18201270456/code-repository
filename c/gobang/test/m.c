#include "t.h"


void init_t(char t[][2])
{
    int i, j;
    
    for(i=0; i<2; i++){
        for(j=0; j<2; j++){
            t[i][j] = 'a';
        }
    }
}

/*
 * DESCRIPTION
 *    return string "str" in string "in" how many times;
 *
*/

int main()
{
    char t[2][2];
    
    int i, j;
    
    init_t(t);
    
    for(i=0; i<2; i++){
        for(j=0; j<2; j++){
            printf("t[%d][%d]=%c ", i, j, t[i][j]);
        }
        printf("\n");
    }
    
    for(i=0, j=2; i<2, j>0; i++, j--)
    {
        printf("i=%d, j=%d\n", i, j);
    }


}



