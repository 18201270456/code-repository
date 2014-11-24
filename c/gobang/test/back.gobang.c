#include <stdio.h>

#define WIDTH 9
#define HIGHT 9

#define WHITE 0
#define BLACK 1

#define WIN 2

char map[HIGHT][WIDTH];
int player = BLACK;

void init_map(int h, int w, char map[][WIDTH]);
void draw_map(char map[][WIDTH]);
int play_game(int player, char map[][WIDTH]);
int is_win(int player, char map[][WIDTH]);

int main()
{
    int ret;
    int i;
    init_map(HIGHT, WIDTH, map);
    draw_map(map);
    for (i = 0; i < 225; i++)
    {
        if (player == BLACK)
        {
            printf("please black play:\n");
            player = WHITE;
        }
        else
        {
            printf("please white play:\n");
            player = BLACK;
        }
        ret = play_game(player, map);
        draw_map(map);
        if (!ret)
            break;
        if (ret == WIN)

        {
            if (player == WHITE)

            {
                printf("BLACK is winner.\n");
            }

            else

            {
                printf("WHITE is winner.\n");
            }
            break;
        }
    }
    printf("game over.\n");
}

int play_game(int player, char map[][WIDTH])
{
    int x, y;
    scanf("%d,%d", &x, &y);
    if (x < 0 || y < 0 || x > HIGHT || y > WIDTH)
    {
        printf("error!\n");
        return 0;
    }
    x--;
    y--;
    if (map[x][y] == '+')
    {
        if (player == WHITE)
        {
            map[x][y] = '@';
        }
        if (player == BLACK)
        {
            map[x][y] = 'O';
        }
    }
    else
    {
        printf("error!\n");
        return 0;
    }
    if (is_win(player, map))

    {
        return WIN;
    }
    return 1;
}

int is_win(int player, char map[][WIDTH])
{
    char m;
    int i, j;
    
    if (player == WHITE)
        m = '@';
    else
        m = 'O';
    
    for (i = 0; i < HIGHT; i++)
    {
        for (j = 0; j < WIDTH; j++)
        {
            if (map[i][j] == m)
            {
                if ((i + 4) < HIGHT)
                {
                    if (map[i + 1][j] == m && map[i + 2][j] == m
                        && map[i + 3][j] == m && map[i + 4][j] == m)
                        return 1;
                }
                if ((j + 4) < WIDTH)
                {
                    if (map[i][j + 1] == m && map[i][j + 2] == m
                        && map[i][j + 3] == m && map[i][j + 4] == m)
                        return 1;
                }
                if ((i + 4) < HIGHT && (j + 4) < WIDTH)
                {
                    if (map[i + 1][j + 1] == m && map[i + 2][j + 2] == m
                        && map[i + 3][j + 3] == m
                        && map[i + 4][j + 4] == m)
                        return 1;
                }
                if ((i + 4) < HIGHT && (j - 4) >= 0)
                {
                    if (map[i + 1][j - 1] == m && map[i + 2][j - 2] == m
                        && map[i + 3][j - 3] == m
                        && map[i + 4][j - 4] == m)
                        return 1;
                }
            }
        }
    }
    return 0;
}

void init_map(int h, int w, char map[][WIDTH])
{
    int i = 0;
    int j = 0;
    for (i = 0; i < HIGHT; i++)
    {
        for (j = 0; j < WIDTH; j++)
        {
            map[i][j] = '+';
        }
    }
}

void draw_map(char map[][WIDTH])
{
    int i, j;
    system("clear");
    for (i = 0; i < HIGHT; i++)
    {
        if (i == 0)
        {
            putchar(' ');
            for (j = 0; j < WIDTH; j++)
            {
                putchar(' ');
                printf("%x", j+1);
            }
            printf("\n");
        }
        
        printf("%x", i+1);
        
        for (j = 0; j < WIDTH; j++)
        {
            putchar(' ');
            putchar(map[i][j]);
        }
        putchar('\n');
    }
}
