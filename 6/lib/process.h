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

void create_proc(){
	
}

RegisterImage* getRegisterImage(){
    return &KernalContext;
}
RegisterImage* getTimeRegisterImage(){
	if(timeFlag==0)
	    return &TimeContext;
	else
	    return &q[current_process_id];
}

void pcbSchedule() {
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
