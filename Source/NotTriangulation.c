#include "NotTriangulation.h"
#include "StdTypes.h"
#include "PathPlanning.h"
#include "MovementControl.h"
#include "math.h"
#include "UART.h"
#include "FlightControl.h"

const int16 MAGNITUDE_MAX = 3600;

void notTriangulationInit(void)
{
  ADC_Set_Input_Channel(BEACON_1_CHANNEL);
  ADC1_Init();
 
  GPIO_Digital_Output(&PEAK_PORT, PEAK_RX_PIN_MASK);
  InitTimer4();
/*
  UARTSendUint16(adcValue);
  adcValue =  ADC1_Get_Sample(BEACON_1);

  // Did we start on top of our victim?
  if (((adcValue - MAGNITUDE_MAX)&0x7fff) < GOAL_THRESHOLD)
  {
    updateMode(FOUND_THAT_SHIT_MODE);
  }
  else
    calcDirection();
     */
  UARTSendString("Beacon test1.");
  /*while(1)
  {
    UARTSendUint16(adcValue);
    Delay_ms(2000);
  } */

  testSequence();
}


// Timer3 Prescaler :884; Preload = 59999; Actual Interrupt Time = 885 ms
// Setup for a 60MHz clock


// Place/Copy this part in declaration section
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
  adcValue = ADC1_Get_Sample(BEACON_1);
  // Trigger peak detection
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
     
     StabilizeMode();  //Set to Stabilize mode for takeoff (Only needed for loop mode - the StabilizeMode() above will place the quad in correct mode for arming
     Delay_ms(500);
     Arm();            //Arm the quad rotors
     success = TakeOff();

     if(success == true)
     {
       LoiterMode();
       //Delay_ms(5000);
       UARTSendUint16(adcValue);
       Delay_ms(5000);
       UARTSendUint16(adcValue);
       Delay_ms(1000);
       UARTSendUint16(adcValue);
       
       /*
       while(iter < 10)
       {

          if (((adcValue - MAGNITUDE_MAX)&0x7fff) < GOAL_THRESHOLD)
          {
            UARTSendString("Found that shiiiiiiiiiit");
            UARTSendUint16(adcValue);
            break;
          }

          UARTSendUint16(adcValue);
          UARTSendString("Forward");
          Forward_Flight();
          Delay_ms(2000);
          Stop_Forward();

          iter++;
        }
        */
       
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
        // Get current magnetometer heading
        heading = getCurrentHeading();

        // Turn appropriate direction
        rotateCopter(heading+ITER_OFFSET);

        // Wait for new orientation to settle out
        Delay_ms(ORIENTATION_DELAY);
  }
  
   // Value comparisons go one step too far, turn clockwise one step
   heading = 0; //CurrentMagHeading();
   rotateCopter(heading-INIT_OFFSET);

   // Wait for new orientation to settle out
   Delay_ms(ORIENTATION_DELAY);
  
  // Save goal orientation
  goalHeading = getCurrentHeading();
  
  return true;
}

/*      main function
        1) reorients copter for sensor data (reorientCopter)
        2) gets sensor data, (gatherSignalStrength)
        3) calls updateGoal with signal strength data.
*/
boolean calcDirection(void)
{
  uint32 oldADCValue = MAGNITUDE_MAX;
  uint16 heading;

  while (oldADCValue > adcValue)
  {
        oldADCValue = adcValue;
        // Get current magnetometer heading
        heading = getCurrentHeading();

        // Turn appropriate direction
        rotateCopter(heading+ITER_OFFSET);

        // Wait for new orientation to settle out
        Delay_ms(ORIENTATION_DELAY);
  }

   // Value comparisons go one step too far, turn back one step
   heading = getCurrentHeading();
   rotateCopter(heading-ITER_OFFSET);

   // Wait for new orientation to settle out
   Delay_ms(ORIENTATION_DELAY);

   heading = getCurrentHeading();
   updateGoal(heading);

  return true;

}


// uses goalDirection and signal strength to update path planning algo (updateMapGoal).
boolean updateGoal(uint16 newHeading)
{
    if (((adcValue - MAGNITUDE_MAX)&0x7fff) < GOAL_THRESHOLD)
        updateMode(FOUND_THAT_SHIT_MODE);
    else
    {
        uint8 row, col;
        int8 deltaRow, deltaCol;
        uint16 deltaAngle = newHeading-goalHeading;

        // Trig Magic
        // TODO: watch for rounding issues here, also rad vs deg
        deltaRow = (cos(deltaAngle)*10)/3;
        deltaCol = (sin(deltaAngle)*10)/3;

        getQuadPostion(row, col);
        updateMapGoal(row+deltaRow, col+deltaCol);
    }
    
    return true;

}