/*程序源代码（upper.c）*/
extern void cls();
extern void putchar(char c);
extern void printPos(char *str, int n, int row, int col);
char *msg = "wodemsg1";
int strlen(char *str)
{
	int cnt = 0;
	while (str[cnt++] != '\0')
		;
	return cnt-1;
}
void printInfo()
{
	cls();
	char *Info = "wodeinfo";
	putchar(strlen(Info)+ '0');
	printPos(Info, strlen(Info), 6, 23);
	printPos(msg, strlen(msg), 9, 23);
}

void printmsg(){
	int row = 9, col=23;
	printPos(msg, strlen(msg), row, col);
}