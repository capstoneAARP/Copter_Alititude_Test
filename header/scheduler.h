#ifndef SCHEDULER_H_
#define SCHEDULER_H_
#define NUM_FUNC 1


extern int current_func;                                 // initialize to first function
extern int func_flag;                                    // start with the LED pin off
extern unsigned int service_time[];                  // keep track of the seperate function time
extern unsigned long mstime;                                 // mS count

void sch_init();
//InitSysTick();
//SysTick_ISR();
void InitTimer2();
void Timer2_interrupt();

#endif  // SCHEDULER_H_