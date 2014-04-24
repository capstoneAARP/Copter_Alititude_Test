#line 1 "C:/Users/Prometheus/Documents/GitHub/Copter_Alititude_Test/Source/blink.c"
#line 1 "c:/users/prometheus/documents/github/copter_alititude_test/header/blink.h"




void blink_init();
void blink_led();
#line 3 "C:/Users/Prometheus/Documents/GitHub/Copter_Alititude_Test/Source/blink.c"
void blink_init()
{
 GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_10);

}

void blink_led()
{
 GPIOC_ODR ^= _GPIO_PINMASK_9;
 return;
}
