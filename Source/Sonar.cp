#line 1 "//eces172.colorado.edu/brca1272/win7folders/Desktop/GitHub/AARP_CAPSTONE/AARPMain/source/Sonar.c"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/sonar.h"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/stdtypes.h"



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
#line 19 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/sonar.h"
void sonarInit();

boolean sonarRead();

uint8 rs232ByteRead();

void calcObstacle(uint16 rangeToObstacle);
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/stdtypes.h"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/pathplanning.h"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/stdtypes.h"
#line 25 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/pathplanning.h"
void pathPlanningInit(void);

boolean checkObstacleFront(void);


boolean updateMapGoal(uint8 newRowGoal, uint8 newColGoal);


boolean addObstacle(uint8 rowObstacle, uint8 colObstacle);

void removePathPlan(void);


boolean updateMode(uint8 newMode);


boolean findPath(void);
#line 47 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/pathplanning.h"
boolean nextStep(void);


mode getMode(void);


void getQuadPostion(uint8 * rowHolder, uint8 * colHolder);


void printMap(void);
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/movementcontrol.h"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/stdtypes.h"
#line 11 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/movementcontrol.h"
void movementControlInit(void);


boolean moveQuad(direction dir, uint8 distance);


boolean rotateCopter(uint16 newHeading);

uint16 getCurrentHeading(void);

boolean updateGPSCoordinate(int8 lonDegrees, float lonMinutes, char lonDirection, int8 latDegrees, float latMinutes, char latDirection);
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/uart.h"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/stdtypes.h"
#line 6 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/uart.h"
void UARTDebugInit();

void UARTSendString(uint8 * stringToSend);

void UARTSendChar(uint8 charToSend);

void UARTSendNewLine(void);

void UARTSendUint16(uint16 dataToSend);

void UARTSendDouble(double dataToSend);
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
#line 8 "//eces172.colorado.edu/brca1272/win7folders/Desktop/GitHub/AARP_CAPSTONE/AARPMain/source/Sonar.c"
void sonarInit()
{
 GPIO_Digital_Input(& GPIOB_BASE ,  _GPIO_PINMASK_10 );
 GPIO_Digital_Output(& GPIOB_BASE ,  _GPIO_PINMASK_11 );

  ODR11_GPIOB_ODR_bit  = 0;


 Delay_ms(500);

  ODR11_GPIOB_ODR_bit  = 1;



 Delay_ms(200);

  ODR11_GPIOB_ODR_bit  = 0;
}

boolean sonarRead(void)
{
 uint8 sensorOutput1 [5] = {0};
 uint8 i;
 uint16 rangeToObstacle = 0;
 uint16 sensorReadArray[ 20 ] = {500};
 uint32 rangeSum = 0;
 boolean recalcAverage =  1 ;

  ODR11_GPIOB_ODR_bit  = 1;

 for(i = 0; i <  20 ; i++)
 {
 sensorOutput1[0] = rs232ByteRead();
 sensorOutput1[1] = rs232ByteRead();
 sensorOutput1[2] = rs232ByteRead();
 sensorOutput1[3] = rs232ByteRead();




 sensorReadArray[i] = (sensorOutput1[1] - 48)*100 + (sensorOutput1[2] - 48)*10 + (sensorOutput1[3] - 48);
 rangeSum += sensorReadArray[i];
 Delay_ms(10);
 }
 rangeToObstacle = (uint16) rangeSum/ 20 ;
 for(i = 0; i <  20 ; i++)
 {

 if(sensorReadArray[i] <= (rangeToObstacle - 40))
 {
 sensorReadArray[i] = rangeToObstacle;
 recalcAverage =  0 ;
 }
 }
 if(recalcAverage ==  0 )
 {
 rangeSum = 0;
 for(i = 0; i <  20 ; i++)
 {
 rangeSum += sensorReadArray[i];
 }
 rangeToObstacle = (uint16) rangeSum/ 20 ;
 }

 UARTSendString("Average: ");
 UARTSendUint16(rangeToObstacle);

  ODR11_GPIOB_ODR_bit  = 0;


 if(rangeToObstacle <=  91 )
 {




 updateMode(ALL_STOP_MODE);
 }


 if(rangeToObstacle >  200 )
 {

 return  0 ;
 }
 calcObstacle(rangeToObstacle);

 return  0 ;
}


uint8 rs232ByteRead()
{
 uint8 byteRead = 0;
 uint8 bitValueRead = 0;
 int i = 1;


 while( IDR10_GPIOB_IDR_bit  == 0);
 Delay_us( 104 );

 byteRead =  IDR10_GPIOB_IDR_bit ;


 for(;i < 8; i++)
 {
 Delay_us( 104 );
 bitValueRead =  IDR10_GPIOB_IDR_bit ;
 byteRead |= (bitValueRead << i);
 }
 Delay_us( 104 );

 return (~byteRead);
}

void calcObstacle(uint16 rangeToObstacle)
{
 float heading;
 uint8 quadXPos, quadYPos;
 float xPart, yPart;
 int8 xPosDiff, yPosDiff;


 getQuadPostion(&quadXPos, &quadYPos);
 heading = getCurrentHeading();



 if(heading > 0 && heading < 90)
 {
 yPart = (float)-1*rangeToObstacle*cos(heading* 0.017453292519943 );
 xPart = (float)rangeToObstacle*sin(heading* 0.017453292519943 );
 }

 else if(heading > 90 && heading < 180)
 {
 yPart = (float)rangeToObstacle*sin((heading-90)* 0.017453292519943 );
 xPart = (float)rangeToObstacle*cos((heading-90)* 0.017453292519943 );
 }

 else if(heading > 180 && heading < 270)
 {
 yPart = (float)rangeToObstacle*cos((heading-180)* 0.017453292519943 );
 xPart = (float)-1*rangeToObstacle*sin((heading-180)* 0.017453292519943 );
 }

 else if(heading > 270)
 {
 yPart = (float)-1*rangeToObstacle*sin((heading-270)* 0.017453292519943 );
 xPart = (float)-1*rangeToObstacle*cos((heading-270)* 0.017453292519943 );
 }
 else if(heading == 0)
 {
 yPart = (float) -1*rangeToObstacle;
 xPart = (float)0;
 }
 else if(heading == 90)
 {
 yPart = (float)0;
 xPart = (float)rangeToObstacle;
 }
 else if(heading == 180)
 {
 yPart = (float)rangeToObstacle;
 xPart = (float)0;
 }
 else if(heading == 270)
 {
 yPart = (float)0;
 xPart = (float)-1*rangeToObstacle;
 }
 else
 {

 return;
 }

 if(xPart < 0)
 {
 xPosDiff = (int8)ceil(xPart/( 100 ));
 }
 else
 {
 xPosDiff = (int8)floor(xPart/( 100 ));
 }
 if(yPart < 0)
 {
 yPosDiff = (int8)ceil(yPart/( 100 ));
 }
 else
 {
 yPosDiff = (int8)floor(yPart/( 100 ));
 }


 addObstacle(quadYPos + yPosDiff, quadXPos + xPosDiff);

}
