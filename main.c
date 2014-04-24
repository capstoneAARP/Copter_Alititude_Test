/**********************************************
*     Capstone
*     JTOS
*     by Joshua Cunningham
**********************************************/

//#include "PathPlanning.h"
//#include "Sonar.h"
#include "UART.h"
//#include "scheduler.h"
#include "StdTypes.h"
#include "blink.h"
#include "FlightControl.h"
//#include "MovementControl.h"
#include "NotTriangulation.h"


//************************************************** ****
// header files of tasks:
//#include "blink.h"
//#include "button.h"
//#include "myuart.h"
//#include "mytime.h"

//************************************************** ****
// interval defines:
//#define BLINK_INTERVAL 1000
//#define BUTTON_INTERVAL 10
//#define MYUART_INTERVAL 500
#define MAIN_TESTING_INTERVAL_MS                1000

#define NUM_FUNC                                1


//************************************************** ****
typedef void (*SliceFunctions) ();                    // pointer array for the functions
//************************************************** ****
// Globals:
int current_func = 0;                                 // initialize to first function
int func_flag = 0;                                    // start with the LED pin off
unsigned long service_time[NUM_FUNC];                  // keep track of the seperate function time
volatile unsigned long msTicks = 0;                   // mS count
unsigned long millis();                               // function to return mS count



//************************************************** ****
// test 1 thread
void mainTestingThread()
{
     //volatile int i;
     //volatile int j;
     boolean success;
     
     //updateMapGoal(0,7);
     UARTSendString("Delay for GPS Signal.");
     Delay_ms(10000);
     UARTSendString("Starting test9.");

     StabilizeMode();  //Set to Stabilize mode for takeoff (Only needed for loop mode - the StabilizeMode() above will place the quad in correct mode for arming
     Delay_ms(500);
     Arm();            //Arm the quad rotors
     success = TakeOff();

     if(success == true)
     {
       LoiterMode();
       Stabilize_Alt();
       LoiterMode();
       Delay_ms(10000);
       /*
       for(j = 0; j < 10; j++)
       {
         for(i = 0; i < 3; i++)
         {
               sonarRead();
               //findPath();
         }
         printMap();
         if(checkObstacleFront() == true)
         {
              UARTSendString("Found an obstacle.");
              Delay_ms(1000);
              
              Yaw_Right(4000);
              Delay_ms(1000);
              Forward_Flight();
              Delay_ms(2000);
              Stop_Forward();
              Delay_ms(1000);
              
              UARTSendString("Landing now.");
              
              LandingMode();
              Delay_ms(20000);
              DisArm();
              while(1)
              {
                   Delay_ms(250);
              }
         }
         //move foward
         Forward_Flight();
         Delay_ms(1500);
         Stop_Forward();
       }
       */
     }
     UARTSendString("Returning to base.");
     LandingMode();
     Delay_ms(20000);
     DisArm();
     
     while(1)
     {
        Delay_ms(500);
     }
}
//************************************************** ****




//************************************************** ****
//all the tasks in an array
const SliceFunctions functions[] =
{

  blink_led,
  //button_check,
  //myuart_check,
  //mytime_check,
  //mainTestingThread,
};

//************************************************** ****
//define service-time intervals, in order of functions[]
unsigned long func_time[] =
{
  BLINK_INTERVAL,                                            // LED func interval
  //BUTTON_INTERVAL,                                             // button func interval
  //MYUART_INTERVAL,
  //MYTIME_INTERVAL,
  //MAIN_TESTING_INTERVAL_MS,
};                      //time between services for different functions in mS




//************************************************** ****
// SysTick initialization
void InitSysTick()
{
  // Clear SysTick Control and Status Register
  NVIC_SYSTICKCSR = 0;

  // SysTick Reload Value Register
  NVIC_SYSTICKRVR = 60000;
  // Reload value when the timer reaches 0 (value = fclock [MHz] * desired_period [s] => 8,000,000 * 0.001 => 8000 <=> 1 ms,
  // the SysTick Timer will generate an Interrupt at every 1 ms). The SysTick Timer Reload Value must be in 24 bits range.

  // SysTick Current Value Register
  NVIC_SYSTICKCVR = 0; // Set Curent Value Register

  // (Calibration value, default 9000 = 3 ms for a 3 Mhz clock speed)
  NVIC_SYSTICKCALVR = 9000;

  // Set SysTick Control and Status Register
  NVIC_SYSTICKCSR.B0 = 1; // SysTick Timer Enable
  NVIC_SYSTICKCSR.B1 = 1; // Enable SysTick Interrupt generation
  NVIC_SYSTICKCSR.B2 = 1; // Use processor free runing clock
}


/*----------------------------------------------------------------------------
  SysTick_Handler
 *----------------------------------------------------------------------------*/
void SysTick_ISR() iv IVT_INT_SysTick ics ICS_AUTO          // once every mS
{
GPIOC_ODR ^= _GPIO_PINMASK_9;
  TIM2_SR.UIF = 0;
  msTicks++;
  current_func++;                                           //switch to next function
  if (current_func == NUM_FUNC)                              //test for end of function
    current_func = 0;                                        //if so, restart at first function
  func_flag = 1;                                    //tell main() that there is a function ready
}

//************************************************** ****
// Initialize program needs
void init_prog()
{
  //blink_init();
  //button_init();
  //myuart_init();

// Turn on interrupts
  //EnableInterrupts();

// Initialize timers
  //InitSysTick();
  //InitTimer2();
  UARTDebugInit();
  Delay_ms(250);
  //pathPlanningInit();
  //movementControlInit();
  //sonarInit();
  
  Flight_Control_Init();
  //notTriangulationInit();
  
  mainTestingThread();
  
  //sch_init();
  
  //EnableInterrupts();
}

//************************************************** ****
// Main loop
void main()
{
// Variables:

// setup
  init_prog();

// main loop
/*
  while(1)
  {
    if (func_flag !=0 && millis() - service_time[current_func] >= func_time[current_func])    //wait for function ready flag, and test if time interval has passed
    {
      service_time[current_func] = millis();                    //reset time interval
      functions[current_func]();                                //call next function
      func_flag = 0;
    }
  }
*/
}

//************************************************** ****
unsigned long millis()
{
  return msTicks;                                      // function to return milliseconds
}