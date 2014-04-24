#include "PathPlanning.h"
#include "StdTypes.h"
#include "MovementControl.h"
#include "UART.h"


//origin is top left (0,0)
static uint8 obstacleMap[MAX_MAP_ROWS][MAX_MAP_COLS];
static uint8 rowQuad;
static uint8 colQuad;
static uint8 rowGoal;
static uint8 colGoal;

static mode currentMode;
static boolean validPath;

//Initalizes map, goal, and modes.
void pathPlanningInit(void)
{
        uint8 row, col;
        for(row = 0; row < MAX_MAP_ROWS; row++)
        {
                for(col = 0; col < MAX_MAP_COLS; col++)
                {
                        obstacleMap[row][col] = EMPTY;
                }
        }
        rowQuad = (MAX_MAP_ROWS/2)-1;
        colQuad = (MAX_MAP_COLS/2)-1;
        obstacleMap[(MAX_MAP_ROWS/2)-1][(MAX_MAP_COLS/2)-1] = QUADCOPTER;
        rowGoal = 255;
        colGoal = 255;
        currentMode = BEACON_MODE;
        validPath = false;
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
                      if(obstacleMap[i][colQuad] == OBSTACLE)
                      {
                         //found obstacle return true
                         return true;
                      }
                  }
                  break;
             case 90:
                  for(i = colQuad+1; i != MAX_MAP_COLS; i++)
                  {
                      if(obstacleMap[rowQuad][i] == OBSTACLE)
                      {
                         //found obstacle return true
                         return true;
                      }
                  }
                  break;
             case 180:
                  for(i = rowQuad+1; i != MAX_MAP_ROWS; i++)
                  {
                      if(obstacleMap[i][colQuad] == OBSTACLE)
                      {
                         //found obstacle return true
                         return true;
                      }
                  }
                  break;
             case 270:
                  for(i = colQuad-1; i != -1; i--)
                  {
                      if(obstacleMap[rowQuad][i] == OBSTACLE)
                      {
                         //found obstacle return true
                         return true;
                      }
                  }
                  break;
             default:
                  //fake obstacle.
                  return true;
        }
        //no obstacle found
        return false;
}


// update goal from Triangulation
boolean updateMapGoal(uint8 newRowGoal, uint8 newColGoal)
{
        if(newRowGoal >= MAX_MAP_ROWS || newColGoal >= MAX_MAP_COLS)
        {
                return false;
        }

        removePathPlan();
        obstacleMap[newRowGoal][newColGoal] = GOAL;
        rowGoal = newRowGoal;
        colGoal = newColGoal;

        return true;
}

// add obstacle from ObstacleAvoidance
boolean addObstacle(uint8 rowObstacle, uint8 colObstacle)
{
        if(rowObstacle >= MAX_MAP_ROWS || colObstacle >= MAX_MAP_COLS)
        {
                return false;
        }
        if(obstacleMap[rowObstacle][colObstacle] != OBSTACLE)
        {
                removePathPlan();
                obstacleMap[rowObstacle][colObstacle] = OBSTACLE;
        }
        return true;
}

void removePathPlan(void)
{
     uint8 row, col;
     for(row = 0; row < MAX_MAP_ROWS; row++)
      {
              for(col = 0; col < MAX_MAP_COLS; col++)
              {
                      //wipe out old path plan.
                      if(obstacleMap[row][col] < OBSTACLE && obstacleMap[row][col] != GOAL)
                      {
                              obstacleMap[row][col] = EMPTY;
                      }
              }
      }
      validPath = false;
}

// based on obstacles.
boolean updateMode(uint8 newMode)
{
        if(currentMode >= MAX_MODE)
        {
                return false;
        }
        currentMode = newMode;
        return true;
}

//main function, calls wes for movement
boolean findPath(void)
{
        uint16 currentDepth[MAX_MAP_COLS+MAX_MAP_ROWS];
        uint16 nextDepth[MAX_MAP_COLS+MAX_MAP_ROWS];
        uint8 currentDepthCount = 0;
        uint8 nextDepthCount = 0;
        uint8 currentNode;
        uint8 rowCheck = 0;
        uint8 colCheck = 0;
        uint8 iteration = 2;
        
        if(rowGoal == 255 && colGoal == 255)
        {
                //goal not set yet, do nothing
                return false;
        }
        //check if a valid path already exists here
        if(validPath == true)
        {

                return true;
        }

        //initial coniditions based around goal.
        //north check
        if(rowGoal != 0)
        {
        if(obstacleMap[rowGoal-1][colGoal] == QUADCOPTER)
        {
            //path found
            validPath = true;
            return true;
        }
        if(obstacleMap[rowGoal-1][colGoal] == EMPTY)
        {
            currentDepth[currentDepthCount] = (rowGoal-1)*MAX_MAP_COLS+colGoal;
            currentDepthCount++;
            obstacleMap[rowGoal-1][colGoal] = 1;
        }
        }
        //south check
        if(rowGoal != MAX_MAP_ROWS-1)
        {
                if(obstacleMap[rowGoal+1][colGoal] == QUADCOPTER)
        {
            //path found
            validPath = true;
            return true;
        }
        if(obstacleMap[rowGoal+1][colGoal] == EMPTY)
        {
            currentDepth[currentDepthCount] = (rowGoal+1)*MAX_MAP_COLS+colGoal;
            currentDepthCount++;
            obstacleMap[rowGoal+1][colGoal] = 1;
        }
        }
        //east check
        if(colGoal != 0)
        {
                if(obstacleMap[rowGoal][colGoal-1] == QUADCOPTER)
        {
            //path found
            validPath = true;
            return true;
        }
        if(obstacleMap[rowGoal][colGoal-1] == EMPTY)
        {
            currentDepth[currentDepthCount] = (rowGoal)*MAX_MAP_COLS+colGoal-1;
            currentDepthCount++;
            obstacleMap[rowGoal][colGoal-1] = 1;
        }
        }
        //west check
        if(colGoal != MAX_MAP_COLS-1)
        {
                if(obstacleMap[rowGoal][colGoal+1] == QUADCOPTER)
        {
            //path found
            validPath = true;
            return true;
        }
        if(obstacleMap[rowGoal][colGoal+1] == EMPTY)
        {
            currentDepth[currentDepthCount] = (rowGoal)*MAX_MAP_COLS+colGoal+1;
            currentDepthCount++;
            obstacleMap[rowGoal][colGoal+1] = 1;
        }
        }

        while(currentDepthCount != 0)
        {
                currentNode = 0;
                for(;currentNode < currentDepthCount; currentNode++)
                {
                        //decode row/col
                        colCheck = currentDepth[currentNode] % MAX_MAP_COLS;
                        rowCheck = currentDepth[currentNode] / MAX_MAP_COLS;
                        //north check
                        if(rowCheck != 0)
                        {
                            if(obstacleMap[rowCheck-1][colCheck] == QUADCOPTER)
                {
                    //path found
                    validPath = true;
                    return true;
                }
                                if(obstacleMap[rowCheck-1][colCheck] == EMPTY)
                                {
                    nextDepth[nextDepthCount] = (rowCheck-1)*MAX_MAP_COLS+colCheck;
                    nextDepthCount++;
                    obstacleMap[rowCheck-1][colCheck] = iteration;
                                }
                        }
                        //south check
                        if(rowCheck != MAX_MAP_ROWS-1)
                        {
                            if(obstacleMap[rowCheck+1][colCheck] == QUADCOPTER)
                {
                    //path found
                    validPath = true;
                    return true;
                }
                                if(obstacleMap[rowCheck+1][colCheck] == EMPTY)
                                {
                    nextDepth[nextDepthCount] = (rowCheck+1)*MAX_MAP_COLS+colCheck;
                    nextDepthCount++;
                    obstacleMap[rowCheck+1][colCheck] = iteration;
                                }
                        }
                        //east check
                        if(colCheck != 0)
                        {
                            if(obstacleMap[rowCheck][colCheck-1] == QUADCOPTER)
                {
                    //path found
                    validPath = true;
                    return true;
                }
                                if(obstacleMap[rowCheck][colCheck-1] == EMPTY)
                                {
                    nextDepth[nextDepthCount] = (rowCheck)*MAX_MAP_COLS+colCheck-1;
                    nextDepthCount++;
                    obstacleMap[rowCheck][colCheck-1] = iteration;
                                }
                        }
                        //west check
                        if(colCheck != MAX_MAP_COLS-1)
                        {
                            if(obstacleMap[rowCheck][colCheck+1] == QUADCOPTER)
                {
                    //path found
                    validPath = true;
                    return true;
                }
                                if(obstacleMap[rowCheck][colCheck+1] == EMPTY)
                                {
                    nextDepth[nextDepthCount] = (rowCheck)*MAX_MAP_COLS+colCheck+1;
                    nextDepthCount++;
                    obstacleMap[rowCheck][colCheck+1] = iteration;
                                }
                        }
                }
                //copy next depth to current depth
                for(currentNode = 0; currentNode < nextDepthCount; currentNode++)
                {
                        currentDepth[currentNode] = nextDepth[currentNode];
                }
                currentDepthCount = nextDepthCount;
                nextDepthCount = 0;
                iteration++;
        }
        //didn't find path to quadcopter
        return false;
}

boolean nextStep(void)
{
    uint8 lowestNumber = EMPTY;
    direction dir = 255;

    if(!validPath)
    {
        findPath();
        if(!validPath)
        {
            //unable to find path to goal
            return false;
        }
    }

    //we have a valid path. follow lowest number.
    //check north
    if(rowQuad != 0)
    {
        if(obstacleMap[rowQuad-1][colQuad] < lowestNumber)
        {
            lowestNumber = obstacleMap[rowQuad-1][colQuad];
            dir = NORTH;
        }
    }
    //check south
    if(rowQuad != MAX_MAP_ROWS-1)
    {
        if(obstacleMap[rowQuad+1][colQuad] < lowestNumber)
        {
            lowestNumber = obstacleMap[rowQuad+1][colQuad];
            dir = SOUTH;
        }
    }
    //check east
    if(colQuad != 0)
    {
        if(obstacleMap[rowQuad][colQuad-1] < lowestNumber)
        {
            lowestNumber = obstacleMap[rowQuad][colQuad-1];
            dir = EAST;
        }
    }
    //check west
    if(colQuad != MAX_MAP_COLS-1)
    {
        if(obstacleMap[rowQuad][colQuad+1] < lowestNumber)
        {
            lowestNumber = obstacleMap[rowQuad][colQuad+1];
            dir = WEST;
        }
    }

    //now move the quad in the correct direction
    switch(dir)
    {
        case NORTH:
            moveQuad(NORTH, SQUARE_SIDE_LENGTH);
            obstacleMap[rowQuad][colQuad] = EMPTY;
            rowQuad--;
            obstacleMap[rowQuad][colQuad] = QUADCOPTER;
            break;
        case SOUTH:
            moveQuad(SOUTH, SQUARE_SIDE_LENGTH);
            obstacleMap[rowQuad][colQuad] = EMPTY;
            rowQuad++;
            obstacleMap[rowQuad][colQuad] = QUADCOPTER;
            break;
        case EAST:
            moveQuad(EAST, SQUARE_SIDE_LENGTH);
            obstacleMap[rowQuad][colQuad] = EMPTY;
            colQuad--;
            obstacleMap[rowQuad][colQuad] = QUADCOPTER;
            break;
        case WEST:
            moveQuad(WEST, SQUARE_SIDE_LENGTH);
            obstacleMap[rowQuad][colQuad] = EMPTY;
            colQuad++;
            obstacleMap[rowQuad][colQuad] = QUADCOPTER;
            break;
        default:
            //you fucked up
            removePathPlan();
            return false;
    }
    return true;

}

//  Function to get the current mode
mode getMode(void)
{
    return currentMode;
}

// Function to get the current quad position in the grid
void getQuadPostion(uint8 * rowHolder, uint8 * colHolder)
{
    *rowHolder = rowQuad;
    *colHolder = colQuad;
}

//prints the map for debug
void printMap(void)
{
        int row, col;
        for(row = 0; row < MAX_MAP_ROWS; row++)
        {
                for(col = 0; col < MAX_MAP_COLS*2; col++)
                {
                        UARTSendChar('_');
                }
                UARTSendChar('\n');
                UARTSendChar('|');
                for(col = 0; col < MAX_MAP_COLS; col++)
                {
                        switch(obstacleMap[row][col])
                        {
                                case QUADCOPTER:
                                        UARTSendChar('A');
                                        UARTSendChar('|');
                                        break;
                                case OBSTACLE:
                                        UARTSendChar('X');
                                        UARTSendChar('|');
                                        break;
                                case GOAL:
                                        UARTSendChar('G');
                                        UARTSendChar('|');
                                        break;
                                case EMPTY:
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
        for(col = 0; col < MAX_MAP_COLS*2; col++)
        {
                UARTSendChar('_');
        }
        UARTSendChar('\n');
}