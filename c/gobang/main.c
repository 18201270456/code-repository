#define  _MAIN_C_
#include "gobang.h"


int main()
{
    init_var();
    init_chessboard(chessboard);
    refresh_chessboard(chessboard);
     
    while(1)
    {
        if (usr_move(chessboard) == -1) continue;
        refresh_chessboard(chessboard);
         
        if(someone_win()) break;
        
        cpu_move(chessboard);
        refresh_chessboard(chessboard);
        
        if(someone_win()) break;
    }
    
    printf("game over.\n");
}

int someone_win()
{        
    int winner;
    
    winner = is_win(chessboard);
    
    if (winner == CPU)
    {
        printf("You FAIL!\n");
        return 1;
    }
    
    if (winner == USR)
    {
        printf("You WIN!\n");
        return 1;
    }
    
    return 0;
 
}

void init_var()
{
	root = malloc(sizeof(struct gametree));
	
	root->player  = USR; //CPU play next step
	root->x       = 0;
	root->y       = 0;
	root->cut     = 0;
	root->ab      = -1;
	root->level   = 0;
	root->father       = NULL;
	root->next_sibling = NULL;
	root->first_child  = NULL;
	root->score   = 0;
	
	nowplayer = CPU;
	treelevel = 0;
    
}
