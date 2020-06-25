#include "./lib/process.h"
#define MAX_BUFLEN 30
extern void loadUsrProgram(const struct sector *);
extern void runUsrProgram(const struct sector *);
extern void setTimeIV();
extern void setDateIV();
extern void kernelInit();

int prev_multproc=0;

void shell()
{
    int usrprogNum = sizeof(Comlist) / sizeof(struct sector);
    enum commandEnum
    {
        Help,
        Cls,
        Shutdown,
        Run,
        Bat,
        List
    };
    char userbuff[MAX_BUFLEN] = {0};
    char command[MAX_BUFLEN] = {0};
    char target[MAX_BUFLEN] = {0};
    char *emptystr = "\0";
    char *mul_proc_msg = "all processes were killed.";
    char *commands[] = {"help", "cls", "shutdown", "run", "bat", "ls"};
    cls();
    printInfo();
    while (1)
    {
        kernelInit();
        prompt();
        readbuff(userbuff, MAX_BUFLEN);
        if(prev_multproc==1){
            cls();
            puts(mul_proc_msg);
            newline;
            setDateIV();
            prev_multproc = 0;
        }
        if (strcmp(userbuff, emptystr) == 0)
        {
            continue;
        }
        if (strcmp(userbuff, commands[Shutdown]) == 0)
        {
            shutdown();
        }
        else if (strcmp(userbuff, commands[Cls]) == 0)
        {
            cls();
        }
        else if (strcmp(userbuff, commands[Help]) == 0)
        {
            printInfo();
        }
        else if (strcmp(userbuff, commands[List]) == 0)
        {
            puts(ComlistTitle);
            newline;
            for (int i = 0; i < usrprogNum; i++)
            {
                printDetail(Comlist[i]);
                newline;
            }
        }
        else
        {
            split(userbuff, command, target);
            if (strcmp(command, commands[Bat]) == 0)
            {
                int valid = target[0] != '\0' && checknum(target, usrprogNum);
                if (valid)
                {
                    for (int i = 0, len = strlen(target); i < len; i++)
                    {
                        int pid = target[i] - '0' - 1;
                        loadUsrProgram(&Comlist[pid]);
                        setTimeIV();
                        runUsrProgram(&Comlist[pid]);
                        cls();
                    }
                }
            }
            else if (strcmp(command, commands[Run]) == 0)
            {
                pcb_init();
                int valid = target[0] != '\0' && checknum(target, usrprogNum);
                if (valid)
                {
                    for (int i = 0, len = strlen(target); i < len; i++)
                    {
                        int pid = target[i] - '0' - 1;
                        loadUsrProgram(&Comlist[pid]);
                        create_proc(&Comlist[pid]);
                    }
                }
                timeFlag = 1;
                setTimeIV();
                prev_multproc = 1;
            }
            else
            {
                char *error_msg = "Bad command.Please try other.Key in \"help\" for help\r\n";
                puts(error_msg);
            }
        }
    }
}
