/*程序源代码（upper.c）*/
#include "mystring.h"

int strlen(const char *str)
{
	int cnt = 0;
	while (str[cnt++])
		;
	return cnt - 1;
}

void puts(const char *str)
{
	for (int i = 0, length = strlen(str); i < length; i++)
	{
		syscall_putchar(str[i]);
	}
}

void print_c(const char* str, uint8_t color) {
    for(int i = 0, len = strlen(str); i < len; i++) {
        syscall_putchar_c(str[i], color);
    }
}

void putnchar(const char c,int n){
    for (int i = 0; i < n; i++)
    {
        syscall_putchar(c);
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

void putnum(const int num,int base){
    puts(itoa(num,base));
}

int isnum(const char c){
	    return c>='0' && c<='9';
}

int checknum(const char* str,int max){
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

int find(const char *buff, int len, char c){
	if (buff[len] != '\0')
		return 0;
	int i = 0;
	while (i < len && buff[i++] != c)
		;
	return i - 1;
}

void split(const char*buff,char*dest1,char*dest2){
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

int strcmp(const char *lhs,const char *rhs)
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
char *strcat(char *dest, const char *src)
{
    char *tmp = dest;

    while (*dest)
        dest++;
    while ((*dest++ = *src++) != '\0');
    return tmp;
}
void strAppend(char*str,const char c){
	int len = strlen(str);
	str[len] = c;
	str[len + 1] = '\0';
}
uint8_t bcd2dec(const uint8_t bcd)
{
    return ((bcd & 0xF0) >> 4) * 10 + (bcd & 0x0F);
}
void readbuff(char *buff, int maxLength)
{
	if (!buff)
		return;
	int len = 0;
    while(1) {
        char c = syscall_getch();
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
                syscall_putchar('\b');
                syscall_putchar(' ');
                syscall_putchar('\b');
                --len;
            }
            else{
                syscall_putchar(c);  
                buff[len] = c;
                ++len;
            }
        }
        else if(len >= maxLength-1) {  
            if(c == '\b') {  
                syscall_putchar('\b');
                syscall_putchar(' ');
                syscall_putchar('\b');
                --len;
            }
        }
        else{  
			if(c != '\b') {
                syscall_putchar(c);  
                buff[len] = c;
                ++len;
            }
        }
    }
    syscall_putchar('\r'); syscall_putchar('\n');
    buff[len] = '\0';  
}

int atoi(char* str) {
    int negative = 0;
    long long ret = 0;
    if(0 == str)
        return 0;
    while(' ' == (*str))
        str++;
    if(0 == *str)
        return 0;
    negative = (*str == '-') ? 1 : 0;
    if(!isdigit(*str))
        return 0;
    while(isdigit(*str))
    {
        ret = ret*10 + *str -'0';

        if(ret > (negative?-(long long )INT32_MIN:INT32_MAX))
            return negative?INT32_MIN:INT32_MAX;
        str++;
    }
    return negative?-ret:ret;
}

void insertionSort(int* _First, int* _Last)
{
	if (_First == _Last)
		return;
	for (int* iter = _First + 1; iter != _Last; ++iter)
	{
		int tmp = *iter;
		int* iter2;
		for (iter2 = iter; iter2 != _First && (tmp < *(iter2 - 1)); --iter2)
		{
			*(iter2) =*(iter2 - 1);
		}
		*iter2 = tmp;
	}
}