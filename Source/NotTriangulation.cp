#line 1 "C:/Users/dell/Documents/GitHub/AARPCopter/source/NotTriangulation.c"
#line 1 "c:/users/dell/documents/github/aarpcopter/header/nottriangulation.h"
#line 1 "c:/users/dell/documents/github/aarpcopter/header/stdtypes.h"



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
#line 19 "c:/users/dell/documents/github/aarpcopter/header/nottriangulation.h"
static uint16 goalHeading;
static int16 adcValue;


void notTriangulationInit(void);
void InitTimer4();

boolean headingInit(void);

boolean testSequence(void);
#line 36 "c:/users/dell/documents/github/aarpcopter/header/nottriangulation.h"
boolean calcDirection(void);


boolean updateGoal(uint16 newHeading);
#line 1 "c:/users/dell/documents/github/aarpcopter/header/stdtypes.h"
#line 1 "c:/users/dell/documents/github/aarpcopter/header/pathplanning.h"
#line 1 "c:/users/dell/documents/github/aarpcopter/header/stdtypes.h"
#line 25 "c:/users/dell/documents/github/aarpcopter/header/pathplanning.h"
void pathPlanningInit(void);

boolean checkObstacleFront(void);


boolean updateMapGoal(uint8 newRowGoal, uint8 newColGoal);


boolean addObstacle(uint8 rowObstacle, uint8 colObstacle);

void removePathPlan(void);


boolean updateMode(uint8 newMode);


boolean findPath(void);
#line 47 "c:/users/dell/documents/github/aarpcopter/header/pathplanning.h"
boolean nextStep(void);


mode getMode(void);


void getQuadPostion(uint8 * rowHolder, uint8 * colHolder);


void printMap(void);
#line 1 "c:/users/dell/documents/github/aarpcopter/header/movementcontrol.h"
#line 1 "c:/users/dell/documents/github/aarpcopter/header/stdtypes.h"
#line 11 "c:/users/dell/documents/github/aarpcopter/header/movementcontrol.h"
void movementControlInit(void);


boolean moveQuad(direction dir, uint8 distance);


boolean rotateCopter(uint16 newHeading);

uint16 getCurrentHeading(void);

boolean updateGPSCoordinate(int8 lonDegrees, float lonMinutes, char lonDirection, int8 latDegrees, float latMinutes, char latDirection);
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/math.h"





double fabs(double d);
double floor(double x);
double ceil(double x);
double frexp(double value, int * eptr);
double ldexp(double value, int newexp);
double modf(double val, double * iptr);
double sqrt(double x);
double atan(double f);
double asin(double x);
double acos(double x);
double atan2(double y,double x);
double sin(double f);
double cos(double f);
double tan(double x);
double exp(double x);
double log(double x);
double log10(double x);
double pow(double x, double y);
double sinh(double x);
double cosh(double x);
double tanh(double x);
#line 1 "c:/users/dell/documents/github/aarpcopter/header/uart.h"
#line 1 "c:/users/dell/documents/github/aarpcopter/header/stdtypes.h"
#line 6 "c:/users/dell/documents/github/aarpcopter/header/uart.h"
void UARTDebugInit();

void UARTSendString(uint8 * stringToSend);

void UARTSendChar(uint8 charToSend);

void UARTSendNewLine(void);

void UARTSendUint16(uint16 dataToSend);

void UARTSendDouble(double dataToSend);
#line 1 "c:/users/dell/documents/github/aarpcopter/header/flightcontrol.h"
#line 1 "c:/users/dell/documents/github/aarpcopter/header/stdtypes.h"
#line 36 "c:/users/dell/documents/github/aarpcopter/header/flightcontrol.h"
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
void Alitutde_Hover();
#line 9 "C:/Users/dell/Documents/GitHub/AARPCopter/source/NotTriangulation.c"
const int16 MAGNITUDE_MAX = 3600;

void notTriangulationInit(void)
{
 ADC_Set_Input_Channel( _ADC_CHANNEL_12 );
 ADC1_Init();

 GPIO_Digital_Output(& GPIOA_BASE ,  _GPIO_PINMASK_4 );
 InitTimer4();
#line 30 "C:/Users/dell/Documents/GitHub/AARPCopter/source/NotTriangulation.c"
 UARTSendString("Beacon test1.");
#line 37 "C:/Users/dell/Documents/GitHub/AARPCopter/source/NotTriangulation.c"
 testSequence();
}







void InitTimer4()
{
 RCC_APB1ENR.TIM4EN = 1;
 TIM4_CR1.CEN = 0;
 TIM4_PSC = 884;
 TIM4_ARR = 59999;
 NVIC_IntEnable(IVT_INT_TIM4);
 TIM4_DIER.UIE = 1;
 TIM4_CR1.CEN = 1;
}

void Timer4_interrupt() iv IVT_INT_TIM4
{
 TIM4_SR.UIF = 0;
 adcValue = ADC1_Get_Sample( 12 );

 ODR4_bit = 1;
 ODR8_GPIOC_ODR_bit = 1;
 Delay_us(10000);
 ODR4_bit = 0;
 ODR8_GPIOC_ODR_bit = 0;
}

boolean testSequence(void)
{
 boolean success;
 int iter = 0;
 Delay_ms(10000);
 UARTSendString("Welcome to the even more DANGA ZONE.");

 StabilizeMode();
 Delay_ms(500);
 Arm();
 success = TakeOff();

 if(success ==  0 )
 {
 LoiterMode();

 UARTSendUint16(adcValue);
 Delay_ms(5000);
 UARTSendUint16(adcValue);
 Delay_ms(1000);
 UARTSendUint16(adcValue);
#line 112 "C:/Users/dell/Documents/GitHub/AARPCopter/source/NotTriangulation.c"
 }
 UARTSendString("Returning to base.");
 Land();
 Delay_ms(20000);
 DisArm();

 while(1)
 {
 Delay_ms(500);
 }
}

boolean headingInit(void)
{
 uint32 oldADCValue = MAGNITUDE_MAX;
 uint16 heading;

 while (oldADCValue > adcValue)
 {
 oldADCValue = adcValue;

 heading = getCurrentHeading();


 rotateCopter(heading+ -5 );


 Delay_ms( 1000 );
 }


 heading = 0;
 rotateCopter(heading- 5 );


 Delay_ms( 1000 );


 goalHeading = getCurrentHeading();

 return  0 ;
}
#line 160 "C:/Users/dell/Documents/GitHub/AARPCopter/source/NotTriangulation.c"
boolean calcDirection(void)
{
 uint32 oldADCValue = MAGNITUDE_MAX;
 uint16 heading;

 while (oldADCValue > adcValue)
 {
 oldADCValue = adcValue;

 heading = getCurrentHeading();


 rotateCopter(heading+ -5 );


 Delay_ms( 1000 );
 }


 heading = getCurrentHeading();
 rotateCopter(heading- -5 );


 Delay_ms( 1000 );

 heading = getCurrentHeading();
 updateGoal(heading);

 return  0 ;

}



boolean updateGoal(uint16 newHeading)
{
 if (((adcValue - MAGNITUDE_MAX)&0x7fff) <  20 )
 updateMode(FOUND_THAT_SHIT_MODE);
 else
 {
 uint8 row, col;
 int8 deltaRow, deltaCol;
 uint16 deltaAngle = newHeading-goalHeading;



 deltaRow = (cos(deltaAngle)*10)/3;
 deltaCol = (sin(deltaAngle)*10)/3;

 getQuadPostion(row, col);
 updateMapGoal(row+deltaRow, col+deltaCol);
 }

 return  0 ;

}
