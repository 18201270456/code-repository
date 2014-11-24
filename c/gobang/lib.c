#include "gobang.h"


/*
 * DESCRIPTION
 *    get the whole chessboard as string.
 *
*/
char *chessboard_string(char board[X][Y])
{
    char *str = malloc( (12 * (MAX(X, Y)+2)) * MAX(X, Y) * sizeof(char) );
    
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
    
    
    int x = 0;
    while (x<X)
    {
        i = x;
        j = 0;
	    while (i<X && j<Y)
	    {
	        sprintf(str, "%s%c", str, board[i++][j++]);
	    }
	    sprintf(str, "%s|", str);
        
        x++;
    }
     
    int y = 1;
    while (y<Y)
    {
        i = 0;
        j = y;
	    while (i<X && j<Y)
	    {
	        sprintf(str, "%s%c", str, board[i++][j++]);
	    }
	    sprintf(str, "%s|", str);
        
        y++;
    }
    
    x = 0;
    while (x<X)
    {
        i = x;
        j = Y-1;
	    while (i<X && j<Y)
	    {
	        sprintf(str, "%s%c", str, board[i++][j--]);
	    }
	    sprintf(str, "%s|", str);
        
        x++;
    }
     
    y = Y-2;
    while (y >=0 )
    {
        i = 0;
        j = y;
	    while (i<X && j<Y)
	    {
	        sprintf(str, "%s%c", str, board[i++][j--]);
	    }
	    sprintf(str, "%s|", str);
        
        y--;
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
    
    if( (cpu_win>0) && (usr_win>0) )
        return 'X';
    
    if(cpu_win > 0)
        return CPU;
    
    if(usr_win > 0)
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
    
    char *live_4  = "+@@@@+"; 
    char *dead_4a = "@@@@+"; 
    char *dead_4b = "@@@+@"; 
    char *dead_4c = "@@+@@"; 
    
    char *live_3  = "++@@@++";
    char *dead_3a = "@@@++";
    char *dead_3b = "+@+@@ ";
    char *dead_3c = "@++@@";
    char *dead_3d = "@+@+@";
    
    char *live_2  = "+++@@+++";
    char *dead_2a = "@@+++";
    char *dead_2b = "++@+@++";
    char *dead_2c = "+@++@+";
    
    char *live_1  = "++@++";
    
    
    char *type[] = {live_4, dead_4a, dead_4b, dead_4c,
                    live_3, dead_3a, dead_3b, dead_3c, dead_3d,
                    live_2, dead_2a, dead_2b, dead_2c,
                    live_1};
    
    int value[] = {300000, 4000, 3000, 2600,
                   3000, 500, 800, 600,550,
                   650, 150, 250, 200,
                   10};
   
    int   i;
    char *str = chessboard_string(board);
    
    
    /* get cpu_score */
    
    int w;
    for(i=0; i<14; i++)
    {
        if( (w=str_in(str, type[i])) > 0 )
        {
            cpu_score = cpu_score + value[i];
        }
    }
       
    
    /* get usr_score */
    
    live_4  = "+OOOO+"; 
    dead_4a = "OOOO+"; 
    dead_4b = "OOO+O"; 
    dead_4c = "OO+OO"; 
    
    live_3  = "++OOO++";
    dead_3a = "OOO++";
    dead_3b = "+O+OO+";
    dead_3c = "O++OO";
    dead_3d = "O+O+O";
    
    live_2  = "+++OO+++";
    dead_2a = "OO+++";
    dead_2b = "++O+O++";
    dead_2c = "+O++O+";
    
    live_1  = "++O++";
    
    char *type2[] = {live_4, dead_4a, dead_4b, dead_4c,
                live_3, dead_3a, dead_3b, dead_3c, dead_3d,
                live_2, dead_2a, dead_2b, dead_2c,
                live_1};
    
    for(i=0; i<14; i++)
    {
        if( (w=str_in(str, type2[i])) > 0 )
        {
            usr_score = usr_score + value[i];
        }
    }
    
    int score;
    
    if ( usr_score > 6000 )
        return 0 - usr_score;
       
    if ( usr_score < 500 )
        return cpu_score;
    
    return cpu_score - usr_score;
}









