/*程序源代码（upper.c）*/
#ifndef _MYSTRING_H_
#define _MYSTRING_H_

#include <stdint.h>
extern void cls();
extern void shutdown();
extern void putchar(char c);
extern void printPos(char *str, int n, uint8_t row, uint8_t col);
extern char getch();
int strlen(char *str)
{
	int cnt = 0;
	while (str[cnt++])
		;
	return cnt - 1;
}

void print(char *str)
{
	for (int i = 0, length = strlen(str); i < length; i++)
	{
		putchar(str[i]);
	}
}


void printchar(char c,int n){
    for (int i = 0; i < n; i++)
    {
        putchar(c);
    }
    
}

char* itoa(int num, int base) {
	static char buf[32] = {0};
	if(num==0) return "0";
	int i = 30;
	for(; num && i ; --i, num /= base) {
		buf[i] = "0123456789ABCDEF"[num % base];
    }
	return &buf[i+1];
}

void putnum(int num,int base){
    print(itoa(num,base));
}

int isnum(char c){
	    return c>='0' && c<='9';
}

int checknum(char* str,int max){
	int isNum=1;
	for (int i = 0, length = strlen(str); i < length; i++)
	{
		if(!isnum(str[i])){
			isNum = 0;
			break;
		}
		else
		{
			if(str[i]-'0' > max){
				isNum = 0;
				break;
			}
		}
		
	}
	return isNum;
}

int find(char *buff, int len, char c){
	if (buff[len] != '\0')
		return 0;
	int i = 0;
	while (i < len && buff[i++] != c)
		;
	return i - 1;
}

void split(char*buff,char*dest1,char*dest2){
	dest2[0] = '\0';
	int len = strlen(buff);
	int n = find(buff, len, ' ');
	if(n==len-1)
		n = len;
	int i;
	for (i = 0; i < n; i++)
	{
		dest1[i] = buff[i];
	}
	dest1[i] = '\0';
	while (buff[i]&&buff[i]==' ')
	{
		i++;
	}
	int j = 0;
	while(buff[i]){
		dest2[j++] = buff[i++];
	}
	dest2[j] = '\0';
}

int strcmp(char *lhs, char *rhs)
{
	int i = 0;
	while (1)
	{
		if (lhs[i] == '\0' || rhs[i] == '\0')
			break;
		if (lhs[i] != rhs[i])
			break;
		++i;
	}
	return lhs[i] - rhs[i];
}

#endif