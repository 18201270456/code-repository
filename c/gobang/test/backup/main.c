#define  _MAIN_C_
#include "gobang.h"


int main()
{
    int i;
    char winner;
    
    init_var();
    init_chessboard(chessboard);
    refresh_chessboard(chessboard);
   
    while(1)
    {
        if (usr_move(chessboard) == -1)
        {
            continue;
        }
        
        refresh_chessboard(chessboard);
        
        cpu_move(chessboard);
        refresh_chessboard(chessboard);
        
        winner = is_win(chessboard);
        
        if (winner == CPU)
        {
            printf("You FAIL!\n");
            break;
        }
        
        if (winner == USR)
        {
            printf("You WIN!\n");
            break;
        }
    }
    
    printf("game over.\n");
}


void init_var()
{

	root = malloc(sizeof(gametree));
	
	root->player  = USR; //CPU play next step
	root->x       = -1;
	root->y       = -1;
	root->score   = 0;
	root->father       = NULL;
	root->next_sibling = NULL;
	root->first_child  = NULL;
	 
	
	nowplayer = CPU;
	treelevel = 0;
}
