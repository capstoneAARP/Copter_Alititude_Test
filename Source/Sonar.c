#include "Sonar.h"
#include "StdTypes.h"
#include "PathPlanning.h"
#include "MovementControl.h"
#include "UART.h"
#include <math.h>

void sonarInit()
{
  GPIO_Digital_Input(&SONAR_1_PORT, SONAR_1_TX_PIN_MASK);
  GPIO_Digital_Output(&SONAR_1_PORT, SONAR_1_RX_PIN_MASK);

  SONAR_1_RX = 0;

  //delay for sensor power up
  Delay_ms(500);
  //start receive mode
  SONAR_1_RX = 1;
  //make sensor 2 read after sensor 1.

  //delay for first sensor read;
  Delay_ms(200);

  SONAR_1_RX = 0;
}

boolean sonarRead(void)
{
  uint8 sensorOutput1 [5] = {0};
  uint8 i;
  uint16 rangeToObstacle = 0;
  uint16 sensorReadArray[SONAR_AVG_READ] = {500};
  uint32 rangeSum = 0;
  boolean recalcAverage = false;
  
  SONAR_1_RX = 1;
  
  for(i = 0; i < SONAR_AVG_READ; i++)
  {
      sensorOutput1[0] = rs232ByteRead();
      sensorOutput1[1] = rs232ByteRead();
      sensorOutput1[2] = rs232ByteRead();
      sensorOutput1[3] = rs232ByteRead();
      
      //UARTSendString(sensorOutput1);

      //48 is the decimal offset for ASCII numbers values are in ASCII Decimal
      sensorReadArray[i] = (sensorOutput1[1] - 48)*100 + (sensorOutput1[2] - 48)*10 + (sensorOutput1[3] - 48);
      rangeSum += sensorReadArray[i];
      Delay_ms(10);
   }
   rangeToObstacle = (uint16) rangeSum/SONAR_AVG_READ;
   for(i = 0; i < SONAR_AVG_READ; i++)
   {
      //try to get rid of anomolies...
      if(sensorReadArray[i] <= (rangeToObstacle - 40))
      {
           sensorReadArray[i] = rangeToObstacle;
           recalcAverage = true;
      }
   }
   if(recalcAverage == true)
   {
       rangeSum = 0;
       for(i = 0; i < SONAR_AVG_READ; i++)
       {
             rangeSum += sensorReadArray[i];
       }
       rangeToObstacle = (uint16) rangeSum/SONAR_AVG_READ;
   }

  UARTSendString("Average: ");
  UARTSendUint16(rangeToObstacle);
  
  SONAR_1_RX = 0;

  //check if obstacle is less than 91 cm away
  if(rangeToObstacle <= ALLSTOP_DISTANCE)
  {
       //call all-stop 
       //TODO: WES define interface
       //allStop();
       //all stop mode
       updateMode(ALL_STOP_MODE);
  }

  //check if obstacle is in range 400cm
  if(rangeToObstacle > OBSTACLE_DETECT_DISTANCE)
  {
       //no obstacle in range
       return true;
  }
  calcObstacle(rangeToObstacle);
  
  return true;
}


uint8 rs232ByteRead()
{
  uint8 byteRead = 0;
  uint8 bitValueRead = 0;
  int i = 1;
  
  //wait for start bit
  while(SONAR_1_TX == 0);
  Delay_us(SONAR_BIT_DELAY);
  //read bits
  byteRead = SONAR_1_TX;

  //shift and read the rest of the bits.
  for(;i < 8; i++)
  {
    Delay_us(SONAR_BIT_DELAY);
    bitValueRead = SONAR_1_TX;
    byteRead |= (bitValueRead << i);
  }
  Delay_us(SONAR_BIT_DELAY);
  //invert for rs232
  return (~byteRead);
}

void calcObstacle(uint16 rangeToObstacle)
{
  float heading;
  uint8 quadXPos, quadYPos;
  float xPart, yPart;
  int8 xPosDiff, yPosDiff;
  
  //figure out what orientation the copter is in, caluculate obstacle position based on orientation
  getQuadPostion(&quadXPos, &quadYPos);
  heading = getCurrentHeading();
  
  // check which quadrant obstacle is in based on heading
  // top right quadrant
  if(heading > 0 && heading < 90)
  {
        yPart = (float)-1*rangeToObstacle*cos(heading*PI_DIVIDED_180);
        xPart = (float)rangeToObstacle*sin(heading*PI_DIVIDED_180);
  }
  //bottom right quad
  else if(heading > 90 && heading < 180)
  {
        yPart = (float)rangeToObstacle*sin((heading-90)*PI_DIVIDED_180);
        xPart = (float)rangeToObstacle*cos((heading-90)*PI_DIVIDED_180);
  }
  //bottom left quad
  else if(heading > 180 && heading < 270)
  {
        yPart = (float)rangeToObstacle*cos((heading-180)*PI_DIVIDED_180);
        xPart = (float)-1*rangeToObstacle*sin((heading-180)*PI_DIVIDED_180);
  }
  //top left quad
  else if(heading > 270)
  {
        yPart = (float)-1*rangeToObstacle*sin((heading-270)*PI_DIVIDED_180);
        xPart = (float)-1*rangeToObstacle*cos((heading-270)*PI_DIVIDED_180);
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
        //how the fuck did you get here?
        return;
  }
  
  if(xPart < 0)
  {
        xPosDiff = (int8)ceil(xPart/(SQUARE_SIDE_LENGTH));
  }
  else
  {
        xPosDiff = (int8)floor(xPart/(SQUARE_SIDE_LENGTH));
  }
  if(yPart < 0)
  {
        yPosDiff = (int8)ceil(yPart/(SQUARE_SIDE_LENGTH));
  }
  else
  {
        yPosDiff = (int8)floor(yPart/(SQUARE_SIDE_LENGTH));
  }
 
  //add obstacle
  addObstacle(quadYPos + yPosDiff, quadXPos + xPosDiff);
  
}