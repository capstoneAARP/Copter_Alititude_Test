#line 1 "//eces172.colorado.edu/brca1272/win7folders/Desktop/GitHub/AARP_CAPSTONE/AARPMain/source/PathPlanning.c"
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/pathplanning.h"
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
#line 1 "//eces172.colorado.edu/brca1272/win7folders/desktop/github/aarp_capstone/aarpmain/header/stdtypes.h"
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
#line 8 "//eces172.colorado.edu/brca1272/win7folders/Desktop/GitHub/AARP_CAPSTONE/AARPMain/source/PathPlanning.c"
static uint8 obstacleMap[ 16 ][ 16 ];
static uint8 rowQuad;
static uint8 colQuad;
static uint8 rowGoal;
static uint8 colGoal;

static mode currentMode;
static boolean validPath;


void pathPlanningInit(void)
{
 uint8 row, col;
 for(row = 0; row <  16 ; row++)
 {
 for(col = 0; col <  16 ; col++)
 {
 obstacleMap[row][col] =  253 ;
 }
 }
 rowQuad = ( 16 /2)-1;
 colQuad = ( 16 /2)-1;
 obstacleMap[( 16 /2)-1][( 16 /2)-1] =  255 ;
 rowGoal = 255;
 colGoal = 255;
 currentMode = BEACON_MODE;
 validPath =  1 ;
}

boolean checkObstacleFront(void)
{
 int16 i;
 uint16 currentHeading = getCurrentHeading();

 switch(currentHeading)
 {
 case 0:
 for(i = rowQuad-1; i != -1; i--)
 {
 if(obstacleMap[i][colQuad] ==  254 )
 {

 return  0 ;
 }
 }
 break;
 case 90:
 for(i = colQuad+1; i !=  16 ; i++)
 {
 if(obstacleMap[rowQuad][i] ==  254 )
 {

 return  0 ;
 }
 }
 break;
 case 180:
 for(i = rowQuad+1; i !=  16 ; i++)
 {
 if(obstacleMap[i][colQuad] ==  254 )
 {

 return  0 ;
 }
 }
 break;
 case 270:
 for(i = colQuad-1; i != -1; i--)
 {
 if(obstacleMap[rowQuad][i] ==  254 )
 {

 return  0 ;
 }
 }
 break;
 default:

 return  0 ;
 }

 return  1 ;
}



boolean updateMapGoal(uint8 newRowGoal, uint8 newColGoal)
{
 if(newRowGoal >=  16  || newColGoal >=  16 )
 {
 return  1 ;
 }

 removePathPlan();
 obstacleMap[newRowGoal][newColGoal] =  0 ;
 rowGoal = newRowGoal;
 colGoal = newColGoal;

 return  0 ;
}


boolean addObstacle(uint8 rowObstacle, uint8 colObstacle)
{
 if(rowObstacle >=  16  || colObstacle >=  16 )
 {
 return  1 ;
 }
 if(obstacleMap[rowObstacle][colObstacle] !=  254 )
 {
 removePathPlan();
 obstacleMap[rowObstacle][colObstacle] =  254 ;
 }
 return  0 ;
}

void removePathPlan(void)
{
 uint8 row, col;
 for(row = 0; row <  16 ; row++)
 {
 for(col = 0; col <  16 ; col++)
 {

 if(obstacleMap[row][col] <  254  && obstacleMap[row][col] !=  0 )
 {
 obstacleMap[row][col] =  253 ;
 }
 }
 }
 validPath =  1 ;
}


boolean updateMode(uint8 newMode)
{
 if(currentMode >= MAX_MODE)
 {
 return  1 ;
 }
 currentMode = newMode;
 return  0 ;
}


boolean findPath(void)
{
 uint16 currentDepth[ 16 + 16 ];
 uint16 nextDepth[ 16 + 16 ];
 uint8 currentDepthCount = 0;
 uint8 nextDepthCount = 0;
 uint8 currentNode;
 uint8 rowCheck = 0;
 uint8 colCheck = 0;
 uint8 iteration = 2;

 if(rowGoal == 255 && colGoal == 255)
 {

 return  1 ;
 }

 if(validPath ==  0 )
 {

 return  0 ;
 }



 if(rowGoal != 0)
 {
 if(obstacleMap[rowGoal-1][colGoal] ==  255 )
 {

 validPath =  0 ;
 return  0 ;
 }
 if(obstacleMap[rowGoal-1][colGoal] ==  253 )
 {
 currentDepth[currentDepthCount] = (rowGoal-1)* 16 +colGoal;
 currentDepthCount++;
 obstacleMap[rowGoal-1][colGoal] = 1;
 }
 }

 if(rowGoal !=  16 -1)
 {
 if(obstacleMap[rowGoal+1][colGoal] ==  255 )
 {

 validPath =  0 ;
 return  0 ;
 }
 if(obstacleMap[rowGoal+1][colGoal] ==  253 )
 {
 currentDepth[currentDepthCount] = (rowGoal+1)* 16 +colGoal;
 currentDepthCount++;
 obstacleMap[rowGoal+1][colGoal] = 1;
 }
 }

 if(colGoal != 0)
 {
 if(obstacleMap[rowGoal][colGoal-1] ==  255 )
 {

 validPath =  0 ;
 return  0 ;
 }
 if(obstacleMap[rowGoal][colGoal-1] ==  253 )
 {
 currentDepth[currentDepthCount] = (rowGoal)* 16 +colGoal-1;
 currentDepthCount++;
 obstacleMap[rowGoal][colGoal-1] = 1;
 }
 }

 if(colGoal !=  16 -1)
 {
 if(obstacleMap[rowGoal][colGoal+1] ==  255 )
 {

 validPath =  0 ;
 return  0 ;
 }
 if(obstacleMap[rowGoal][colGoal+1] ==  253 )
 {
 currentDepth[currentDepthCount] = (rowGoal)* 16 +colGoal+1;
 currentDepthCount++;
 obstacleMap[rowGoal][colGoal+1] = 1;
 }
 }

 while(currentDepthCount != 0)
 {
 currentNode = 0;
 for(;currentNode < currentDepthCount; currentNode++)
 {

 colCheck = currentDepth[currentNode] %  16 ;
 rowCheck = currentDepth[currentNode] /  16 ;

 if(rowCheck != 0)
 {
 if(obstacleMap[rowCheck-1][colCheck] ==  255 )
 {

 validPath =  0 ;
 return  0 ;
 }
 if(obstacleMap[rowCheck-1][colCheck] ==  253 )
 {
 nextDepth[nextDepthCount] = (rowCheck-1)* 16 +colCheck;
 nextDepthCount++;
 obstacleMap[rowCheck-1][colCheck] = iteration;
 }
 }

 if(rowCheck !=  16 -1)
 {
 if(obstacleMap[rowCheck+1][colCheck] ==  255 )
 {

 validPath =  0 ;
 return  0 ;
 }
 if(obstacleMap[rowCheck+1][colCheck] ==  253 )
 {
 nextDepth[nextDepthCount] = (rowCheck+1)* 16 +colCheck;
 nextDepthCount++;
 obstacleMap[rowCheck+1][colCheck] = iteration;
 }
 }

 if(colCheck != 0)
 {
 if(obstacleMap[rowCheck][colCheck-1] ==  255 )
 {

 validPath =  0 ;
 return  0 ;
 }
 if(obstacleMap[rowCheck][colCheck-1] ==  253 )
 {
 nextDepth[nextDepthCount] = (rowCheck)* 16 +colCheck-1;
 nextDepthCount++;
 obstacleMap[rowCheck][colCheck-1] = iteration;
 }
 }

 if(colCheck !=  16 -1)
 {
 if(obstacleMap[rowCheck][colCheck+1] ==  255 )
 {

 validPath =  0 ;
 return  0 ;
 }
 if(obstacleMap[rowCheck][colCheck+1] ==  253 )
 {
 nextDepth[nextDepthCount] = (rowCheck)* 16 +colCheck+1;
 nextDepthCount++;
 obstacleMap[rowCheck][colCheck+1] = iteration;
 }
 }
 }

 for(currentNode = 0; currentNode < nextDepthCount; currentNode++)
 {
 currentDepth[currentNode] = nextDepth[currentNode];
 }
 currentDepthCount = nextDepthCount;
 nextDepthCount = 0;
 iteration++;
 }

 return  1 ;
}

boolean nextStep(void)
{
 uint8 lowestNumber =  253 ;
 direction dir = 255;

 if(!validPath)
 {
 findPath();
 if(!validPath)
 {

 return  1 ;
 }
 }



 if(rowQuad != 0)
 {
 if(obstacleMap[rowQuad-1][colQuad] < lowestNumber)
 {
 lowestNumber = obstacleMap[rowQuad-1][colQuad];
 dir = NORTH;
 }
 }

 if(rowQuad !=  16 -1)
 {
 if(obstacleMap[rowQuad+1][colQuad] < lowestNumber)
 {
 lowestNumber = obstacleMap[rowQuad+1][colQuad];
 dir = SOUTH;
 }
 }

 if(colQuad != 0)
 {
 if(obstacleMap[rowQuad][colQuad-1] < lowestNumber)
 {
 lowestNumber = obstacleMap[rowQuad][colQuad-1];
 dir = EAST;
 }
 }

 if(colQuad !=  16 -1)
 {
 if(obstacleMap[rowQuad][colQuad+1] < lowestNumber)
 {
 lowestNumber = obstacleMap[rowQuad][colQuad+1];
 dir = WEST;
 }
 }


 switch(dir)
 {
 case NORTH:
 moveQuad(NORTH,  100 );
 obstacleMap[rowQuad][colQuad] =  253 ;
 rowQuad--;
 obstacleMap[rowQuad][colQuad] =  255 ;
 break;
 case SOUTH:
 moveQuad(SOUTH,  100 );
 obstacleMap[rowQuad][colQuad] =  253 ;
 rowQuad++;
 obstacleMap[rowQuad][colQuad] =  255 ;
 break;
 case EAST:
 moveQuad(EAST,  100 );
 obstacleMap[rowQuad][colQuad] =  253 ;
 colQuad--;
 obstacleMap[rowQuad][colQuad] =  255 ;
 break;
 case WEST:
 moveQuad(WEST,  100 );
 obstacleMap[rowQuad][colQuad] =  253 ;
 colQuad++;
 obstacleMap[rowQuad][colQuad] =  255 ;
 break;
 default:

 removePathPlan();
 return  1 ;
 }
 return  0 ;

}


mode getMode(void)
{
 return currentMode;
}


void getQuadPostion(uint8 * rowHolder, uint8 * colHolder)
{
 *rowHolder = rowQuad;
 *colHolder = colQuad;
}


void printMap(void)
{
 int row, col;
 for(row = 0; row <  16 ; row++)
 {
 for(col = 0; col <  16 *2; col++)
 {
 UARTSendChar('_');
 }
 UARTSendChar('\n');
 UARTSendChar('|');
 for(col = 0; col <  16 ; col++)
 {
 switch(obstacleMap[row][col])
 {
 case  255 :
 UARTSendChar('A');
 UARTSendChar('|');
 break;
 case  254 :
 UARTSendChar('X');
 UARTSendChar('|');
 break;
 case  0 :
 UARTSendChar('G');
 UARTSendChar('|');
 break;
 case  253 :
 UARTSendChar(' ');
 UARTSendChar(' ');
 UARTSendChar('|');
 break;
 default:
 if(obstacleMap[row][col] < 10)
 {
 UARTSendChar(obstacleMap[row][col]+48);
 }
 else
 {
 UARTSendChar((obstacleMap[row][col]/10)+48);
 UARTSendChar((obstacleMap[row][col]%10)+48);
 }
 UARTSendChar('|');
 break;
 }
 }
 UARTSendChar('\n');
 }
 for(col = 0; col <  16 *2; col++)
 {
 UARTSendChar('_');
 }
 UARTSendChar('\n');
}
