#line 1 "C:/Users/Brian Campuzano/Documents/GitHub/Copter_Alititude_Test/Source/FlightControl.c"
#line 1 "c:/users/brian campuzano/documents/github/copter_alititude_test/header/flightcontrol.h"
#line 1 "c:/users/brian campuzano/documents/github/copter_alititude_test/header/stdtypes.h"



typedef unsigned char uint8;
typedef signed char int8;
typedef unsigned int uint16;
typedef signed int int16;
typedef unsigned long uint32;
typedef signed long int32;
typedef unsigned long long uint64;
typedef signed long long int64;

typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long uint32_t;

typedef unsigned char boolean;







typedef enum
{
 NORTH = 0,
 SOUTH,
 EAST,
 WEST,
 MAX_DIRECTION
} direction;

typedef enum
{
 BEACON_MODE = 0,
 OBSTACLE_MODE,
 ALL_STOP_MODE,
 FOUND_THAT_SHIT_MODE,
 MAX_MODE
} mode;
#line 40 "c:/users/brian campuzano/documents/github/copter_alititude_test/header/flightcontrol.h"
void Flight_Control_Init();
void Init_LED();
void Init_ADC();
void Init_Pwm();
void Arm();
void DisArm();
boolean TakeOff();
void LoiterMode();
void StabilizeMode();
void LandingMode();
void Yaw_Left(uint16 timeToYaw_ms);
void Yaw_Right(uint16 timeToYaw_ms);
void Yaw_Stop();
void Land();
void Forward_Flight();
void Stop_Forward();
uint16 alitudeSonarRead();
void Stabilize_Alt();
#line 1 "c:/users/brian campuzano/documents/github/copter_alititude_test/header/stdtypes.h"
#line 1 "c:/users/brian campuzano/documents/github/copter_alititude_test/header/uart.h"
#line 1 "c:/users/brian campuzano/documents/github/copter_alititude_test/header/stdtypes.h"
#line 6 "c:/users/brian campuzano/documents/github/copter_alititude_test/header/uart.h"
void UARTDebugInit();

void UARTSendString(uint8 * stringToSend);

void UARTSendChar(uint8 charToSend);

void UARTSendNewLine(void);

void UARTSendUint16(uint16 dataToSend);

void UARTSendDouble(double dataToSend);
#line 6 "C:/Users/Brian Campuzano/Documents/GitHub/Copter_Alititude_Test/Source/FlightControl.c"
float pwm_period1, pwm_period2;
float current_DC = 7.4;
float current_DC_2 = 5.0;
float current_DC_3 = 5.5;
float current_DC_4 = 9.9;
float current_DC_8 = 9.5;
float current_DC_9 = 8.3;
float current_DC_7 = 7.4;
uint16 DC_time, DC_time_2, DC_time_3;

void Flight_Control_Init()
{
 Init_ADC();
 Init_Pwm();
 Init_LED();
}

void Init_LED(){
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_8 | _GPIO_PINMASK_9);
 GPIOC_ODR.B8 = 0;
 GPIOC_ODR.B9 = 0;
 Delay_ms(250);
 GPIOC_ODR.B8 = 1;
}

void Init_ADC(){

 ADC_Set_Input_Channel(_ADC_CHANNEL_13);
 ADC1_Init();
 Delay_ms(100);
}

void Init_Pwm(){

 pwm_period1 = PWM_TIM3_Init(49);
 pwm_period2 = PWM_TIM2_Init(49);

 DC_time = (current_DC*pwm_period2)/100;
 DC_time_2 = (current_DC_2*pwm_period2)/100;
 DC_time_3 = (current_DC_2*pwm_period2)/100;


 PWM_TIM2_Set_Duty(DC_time_2, _PWM_NON_INVERTED, _PWM_CHANNEL1);
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL4);
 PWM_TIM3_Set_Duty(DC_time_3, _PWM_NON_INVERTED, _PWM_CHANNEL1);

 PWM_TIM2_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM2_CH1_PA0);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 PWM_TIM2_Start(_PWM_CHANNEL3, &_GPIO_MODULE_TIM2_CH3_PA2);
 PWM_TIM2_Start(_PWM_CHANNEL4, &_GPIO_MODULE_TIM2_CH4_PA3);
 PWM_TIM3_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM3_CH1_PA6);
}

void Arm(){

 DC_time = (current_DC_2*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);


 DC_time = (current_DC_4*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 delay_ms(5000);

 DC_time = (current_DC*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 Delay_ms(6000);

}

void Throttle_Off(){
 current_DC_2 = 5.0;
 DC_time = (current_DC_2*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

void DisArm(){

 Throttle_Off();

 Delay_ms(1000);

 DC_time = (current_DC_2*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 Delay_ms(3000);


 DC_time = (current_DC*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 Delay_ms(2000);
}

boolean TakeOff()
{
 uint16 sonarReadValue;
 current_DC_3 =  5.8 ;
 UARTSendString("Taking off7.");
 while(current_DC_3 <  6.7 ){
 current_DC_3 +=  0.05 ;

 DC_time = (current_DC_3*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);

 if(current_DC_3 >=  6.5 )
 {
 sonarReadValue = alitudeSonarRead();
 UARTSendString("Sonar average.");
 UARTSendUint16(sonarReadValue);
 UARTSendNewLine();
 UARTSendString("Throttle");
 UARTSendDouble(current_DC_3);


 if (sonarReadValue <=  12  && current_DC_3 >=  6.7 )
 {
 UARTSendString("Failed to reach altitude.");
 Throttle_Off();
 GPIOC_ODR.B9 = 0;
 return  1 ;
 }
 if (current_DC_3 >=  6.7 )
 {
 UARTSendString("Max Throttle.");
 GPIOC_ODR.B9 = 1;
 return  0 ;
 }
 if(sonarReadValue == 255)
 {
 UARTSendString("Sonar reads 255 return false.");
 GPIOC_ODR.B9 = 0;
 return  1 ;
 }
 if (sonarReadValue >=  30 )
 {
 UARTSendString("Reached Alitutude.");
 GPIOC_ODR.B9 = 1;
 return  0 ;
 }
 }
 GPIOC_ODR.B9 = ~GPIOC_ODR.B9;
 Delay_ms( 500 );
 }
}

void LoiterMode(){
 DC_time = (current_DC_8*pwm_period2)/100;
 PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

void StabilizeMode(){
 DC_time = (current_DC_3*pwm_period2)/100;
 PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}


void LandingMode(){
 DC_time = (current_DC_9*pwm_period2)/100;
 PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

void Land(){
 DC_time = (current_DC_7*pwm_period2)/100;
 PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

void Yaw_Left(uint16 timeToYaw_ms){
 DC_time = (8.0*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 Vdelay_ms(timeToYaw_ms);
 Yaw_Stop();
}

void Yaw_Right(const uint16 timeToYaw_ms){
 DC_time = (6.8*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 Vdelay_ms(timeToYaw_ms);
 Yaw_Stop();
}

void Yaw_Stop(){
 DC_time = (current_DC*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);
}

void Forward_Flight(){
 DC_time = (6.5*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);
}

void Stop_Forward(){
 DC_time = (current_DC*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);
}

uint16 alitudeSonarRead()
{
 uint16 sonarArray[ 10 ] = {0};
 int16 i = 0;
 uint32 sonarAvg = 0;
 uint32 secondAvg = 0;
 uint8 anomolyCount = 0;


 for(i=0; i <  10 ; i++)
 {
 sonarArray[i] = ADC1_Get_Sample(13);
 sonarArray[i] >>= 4;

 if(sonarArray[i] >=  240 )
 {

 i--;
 anomolyCount++;
 if(anomolyCount >  10 )
 {
 return 255;
 }
 }
 else
 {
 sonarAvg += sonarArray[i];
 }
 Delay_ms( 50 );
 }
 sonarAvg = sonarAvg/ 10 ;
 secondAvg = 0;
 for(i=0; i <  10 ; i++)
 {
 if(sonarArray[i] >= sonarAvg +  40 )
 {
 sonarArray[i] = sonarAvg;
 }
 secondAvg += sonarArray[i];
 }
 return((uint16)secondAvg/ 10 );
}

void Stabilize_Alt()
{
 uint16 sonarAlititude = 0;
 uint8 failSafeCounter = 0;
 uint8 sonarReadIteration = 0;

 current_DC_3 =  6.3 ;
 DC_time = (current_DC_3*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);

 UARTSendString("Stablilizing Alititude.");
 sonarAlititude = alitudeSonarRead();
 UARTSendString("1st Sonar average.");
 UARTSendUint16(sonarAlititude);
 UARTSendNewLine();

 while((sonarAlititude < ( 96  -  5 )) || (sonarAlititude > ( 96  +  5 )))
 {
 if(failSafeCounter >=  5 )
 {
 UARTSendString("Breaking out, too many iterations.");
 return;
 }
 else if(sonarReadIteration >=  2 )
 {
 sonarReadIteration = 0;
 if(sonarAlititude >  96 )
 {
 current_DC_3 -=  0.05 ;
 UARTSendString("Decrease Throttle.");
 }
 else if(sonarAlititude <  96 )
 {
 current_DC_3 +=  0.05 ;
 UARTSendString("Increase Throttle.");
 }
 GPIOC_ODR.B8 = ~GPIOC_ODR.B8;
 UARTSendString("Throttle:");
 UARTSendUint16(current_DC_3);

 DC_time = (current_DC_3*pwm_period2)/100;
 PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
 failSafeCounter++;
 }

 sonarAlititude = alitudeSonarRead();
 UARTSendUint16(sonarAlititude);
 sonarReadIteration++;
 }
 UARTSendString("Reached Altitude.");
}
