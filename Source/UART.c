#include "UART.h"
#include "StdTypes.h"

void UARTDebugInit()
{
     UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
}

void UARTSendString(uint8 * stringToSend)
{
     UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
     UART1_Write_Text(stringToSend);
     UART1_Write(13);                             // put cursor back at left
     UART1_Write(10);                             // newline
}

void UARTSendChar(uint8 charToSend)
{
     UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
     UART1_Write(charToSend);
}

void UARTSendNewLine(void)
{
     UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
     UART1_Write(10);
     UART1_Write(13);
}

void UARTSendUint16(uint16 dataToSend)
{
     UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
     UART1_Write((dataToSend/10000)+48);
     UART1_Write(((dataToSend%10000)/1000)+48);
     UART1_Write(((dataToSend%1000)/100)+48);
     UART1_Write(((dataToSend%100)/10)+48);
     UART1_Write((dataToSend%10)+48);
     UART1_Write(10);
     UART1_Write(13);
}

void UARTSendDouble(double dataToSend)
{
     char test = 0;
     long dataHolder;
     long floatHolder;
     UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active

     dataHolder = (long)(dataToSend/100000);
     test = (char)(dataHolder+48);
     UART1_Write(test);

     dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 100000)))/10000;
     test = (char)(dataHolder+48);
     UART1_Write(test);

     dataHolder = (long)(dataToSend/10000);
     dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 10000)))/1000;
     test = (char)(dataHolder+48);
     UART1_Write(test);

     dataHolder = (long)(dataToSend/1000);
     dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 1000)))/100;
     test = (char)(dataHolder+48);
     UART1_Write(test);

     dataHolder = (long)(dataToSend/100);
     dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 100)))/10;
     test = (char)(dataHolder+48);
     UART1_Write(test);

     dataHolder = (long)(dataToSend/10);
     dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);
     UART1_Write('.');

     floatHolder = (long)(dataToSend/.1);
     dataHolder = (long)(floatHolder/10);
     dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);

     floatHolder = (long)(dataToSend/.01);
     dataHolder = (long)(floatHolder/10);
     dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);

     floatHolder = (long)(dataToSend/.001);
     dataHolder = (long)(floatHolder/10);
     dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);

     floatHolder = (long)(dataToSend/.0001);
     dataHolder = (long)(floatHolder/10);
     dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);

     floatHolder = (long)(dataToSend/.00001);
     dataHolder = (long)(floatHolder/10);
     dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);

     floatHolder = (long)(dataToSend/.000001);
     dataHolder = (long)(floatHolder/10);
     dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);

     floatHolder = (long)(dataToSend/.0000001);
     dataHolder = (long)(floatHolder/10);
     dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);

     floatHolder = (long)(dataToSend/.00000001);
     dataHolder = (long)(floatHolder/10);
     dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
     test = (char)(dataHolder+48);
     UART1_Write(test);
     UART1_Write(10);
     UART1_Write(13);
}