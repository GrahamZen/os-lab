BITS 16
extern save
global int20

int20:
    add sp, 6 ;ip(before int), cs,flags(pushf),afterRun,cs
    retf
