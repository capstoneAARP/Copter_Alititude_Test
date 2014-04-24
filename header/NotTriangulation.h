#ifndef _NOT_TRIANGULATION_H_
#define _NOT_TRIANGULATION_H_

#include "StdTypes.h"

#define BEACON_1_CHANNEL           _ADC_CHANNEL_12  //PC3
#define BEACON_1                   12

#define ORIENTATION_DELAY          1000 //(uS)

#define GOAL_THRESHOLD             20

#define INIT_OFFSET                5
#define ITER_OFFSET                -5

#define PEAK_PORT              GPIOA_BASE
#define PEAK_RX_PIN_MASK       _GPIO_PINMASK_4     //PA4

static uint16 goalHeading;
static int16 adcValue;

// System init functions
void notTriangulationInit(void);
void InitTimer4();

boolean headingInit(void);

boolean testSequence(void);


/*      main function
        1) reorients copter for sensor data (reorientCopter)
        2) gets sensor data, (gatherSignalStrength)
        3) calls updateGoal with signal strength data.
*/
boolean calcDirection(void);

// uses goalDirection and signal strength to update path planning algo (updateMapGoal).
boolean updateGoal(uint16 newHeading);

#endif //_NOT_TRIANGULATION_H_