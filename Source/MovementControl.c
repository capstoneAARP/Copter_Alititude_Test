#include "MovementControl.h"
#include "StdTypes.h"
#include "FlightControl.h"
#include "PathPlanning.h"

static uint16 currentHeading = 0;
static double latFeet = 0;
static double lonFeet = 0;

void movementControlInit(void)
{
        currentHeading = 0;
}

// moves quadcopter in direction for distance (ft)
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
                      return false;
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
                      return false;
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
                      return false;
        }
        Stop_Forward();
        
        return true;
}

// Function to reoreint copter
boolean rotateCopter(uint16 newHeading)
{
        uint16 diff = currentHeading - newHeading;
        uint16 timeToYaw_ms;
        
        if((newHeading % 10) != 0)
        {
               //only works in 10 deg increments
               return false;
        }
        
        if(diff == 0)
        {
                return true;
        }
        
        timeToYaw_ms = (diff/10)*MILI_SECONDS_PER_10_DEGREE_YAW;
        

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
        else //diff > 180
        {
                Yaw_Right(timeToYaw_ms);
        }

       currentHeading = newHeading;
       return true;
}

uint16 getCurrentHeading(void)
{
        return currentHeading;
}

boolean updateGPSCoordinate(int8 lonDegrees, double lonMinutes, char lonDirection, int8 latDegrees, double latMinutes, char latDirection)
{
     double lonFeetTemp = (lonDegrees + lonMinutes/SIXTY_MINUTES_PER_DEGREE)*FEET_PER_KM_PER_DEGREE;
     double latFeetTemp = (latDegrees + latMinutes/SIXTY_MINUTES_PER_DEGREE)*FEET_PER_KM_PER_DEGREE;
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
          return false;
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
          return false;
     }
     return true;
}