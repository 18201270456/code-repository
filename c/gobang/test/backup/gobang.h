#ifndef _GOBANG_H_
#define _GOBANG_H_

#include <stdio.h>
#include <stdlib.h>  /* system */
#include <string.h>  /* strstr strlen */

#define MAX(x,y)  (x > y ? x:y)
#define MIN(x,y)  (x < y ? x:y)
#define SWITCH_PLAYER(player)  (player == '@' ? 'O':'@')

/* (X,Y), max area of the chess board */
#define X 9
#define Y 9

/* player, CPU or USR */
#define CPU '@'
#define USR 'O'

typedef struct gametree
{
    char player; // CPU or USR
    int  x;      // position-x
    int  y;      // position-y
    int  score;  // the score can get.
    int  level;  // deep in the whole tree.
    int  cut;    // alpha-beta cutting. alpha/bata for children.
    struct gametree *father;
    struct gametree *next_sibling;
    struct gametree *first_child;
} *gametree;



#ifdef _MAIN_C_
#define EXTERN

#else
#define EXTERN extern

#endif  /* _MAIN_C */


EXTERN gametree root;
EXTERN char     chessboard[X][Y];
EXTERN char     nowplayer; /* current player */
EXTERN int      treelevel;




/* main.c */
extern void init_var();

/* chessboard.c  [chessboard drawing, etc] */
extern void init_chessboard(char board[X][Y]);
extern void refresh_chessboard(char board[X][Y]);
extern int  usr_move(char board[X][Y]);
extern char is_win(char board[X][Y]);
extern int  is_empty(int i, int j); /* lib.c */
extern char *chessboard_string(char board[X][Y]);
extern int   str_in(char *in, char *str);
extern char *str_reverse(char *str);
extern int   calculate_score(char board[X][Y]);

/* ai.c */
extern void cpu_move(char board[X][Y]);
extern void set_node_score(char board[X][Y], gametree node);





#endif  /* _GOBANG_H_ */
