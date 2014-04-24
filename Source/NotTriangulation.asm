_notTriangulationInit:
;NotTriangulation.c,11 :: 		void notTriangulationInit(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NotTriangulation.c,13 :: 		ADC_Set_Input_Channel(BEACON_1_CHANNEL);
MOVW	R0, #4096
BL	_ADC_Set_Input_Channel+0
;NotTriangulation.c,14 :: 		ADC1_Init();
BL	_ADC1_Init+0
;NotTriangulation.c,16 :: 		GPIO_Digital_Output(&PEAK_PORT, PEAK_RX_PIN_MASK);
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;NotTriangulation.c,17 :: 		InitTimer4();
BL	_InitTimer4+0
;NotTriangulation.c,30 :: 		UARTSendString("Beacon test1.");
MOVW	R0, #lo_addr(?lstr1_NotTriangulation+0)
MOVT	R0, #hi_addr(?lstr1_NotTriangulation+0)
BL	_UARTSendString+0
;NotTriangulation.c,37 :: 		testSequence();
BL	_testSequence+0
;NotTriangulation.c,38 :: 		}
L_end_notTriangulationInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _notTriangulationInit
_InitTimer4:
;NotTriangulation.c,46 :: 		void InitTimer4()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NotTriangulation.c,48 :: 		RCC_APB1ENR.TIM4EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;NotTriangulation.c,49 :: 		TIM4_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM4_CR1+0)
MOVT	R0, #hi_addr(TIM4_CR1+0)
STR	R1, [R0, #0]
;NotTriangulation.c,50 :: 		TIM4_PSC = 884;
MOVW	R1, #884
MOVW	R0, #lo_addr(TIM4_PSC+0)
MOVT	R0, #hi_addr(TIM4_PSC+0)
STR	R1, [R0, #0]
;NotTriangulation.c,51 :: 		TIM4_ARR = 59999;
MOVW	R1, #59999
MOVW	R0, #lo_addr(TIM4_ARR+0)
MOVT	R0, #hi_addr(TIM4_ARR+0)
STR	R1, [R0, #0]
;NotTriangulation.c,52 :: 		NVIC_IntEnable(IVT_INT_TIM4);
MOVW	R0, #46
BL	_NVIC_IntEnable+0
;NotTriangulation.c,53 :: 		TIM4_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM4_DIER+0)
MOVT	R0, #hi_addr(TIM4_DIER+0)
STR	R1, [R0, #0]
;NotTriangulation.c,54 :: 		TIM4_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM4_CR1+0)
MOVT	R0, #hi_addr(TIM4_CR1+0)
STR	R1, [R0, #0]
;NotTriangulation.c,55 :: 		}
L_end_InitTimer4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimer4
_Timer4_interrupt:
;NotTriangulation.c,57 :: 		void Timer4_interrupt() iv IVT_INT_TIM4
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NotTriangulation.c,59 :: 		TIM4_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM4_SR+0)
MOVT	R0, #hi_addr(TIM4_SR+0)
STR	R1, [R0, #0]
;NotTriangulation.c,60 :: 		adcValue = ADC1_Get_Sample(BEACON_1);
MOVS	R0, #12
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R1, #hi_addr(NotTriangulation_adcValue+0)
STRH	R0, [R1, #0]
;NotTriangulation.c,62 :: 		ODR4_bit = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR4_bit+0)
MOVT	R0, #hi_addr(ODR4_bit+0)
STR	R1, [R0, #0]
;NotTriangulation.c,63 :: 		ODR8_GPIOC_ODR_bit = 1;
MOVW	R2, #lo_addr(ODR8_GPIOC_ODR_bit+0)
MOVT	R2, #hi_addr(ODR8_GPIOC_ODR_bit+0)
STR	R1, [R2, #0]
;NotTriangulation.c,64 :: 		Delay_us(10000);
MOVW	R7, #34463
MOVT	R7, #1
NOP
NOP
L_Timer4_interrupt0:
SUBS	R7, R7, #1
BNE	L_Timer4_interrupt0
NOP
NOP
NOP
;NotTriangulation.c,65 :: 		ODR4_bit = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR4_bit+0)
MOVT	R0, #hi_addr(ODR4_bit+0)
STR	R1, [R0, #0]
;NotTriangulation.c,66 :: 		ODR8_GPIOC_ODR_bit = 0;
STR	R1, [R2, #0]
;NotTriangulation.c,67 :: 		}
L_end_Timer4_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Timer4_interrupt
_testSequence:
;NotTriangulation.c,69 :: 		boolean testSequence(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NotTriangulation.c,72 :: 		int iter = 0;
;NotTriangulation.c,73 :: 		Delay_ms(10000);
MOVW	R7, #57599
MOVT	R7, #1525
NOP
NOP
L_testSequence2:
SUBS	R7, R7, #1
BNE	L_testSequence2
NOP
NOP
NOP
;NotTriangulation.c,74 :: 		UARTSendString("Welcome to the even more DANGA ZONE.");
MOVW	R0, #lo_addr(?lstr2_NotTriangulation+0)
MOVT	R0, #hi_addr(?lstr2_NotTriangulation+0)
BL	_UARTSendString+0
;NotTriangulation.c,76 :: 		StabilizeMode();  //Set to Stabilize mode for takeoff (Only needed for loop mode - the StabilizeMode() above will place the quad in correct mode for arming
BL	_StabilizeMode+0
;NotTriangulation.c,77 :: 		Delay_ms(500);
MOVW	R7, #19263
MOVT	R7, #76
NOP
NOP
L_testSequence4:
SUBS	R7, R7, #1
BNE	L_testSequence4
NOP
NOP
NOP
;NotTriangulation.c,78 :: 		Arm();            //Arm the quad rotors
BL	_Arm+0
;NotTriangulation.c,79 :: 		success = TakeOff();
BL	_TakeOff+0
;NotTriangulation.c,81 :: 		if(success == true)
CMP	R0, #0
IT	NE
BNE	L_testSequence6
;NotTriangulation.c,83 :: 		LoiterMode();
BL	_LoiterMode+0
;NotTriangulation.c,85 :: 		UARTSendUint16(adcValue);
MOVW	R0, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R0, #hi_addr(NotTriangulation_adcValue+0)
LDRSH	R0, [R0, #0]
BL	_UARTSendUint16+0
;NotTriangulation.c,86 :: 		Delay_ms(5000);
MOVW	R7, #61567
MOVT	R7, #762
NOP
NOP
L_testSequence7:
SUBS	R7, R7, #1
BNE	L_testSequence7
NOP
NOP
NOP
;NotTriangulation.c,87 :: 		UARTSendUint16(adcValue);
MOVW	R0, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R0, #hi_addr(NotTriangulation_adcValue+0)
LDRSH	R0, [R0, #0]
BL	_UARTSendUint16+0
;NotTriangulation.c,88 :: 		Delay_ms(1000);
MOVW	R7, #38527
MOVT	R7, #152
NOP
NOP
L_testSequence9:
SUBS	R7, R7, #1
BNE	L_testSequence9
NOP
NOP
NOP
;NotTriangulation.c,89 :: 		UARTSendUint16(adcValue);
MOVW	R0, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R0, #hi_addr(NotTriangulation_adcValue+0)
LDRSH	R0, [R0, #0]
BL	_UARTSendUint16+0
;NotTriangulation.c,112 :: 		}
L_testSequence6:
;NotTriangulation.c,113 :: 		UARTSendString("Returning to base.");
MOVW	R0, #lo_addr(?lstr3_NotTriangulation+0)
MOVT	R0, #hi_addr(?lstr3_NotTriangulation+0)
BL	_UARTSendString+0
;NotTriangulation.c,114 :: 		Land();
BL	_Land+0
;NotTriangulation.c,115 :: 		Delay_ms(20000);
MOVW	R7, #49663
MOVT	R7, #3051
NOP
NOP
L_testSequence11:
SUBS	R7, R7, #1
BNE	L_testSequence11
NOP
NOP
NOP
;NotTriangulation.c,116 :: 		DisArm();
BL	_DisArm+0
;NotTriangulation.c,118 :: 		while(1)
L_testSequence13:
;NotTriangulation.c,120 :: 		Delay_ms(500);
MOVW	R7, #19263
MOVT	R7, #76
NOP
NOP
L_testSequence15:
SUBS	R7, R7, #1
BNE	L_testSequence15
NOP
NOP
NOP
;NotTriangulation.c,121 :: 		}
IT	AL
BAL	L_testSequence13
;NotTriangulation.c,122 :: 		}
L_end_testSequence:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _testSequence
_headingInit:
;NotTriangulation.c,124 :: 		boolean headingInit(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;NotTriangulation.c,126 :: 		uint32 oldADCValue = MAGNITUDE_MAX;
MOV	R0, #3600
STR	R0, [SP, #4]
;NotTriangulation.c,129 :: 		while (oldADCValue > adcValue)
L_headingInit17:
MOVW	R0, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R0, #hi_addr(NotTriangulation_adcValue+0)
LDRSH	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R0, R1
IT	LS
BLS	L_headingInit18
;NotTriangulation.c,131 :: 		oldADCValue = adcValue;
MOVW	R0, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R0, #hi_addr(NotTriangulation_adcValue+0)
LDRSH	R0, [R0, #0]
STR	R0, [SP, #4]
;NotTriangulation.c,133 :: 		heading = getCurrentHeading();
BL	_getCurrentHeading+0
;NotTriangulation.c,136 :: 		rotateCopter(heading+ITER_OFFSET);
SUBS	R0, R0, #5
BL	_rotateCopter+0
;NotTriangulation.c,139 :: 		Delay_ms(ORIENTATION_DELAY);
MOVW	R7, #38527
MOVT	R7, #152
NOP
NOP
L_headingInit19:
SUBS	R7, R7, #1
BNE	L_headingInit19
NOP
NOP
NOP
;NotTriangulation.c,140 :: 		}
IT	AL
BAL	L_headingInit17
L_headingInit18:
;NotTriangulation.c,144 :: 		rotateCopter(heading-INIT_OFFSET);
MOVW	R0, #65531
BL	_rotateCopter+0
;NotTriangulation.c,147 :: 		Delay_ms(ORIENTATION_DELAY);
MOVW	R7, #38527
MOVT	R7, #152
NOP
NOP
L_headingInit21:
SUBS	R7, R7, #1
BNE	L_headingInit21
NOP
NOP
NOP
;NotTriangulation.c,150 :: 		goalHeading = getCurrentHeading();
BL	_getCurrentHeading+0
MOVW	R1, #lo_addr(NotTriangulation_goalHeading+0)
MOVT	R1, #hi_addr(NotTriangulation_goalHeading+0)
STRH	R0, [R1, #0]
;NotTriangulation.c,152 :: 		return true;
MOVS	R0, #0
;NotTriangulation.c,153 :: 		}
L_end_headingInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _headingInit
_calcDirection:
;NotTriangulation.c,160 :: 		boolean calcDirection(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;NotTriangulation.c,162 :: 		uint32 oldADCValue = MAGNITUDE_MAX;
MOV	R0, #3600
STR	R0, [SP, #4]
;NotTriangulation.c,165 :: 		while (oldADCValue > adcValue)
L_calcDirection23:
MOVW	R0, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R0, #hi_addr(NotTriangulation_adcValue+0)
LDRSH	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R0, R1
IT	LS
BLS	L_calcDirection24
;NotTriangulation.c,167 :: 		oldADCValue = adcValue;
MOVW	R0, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R0, #hi_addr(NotTriangulation_adcValue+0)
LDRSH	R0, [R0, #0]
STR	R0, [SP, #4]
;NotTriangulation.c,169 :: 		heading = getCurrentHeading();
BL	_getCurrentHeading+0
;NotTriangulation.c,172 :: 		rotateCopter(heading+ITER_OFFSET);
SUBS	R0, R0, #5
BL	_rotateCopter+0
;NotTriangulation.c,175 :: 		Delay_ms(ORIENTATION_DELAY);
MOVW	R7, #38527
MOVT	R7, #152
NOP
NOP
L_calcDirection25:
SUBS	R7, R7, #1
BNE	L_calcDirection25
NOP
NOP
NOP
;NotTriangulation.c,176 :: 		}
IT	AL
BAL	L_calcDirection23
L_calcDirection24:
;NotTriangulation.c,179 :: 		heading = getCurrentHeading();
BL	_getCurrentHeading+0
;NotTriangulation.c,180 :: 		rotateCopter(heading-ITER_OFFSET);
ADDS	R0, R0, #5
BL	_rotateCopter+0
;NotTriangulation.c,183 :: 		Delay_ms(ORIENTATION_DELAY);
MOVW	R7, #38527
MOVT	R7, #152
NOP
NOP
L_calcDirection27:
SUBS	R7, R7, #1
BNE	L_calcDirection27
NOP
NOP
NOP
;NotTriangulation.c,185 :: 		heading = getCurrentHeading();
BL	_getCurrentHeading+0
;NotTriangulation.c,186 :: 		updateGoal(heading);
BL	_updateGoal+0
;NotTriangulation.c,188 :: 		return true;
MOVS	R0, #0
;NotTriangulation.c,190 :: 		}
L_end_calcDirection:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _calcDirection
_updateGoal:
;NotTriangulation.c,194 :: 		boolean updateGoal(uint16 newHeading)
; newHeading start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; newHeading end address is: 0 (R0)
; newHeading start address is: 0 (R0)
;NotTriangulation.c,196 :: 		if (((adcValue - MAGNITUDE_MAX)&0x7fff) < GOAL_THRESHOLD)
MOVW	R1, #lo_addr(NotTriangulation_adcValue+0)
MOVT	R1, #hi_addr(NotTriangulation_adcValue+0)
LDRSH	R1, [R1, #0]
SUB	R2, R1, #3600
SXTH	R2, R2
MOVW	R1, #32767
SXTH	R1, R1
AND	R1, R2, R1, LSL #0
SXTH	R1, R1
CMP	R1, #20
IT	GE
BGE	L_updateGoal29
; newHeading end address is: 0 (R0)
;NotTriangulation.c,197 :: 		updateMode(FOUND_THAT_SHIT_MODE);
MOVS	R0, #3
BL	_updateMode+0
IT	AL
BAL	L_updateGoal30
L_updateGoal29:
;NotTriangulation.c,202 :: 		uint16 deltaAngle = newHeading-goalHeading;
; newHeading start address is: 0 (R0)
MOVW	R1, #lo_addr(NotTriangulation_goalHeading+0)
MOVT	R1, #hi_addr(NotTriangulation_goalHeading+0)
LDRH	R1, [R1, #0]
SUB	R1, R0, R1
UXTH	R1, R1
; newHeading end address is: 0 (R0)
STRH	R1, [SP, #8]
;NotTriangulation.c,206 :: 		deltaRow = (cos(deltaAngle)*10)/3;
UXTH	R0, R1
BL	__UnsignedIntegralToFloat+0
BL	_cos+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #16448
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
STRB	R0, [SP, #6]
;NotTriangulation.c,207 :: 		deltaCol = (sin(deltaAngle)*10)/3;
LDRH	R0, [SP, #8]
BL	__UnsignedIntegralToFloat+0
BL	_sin+0
MOVW	R2, #0
MOVT	R2, #16672
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #16448
BL	__Div_FP+0
BL	__FloatToSignedIntegral+0
SXTB	R0, R0
STRB	R0, [SP, #7]
;NotTriangulation.c,209 :: 		getQuadPostion(row, col);
LDRB	R1, [SP, #5]
LDRB	R0, [SP, #4]
BL	_getQuadPostion+0
;NotTriangulation.c,210 :: 		updateMapGoal(row+deltaRow, col+deltaCol);
LDRSB	R2, [SP, #7]
LDRB	R1, [SP, #5]
ADDS	R3, R1, R2
LDRSB	R2, [SP, #6]
LDRB	R1, [SP, #4]
ADDS	R1, R1, R2
UXTB	R0, R1
UXTB	R1, R3
BL	_updateMapGoal+0
;NotTriangulation.c,211 :: 		}
L_updateGoal30:
;NotTriangulation.c,213 :: 		return true;
MOVS	R0, #0
;NotTriangulation.c,215 :: 		}
L_end_updateGoal:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _updateGoal
