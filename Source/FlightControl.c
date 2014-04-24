#include "FlightControl.h"
#include "StdTypes.h"
#include "UART.h"

// Variables for motor control pwm
float pwm_period1, pwm_period2;
float    current_DC = 7.4;       //Mid PWM ((Mid stick setting)
float    current_DC_2 = 5.0;     //Low PWM (Low stick setting)
float    current_DC_3 = 5.5;     //PWM target for Flight mode 2 on Arducopter
float   current_DC_4 = 9.9;     //MAX value for PWM for ARM'ing the quad (Max stick setting)
float    current_DC_8 = 9.5;     //For Loiter Mode
float   current_DC_9 = 8.3;     //For Landing Mode  RTL
float   current_DC_7 = 7.4;     //land at current position
uint16 DC_time, DC_time_2, DC_time_3;

void Flight_Control_Init()
{
       Init_ADC();
       Init_Pwm();
       Init_LED();
}

void Init_LED(){
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_8 | _GPIO_PINMASK_9); // Set PORTC as digital output
  GPIOC_ODR.B8 = 0;
  GPIOC_ODR.B9 = 0;
  Delay_ms(250);
  GPIOC_ODR.B8 = 1;
}

void Init_ADC(){
  //ADC for Ultrasonic Sensor input
  ADC_Set_Input_Channel(_ADC_CHANNEL_13);                     // Choose ADC channel
  ADC1_Init();
  Delay_ms(100);
}

void Init_Pwm(){
     //Set up PWM frequency to match quad receiver output = 49Hz
     pwm_period1 = PWM_TIM3_Init(49);     //AUX channel(s) timer
     pwm_period2 = PWM_TIM2_Init(49);     //Throttle, Yaw, Pitch, Roll timer

     DC_time = (current_DC*pwm_period2)/100;       //Set Yaw, Pitch and Roll to mid stick
     DC_time_2 = (current_DC_2*pwm_period2)/100;    //Set the duty cycle to very low - for initial THROTTLE settings
     DC_time_3 = (current_DC_2*pwm_period2)/100;    //Set the duty cycle to very low for AUX1 - (channel 5)

     //Set up PWM for control channels
     PWM_TIM2_Set_Duty(DC_time_2, _PWM_NON_INVERTED, _PWM_CHANNEL1);     //for THROTTLE
     PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
     PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);       //for PITCH
     PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL4);       //for ROLL
     PWM_TIM3_Set_Duty(DC_time_3, _PWM_NON_INVERTED, _PWM_CHANNEL1);     //set AUX1 to low for gyro stabilization
     //Start the PWM
     PWM_TIM2_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM2_CH1_PA0);    //for THROTTLE
     PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);    //for YAW
     PWM_TIM2_Start(_PWM_CHANNEL3, &_GPIO_MODULE_TIM2_CH3_PA2);    //for PITCH
     PWM_TIM2_Start(_PWM_CHANNEL4, &_GPIO_MODULE_TIM2_CH4_PA3);    //for ROLL
     PWM_TIM3_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM3_CH1_PA6);    //set AUX1 to low for gyro stabilization
}

void Arm(){
     // Throttle off at duty cycle 5.0
     DC_time = (current_DC_2*pwm_period2)/100;
             PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);   //for THROTTLE
     // YAW (rudder) all the way to the right (ARM'ing mode)
     
     DC_time = (current_DC_4*pwm_period2)/100;
             PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);   //for YAW
     delay_ms(5000);  //Delay for Arducopter to notice 'ARM motors' command  (~2500ms is the smallest amount I found to work) however Arducopter says 5000ms
     //Set YAW (rudder) to neutral
     DC_time = (current_DC*pwm_period2)/100;
             PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
     Delay_ms(6000);  //When APM is first turned on - need this interval to allow for APM auto-calibration
     //Throttle needs to be adjusted (or "moved") within 15 seconds of 'arming' or quad will automatically disarm http://copter.ardupilot.com/wiki/arming_the_motors/
}

void Throttle_Off(){
 current_DC_2 = 5.0;
     DC_time = (current_DC_2*pwm_period2)/100;
            PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

void DisArm(){
     // Throttle all the way off
     Throttle_Off();
     //Small delay to settle the motors
     Delay_ms(1000);
     // Left Yaw all the way Left (DISARM'ing mode)
     DC_time = (current_DC_2*pwm_period2)/100;
     PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
     Delay_ms(3000);  //Delay for Arducopter to notice 'DISARM motors' command  (~2000 ms is the smallest amount to use)  http://copter.ardupilot.com/wiki/arming_the_motors/

     //Set YAW back to neutral position
     DC_time = (current_DC*pwm_period2)/100;
     PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
     Delay_ms(2000);   //Probably non necessary delay but allows time for the Ardupilot to register the DisArm stick position
}

boolean TakeOff()
{
    uint16 sonarReadValue;
    current_DC_3 = STARTING_THROTTLE_VALUE;  //Start motors at this value to predict timing-iterations in launch sequence
    UARTSendString("Taking off7.");
    while(current_DC_3 < MAX_THROTTLE_VALUE){
       current_DC_3 += THROTLE_STEP_SIZE;
       //Start increasing Throttle
       DC_time = (current_DC_3*pwm_period2)/100;
       PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
       //Do not start taking US readings until flight barely begins - and/or maybe a little off the ground.
       if(current_DC_3 >= LIMIT_THROTTLE_VALUE)
       {
           sonarReadValue = alitudeSonarRead();
           UARTSendString("Sonar average.");
           UARTSendUint16(sonarReadValue);
           UARTSendNewLine();
           UARTSendString("Throttle");
           UARTSendDouble(current_DC_3);

           // Failsafe if no altitude reached and throttle is maxing out exit this routine
           if (sonarReadValue <= MINIMUM_ALITITUDE && current_DC_3 >= MAX_THROTTLE_VALUE)
           {
                UARTSendString("Failed to reach altitude.");
                Throttle_Off();
                GPIOC_ODR.B9 = 0; //Green LED Off - Indicates that the max throttle was reached but height off ground not acheived
                return false;
           }
           if (current_DC_3 >= MAX_THROTTLE_VALUE)
           {
              UARTSendString("Max Throttle.");
              GPIOC_ODR.B9 = 1;
              return true;
           }
           if(sonarReadValue == 255)
           {
                UARTSendString("Sonar reads 255 return false.");
                GPIOC_ODR.B9 = 0; //Green LED Off - Indicates that the max throttle was reached but height off ground not acheived
                return false;
           }
           if (sonarReadValue >= TAKEOFF_ALITITUDE)
           {  //If altitude is greater than 24 inches off the ground return to main function to enable loiter mode   (1E = 30INCHES)E
                UARTSendString("Reached Alitutude.");
                GPIOC_ODR.B9 = 1;   //Green LED Solid On - Indicates that target height off ground acheived
                return true;
           }
       }
       GPIOC_ODR.B9 = ~GPIOC_ODR.B9; // Toggle PORTC
       Delay_ms(TAKEOFF_LOOP_DELAY_MS);
    }
}

void LoiterMode(){
    DC_time = (current_DC_8*pwm_period2)/100;
            PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

void StabilizeMode(){
    DC_time = (current_DC_3*pwm_period2)/100;
            PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

//Currently RTL mode
void LandingMode(){
    DC_time = (current_DC_9*pwm_period2)/100;
            PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

void Land(){
    DC_time = (current_DC_7*pwm_period2)/100;
    PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
}

void Yaw_Left(uint16 timeToYaw_ms){
  DC_time = (8.0*pwm_period2)/100;
  PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
  Vdelay_ms(timeToYaw_ms);
  Yaw_Stop();
}

void Yaw_Right(const uint16 timeToYaw_ms){
  DC_time = (6.8*pwm_period2)/100;
  PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
  Vdelay_ms(timeToYaw_ms);
  Yaw_Stop();
}

void Yaw_Stop(){
  DC_time = (current_DC*pwm_period2)/100;
  PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
}

void Forward_Flight(){
   DC_time = (6.5*pwm_period2)/100;
   PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);       //for PITCH
}

void Stop_Forward(){
   DC_time = (current_DC*pwm_period2)/100;
   PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);       //for PITCH
}

uint16 alitudeSonarRead()
{
   uint16 sonarArray[SONAR_ITERATIONS] = {0};
   int16 i = 0;
   uint32 sonarAvg = 0;
   uint32 secondAvg = 0;
   uint8 anomolyCount = 0;
   
   //Start averaging of Ultrasonic readings
   for(i=0; i < SONAR_ITERATIONS; i++)
   {
      sonarArray[i] = ADC1_Get_Sample(13);                          // Get ADC value from corresponding channel
      sonarArray[i] >>= 4;
      //UARTSendUint16(sonarArray[i]);
      if(sonarArray[i] >= SONAR_MAX_VALUE)
      {
          //bad value
          i--;
          anomolyCount++;
          if(anomolyCount > MAX_ANOMOLY_TOSS)
          {
              return 255;
          }
      }
      else
      {
          sonarAvg += sonarArray[i];
      }
      Delay_ms(ALITUDE_SONAR_READ_DELAY);
   }
   sonarAvg = sonarAvg/SONAR_ITERATIONS;
   secondAvg = 0;
   for(i=0; i < SONAR_ITERATIONS; i++)
   {
      if(sonarArray[i] >= sonarAvg + SONAR_OUTLIER_OFFSET)
      {
          sonarArray[i] = sonarAvg;
      }
      secondAvg += sonarArray[i];
   }
   return((uint16)secondAvg/SONAR_ITERATIONS);
}

void Stabilize_Alt()
{
   uint16 sonarAlititude = 0;
   uint8 failSafeCounter = 0;
   uint8 sonarReadIteration = 0;
   
   current_DC_3 = HOVER_THROTTLE_VALUE;
   DC_time = (current_DC_3*pwm_period2)/100;
   PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
   
   UARTSendString("Stablilizing Alititude.");
   sonarAlititude = alitudeSonarRead();
   UARTSendString("1st Sonar average.");
   UARTSendUint16(sonarAlititude);
   UARTSendNewLine();
   
   while((sonarAlititude < (ALTITUDE_HOLD - SONAR_ALITUDE_RANGE)) || (sonarAlititude > (ALTITUDE_HOLD + SONAR_ALITUDE_RANGE)))
   {
       if(failSafeCounter >= ALTITUDE_FAIL_SAFE_MAX)
       {
           UARTSendString("Breaking out, too many iterations.");
           return;
       }
       else if(sonarReadIteration >= ALITITUDE_SONAR_READ_ITER)
       {
         sonarReadIteration = 0;
         if(sonarAlititude > ALTITUDE_HOLD)
         {
             current_DC_3 -= ALT_THROTLE_STEP_SIZE;
             UARTSendString("Decrease Throttle.");
         }
         else if(sonarAlititude < ALTITUDE_HOLD)
         {
               current_DC_3 += ALT_THROTLE_STEP_SIZE;
               UARTSendString("Increase Throttle.");
         }
         GPIOC_ODR.B8 = ~GPIOC_ODR.B8;
         UARTSendString("Throttle:");
         UARTSendUint16(current_DC_3);

         DC_time = (current_DC_3*pwm_period2)/100;
         PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
         failSafeCounter++;
       }
       
       sonarAlititude = alitudeSonarRead();
       UARTSendUint16(sonarAlititude);
       sonarReadIteration++;
   }
   UARTSendString("Reached Altitude.");
}