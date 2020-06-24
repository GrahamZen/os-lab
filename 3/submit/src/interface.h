#include "mystring.h"
#define OffsetOfUserPrg1 0x0A100
#define OffsetOfUserPrg2 0x0A300
#define OffsetOfUserPrg3 0x0A700
#define OffsetOfUserPrg4 0x0AB00
#define newline putchar('\r');putchar('\n')
int SizeofSector = 512;
char *ComlistTitle = "pid name cylinder head sector len  addr";
struct sector
{
    int pid;
    char name[20];
    int cylinder;
    int head;
    int sector;
    int len;
    int addr;
};

const struct sector Comlist[] = {
//  pid   name   柱面号  磁头号 起始扇区号 扇区数   起始扇区号
{    1, "LU.com",  0,      1,      1,      2, OffsetOfUserPrg1},
{    2, "LD.com",  0,      1,      3,      2, OffsetOfUserPrg2},
{    3, "RU.com",  0,      1,      5,      2, OffsetOfUserPrg3},
{    4, "RD.com",  0,      1,      7,      2, OffsetOfUserPrg4}
};

void readbuff(char *buff, int maxLength)
{
	if (!buff)
		return;
	int len = 0;
    while(1) {
        char c = getch();
        if(!(c==0xD || c=='\b' ||c==3|| c>=32 && c<=127)) { continue; }  
        if(c==0x0D){
            break;
        }
        else if(c==3){
            len = 0;
            break;
        }
        if(len > 0 && len < maxLength-1) { 
			if(c == '\b') {  
                putchar('\b');
                putchar(' ');
                putchar('\b');
                --len;
            }
            else{
                putchar(c);  
                buff[len] = c;
                ++len;
            }
        }
        else if(len >= maxLength-1) {  
            if(c == '\b') {  
                putchar('\b');
                putchar(' ');
                putchar('\b');
                --len;
            }
        }
        else{  
			if(c != '\b') {
                putchar(c);  
                buff[len] = c;
                ++len;
            }
        }
    }
    putchar('\r'); putchar('\n');
    buff[len] = '\0';  
}

//calculate position of Col
int middleCol(int len){
    int colMax = 80;
    return (colMax - len) / 2;
}

//print string to middle of screen
void printMiddle(char*str, int row){
    int len = strlen(str);
    int col = middleCol(len);
    printPos(str, len, row, col);
}

void Greet()
{
    cls();
    char* title = "17338233 OS";
    char* hint = "Press Enter to go on";
    char* author = "ZhengGeHan 17338233";
    char* date = "2020.5.13";
    printMiddle(title, 10);
    printMiddle(author, 12);
    printMiddle(date, 14);
    printMiddle(hint, 20);
}
void prompt(){
    char *str = "->";
    print(str);
}
void printInfo(){
    char *str = 
    "List of commands:\n\r"
    "\r\n"
    "    help -- Show information about builtin commands\r\n"
    "    cls -- Clear the terminal screen\r\n"
    "    ls -- Show a list of user programmes' information\r\n"
    "    run <arg> -- Run user programmes in sequence,\r\n"
    "        spaces between pid is prohibited. e.g. `run 134`\r\n"
    "    shutdown -- Force shutdown the machine\r\n"
    "    ctrl-c -- interrput current input\r\n"
    ;
    print(str);
}

void printDetail(struct sector Com){
    putnum(Com.pid,10);
    printchar(' ',2);
    print(Com.name);
    printchar(' ',3);
    putnum(Com.cylinder,10);
    printchar(' ',6);
    putnum(Com.head,10);
    printchar(' ',5);
    putnum(Com.sector,10);
    printchar(' ',4);
    putnum(Com.len*SizeofSector,10);
    putchar(' ');
    putnum(Com.addr,16);
}
