#ifndef _SONAR_H_
#define _SONAR_H_

#include "StdTypes.h"

#define SONAR_1_PORT              GPIOB_BASE
#define SONAR_1_TX_PIN_MASK       _GPIO_PINMASK_10
#define SONAR_1_RX_PIN_MASK       _GPIO_PINMASK_11

#define SONAR_1_TX                IDR10_GPIOB_IDR_bit
#define SONAR_1_RX                ODR11_GPIOB_ODR_bit

//104 MicroSeconds between bit reads;
#define SONAR_BIT_DELAY 104

#define SONAR_AVG_READ               20

void sonarInit();

boolean sonarRead();

uint8 rs232ByteRead();

void calcObstacle(uint16 rangeToObstacle);

#endif //_SONAR_H_