#ifndef _UART_H_
#define _UART_H_

#include "StdTypes.h"

void UARTDebugInit();

void UARTSendString(uint8 * stringToSend);

void UARTSendChar(uint8 charToSend);

void UARTSendNewLine(void);

void UARTSendUint16(uint16 dataToSend);

void UARTSendDouble(double dataToSend);

#endif //_UART_H_