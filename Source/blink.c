#include "blink.h"

void blink_init()
{
  GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_10);   // LED pin
  //GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_ALL); // Set PORTA as digital output
}

void blink_led()                                      //function to blink the LED at ~1hz
{
  GPIOC_ODR ^= _GPIO_PINMASK_9;
  return;
}