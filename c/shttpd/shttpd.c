




int main(int argc, char *argv[])
{
    signal(SIGINT, sig_int);
    Para_Init(argc, argv);
    int s = do_listen();
    Worker_ScheduleRun(s);

    return 0;
}


static void sig_int(int num)
{
    Worker_ScheduleStop();
    return;
}
