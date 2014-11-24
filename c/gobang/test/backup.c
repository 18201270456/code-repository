#include "gobang.h"


void cpu_move(board[X][Y])
{
    char nowboard[X][Y] = board[X][Y];
    build_gametree(gt, nowboard[X][Y], nowplayer);
    
    int move_x, move_y;
    get_best_move(gt, bestmove);
    
    board[bestmove[0]][bestmove[1]] = CPU;
}

//doing
int get_best_move(gametree gt, int move[])
{
}


/*
 * DESCRIPTION
 *    build child trees for gametree father. 
 *    supposebly move only one step as 'childplayer'
 *
*/
void build_child_trees(gametree father, board[X][Y], char childplayer)
{
    int i, j, cpuscore, usrscore;
    char nowboard[X][Y] = board[X][Y]; 
    
    for(i=0; i<X; i++)
    {
        for(j=0; j<Y; j++)
        {
            if( is_empty(i, j) ) continue;
            if( board[i][j] != '+' ) continue;
            
            gametree newnode = malloc(sizeof(gametree));
            newnode->player  = childplayer;
	        newnode->x       = i;
	        newnode->y       = j;
	        newnode->parent  = father;
	        newnode->next_sibling = NULL;
	        newnode->first_child  = NULL;
            
            //start calculate score when move 1 step.
            nowboard[i][j] = childplayer;
            
            cpuscore = calculate_score(nowboard, childplayer);
            usrscore = calculate_score(nowboard, SWITCH_PLAYER(childplayer));
            
            if (childplayer == CPU)
            {
	            newnode->score   = cpuscore - usrscore;
            }
            else
            {
	            newnode->score   = usrscore - cpuscore;
            }
            
            insert_as_child(father, newnode);
            
            nowboard[i][j] = '+';
        }
    }
}


/*
 * DESCRIPTION
 *    insert gametree newnode to father as child.
 *    if newnode score bigger than anyone of the existing childs, replace it.
 *
*/
void insert_as_child(gametree father, gametree newnode)
{
    int n = 0;
    
    newnode->parent       = father;
    newnode->next_sibling = NULL;
    newnode->first_child  = NULL;
    
    gametree c = malloc(sizeof(gametree));
    c = father->first_child;
    
    if(c == NULL)
    {
        father->first_child = newnode;
        return;
    }
    
    while (c != NULL)
    {
        n++;
        
        //TO DO: n > 7, replace; n<=7, insert;
        if (n > 7) break;
        
        if(c->score < newnode->score)
        {
            newnode->next_sibling = c->next_sibling;
            
            if(n == 1)
            {
                father->first_child = newnode;
            }
            else
            {
                c = father->first_child;
                
                while(n > 2)
                {
                    c = c->next_sibling;
                    n--;
                }
                
                c->next = newnode;
            }
            
            break;
        }
        
        c = c->next_sibling;
    }
 
}


//build all whole gametree.
void build_gametree_backup(gametree t, board[X][Y], char player)
{
    int i, j;
    
    char nowboard[X][Y] = board[X][Y];
    
    if (t->first_child == NULL)
    {
        build_child_trees(t, nowboard, player);
        
        gametree n = t->first_child;
        i = n->x;
        j = n->y;
        nowboard[i][j] = player;
        
        build_gametree(n, nowboard, SWITCH_PLAYER(player));
    }
    
    gametree n = t->next_sibling;
    
    while(n != NULL)
    {
        treelevel = 0;
        
        build_gametree(n, board[X][Y], playermark);
        
        n = n->next_sibling;
    }
    
}




typedef struct treelayer
{
    struct gametree   *node;
    struct treelayer  *next;
} *layer;


layer layer_init()
{
    layer ly = malloc(sizeof(layer));
    
    ly->node = NULL;
    ly->next = NULL;
    
    return ly;
}

void layer_add(layer ly, gametree node)
{
    layer newnode = malloc(sizeof(layer));
    newnode->node = node;
    newnode->next = NULL;
    
    if (ly->node = NULL)
    {
        ly->node = node;
        ly->next = NULL;
    }
    else
    {
	    while( ly->next != NULL )
	    {
            ly = ly->next;
	    }
        
        ly->next = newnode;
    }
}


layer get_child_layer(layer ly)
{
    layer child_layer = layer_init();
    
    while(ly != NULL)
    {
        gametree c = ly->node->first_child;
        
        while(c != NULL)
        {
            layer_add(child_layer, c);
            c = c->next_sibling;
        }
        
        ly = ly->next;
    }
    
    return child_layer;
}

layer build_child_gametree_by_layer(layer ly)
{
    int  x, y;
    char nowboard[X][Y] = chessboard[X][Y];
    
    gametree t = malloc(sizeof(gametree));
    
    while(ly->node != NULL)
    {
        t = ly->node;
        
        nowboard[X][Y] = chessboard[X][Y];
        
        while(t->parent != NULL)
        {
            nowboard[t->x][t->y] = t->player;
            t = t->parent;
        }
        
        t = ly->node;
        
        build_child_trees(t, nowboard, SWITCH_PLAYER(t->player));
        
        ly = ly->next;
    }
    
    layer child_layer = get_child_layer(ly);
    
    return child_layer;
}



gametree build_gametree(int deep)
{
    layer alayer = layer_init();
    alayer->node = root;
    
    layer blayer = layer_init();
    
    while(deep-- > 0)
    {
        blayer = build_child_gametree_by_layer(alayer)
        alayer = blayer;
    }
    
    gametree t;
    int score = 0;
    
    while(blayer->next != NULL)
    {
        t = blayer->node;
        
    }
    
}

void traverse_gametree_by_layer(int deep)
{
    layer parentlayer = malloc(sizeof(layer));
    layer_init(parentlayer);
    layer_push(parentlayer, root);
    
    int i;
    for(i=0; i<=level; i++)
    {
        layer childlayer = malloc(sizeof(layer));
        layer_init(childlayer);
        
        childlayer = nextlayer(parentlayer);
        parentlayer = childlayer;
    }
    
}




void insert_gametree(gametree t, int i, int j, int score)
{
    int m = 0;
    int n = 0;
    
    gametree c = malloc(sizeof(gametree));
    c = t->first_child;
    
    if(c == NULL)
    {
        gametree newnode = malloc(sizeof(gametree));
        newnode->move[0] = i;
        newnode->move[1] = j;
        newnode->score   = score;
        newnode->parent  = t;
        newnode->next_sibling = c->next_sibling;
        newnode->first_child  = NULL;
        
        t->first_child = newnode;
        
        return;
    }
    
    while (c != NULL)
    {
        n++;
        
        if(c->score < score)
        {
            gametree newnode = malloc(sizeof(gametree));
            newnode->move[0] = i;
            newnode->move[1] = j;
            newnode->score   = score;
            newnode->parent  = t;
            newnode->next_sibling = c->next_sibling;
            newnode->first_child  = NULL;
            
            if(n == 1)
            {
                t->first_child = newnode;
            }
            else
            {
                c = t->first_child;
                
                while(n > 2)
                {
                    c = c->next;
                    n--;
                }
                
                c->next = newnode;
            }
            
            break;
        }
        c = c->next_sibling;
    }
    
}





























