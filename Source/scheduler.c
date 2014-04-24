#include "scheduler.h"

void sch_init()
{
  //InitSysTick();
  //InitTimer2();
}



  /*
//************************************************** ****
//Timer2 Prescaler :39; Preload = 59999; Actual Interrupt Time = 50 ms
void InitTimer2(){
  RCC_APB1ENR.TIM2EN = 1;
  TIM2_CR1.CEN = 0;
  TIM2_PSC = 39;
  TIM2_ARR = 59999;
  NVIC_IntEnable(IVT_INT_TIM2);
  TIM2_DIER.UIE = 1;
  TIM2_CR1.CEN = 1;
}

//************************************************** ****
// timer, once every 50mS
void Timer2_interrupt() iv IVT_INT_TIM2
{
  asm nop
}   */