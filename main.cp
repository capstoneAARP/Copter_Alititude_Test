#line 1 "C:/Users/dell/Documents/GitHub/Copter_Alititude_Test/main.c"
#line 1 "c:/users/dell/documents/github/copter_alititude_test/header/uart.h"
#line 1 "c:/users/dell/documents/github/copter_alititude_test/header/stdtypes.h"



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
#line 6 "c:/users/dell/documents/github/copter_alititude_test/header/uart.h"
void UARTDebugInit();

void UARTSendString(uint8 * stringToSend);

void UARTSendChar(uint8 charToSend);

void UARTSendNewLine(void);

void UARTSendUint16(uint16 dataToSend);

void UARTSendDouble(double dataToSend);
#line 1 "c:/users/dell/documents/github/copter_alititude_test/header/stdtypes.h"
#line 1 "c:/users/dell/documents/github/copter_alititude_test/header/blink.h"




void blink_init();
void blink_led();
#line 1 "c:/users/dell/documents/github/copter_alititude_test/header/flightcontrol.h"
#line 1 "c:/users/dell/documents/github/copter_alititude_test/header/stdtypes.h"
#line 40 "c:/users/dell/documents/github/copter_alititude_test/header/flightcontrol.h"
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
#line 1 "c:/users/dell/documents/github/copter_alititude_test/header/nottriangulation.h"
#line 1 "c:/users/dell/documents/github/copter_alititude_test/header/stdtypes.h"
#line 19 "c:/users/dell/documents/github/copter_alititude_test/header/nottriangulation.h"
static uint16 goalHeading;
static int16 adcValue;


void notTriangulationInit(void);
void InitTimer4();

boolean headingInit(void);

boolean testSequence(void);
#line 36 "c:/users/dell/documents/github/copter_alititude_test/header/nottriangulation.h"
boolean calcDirection(void);


boolean updateGoal(uint16 newHeading);
#line 36 "C:/Users/dell/Documents/GitHub/Copter_Alititude_Test/main.c"
typedef void (*SliceFunctions) ();


int current_func = 0;
int func_flag = 0;
unsigned long service_time[ 1 ];
volatile unsigned long msTicks = 0;
unsigned long millis();





void mainTestingThread()
{



 boolean success;


 UARTSendString("Delay for GPS Signal.");
 Delay_ms(10000);
 UARTSendString("Starting test12.");

 StabilizeMode();
 Delay_ms(500);
 Arm();
 success = TakeOff();

 if(success ==  0 )
 {
 LoiterMode();
 Delay_ms(5000);
 StabilizeMode();
 delay_ms(500);
 Stabilize_Alt();
 delay_ms(500);
 LoiterMode();
 Delay_ms(8000);
#line 114 "C:/Users/dell/Documents/GitHub/Copter_Alititude_Test/main.c"
 }
 UARTSendString("Returning to base.");
 LandingMode();
 Delay_ms(30000);
 UARTSendString("Disarm in 10 seconds.");
 Delay_ms(10000);
 DisArm();

 while(1)
 {
 Delay_ms(500);
 }
}







const SliceFunctions functions[] =
{

 blink_led,




};



unsigned long func_time[] =
{
  600 ,




};






void InitSysTick()
{

 NVIC_SYSTICKCSR = 0;


 NVIC_SYSTICKRVR = 60000;




 NVIC_SYSTICKCVR = 0;


 NVIC_SYSTICKCALVR = 9000;


 NVIC_SYSTICKCSR.B0 = 1;
 NVIC_SYSTICKCSR.B1 = 1;
 NVIC_SYSTICKCSR.B2 = 1;
}
#line 186 "C:/Users/dell/Documents/GitHub/Copter_Alititude_Test/main.c"
void SysTick_ISR() iv IVT_INT_SysTick ics ICS_AUTO
{
GPIOC_ODR ^= _GPIO_PINMASK_9;
 TIM2_SR.UIF = 0;
 msTicks++;
 current_func++;
 if (current_func ==  1 )
 current_func = 0;
 func_flag = 1;
}



void init_prog()
{










 UARTDebugInit();
 Delay_ms(250);




 Flight_Control_Init();


 mainTestingThread();




}



void main()
{



 init_prog();
#line 248 "C:/Users/dell/Documents/GitHub/Copter_Alititude_Test/main.c"
}


unsigned long millis()
{
 return msTicks;
}
