#ifndef _FLIGHT_CONTROL_H_
#define _FLIGHT_CONTROL_H_

#include "StdTypes.h"

#define GREEN_COPTER                  1

#ifdef GREEN_COPTER
#define STARTING_THROTTLE_VALUE         5.9
#define SONAR_LIMIT_THROTTLE_VALUE      6.5
#define MAX_THROTTLE_VALUE              6.7
#define HOVER_THROTTLE_VALUE            6.6
#define TAKEOFF_THROTTLE_STEP_SIZE      0.05               //Takeoff
#define ALT_THROTLE_STEP_SIZE           0.04
#else
#define STARTING_THROTTLE_VALUE         6.2
#define SONAR_LIMIT_THROTTLE_VALUE      6.8
#define MAX_THROTTLE_VALUE              6.9
#define HOVER_THROTTLE_VALUE            6.8
#define TAKEOFF_THROTTLE_STEP_SIZE      0.05
#define ALT_THROTLE_STEP_SIZE           0.03
#endif

#define TAKEOFF_ALITITUDE               30
#define MINIMUM_ALITITUDE               12
#define TAKEOFF_LOOP_DELAY_MS           500

#define THROTTLE_ALT_UP                 8.8
#define THROTTLE_ALT_DOWN               6.0

#define ALTITUDE_HOLD                   40
#define ALITUDE_SONAR_READ_DELAY        110
#define SONAR_ITERATIONS                4
#define SONAR_OUTLIER_OFFSET            40
#define SONAR_ALITUDE_RANGE             10
#define SONAR_MAX_VALUE                 240
#define MAX_ANOMOLY_TOSS                10
#define ALITITUDE_SONAR_READ_ITER       3
#define ALTITUDE_FAIL_SAFE_MAX          10

#define ALITITUDE_VALUE_ARRAY_SIZE      10

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
uint16 sonarGeneric();
void Stabilize_Alt();

#endif // _FLIGHT_CONTROL_H_