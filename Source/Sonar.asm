_sonarInit:
;Sonar.c,8 :: 		void sonarInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sonar.c,10 :: 		GPIO_Digital_Input(&SONAR_1_PORT, SONAR_1_TX_PIN_MASK);
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;Sonar.c,11 :: 		GPIO_Digital_Output(&SONAR_1_PORT, SONAR_1_RX_PIN_MASK);
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;Sonar.c,13 :: 		SONAR_1_RX = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR11_GPIOB_ODR_bit+0)
MOVT	R0, #hi_addr(ODR11_GPIOB_ODR_bit+0)
STR	R1, [R0, #0]
;Sonar.c,16 :: 		Delay_ms(500);
MOVW	R7, #19263
MOVT	R7, #76
NOP
NOP
L_sonarInit0:
SUBS	R7, R7, #1
BNE	L_sonarInit0
NOP
NOP
NOP
;Sonar.c,18 :: 		SONAR_1_RX = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR11_GPIOB_ODR_bit+0)
MOVT	R0, #hi_addr(ODR11_GPIOB_ODR_bit+0)
STR	R1, [R0, #0]
;Sonar.c,22 :: 		Delay_ms(200);
MOVW	R7, #33919
MOVT	R7, #30
NOP
NOP
L_sonarInit2:
SUBS	R7, R7, #1
BNE	L_sonarInit2
NOP
NOP
NOP
;Sonar.c,24 :: 		SONAR_1_RX = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR11_GPIOB_ODR_bit+0)
MOVT	R0, #hi_addr(ODR11_GPIOB_ODR_bit+0)
STR	R1, [R0, #0]
;Sonar.c,25 :: 		}
L_end_sonarInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sonarInit
_sonarRead:
;Sonar.c,27 :: 		boolean sonarRead(void)
SUB	SP, SP, #64
STR	LR, [SP, #0]
;Sonar.c,29 :: 		uint8 sensorOutput1 [5] = {0};
ADD	R11, SP, #8
ADD	R10, R11, #46
MOVW	R12, #lo_addr(?ICSsonarRead_sensorOutput1_L0+0)
MOVT	R12, #hi_addr(?ICSsonarRead_sensorOutput1_L0+0)
BL	___CC2DW+0
;Sonar.c,31 :: 		uint16 rangeToObstacle = 0;
;Sonar.c,32 :: 		uint16 sensorReadArray[SONAR_AVG_READ] = {500};
;Sonar.c,33 :: 		uint32 rangeSum = 0;
; rangeSum start address is: 36 (R9)
MOV	R9, #0
;Sonar.c,34 :: 		boolean recalcAverage = false;
; recalcAverage start address is: 24 (R6)
MOVS	R6, #1
;Sonar.c,36 :: 		SONAR_1_RX = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR11_GPIOB_ODR_bit+0)
MOVT	R0, #hi_addr(ODR11_GPIOB_ODR_bit+0)
STR	R1, [R0, #0]
;Sonar.c,38 :: 		for(i = 0; i < SONAR_AVG_READ; i++)
; i start address is: 32 (R8)
MOVW	R8, #0
; recalcAverage end address is: 24 (R6)
; rangeSum end address is: 36 (R9)
; i end address is: 32 (R8)
L_sonarRead4:
; i start address is: 32 (R8)
; recalcAverage start address is: 24 (R6)
; rangeSum start address is: 36 (R9)
CMP	R8, #20
IT	CS
BCS	L_sonarRead5
;Sonar.c,40 :: 		sensorOutput1[0] = rs232ByteRead();
ADD	R0, SP, #8
STR	R0, [SP, #60]
STR	R0, [SP, #56]
BL	_rs232ByteRead+0
LDR	R1, [SP, #56]
STRB	R0, [R1, #0]
;Sonar.c,41 :: 		sensorOutput1[1] = rs232ByteRead();
LDR	R0, [SP, #60]
ADDS	R0, R0, #1
STR	R0, [SP, #56]
BL	_rs232ByteRead+0
LDR	R1, [SP, #56]
STRB	R0, [R1, #0]
;Sonar.c,42 :: 		sensorOutput1[2] = rs232ByteRead();
LDR	R0, [SP, #60]
ADDS	R0, R0, #2
STR	R0, [SP, #56]
BL	_rs232ByteRead+0
LDR	R1, [SP, #56]
STRB	R0, [R1, #0]
;Sonar.c,43 :: 		sensorOutput1[3] = rs232ByteRead();
LDR	R0, [SP, #60]
ADDS	R0, R0, #3
STR	R0, [SP, #56]
BL	_rs232ByteRead+0
LDR	R1, [SP, #56]
STRB	R0, [R1, #0]
;Sonar.c,48 :: 		sensorReadArray[i] = (sensorOutput1[1] - 48)*100 + (sensorOutput1[2] - 48)*10 + (sensorOutput1[3] - 48);
ADD	R5, SP, #14
LSL	R0, R8, #1
ADDS	R4, R5, R0
LDR	R3, [SP, #60]
ADDS	R0, R3, #1
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
SXTH	R1, R1
MOVS	R0, #100
SXTH	R0, R0
MUL	R2, R1, R0
SXTH	R2, R2
ADDS	R0, R3, #2
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
SXTH	R1, R1
MOVS	R0, #10
SXTH	R0, R0
MULS	R0, R1, R0
SXTH	R0, R0
ADDS	R1, R2, R0
SXTH	R1, R1
ADDS	R0, R3, #3
LDRB	R0, [R0, #0]
SUBS	R0, #48
SXTH	R0, R0
ADDS	R0, R1, R0
STRH	R0, [R4, #0]
;Sonar.c,49 :: 		rangeSum += sensorReadArray[i];
LSL	R0, R8, #1
ADDS	R0, R5, R0
LDRH	R0, [R0, #0]
ADD	R9, R9, R0, LSL #0
;Sonar.c,50 :: 		Delay_ms(10);
MOVW	R7, #34463
MOVT	R7, #1
NOP
NOP
L_sonarRead7:
SUBS	R7, R7, #1
BNE	L_sonarRead7
NOP
NOP
NOP
;Sonar.c,38 :: 		for(i = 0; i < SONAR_AVG_READ; i++)
ADD	R8, R8, #1
UXTB	R8, R8
;Sonar.c,51 :: 		}
; i end address is: 32 (R8)
IT	AL
BAL	L_sonarRead4
L_sonarRead5:
;Sonar.c,52 :: 		rangeToObstacle = (uint16) rangeSum/SONAR_AVG_READ;
UXTH	R1, R9
; rangeSum end address is: 36 (R9)
MOVS	R0, #20
UDIV	R2, R1, R0
UXTH	R2, R2
; rangeToObstacle start address is: 8 (R2)
;Sonar.c,53 :: 		for(i = 0; i < SONAR_AVG_READ; i++)
; i start address is: 12 (R3)
MOVS	R3, #0
; recalcAverage end address is: 24 (R6)
; i end address is: 12 (R3)
; rangeToObstacle end address is: 8 (R2)
UXTB	R4, R6
L_sonarRead9:
; i start address is: 12 (R3)
; rangeToObstacle start address is: 8 (R2)
; recalcAverage start address is: 16 (R4)
CMP	R3, #20
IT	CS
BCS	L_sonarRead10
;Sonar.c,56 :: 		if(sensorReadArray[i] <= (rangeToObstacle - 40))
ADD	R1, SP, #14
LSLS	R0, R3, #1
ADDS	R0, R1, R0
LDRH	R1, [R0, #0]
SUBW	R0, R2, #40
UXTH	R0, R0
CMP	R1, R0
IT	HI
BHI	L__sonarRead65
; recalcAverage end address is: 16 (R4)
;Sonar.c,58 :: 		sensorReadArray[i] = rangeToObstacle;
ADD	R1, SP, #14
LSLS	R0, R3, #1
ADDS	R0, R1, R0
STRH	R2, [R0, #0]
;Sonar.c,59 :: 		recalcAverage = true;
; recalcAverage start address is: 16 (R4)
MOVS	R4, #0
; recalcAverage end address is: 16 (R4)
;Sonar.c,60 :: 		}
IT	AL
BAL	L_sonarRead12
L__sonarRead65:
;Sonar.c,56 :: 		if(sensorReadArray[i] <= (rangeToObstacle - 40))
;Sonar.c,60 :: 		}
L_sonarRead12:
;Sonar.c,53 :: 		for(i = 0; i < SONAR_AVG_READ; i++)
; recalcAverage start address is: 16 (R4)
ADDS	R3, R3, #1
UXTB	R3, R3
;Sonar.c,61 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_sonarRead9
L_sonarRead10:
;Sonar.c,62 :: 		if(recalcAverage == true)
CMP	R4, #0
IT	NE
BNE	L__sonarRead66
; recalcAverage end address is: 16 (R4)
; rangeToObstacle end address is: 8 (R2)
;Sonar.c,64 :: 		rangeSum = 0;
; rangeSum start address is: 12 (R3)
MOVS	R3, #0
;Sonar.c,65 :: 		for(i = 0; i < SONAR_AVG_READ; i++)
; i start address is: 8 (R2)
MOVS	R2, #0
; rangeSum end address is: 12 (R3)
; i end address is: 8 (R2)
L_sonarRead14:
; i start address is: 8 (R2)
; rangeSum start address is: 12 (R3)
CMP	R2, #20
IT	CS
BCS	L_sonarRead15
;Sonar.c,67 :: 		rangeSum += sensorReadArray[i];
ADD	R1, SP, #14
LSLS	R0, R2, #1
ADDS	R0, R1, R0
LDRH	R0, [R0, #0]
ADDS	R3, R3, R0
;Sonar.c,65 :: 		for(i = 0; i < SONAR_AVG_READ; i++)
ADDS	R2, R2, #1
UXTB	R2, R2
;Sonar.c,68 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_sonarRead14
L_sonarRead15:
;Sonar.c,69 :: 		rangeToObstacle = (uint16) rangeSum/SONAR_AVG_READ;
UXTH	R1, R3
; rangeSum end address is: 12 (R3)
MOVS	R0, #20
UDIV	R2, R1, R0
UXTH	R2, R2
; rangeToObstacle start address is: 8 (R2)
; rangeToObstacle end address is: 8 (R2)
;Sonar.c,70 :: 		}
IT	AL
BAL	L_sonarRead13
L__sonarRead66:
;Sonar.c,62 :: 		if(recalcAverage == true)
;Sonar.c,70 :: 		}
L_sonarRead13:
;Sonar.c,72 :: 		UARTSendString("Average: ");
; rangeToObstacle start address is: 8 (R2)
MOVW	R0, #lo_addr(?lstr1_Sonar+0)
MOVT	R0, #hi_addr(?lstr1_Sonar+0)
STRH	R2, [SP, #4]
BL	_UARTSendString+0
LDRH	R2, [SP, #4]
;Sonar.c,73 :: 		UARTSendUint16(rangeToObstacle);
STRH	R2, [SP, #4]
UXTH	R0, R2
BL	_UARTSendUint16+0
LDRH	R2, [SP, #4]
;Sonar.c,75 :: 		SONAR_1_RX = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR11_GPIOB_ODR_bit+0)
MOVT	R0, #hi_addr(ODR11_GPIOB_ODR_bit+0)
STR	R1, [R0, #0]
;Sonar.c,78 :: 		if(rangeToObstacle <= ALLSTOP_DISTANCE)
CMP	R2, #91
IT	HI
BHI	L_sonarRead17
;Sonar.c,84 :: 		updateMode(ALL_STOP_MODE);
STRH	R2, [SP, #4]
MOVS	R0, #2
BL	_updateMode+0
LDRH	R2, [SP, #4]
;Sonar.c,85 :: 		}
L_sonarRead17:
;Sonar.c,88 :: 		if(rangeToObstacle > OBSTACLE_DETECT_DISTANCE)
CMP	R2, #200
IT	LS
BLS	L_sonarRead18
; rangeToObstacle end address is: 8 (R2)
;Sonar.c,91 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_sonarRead
;Sonar.c,92 :: 		}
L_sonarRead18:
;Sonar.c,93 :: 		calcObstacle(rangeToObstacle);
; rangeToObstacle start address is: 8 (R2)
UXTH	R0, R2
; rangeToObstacle end address is: 8 (R2)
BL	_calcObstacle+0
;Sonar.c,95 :: 		return true;
MOVS	R0, #0
;Sonar.c,96 :: 		}
L_end_sonarRead:
LDR	LR, [SP, #0]
ADD	SP, SP, #64
BX	LR
; end of _sonarRead
_rs232ByteRead:
;Sonar.c,99 :: 		uint8 rs232ByteRead()
SUB	SP, SP, #4
;Sonar.c,101 :: 		uint8 byteRead = 0;
;Sonar.c,102 :: 		uint8 bitValueRead = 0;
;Sonar.c,103 :: 		int i = 1;
; i start address is: 8 (R2)
MOVW	R2, #1
SXTH	R2, R2
; i end address is: 8 (R2)
;Sonar.c,106 :: 		while(SONAR_1_TX == 0);
L_rs232ByteRead19:
; i start address is: 8 (R2)
MOVW	R1, #lo_addr(IDR10_GPIOB_IDR_bit+0)
MOVT	R1, #hi_addr(IDR10_GPIOB_IDR_bit+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_rs232ByteRead20
IT	AL
BAL	L_rs232ByteRead19
L_rs232ByteRead20:
;Sonar.c,107 :: 		Delay_us(SONAR_BIT_DELAY);
MOVW	R7, #1039
MOVT	R7, #0
NOP
NOP
L_rs232ByteRead21:
SUBS	R7, R7, #1
BNE	L_rs232ByteRead21
NOP
NOP
NOP
;Sonar.c,109 :: 		byteRead = SONAR_1_TX;
MOVW	R0, #lo_addr(IDR10_GPIOB_IDR_bit+0)
MOVT	R0, #hi_addr(IDR10_GPIOB_IDR_bit+0)
; byteRead start address is: 4 (R1)
LDR	R1, [R0, #0]
; i end address is: 8 (R2)
; byteRead end address is: 4 (R1)
STRB	R1, [SP, #0]
SXTH	R1, R2
LDRB	R2, [SP, #0]
;Sonar.c,112 :: 		for(;i < 8; i++)
L_rs232ByteRead23:
; byteRead start address is: 8 (R2)
; i start address is: 4 (R1)
CMP	R1, #8
IT	GE
BGE	L_rs232ByteRead24
;Sonar.c,114 :: 		Delay_us(SONAR_BIT_DELAY);
MOVW	R7, #1039
MOVT	R7, #0
NOP
NOP
L_rs232ByteRead26:
SUBS	R7, R7, #1
BNE	L_rs232ByteRead26
NOP
NOP
NOP
;Sonar.c,115 :: 		bitValueRead = SONAR_1_TX;
MOVW	R0, #lo_addr(IDR10_GPIOB_IDR_bit+0)
MOVT	R0, #hi_addr(IDR10_GPIOB_IDR_bit+0)
; bitValueRead start address is: 12 (R3)
LDR	R3, [R0, #0]
;Sonar.c,116 :: 		byteRead |= (bitValueRead << i);
LSL	R0, R3, R1
UXTH	R0, R0
; bitValueRead end address is: 12 (R3)
ORR	R0, R2, R0, LSL #0
UXTB	R2, R0
;Sonar.c,112 :: 		for(;i < 8; i++)
ADDS	R1, R1, #1
SXTH	R1, R1
;Sonar.c,117 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_rs232ByteRead23
L_rs232ByteRead24:
;Sonar.c,118 :: 		Delay_us(SONAR_BIT_DELAY);
MOVW	R7, #1039
MOVT	R7, #0
NOP
NOP
L_rs232ByteRead28:
SUBS	R7, R7, #1
BNE	L_rs232ByteRead28
NOP
NOP
NOP
;Sonar.c,120 :: 		return (~byteRead);
MVN	R0, R2
; byteRead end address is: 8 (R2)
;Sonar.c,121 :: 		}
L_end_rs232ByteRead:
ADD	SP, SP, #4
BX	LR
; end of _rs232ByteRead
_calcObstacle:
;Sonar.c,123 :: 		void calcObstacle(uint16 rangeToObstacle)
SUB	SP, SP, #32
STR	LR, [SP, #0]
STRH	R0, [SP, #20]
;Sonar.c,131 :: 		getQuadPostion(&quadXPos, &quadYPos);
ADD	R2, SP, #9
ADD	R1, SP, #8
MOV	R0, R1
MOV	R1, R2
BL	_getQuadPostion+0
;Sonar.c,132 :: 		heading = getCurrentHeading();
BL	_getCurrentHeading+0
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #4]
;Sonar.c,136 :: 		if(heading > 0 && heading < 90)
MOV	R2, #0
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__calcObstacle71
MOVS	R0, #1
L__calcObstacle71:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__calcObstacle60
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17076
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__calcObstacle72
MOVS	R0, #1
L__calcObstacle72:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__calcObstacle59
L__calcObstacle58:
;Sonar.c,138 :: 		yPart = (float)-1*rangeToObstacle*cos(heading*PI_DIVIDED_180);
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #49024
BL	__Mul_FP+0
STR	R0, [SP, #28]
LDR	R2, [SP, #4]
MOVW	R0, #64053
MOVT	R0, #15502
BL	__Mul_FP+0
BL	_cos+0
LDR	R2, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #16]
;Sonar.c,139 :: 		xPart = (float)rangeToObstacle*sin(heading*PI_DIVIDED_180);
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOV	R1, R0
STR	R1, [SP, #28]
LDR	R2, [SP, #4]
MOVW	R0, #64053
MOVT	R0, #15502
BL	__Mul_FP+0
BL	_sin+0
LDR	R2, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #12]
;Sonar.c,140 :: 		}
IT	AL
BAL	L_calcObstacle33
;Sonar.c,136 :: 		if(heading > 0 && heading < 90)
L__calcObstacle60:
L__calcObstacle59:
;Sonar.c,142 :: 		else if(heading > 90 && heading < 180)
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17076
BL	__Compare_FP+0
MOVW	R0, #0
BGE	L__calcObstacle73
MOVS	R0, #1
L__calcObstacle73:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__calcObstacle62
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17204
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__calcObstacle74
MOVS	R0, #1
L__calcObstacle74:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__calcObstacle61
L__calcObstacle57:
;Sonar.c,144 :: 		yPart = (float)rangeToObstacle*sin((heading-90)*PI_DIVIDED_180);
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOV	R1, R0
STR	R1, [SP, #28]
LDR	R0, [SP, #4]
MOVW	R2, #0
MOVT	R2, #17076
BL	__Sub_FP+0
MOVW	R2, #64053
MOVT	R2, #15502
BL	__Mul_FP+0
BL	_sin+0
LDR	R2, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #16]
;Sonar.c,145 :: 		xPart = (float)rangeToObstacle*cos((heading-90)*PI_DIVIDED_180);
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOV	R1, R0
STR	R1, [SP, #28]
LDR	R0, [SP, #4]
MOVW	R2, #0
MOVT	R2, #17076
BL	__Sub_FP+0
MOVW	R2, #64053
MOVT	R2, #15502
BL	__Mul_FP+0
BL	_cos+0
LDR	R2, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #12]
;Sonar.c,146 :: 		}
IT	AL
BAL	L_calcObstacle37
;Sonar.c,142 :: 		else if(heading > 90 && heading < 180)
L__calcObstacle62:
L__calcObstacle61:
;Sonar.c,148 :: 		else if(heading > 180 && heading < 270)
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17204
BL	__Compare_FP+0
MOVW	R0, #0
BGE	L__calcObstacle75
MOVS	R0, #1
L__calcObstacle75:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__calcObstacle64
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17287
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__calcObstacle76
MOVS	R0, #1
L__calcObstacle76:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__calcObstacle63
L__calcObstacle56:
;Sonar.c,150 :: 		yPart = (float)rangeToObstacle*cos((heading-180)*PI_DIVIDED_180);
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOV	R1, R0
STR	R1, [SP, #28]
LDR	R0, [SP, #4]
MOVW	R2, #0
MOVT	R2, #17204
BL	__Sub_FP+0
MOVW	R2, #64053
MOVT	R2, #15502
BL	__Mul_FP+0
BL	_cos+0
LDR	R2, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #16]
;Sonar.c,151 :: 		xPart = (float)-1*rangeToObstacle*sin((heading-180)*PI_DIVIDED_180);
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #49024
BL	__Mul_FP+0
STR	R0, [SP, #28]
LDR	R0, [SP, #4]
MOVW	R2, #0
MOVT	R2, #17204
BL	__Sub_FP+0
MOVW	R2, #64053
MOVT	R2, #15502
BL	__Mul_FP+0
BL	_sin+0
LDR	R2, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #12]
;Sonar.c,152 :: 		}
IT	AL
BAL	L_calcObstacle41
;Sonar.c,148 :: 		else if(heading > 180 && heading < 270)
L__calcObstacle64:
L__calcObstacle63:
;Sonar.c,154 :: 		else if(heading > 270)
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17287
BL	__Compare_FP+0
MOVW	R0, #0
BGE	L__calcObstacle77
MOVS	R0, #1
L__calcObstacle77:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_calcObstacle42
;Sonar.c,156 :: 		yPart = (float)-1*rangeToObstacle*sin((heading-270)*PI_DIVIDED_180);
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #49024
BL	__Mul_FP+0
STR	R0, [SP, #28]
LDR	R0, [SP, #4]
MOVW	R2, #0
MOVT	R2, #17287
BL	__Sub_FP+0
MOVW	R2, #64053
MOVT	R2, #15502
BL	__Mul_FP+0
BL	_sin+0
LDR	R2, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #16]
;Sonar.c,157 :: 		xPart = (float)-1*rangeToObstacle*cos((heading-270)*PI_DIVIDED_180);
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #49024
BL	__Mul_FP+0
STR	R0, [SP, #28]
LDR	R0, [SP, #4]
MOVW	R2, #0
MOVT	R2, #17287
BL	__Sub_FP+0
MOVW	R2, #64053
MOVT	R2, #15502
BL	__Mul_FP+0
BL	_cos+0
LDR	R2, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #12]
;Sonar.c,158 :: 		}
IT	AL
BAL	L_calcObstacle43
L_calcObstacle42:
;Sonar.c,159 :: 		else if(heading == 0)
LDR	R2, [SP, #4]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__calcObstacle78
MOVS	R0, #1
L__calcObstacle78:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_calcObstacle44
;Sonar.c,161 :: 		yPart = (float) -1*rangeToObstacle;
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #49024
BL	__Mul_FP+0
STR	R0, [SP, #16]
;Sonar.c,162 :: 		xPart = (float)0;
MOV	R1, #0
STR	R1, [SP, #12]
;Sonar.c,163 :: 		}
IT	AL
BAL	L_calcObstacle45
L_calcObstacle44:
;Sonar.c,164 :: 		else if(heading == 90)
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17076
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__calcObstacle79
MOVS	R0, #1
L__calcObstacle79:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_calcObstacle46
;Sonar.c,166 :: 		yPart = (float)0;
MOV	R1, #0
STR	R1, [SP, #16]
;Sonar.c,167 :: 		xPart = (float)rangeToObstacle;
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #12]
;Sonar.c,168 :: 		}
IT	AL
BAL	L_calcObstacle47
L_calcObstacle46:
;Sonar.c,169 :: 		else if(heading == 180)
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17204
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__calcObstacle80
MOVS	R0, #1
L__calcObstacle80:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_calcObstacle48
;Sonar.c,171 :: 		yPart = (float)rangeToObstacle;
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #16]
;Sonar.c,172 :: 		xPart = (float)0;
MOV	R1, #0
STR	R1, [SP, #12]
;Sonar.c,173 :: 		}
IT	AL
BAL	L_calcObstacle49
L_calcObstacle48:
;Sonar.c,174 :: 		else if(heading == 270)
LDR	R2, [SP, #4]
MOVW	R0, #0
MOVT	R0, #17287
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__calcObstacle81
MOVS	R0, #1
L__calcObstacle81:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_calcObstacle50
;Sonar.c,176 :: 		yPart = (float)0;
MOV	R1, #0
STR	R1, [SP, #16]
;Sonar.c,177 :: 		xPart = (float)-1*rangeToObstacle;
LDRH	R0, [SP, #20]
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #0
MOVT	R2, #49024
BL	__Mul_FP+0
STR	R0, [SP, #12]
;Sonar.c,178 :: 		}
IT	AL
BAL	L_calcObstacle51
L_calcObstacle50:
;Sonar.c,182 :: 		return;
IT	AL
BAL	L_end_calcObstacle
;Sonar.c,183 :: 		}
L_calcObstacle51:
L_calcObstacle49:
L_calcObstacle47:
L_calcObstacle45:
L_calcObstacle43:
L_calcObstacle41:
L_calcObstacle37:
L_calcObstacle33:
;Sonar.c,185 :: 		if(xPart < 0)
LDR	R2, [SP, #12]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__calcObstacle82
MOVS	R0, #1
L__calcObstacle82:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_calcObstacle52
;Sonar.c,187 :: 		xPosDiff = (int8)ceil(xPart/(SQUARE_SIDE_LENGTH));
LDR	R0, [SP, #12]
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	_ceil+0
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
; xPosDiff start address is: 40 (R10)
SXTB	R10, R0
;Sonar.c,188 :: 		}
SXTB	R9, R10
; xPosDiff end address is: 40 (R10)
IT	AL
BAL	L_calcObstacle53
L_calcObstacle52:
;Sonar.c,191 :: 		xPosDiff = (int8)floor(xPart/(SQUARE_SIDE_LENGTH));
LDR	R0, [SP, #12]
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
; xPosDiff start address is: 40 (R10)
SXTB	R10, R0
; xPosDiff end address is: 40 (R10)
SXTB	R9, R10
;Sonar.c,192 :: 		}
L_calcObstacle53:
;Sonar.c,193 :: 		if(yPart < 0)
; xPosDiff start address is: 36 (R9)
LDR	R2, [SP, #16]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__calcObstacle83
MOVS	R0, #1
L__calcObstacle83:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_calcObstacle54
;Sonar.c,195 :: 		yPosDiff = (int8)ceil(yPart/(SQUARE_SIDE_LENGTH));
LDR	R0, [SP, #16]
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	_ceil+0
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
;Sonar.c,196 :: 		}
IT	AL
BAL	L_calcObstacle55
L_calcObstacle54:
;Sonar.c,199 :: 		yPosDiff = (int8)floor(yPart/(SQUARE_SIDE_LENGTH));
LDR	R0, [SP, #16]
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	_floor+0
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
; yPosDiff start address is: 4 (R1)
SXTB	R1, R0
; yPosDiff end address is: 4 (R1)
SXTB	R0, R1
;Sonar.c,200 :: 		}
L_calcObstacle55:
;Sonar.c,203 :: 		addObstacle(quadYPos + yPosDiff, quadXPos + xPosDiff);
LDRB	R1, [SP, #8]
ADD	R2, R1, R9, LSL #0
; xPosDiff end address is: 36 (R9)
LDRB	R1, [SP, #9]
ADDS	R1, R1, R0
UXTB	R0, R1
UXTB	R1, R2
BL	_addObstacle+0
;Sonar.c,205 :: 		}
L_end_calcObstacle:
LDR	LR, [SP, #0]
ADD	SP, SP, #32
BX	LR
; end of _calcObstacle
