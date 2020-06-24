#include "mystring.h"
void insertionSort(int *_First, int *_Last);

int main(){
    char buff[200],numbuf[20];
    char *greetMsg = "This is a Insertion sort program.\n\rplease input some number(less than 2147483647)\n\r";
    char *errMsg = "your input is not valid!\n\r";
    char *exitMsg = "Press any key to exit..";
    print_c(greetMsg,0x0B);
    int cnt = 20;
    int num[cnt];
    int strHead=0,strTail = 0,j;
    while (1){
        readbuff(buff, 200);
        while(' ' == buff[strHead]){
            strHead++;
        }
        if(0 == buff[strHead])
            continue;
        break;
    }
    for (int i = 0; i < strlen(buff); i++)
    {
        if (!isdigit(buff[i]) && buff[i] != ' '){
            puts(errMsg);
            puts(exitMsg);
            syscall_getch();
            return 0;
        }
    }
    
    for (int i = 0; i < cnt; i++,j=0)
    {
        j = 0;
        strTail = strHead;
        while('\0'!=buff[strTail]&&' ' != buff[strTail]){
            strTail++;
        }
        for (j = 0; j < strTail-strHead; j++)
        {
            numbuf[j] = buff[strHead + j];
        }
        numbuf[j] = '\0';

        num[i] = atoi(numbuf);
        if ('\0'==buff[strTail]){
            cnt = i+1;
            break;        
        }
        while(buff[++strTail]==' ')
            ;
        strHead=strTail;
    }
    insertionSort(num, num + cnt);
    for (int i = 0; i < cnt; i++)
    {
        putnum(num[i], 10);
        syscall_putchar(' ');
    }
    syscall_putchar('\n');
    syscall_putchar('\r');
    puts(exitMsg);
    syscall_getch();
}
