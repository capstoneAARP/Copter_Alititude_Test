#ifndef _PATH_PLANNING_H_
#define _PATH_PLANNING_H_

#include "StdTypes.h"

//defines for obstacle map
#define QUADCOPTER              255
#define OBSTACLE                254
#define GOAL                    0
#define EMPTY                   253

//distance to change to allstop mode (cm)
#define ALLSTOP_DISTANCE        91


//distance to add obstacles at
#define OBSTACLE_DETECT_DISTANCE 200

#define MAX_MAP_ROWS            16
#define MAX_MAP_COLS            16

#define SQUARE_SIDE_LENGTH      100 //cm

//Initalizes map, goal, and modes.
void pathPlanningInit(void);

boolean checkObstacleFront(void);

// update goal from Triangulation
boolean updateMapGoal(uint8 newRowGoal, uint8 newColGoal);

// add obstacle from ObstacleAvoidance
boolean addObstacle(uint8 rowObstacle, uint8 colObstacle);

void removePathPlan(void);

// based on obstacles.
boolean updateMode(uint8 newMode);

// calculates a path to the goal if one doesn't exist
boolean findPath(void);

/*         1) finds next step on path, and sends command to MovementControl
*         2) if no path exists calls findPath
*        3) If no path can be found returns false.
*/
boolean nextStep(void);

//  Function to get the current mode
mode getMode(void);

// Function to get the current quad position in the grid
void getQuadPostion(uint8 * rowHolder, uint8 * colHolder);

//prints the map for debug
void printMap(void);

#endif //_PATH_PLANNING_H_