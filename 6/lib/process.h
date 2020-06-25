#include "interface.h"
#define SCHEDULE_QUEUE_LEN 10
#define NEW 0
#define RUNNING 1

#include <stdint.h>

uint16_t curr_proc_id=0,timeFlag=0;

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
	    return &q[curr_proc_id];
}

void pcb_init() {
	for(int i = 0; i < SCHEDULE_QUEUE_LEN; i++) {
		q[i].pid = i;
		q[i].state = P_NEW;
		q[i].ax = 0;
		q[i].cx = 0;
		q[i].dx = 0;
		q[i].bx = 0;
		q[i].sp = 0xff00;
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


void create_proc(const struct sector *target){
	int id = target->pid;
	q[id].pid = id;
	// q[id].sp = 0xff00;
	q[id].ds = target->seg;
	q[id].es = target->seg;
	q[id].fs = target->seg;
	q[id].gs = 0xB800;
	q[id].ss = target->seg;
	q[id].ip = 0x100;
	q[id].cs = target->seg;
	q[id].flags = 512;
	q[id].state = P_READY;
}

//前置条件：timeFlag=1
void schedule() {
	uint16_t prev_id = curr_proc_id;
	getTimeRegisterImage()->state = P_READY;
	do {
		curr_proc_id++;
		if(curr_proc_id >= SCHEDULE_QUEUE_LEN) curr_proc_id = 1;
	} while(getTimeRegisterImage()->state != P_READY);
	getTimeRegisterImage()->state = P_RUNNING;

}

void goBackKernel(){
	if(timeFlag==1){
		q[curr_proc_id].state = P_EXIT;
		int8();
	}
	return;
}
