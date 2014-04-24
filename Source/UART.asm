_UARTDebugInit:
;UART.c,4 :: 		void UARTDebugInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;UART.c,6 :: 		UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;UART.c,7 :: 		}
L_end_UARTDebugInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UARTDebugInit
_UARTSendString:
;UART.c,9 :: 		void UARTSendString(uint8 * stringToSend)
; stringToSend start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R5, R0
; stringToSend end address is: 0 (R0)
; stringToSend start address is: 20 (R5)
;UART.c,11 :: 		UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
MOVW	R3, #lo_addr(_UART1_Tx_Idle+0)
MOVT	R3, #hi_addr(_UART1_Tx_Idle+0)
MOVW	R2, #lo_addr(_UART1_Data_Ready+0)
MOVT	R2, #hi_addr(_UART1_Data_Ready+0)
MOVW	R1, #lo_addr(_UART1_Write+0)
MOVT	R1, #hi_addr(_UART1_Write+0)
MOVW	R0, #lo_addr(_UART1_Read+0)
MOVT	R0, #hi_addr(_UART1_Read+0)
BL	_UART_Set_Active+0
;UART.c,12 :: 		UART1_Write_Text(stringToSend);
MOV	R0, R5
; stringToSend end address is: 20 (R5)
BL	_UART1_Write_Text+0
;UART.c,13 :: 		UART1_Write(13);                             // put cursor back at left
MOVS	R0, #13
BL	_UART1_Write+0
;UART.c,14 :: 		UART1_Write(10);                             // newline
MOVS	R0, #10
BL	_UART1_Write+0
;UART.c,15 :: 		}
L_end_UARTSendString:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UARTSendString
_UARTSendChar:
;UART.c,17 :: 		void UARTSendChar(uint8 charToSend)
; charToSend start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
; charToSend end address is: 0 (R0)
; charToSend start address is: 20 (R5)
;UART.c,19 :: 		UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
MOVW	R3, #lo_addr(_UART1_Tx_Idle+0)
MOVT	R3, #hi_addr(_UART1_Tx_Idle+0)
MOVW	R2, #lo_addr(_UART1_Data_Ready+0)
MOVT	R2, #hi_addr(_UART1_Data_Ready+0)
MOVW	R1, #lo_addr(_UART1_Write+0)
MOVT	R1, #hi_addr(_UART1_Write+0)
MOVW	R0, #lo_addr(_UART1_Read+0)
MOVT	R0, #hi_addr(_UART1_Read+0)
BL	_UART_Set_Active+0
;UART.c,20 :: 		UART1_Write(charToSend);
UXTB	R0, R5
; charToSend end address is: 20 (R5)
BL	_UART1_Write+0
;UART.c,21 :: 		}
L_end_UARTSendChar:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UARTSendChar
_UARTSendNewLine:
;UART.c,23 :: 		void UARTSendNewLine(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;UART.c,25 :: 		UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
MOVW	R3, #lo_addr(_UART1_Tx_Idle+0)
MOVT	R3, #hi_addr(_UART1_Tx_Idle+0)
MOVW	R2, #lo_addr(_UART1_Data_Ready+0)
MOVT	R2, #hi_addr(_UART1_Data_Ready+0)
MOVW	R1, #lo_addr(_UART1_Write+0)
MOVT	R1, #hi_addr(_UART1_Write+0)
MOVW	R0, #lo_addr(_UART1_Read+0)
MOVT	R0, #hi_addr(_UART1_Read+0)
BL	_UART_Set_Active+0
;UART.c,26 :: 		UART1_Write(10);
MOVS	R0, #10
BL	_UART1_Write+0
;UART.c,27 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;UART.c,28 :: 		}
L_end_UARTSendNewLine:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UARTSendNewLine
_UARTSendUint16:
;UART.c,30 :: 		void UARTSendUint16(uint16 dataToSend)
; dataToSend start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R5, R0
; dataToSend end address is: 0 (R0)
; dataToSend start address is: 20 (R5)
;UART.c,32 :: 		UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
MOVW	R3, #lo_addr(_UART1_Tx_Idle+0)
MOVT	R3, #hi_addr(_UART1_Tx_Idle+0)
MOVW	R2, #lo_addr(_UART1_Data_Ready+0)
MOVT	R2, #hi_addr(_UART1_Data_Ready+0)
MOVW	R1, #lo_addr(_UART1_Write+0)
MOVT	R1, #hi_addr(_UART1_Write+0)
MOVW	R0, #lo_addr(_UART1_Read+0)
MOVT	R0, #hi_addr(_UART1_Read+0)
BL	_UART_Set_Active+0
;UART.c,33 :: 		UART1_Write((dataToSend/10000)+48);
MOVW	R1, #10000
UDIV	R1, R5, R1
UXTH	R1, R1
ADDS	R1, #48
UXTH	R0, R1
BL	_UART1_Write+0
;UART.c,34 :: 		UART1_Write(((dataToSend%10000)/1000)+48);
MOVW	R1, #10000
UDIV	R2, R5, R1
MLS	R2, R1, R2, R5
UXTH	R2, R2
MOVW	R1, #1000
UDIV	R1, R2, R1
UXTH	R1, R1
ADDS	R1, #48
UXTH	R0, R1
BL	_UART1_Write+0
;UART.c,35 :: 		UART1_Write(((dataToSend%1000)/100)+48);
MOVW	R1, #1000
UDIV	R2, R5, R1
MLS	R2, R1, R2, R5
UXTH	R2, R2
MOVS	R1, #100
UDIV	R1, R2, R1
UXTH	R1, R1
ADDS	R1, #48
UXTH	R0, R1
BL	_UART1_Write+0
;UART.c,36 :: 		UART1_Write(((dataToSend%100)/10)+48);
MOVS	R1, #100
UDIV	R2, R5, R1
MLS	R2, R1, R2, R5
UXTH	R2, R2
MOVS	R1, #10
UDIV	R1, R2, R1
UXTH	R1, R1
ADDS	R1, #48
UXTH	R0, R1
BL	_UART1_Write+0
;UART.c,37 :: 		UART1_Write((dataToSend%10)+48);
MOVS	R2, #10
UDIV	R1, R5, R2
MLS	R1, R2, R1, R5
UXTH	R1, R1
; dataToSend end address is: 20 (R5)
ADDS	R1, #48
UXTH	R0, R1
BL	_UART1_Write+0
;UART.c,38 :: 		UART1_Write(10);
MOVS	R0, #10
BL	_UART1_Write+0
;UART.c,39 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;UART.c,40 :: 		}
L_end_UARTSendUint16:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UARTSendUint16
_UARTSendDouble:
;UART.c,42 :: 		void UARTSendDouble(double dataToSend)
; dataToSend start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R9, R0
; dataToSend end address is: 0 (R0)
; dataToSend start address is: 36 (R9)
;UART.c,44 :: 		char test = 0;
;UART.c,47 :: 		UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle); // set UART1 active
MOVW	R3, #lo_addr(_UART1_Tx_Idle+0)
MOVT	R3, #hi_addr(_UART1_Tx_Idle+0)
MOVW	R2, #lo_addr(_UART1_Data_Ready+0)
MOVT	R2, #hi_addr(_UART1_Data_Ready+0)
MOVW	R1, #lo_addr(_UART1_Write+0)
MOVT	R1, #hi_addr(_UART1_Write+0)
MOVW	R0, #lo_addr(_UART1_Read+0)
MOVT	R0, #hi_addr(_UART1_Read+0)
BL	_UART_Set_Active+0
;UART.c,49 :: 		dataHolder = (long)(dataToSend/100000);
MOVW	R2, #20480
MOVT	R2, #18371
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
; dataHolder start address is: 16 (R4)
MOV	R4, R0
;UART.c,50 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,51 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,53 :: 		dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 100000)))/10000;
MOV	R0, R4
BL	__SignedIntegralToFloat+0
; dataHolder end address is: 16 (R4)
MOVW	R2, #20480
MOVT	R2, #18371
BL	__Mul_FP+0
STR	R0, [SP, #8]
STR	R1, [SP, #4]
LDR	R1, [SP, #8]
MOV	R2, R1
MOV	R0, R9
BL	__Sub_FP+0
LDR	R1, [SP, #4]
BL	_floor+0
BL	__FloatToSignedIntegral+0
MOVW	R1, #10000
SDIV	R1, R0, R1
;UART.c,54 :: 		test = (char)(dataHolder+48);
ADDS	R1, #48
;UART.c,55 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,57 :: 		dataHolder = (long)(dataToSend/10000);
MOVW	R2, #16384
MOVT	R2, #17948
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
;UART.c,58 :: 		dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 10000)))/1000;
BL	__SignedIntegralToFloat+0
MOVW	R2, #16384
MOVT	R2, #17948
BL	__Mul_FP+0
STR	R0, [SP, #8]
STR	R1, [SP, #4]
LDR	R1, [SP, #8]
MOV	R2, R1
MOV	R0, R9
BL	__Sub_FP+0
LDR	R1, [SP, #4]
BL	_floor+0
BL	__FloatToSignedIntegral+0
MOVW	R1, #1000
SDIV	R1, R0, R1
;UART.c,59 :: 		test = (char)(dataHolder+48);
ADDS	R1, #48
;UART.c,60 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,62 :: 		dataHolder = (long)(dataToSend/1000);
MOVW	R2, #0
MOVT	R2, #17530
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
;UART.c,63 :: 		dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 1000)))/100;
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #17530
BL	__Mul_FP+0
STR	R0, [SP, #8]
STR	R1, [SP, #4]
LDR	R1, [SP, #8]
MOV	R2, R1
MOV	R0, R9
BL	__Sub_FP+0
LDR	R1, [SP, #4]
BL	_floor+0
BL	__FloatToSignedIntegral+0
MOVS	R1, #100
SDIV	R1, R0, R1
;UART.c,64 :: 		test = (char)(dataHolder+48);
ADDS	R1, #48
;UART.c,65 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,67 :: 		dataHolder = (long)(dataToSend/100);
MOVW	R2, #0
MOVT	R2, #17096
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
;UART.c,68 :: 		dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 100)))/10;
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Mul_FP+0
STR	R0, [SP, #8]
STR	R1, [SP, #4]
LDR	R1, [SP, #8]
MOV	R2, R1
MOV	R0, R9
BL	__Sub_FP+0
LDR	R1, [SP, #4]
BL	_floor+0
BL	__FloatToSignedIntegral+0
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,69 :: 		test = (char)(dataHolder+48);
ADDS	R1, #48
;UART.c,70 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,72 :: 		dataHolder = (long)(dataToSend/10);
MOVW	R2, #0
MOVT	R2, #16672
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
;UART.c,73 :: 		dataHolder = ((long)floor(dataToSend - ((double)(dataHolder) * 10)));
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
STR	R1, [SP, #4]
LDR	R1, [SP, #8]
MOV	R2, R1
MOV	R0, R9
BL	__Sub_FP+0
LDR	R1, [SP, #4]
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,74 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,75 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,76 :: 		UART1_Write('.');
MOVS	R0, #46
BL	_UART1_Write+0
;UART.c,78 :: 		floatHolder = (long)(dataToSend/.1);
MOVW	R2, #52429
MOVT	R2, #15820
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
; floatHolder start address is: 32 (R8)
MOV	R8, R0
;UART.c,79 :: 		dataHolder = (long)(floatHolder/10);
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,80 :: 		dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
MOV	R0, R1
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOV	R0, R8
BL	__SignedIntegralToFloat+0
; floatHolder end address is: 32 (R8)
LDR	R2, [SP, #8]
BL	__Sub_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,81 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,82 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,84 :: 		floatHolder = (long)(dataToSend/.01);
MOVW	R2, #55050
MOVT	R2, #15395
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
; floatHolder start address is: 32 (R8)
MOV	R8, R0
;UART.c,85 :: 		dataHolder = (long)(floatHolder/10);
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,86 :: 		dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
MOV	R0, R1
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOV	R0, R8
BL	__SignedIntegralToFloat+0
; floatHolder end address is: 32 (R8)
LDR	R2, [SP, #8]
BL	__Sub_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,87 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,88 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,90 :: 		floatHolder = (long)(dataToSend/.001);
MOVW	R2, #4719
MOVT	R2, #14979
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
; floatHolder start address is: 32 (R8)
MOV	R8, R0
;UART.c,91 :: 		dataHolder = (long)(floatHolder/10);
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,92 :: 		dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
MOV	R0, R1
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOV	R0, R8
BL	__SignedIntegralToFloat+0
; floatHolder end address is: 32 (R8)
LDR	R2, [SP, #8]
BL	__Sub_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,93 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,94 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,96 :: 		floatHolder = (long)(dataToSend/.0001);
MOVW	R2, #46871
MOVT	R2, #14545
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
; floatHolder start address is: 32 (R8)
MOV	R8, R0
;UART.c,97 :: 		dataHolder = (long)(floatHolder/10);
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,98 :: 		dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
MOV	R0, R1
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOV	R0, R8
BL	__SignedIntegralToFloat+0
; floatHolder end address is: 32 (R8)
LDR	R2, [SP, #8]
BL	__Sub_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,99 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,100 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,102 :: 		floatHolder = (long)(dataToSend/.00001);
MOVW	R2, #50604
MOVT	R2, #14119
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
; floatHolder start address is: 32 (R8)
MOV	R8, R0
;UART.c,103 :: 		dataHolder = (long)(floatHolder/10);
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,104 :: 		dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
MOV	R0, R1
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOV	R0, R8
BL	__SignedIntegralToFloat+0
; floatHolder end address is: 32 (R8)
LDR	R2, [SP, #8]
BL	__Sub_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,105 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,106 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,108 :: 		floatHolder = (long)(dataToSend/.000001);
MOVW	R2, #14269
MOVT	R2, #13702
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
; floatHolder start address is: 32 (R8)
MOV	R8, R0
;UART.c,109 :: 		dataHolder = (long)(floatHolder/10);
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,110 :: 		dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
MOV	R0, R1
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOV	R0, R8
BL	__SignedIntegralToFloat+0
; floatHolder end address is: 32 (R8)
LDR	R2, [SP, #8]
BL	__Sub_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,111 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,112 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,114 :: 		floatHolder = (long)(dataToSend/.0000001);
MOVW	R2, #49045
MOVT	R2, #13270
MOV	R0, R9
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
; floatHolder start address is: 32 (R8)
MOV	R8, R0
;UART.c,115 :: 		dataHolder = (long)(floatHolder/10);
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,116 :: 		dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
MOV	R0, R1
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOV	R0, R8
BL	__SignedIntegralToFloat+0
; floatHolder end address is: 32 (R8)
LDR	R2, [SP, #8]
BL	__Sub_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,117 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,118 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,120 :: 		floatHolder = (long)(dataToSend/.00000001);
MOVW	R2, #52343
MOVT	R2, #12843
MOV	R0, R9
BL	__Div_FP+0
; dataToSend end address is: 36 (R9)
BL	__FloatToSignedIntegral+0
; floatHolder start address is: 32 (R8)
MOV	R8, R0
;UART.c,121 :: 		dataHolder = (long)(floatHolder/10);
MOVS	R1, #10
SDIV	R1, R0, R1
;UART.c,122 :: 		dataHolder = ((long)floor(floatHolder - ((double)(dataHolder) * 10)));
MOV	R0, R1
BL	__SignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOV	R0, R8
BL	__SignedIntegralToFloat+0
; floatHolder end address is: 32 (R8)
LDR	R2, [SP, #8]
BL	__Sub_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
;UART.c,123 :: 		test = (char)(dataHolder+48);
ADDW	R1, R0, #48
;UART.c,124 :: 		UART1_Write(test);
UXTB	R0, R1
BL	_UART1_Write+0
;UART.c,125 :: 		UART1_Write(10);
MOVS	R0, #10
BL	_UART1_Write+0
;UART.c,126 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;UART.c,127 :: 		}
L_end_UARTSendDouble:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _UARTSendDouble
