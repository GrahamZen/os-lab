#ifndef _MYSTRING_H_
#define _MYSTRING_H_

#include <stdint.h>
#define isdigit(c) ((c) >= '0' && (c) <= '9')
extern void syscall_putchar(const char c);
extern void syscall_putchar_c(const char c,const uint8_t color);
extern char syscall_getch();

int strlen(const char *str);
void puts(const char *str);
void putnchar(const char c,int n);
char* itoa(int num, int base); 
void putnum(const int num,int base);
int isnum(const char c);
int checknum(const char* str,int max);
int find(const char *buff, int len, char c);
void split(const char*buff,char*dest1,char*dest2);
int strcmp(const char *lhs,const char *rhs);
char *strcat(char *dest, const char *src);
void strAppend(char*str,const char c);
uint8_t bcd2dec(const uint8_t bcd);
void readbuff(char *buff, int maxLength);
int atoi(char *str);
void print_c(const char *str, uint8_t color);
#endif