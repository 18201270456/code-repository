#include "gobang.h"


/*
 * DESCRIPTION
 *   initialize the value of chessboard. all is empty. 
 *
 * EXAMPLE
 *   char chessboard[X][Y];
 *   init_chessboard(chessboard);
 *   //value of chessboard[X][Y] would be iniatialized.
 *
*/
void init_chessboard(char board[X][Y])
{
    int i, j;
    
    for (i=0; i<X; i++)
    {
        for (j=0; j<Y; j++)
        {
            board[i][j] = '+';
        }
    }
}


/*
 * DESCRIPTION
 *   refresh chessboard after value updated.
 *
*/
void refresh_chessboard(char board[X][Y])
{
    system("clear");
    
    int i, j;
    
    for (j=Y; j>=0; j--)
    {
        /* X */
        if (j==0)
        {
            printf(" ");
            
            for (i=0; i<X; i++)
            {
                printf(" %x", i+1);
            }
            
            printf("\n");
            continue;
        }
        
        /* Y */
        printf("%x", j);
        
        /* board */
        for (i=0; i<X; i++)
        {
            printf(" %c", board[i][j-1]);
        }
        
        printf("\n");
    }
}

/*
 * DESCRIPTION
 *   accept a step of user move from input.
 *
*/
int usr_move(char board[X][Y])
{
    int x, y;
    
    printf("please play, input: x, y\n");
    scanf("%d,%d", &x, &y);
    
    if (x < 1 || y < 1 || x > X || y > Y)
    {
        printf("input value not proper!\n");
        return -1;
    }
    
    x--;
    y--;
    
    if (board[x][y] == '+')
    {
        board[x][y] = USR;
    }
    else
    {
        printf("position not empty!\n");
        return -1;
    }
    
    return 0;
}



/*
 * DESCRIPTION
 *    if map (i-2 => i+2)(j-2 => j+2) all elements empty, return 1;
 *    else, return 0;
*/
int is_empty(int i, int j)
{
    int x, y;

    for(x=i-1; x <= i+1; x++)
    {
        if (x < 0 || x >= X)
        {
            continue;
        }
        
        for(y=j-1; y <= j+1; y++)
        {
            if( y < 0 || y >= Y )
            {
                continue;
            }
            
            if (chessboard[x][y] != '+')
            {
                return 0;
            }
        }
    }
    
    return 1;
}




