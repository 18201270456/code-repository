#include "gobang.h"


/*
 * DESCRIPTION
 *    get the whole chessboard as string.
 *
*/
char *chessboard_string(char board[X][Y])
{
    char *str = malloc( 12 * (MAX(X, Y)+1) );
    
    int i, j, m, n;
    
    for(j=0; j<Y; j++)
    {
        for(i=0; i<X; i++)
        {
            sprintf(str, "%s%c", str, board[i][j]);
        }
        
        sprintf(str, "%s|", str);
    }
    
    for(i=0; i<X; i++)
    {
        for(j=0; j<Y; j++)
        {
            sprintf(str, "%s%c", str, board[i][j]);
        }
        
        sprintf(str, "%s|", str);
    }
     
    for(i=0; i<X; i++)
    {
        for(m=i, n=0; m>=0 && n<=i; m--, n++)
        {
            sprintf(str, "%s%c", str, board[m][n]);
        }
        sprintf(str, "%s|", str);
        
        for(j=0; j<Y-i; j++)
        {
            sprintf(str, "%s%c", str, board[i][j]);
        }
        sprintf(str, "%s|", str);
    }
    
    for(j=1; j<Y; j++)
    {
        for(i=0; i<X-j; i++)
        {
            sprintf(str, "%s%c", str, board[i][j]);
        }
        
        sprintf(str, "%s|", str);
        
        for(i=X-1; i>=j; i--)
        {
            sprintf(str, "%s%c", str, board[i][j]);
        }
        
        sprintf(str, "%s|", str);
    } 
     
    char *rvs = str_reverse(str);
    sprintf(str, "%s|%s", str, rvs);
    
    return str;
    
}


/*
 * DESCRIPTION
 *    return string "str" in string "in" how many times;
 *
*/
int str_in(char *in, char *str)
{
    int i = 0;
    while( (in=strstr(in, str)) != NULL )
    {
        in = in + strlen(str);
        i++;
    }
    
    return i;
}


/*
 * DESCRIPTION
 *    return CPU or USR or ' '
 *
*/
char is_win(char board[X][Y])
{
    char *str = chessboard_string(board);
    char *cpu = "@@@@@";
    char *usr = "OOOOO";
        
    int cpu_win = str_in(str, cpu);
    int usr_win = str_in(str, usr);
    
    if(cpu_win && usr_win)
        return 'X';
    
    if(cpu_win)
        return CPU;
    
    if(usr_win)
        return USR;
    
    return ' ';
}


/*
 * DESCRIPTION
 *    reverse a string.
 *
*/
char *str_reverse(char *str)
{
    int   len = strlen(str);
    char *rvs = malloc(len+1);
    
    int i = 0;
    while ( (rvs[i] = str[len-i-1]) != '\0' )
    {
        i++;
    }
    
    return rvs;
}



/*
 * DESCRIPTION
 *    calculate score of CPU for current chessboard.
 *
*/
int calculate_score(char board[X][Y])
{
    int cpu_score = 0;
    int usr_score = 0;
    
    char *live_4  = " @@@@ "; 
    char *dead_4a = "@@@@ "; 
    char *dead_4b = "@@@ @"; 
    char *dead_4c = "@@ @@"; 
    
    char *live_3  = "  @@@  ";
    char *dead_3a = "@@@  ";
    char *dead_3b = " @ @@ ";
    char *dead_3c = "@  @@";
    char *dead_3d = "@ @ @";
    
    char *live_2  = "   @@   ";
    char *dead_2a = "@@   ";
    char *dead_2b = "  @ @  ";
    char *dead_2c = " @  @ ";
    
    char *live_1  = "    @    ";
    
    
    char *type[] = {live_4, dead_4a, dead_4b, dead_4c,
                      live_3, dead_3a, dead_3b, dead_3c, dead_3d,
                      live_2, dead_2a, dead_2b, dead_2c,
                      live_1};
    
    int value[] = {300000, 2500, 3000, 2600,
                     3000, 500, 800, 600,550,
                     650, 150, 250, 200,
                     1};
   
    int   i;
    char *str = chessboard_string(board);
    
    
    /* get cpu_score */
    
    for(i=0; i<14; i++)
    {
        if( str_in(str, type[i]) )
        {
            cpu_score += value[i];
        }
    }
       
    
    /* get usr_score */
    
    live_4  = " OOOO "; 
    dead_4a = "OOOO "; 
    dead_4b = "OOO O"; 
    dead_4c = "OO OO"; 
    
    live_3  = "  OOO  ";
    dead_3a = "OOO  ";
    dead_3b = " O OO ";
    dead_3c = "O  OO";
    dead_3d = "O O O";
    
    live_2  = "   OO   ";
    dead_2a = "OO   ";
    dead_2b = "  O O  ";
    dead_2c = " O  O ";
    
    live_1  = "    O    ";
    
    for(i=0; i<14; i++)
    {
        if( str_in(str, type[i]) )
        {
            usr_score += value[i];
        }
    }
    
    return cpu_score - usr_score;
}









