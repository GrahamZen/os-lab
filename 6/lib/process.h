#include "interface.h"
#define SCHEDULE_QUEUE_LEN 10
#define NEW 0
#define RUNNING 1

#include <stdint.h>

extern uint16_t current_process_id,timeFlag;

enum PCB_STATE {P_NEW, P_READY, P_RUNNING, P_BLOCKED, P_EXIT};

typedef struct RegisterImage{
	uint16_t ax;     // 0
	uint16_t cx;     // 2
	uint16_t dx;     // 4
	uint16_t bx;     // 6
	uint16_t sp;     // 8
	uint16_t bp;     // 10
	uint16_t si;     // 12
	uint16_t di;     // 14
	uint16_t ds;     // 16
	uint16_t es;     // 18
	uint16_t fs;     // 20
	uint16_t gs;     // 22
	uint16_t ss;     // 24
	uint16_t ip;     // 26
	uint16_t cs;     // 28
	uint16_t flags;  // 30
	int pid;
	int state;
} RegisterImage;


RegisterImage q[SCHEDULE_QUEUE_LEN];
RegisterImage KernalContext,TimeContext;

RegisterImage* getRegisterImage(){
    return &KernalContext;
}
RegisterImage* getTimeRegisterImage(){
	if(timeFlag==0)
	    return &TimeContext;
	else
	    return &q[current_process_id];
}

void pcb_init() {
	for(int i = 0; i < SCHEDULE_QUEUE_LEN; i++) {
		q[i].pid = i;
		q[i].state = 0;
		q[i].ax = 0;
		q[i].cx = 0;
		q[i].dx = 0;
		q[i].bx = 0;
		q[i].sp = 0xffff;
		q[i].bp = 0;
		q[i].si = 0;
		q[i].di = 0;
		q[i].ds = 0;
		q[i].es = 0;
		q[i].fs = 0;
		q[i].gs = 0xB800;
		q[i].ss = 0;
		q[i].ip = 0x100;
		q[i].cs = 0;
		q[i].flags = 512;
	}
}


void create_proc(){
	
}

//前置条件：timeFlag=1
void schedule() {
	uint16_t previous_id = current_process_id;
	getTimeRegisterImage()->state = P_READY;
	do {
		current_process_id++;
		if(current_process_id >= SCHEDULE_QUEUE_LEN) current_process_id = 1;
	} while(getTimeRegisterImage()->state != P_READY);
	getTimeRegisterImage()->state = P_RUNNING;

	// 没有发现其它处于就绪态的进程，返回内核
	// if(current_process_id == previous_id) {
	// 	goBackToKernel();
	// }
}
