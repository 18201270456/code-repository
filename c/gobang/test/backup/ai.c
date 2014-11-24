#include "gobang.h"


void cpu_move(char board[X][Y])
{
    set_node_score(board, root);
    
    gametree t    = root->first_child;
    gametree node = t;
    
    while(t != NULL)
    {
        if(t->score > node->score)
            node = t;
        
        t = t->next_sibling;
    }
    
    board[node->x][node->y] = CPU;
}


/*
 * DESCRIPTION
 *    set node->score or node->cut;
 *
*/
void set_node_score(char newboard[X][Y], gametree node)
{
    int  i, j, score;
    
    /* check if someone wins */
    int win = is_win(newboard);
    
    if (win == CPU)
    {
        node->score = 9000000;
        return;
    }
    
    if (win == USR)
    {
        node->score = -9000000;
        return;
    }
    
    /* get score of the final step */
    if (node->level == 4)
    {
        node->score = calculate_score(newboard);
        return;
    }
    
    /* start to check score of each child */
    gametree newnode  = NULL;
    gametree prenode = NULL;
    
    for(i=0; i<X; i++)
    {
        for(j=0; j<Y; j++)
        {
            if( newboard[i][j] != '+' ) continue;
            
            if( is_empty(i, j) ) continue;
            
            newnode = malloc(sizeof(gametree));
            
            newnode->player  = SWITCH_PLAYER(node->player);
        	newnode->x       = i;
        	newnode->y       = j;
            newnode->level   = node->level + 1;
            newnode->cut     = 0;
            
        	newnode->father  = node;
        	newnode->next_sibling = NULL;
        	newnode->first_child  = NULL;
            
            newboard[i][j] = newnode->player;
            set_node_score(newboard, newnode);
            
            /* alpha-beta cutting */
            if (newnode->cut == 1)
            {
                free(newnode);
                continue;
            }
            
            
            if (prenode == NULL)
            {
                node->first_child = newnode;
                score = newnode->score;
            }
            else
            {
                if( (newnode->player == USR) && (newnode->score < prenode->score) )
                {
                    newnode->cut = 1;
                    return;
                }
                
                if( (newnode->player == CPU) && (newnode->score > prenode->score) )
                {
                    newnode->cut = 1;
                    return;
                }
                
                prenode->next_sibling = newnode;
            }
            
            
            prenode = newnode;
            
            if (node->player == CPU)
                score = MIN(score, newnode->score);
            else
                score = MAX(score, newnode->score);
            
            
            newboard[i][j] = '+';
        }
    }
    
    node->score = score;
}











