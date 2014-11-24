#include <sys/sem.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    int semid;
    semid = semget(IPC_PRIVATE, 1, 0666);

    if (semid < 0)
    {
        perror("semget");
        exit(1);
    }

    printf("successfully created a semaphore: %d\n", semid);

    system("ipcs");

    if( semctl(semid, 0, IPC_RMID) < 0 )
    {
        perror("semctl");
        exit(1);
    }else
    {
        printf("semaphore removed. \n");
        system("ipcs");
    }

    return 0;
}
