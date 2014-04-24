#ifndef _MOVEMENT_CONTROL_H_
#define _MOVEMENT_CONTROL_H_

#include "StdTypes.h"

#define MILI_SECONDS_PER_10_DEGREE_YAW                10

#define SIXTY_MINUTES_PER_DEGREE                      60
#define FEET_PER_KM_PER_DEGREE                        364537.766667

void movementControlInit(void);

// moves quadcopter in direction for distance (ft)
boolean moveQuad(direction dir, uint8 distance);

// Function to reoreint copter
boolean rotateCopter(uint16 newHeading);

uint16 getCurrentHeading(void);

boolean updateGPSCoordinate(int8 lonDegrees, float lonMinutes, char lonDirection, int8 latDegrees, float latMinutes, char latDirection);

#endif //_MOVEMENT_CONTROL_H_