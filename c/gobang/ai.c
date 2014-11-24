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
        
        printf("(%d, %d)=%d  ", 1+t->x, 1+t->y, t->score);
        
        t = t->next_sibling;
    }
    
    board[node->x][node->y] = CPU;
    
    destroy_children(root);
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
    char win = is_win(newboard);
    
    if (win == CPU)
    {
        node->score = 90000000/node->level;
        return;
    }
    
    if (win == USR)
    {
        node->score = -90000000/node->level;
        return;
    }
    
    /* get score of the final step */
    if (node->level == 3)
    {
        node->score = calculate_score(newboard);
        return;
    }
    
    /* start to check score of each child */
    gametree newnode = NULL;
    gametree prenode = NULL;
    
    score = -1;
    for(i=0; i<X; i++)
    {
        for(j=0; j<Y; j++)
        {
            if( newboard[i][j] != '+' ) continue;
            
            if( is_empty(i, j) ) continue;
            
            newnode = malloc(sizeof(struct gametree));
            
            newnode->player  = SWITCH_PLAYER(node->player);
        	newnode->x       = i;
        	newnode->y       = j;
            newnode->level   = node->level + 1;
            newnode->ab      = score;
            newnode->cut     = 0;
            
        	newnode->father  = node;
        	newnode->next_sibling = NULL;
        	newnode->first_child  = NULL;
            
            newboard[i][j] = newnode->player;
            set_node_score(newboard, newnode);
            newboard[i][j] = '+';
            
            if( newnode->cut == 1 )
            {
                free(newnode);
                continue;
            }
            
            /* alpha-beta cutting */
            if (node->ab != -1)
            {
                if( (newnode->player == USR) && (newnode->score < node->ab) )
                {
                    node->cut = 1;
                    return;
                }
                
                if( (newnode->player == CPU) && (newnode->score > node->ab) )
                {
                    node->cut = 1;
                    return;
                }
            }
            
            if (prenode == NULL)
            {
                node->first_child = newnode;
                score = newnode->score;
            }
            else
            {
                prenode->next_sibling = newnode;
            }
            
            prenode = newnode;
            
            if (node->player == CPU)
                score = MIN(score, newnode->score);
            else
                score = MAX(score, newnode->score);
            
        }
    }
    
    node->score = score;
    
}

void destroy_children(gametree t)
{
    gametree c = t->first_child;
    gametree n = NULL;
    gametree temp = NULL;
    
    if(c != NULL)
    {
        n = c->next_sibling;
        while(n != NULL)
        {
            destroy_children(n);
            temp = n;
            free(temp);
            n = n->next_sibling;
        }
        
        if(c->first_child != NULL)
        {
            destroy_children(c->first_child);
        }
        
        free(c);
    }
}










