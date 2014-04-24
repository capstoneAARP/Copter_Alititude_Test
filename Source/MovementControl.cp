#line 1 "//eces172.colorado.edu/brca1272/win7folders/Desktop/GitHub/AARP_CAPSTONE/AARPMain/source/MovementControl.c"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/movementcontrol.h"
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
#line 11 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/movementcontrol.h"
void movementControlInit(void);


boolean moveQuad(direction dir, uint8 distance);


boolean rotateCopter(uint16 newHeading);

uint16 getCurrentHeading(void);

boolean updateGPSCoordinate(int8 lonDegrees, float lonMinutes, char lonDirection, int8 latDegrees, float latMinutes, char latDirection);
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/stdtypes.h"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/flightcontrol.h"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/stdtypes.h"
#line 25 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/flightcontrol.h"
void Flight_Control_Init();
void Init_LED();
void Init_ADC();
void Init_Pwm();
void Arm();
void DisArm();
boolean TakeOff();
void LoiterMode();
void StabilizeMode();
void Land();
void LandingMode();
void Landing_Manual();
void Yaw_Left(uint16 timeToYaw_ms);
void Yaw_Right(uint16 timeToYaw_ms);
void Yaw_Stop();
void Forward_Flight();
void Stop_Forward();
uint16 alitudeSonarRead();
void Alitutde_Hover();
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
#line 6 "//eces172.colorado.edu/brca1272/win7folders/Desktop/GitHub/AARP_CAPSTONE/AARPMain/source/MovementControl.c"
static uint16 currentHeading = 0;
static double latFeet = 0;
static double lonFeet = 0;

void movementControlInit(void)
{
 currentHeading = 0;
}


boolean moveQuad(direction dir, uint8 distance)
{
 uint16 newHeading;
 float newLatFeet;
 float newLonFeet;

 switch(dir)
 {
 case NORTH:
 newHeading = 0;
 break;
 case SOUTH:
 newHeading = 180;
 break;
 case EAST:
 newHeading = 90;
 break;
 case WEST:
 newHeading = 270;
 break;
 default:
 return  1 ;
 }

 switch(dir)
 {
 case NORTH:
 newLonFeet = lonFeet;
 newLatFeet = latFeet+distance;
 break;
 case SOUTH:
 newLonFeet = lonFeet;
 newLatFeet = latFeet-distance;
 break;
 case EAST:
 newLatFeet = latFeet;
 newLonFeet = lonFeet+distance;
 break;
 case WEST:
 newLatFeet = latFeet;
 newLonFeet = lonFeet-distance;
 break;
 default:
 return  1 ;
 }

 rotateCopter(newHeading);
 Forward_Flight();

 switch(dir)
 {
 case NORTH:
 while(1)
 {
 if(latFeet >= newLatFeet)
 {
 break;
 }
 }
 break;
 case SOUTH:
 while(1)
 {
 if(latFeet <= newLatFeet)
 {
 break;
 }
 }
 break;
 case EAST:
 while(1)
 {
 if(lonFeet >= newLonFeet)
 {
 break;
 }
 }
 break;
 case WEST:
 while(1)
 {
 if(lonFeet <= newLonFeet)
 {
 break;
 }
 }
 break;
 default:
 return  1 ;
 }
 Stop_Forward();

 return  0 ;
}


boolean rotateCopter(uint16 newHeading)
{
 uint16 diff = currentHeading - newHeading;
 uint16 timeToYaw_ms;

 if((newHeading % 10) != 0)
 {

 return  1 ;
 }

 if(diff == 0)
 {
 return  0 ;
 }

 timeToYaw_ms = (diff/10)* 10 ;


 if(diff < -180)
 {
 Yaw_Left(timeToYaw_ms);
 }
 else if(diff < 0)
 {
 Yaw_Right(timeToYaw_ms);
 }
 else if(diff < 180)
 {
 Yaw_Left(timeToYaw_ms);
 }
 else
 {
 Yaw_Right(timeToYaw_ms);
 }

 currentHeading = newHeading;
 return  0 ;
}

uint16 getCurrentHeading(void)
{
 return currentHeading;
}

boolean updateGPSCoordinate(int8 lonDegrees, double lonMinutes, char lonDirection, int8 latDegrees, double latMinutes, char latDirection)
{
 double lonFeetTemp = (lonDegrees + lonMinutes/ 60 )* 364537.766667 ;
 double latFeetTemp = (latDegrees + latMinutes/ 60 )* 364537.766667 ;
 if(lonDirection == 'W')
 {
 lonFeet = lonFeetTemp*-1;
 }
 else if(lonDirection == 'E')
 {
 lonFeet = lonFeetTemp;
 }
 else
 {
 return  1 ;
 }
 if(lonDirection == 'S')
 {
 latFeet = latFeetTemp*-1;
 }
 else if(lonDirection == 'N')
 {
 latFeet = latFeetTemp;
 }
 else
 {
 return  1 ;
 }
 return  0 ;
}
