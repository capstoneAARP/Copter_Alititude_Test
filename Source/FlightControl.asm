_Flight_Control_Init:
;FlightControl.c,16 :: 		void Flight_Control_Init()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,18 :: 		Init_ADC();
BL	_Init_ADC+0
;FlightControl.c,19 :: 		Init_Pwm();
BL	_Init_Pwm+0
;FlightControl.c,20 :: 		Init_LED();
BL	_Init_LED+0
;FlightControl.c,21 :: 		}
L_end_Flight_Control_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Flight_Control_Init
_Init_LED:
;FlightControl.c,23 :: 		void Init_LED(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,24 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_8 | _GPIO_PINMASK_9); // Set PORTC as digital output
MOVW	R1, #768
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;FlightControl.c,25 :: 		GPIOC_ODR.B8 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,26 :: 		GPIOC_ODR.B9 = 0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,27 :: 		Delay_ms(250);
MOVW	R7, #9631
MOVT	R7, #38
NOP
NOP
L_Init_LED0:
SUBS	R7, R7, #1
BNE	L_Init_LED0
NOP
NOP
NOP
;FlightControl.c,28 :: 		GPIOC_ODR.B8 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,29 :: 		}
L_end_Init_LED:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_LED
_Init_ADC:
;FlightControl.c,31 :: 		void Init_ADC(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,33 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_13);                     // Choose ADC channel
MOVW	R0, #8192
BL	_ADC_Set_Input_Channel+0
;FlightControl.c,34 :: 		ADC1_Init();
BL	_ADC1_Init+0
;FlightControl.c,35 :: 		Delay_ms(100);
MOVW	R7, #16959
MOVT	R7, #15
NOP
NOP
L_Init_ADC2:
SUBS	R7, R7, #1
BNE	L_Init_ADC2
NOP
NOP
NOP
;FlightControl.c,36 :: 		}
L_end_Init_ADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_ADC
_Init_Pwm:
;FlightControl.c,38 :: 		void Init_Pwm(){
SUB	SP, SP, #12
STR	LR, [SP, #0]
;FlightControl.c,40 :: 		pwm_period1 = PWM_TIM3_Init(49);     //AUX channel(s) timer
MOVS	R0, #49
BL	_PWM_TIM3_Init+0
BL	__UnsignedIntegralToFloat+0
MOVW	R1, #lo_addr(_pwm_period1+0)
MOVT	R1, #hi_addr(_pwm_period1+0)
STR	R0, [R1, #0]
;FlightControl.c,41 :: 		pwm_period2 = PWM_TIM2_Init(49);     //Throttle, Yaw, Pitch, Roll timer
MOVS	R0, #49
BL	_PWM_TIM2_Init+0
BL	__UnsignedIntegralToFloat+0
MOVW	R1, #lo_addr(_pwm_period2+0)
MOVT	R1, #hi_addr(_pwm_period2+0)
STR	R1, [SP, #4]
STR	R0, [R1, #0]
;FlightControl.c,43 :: 		DC_time = (current_DC*pwm_period2)/100;       //Set Yaw, Pitch and Roll to mid stick
MOVW	R1, #lo_addr(_current_DC+0)
MOVT	R1, #hi_addr(_current_DC+0)
LDR	R2, [R1, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,44 :: 		DC_time_2 = (current_DC_2*pwm_period2)/100;    //Set the duty cycle to very low - for initial THROTTLE settings
LDR	R0, [SP, #4]
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_2+0)
MOVT	R0, #hi_addr(_current_DC_2+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
STR	R0, [SP, #8]
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time_2+0)
MOVT	R1, #hi_addr(_DC_time_2+0)
STR	R1, [SP, #4]
STRH	R0, [R1, #0]
;FlightControl.c,45 :: 		DC_time_3 = (current_DC_2*pwm_period2)/100;    //Set the duty cycle to very low for AUX1 - (channel 5)
MOVW	R2, #0
MOVT	R2, #17096
LDR	R0, [SP, #8]
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time_3+0)
MOVT	R1, #hi_addr(_DC_time_3+0)
STRH	R0, [R1, #0]
;FlightControl.c,48 :: 		PWM_TIM2_Set_Duty(DC_time_2, _PWM_NON_INVERTED, _PWM_CHANNEL1);     //for THROTTLE
LDR	R0, [SP, #4]
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,49 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
MOVW	R0, #lo_addr(_DC_time+0)
MOVT	R0, #hi_addr(_DC_time+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,50 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);       //for PITCH
MOVW	R0, #lo_addr(_DC_time+0)
MOVT	R0, #hi_addr(_DC_time+0)
LDRH	R0, [R0, #0]
MOVS	R2, #2
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,51 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL4);       //for ROLL
MOVW	R0, #lo_addr(_DC_time+0)
MOVT	R0, #hi_addr(_DC_time+0)
LDRH	R0, [R0, #0]
MOVS	R2, #3
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,52 :: 		PWM_TIM3_Set_Duty(DC_time_3, _PWM_NON_INVERTED, _PWM_CHANNEL1);     //set AUX1 to low for gyro stabilization
MOVW	R0, #lo_addr(_DC_time_3+0)
MOVT	R0, #hi_addr(_DC_time_3+0)
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM3_Set_Duty+0
;FlightControl.c,54 :: 		PWM_TIM2_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM2_CH1_PA0);    //for THROTTLE
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH1_PA0+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH1_PA0+0)
MOVS	R0, #0
BL	_PWM_TIM2_Start+0
;FlightControl.c,55 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);    //for YAW
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;FlightControl.c,56 :: 		PWM_TIM2_Start(_PWM_CHANNEL3, &_GPIO_MODULE_TIM2_CH3_PA2);    //for PITCH
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH3_PA2+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH3_PA2+0)
MOVS	R0, #2
BL	_PWM_TIM2_Start+0
;FlightControl.c,57 :: 		PWM_TIM2_Start(_PWM_CHANNEL4, &_GPIO_MODULE_TIM2_CH4_PA3);    //for ROLL
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH4_PA3+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH4_PA3+0)
MOVS	R0, #3
BL	_PWM_TIM2_Start+0
;FlightControl.c,58 :: 		PWM_TIM3_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM3_CH1_PA6);    //set AUX1 to low for gyro stabilization
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM3_CH1_PA6+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM3_CH1_PA6+0)
MOVS	R0, #0
BL	_PWM_TIM3_Start+0
;FlightControl.c,59 :: 		}
L_end_Init_Pwm:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _Init_Pwm
_Arm:
;FlightControl.c,61 :: 		void Arm(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,63 :: 		DC_time = (current_DC_2*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_2+0)
MOVT	R0, #hi_addr(_current_DC_2+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,64 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);   //for THROTTLE
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,67 :: 		DC_time = (current_DC_4*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_4+0)
MOVT	R0, #hi_addr(_current_DC_4+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,68 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);   //for YAW
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,69 :: 		delay_ms(5000);  //Delay for Arducopter to notice 'ARM motors' command  (~2500ms is the smallest amount I found to work) however Arducopter says 5000ms
MOVW	R7, #61567
MOVT	R7, #762
NOP
NOP
L_Arm4:
SUBS	R7, R7, #1
BNE	L_Arm4
NOP
NOP
NOP
;FlightControl.c,71 :: 		DC_time = (current_DC*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC+0)
MOVT	R0, #hi_addr(_current_DC+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,72 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,73 :: 		Delay_ms(6000);  //When APM is first turned on - need this interval to allow for APM auto-calibration
MOVW	R7, #34559
MOVT	R7, #915
NOP
NOP
L_Arm6:
SUBS	R7, R7, #1
BNE	L_Arm6
NOP
NOP
NOP
;FlightControl.c,75 :: 		}
L_end_Arm:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Arm
_Throttle_Off:
;FlightControl.c,77 :: 		void Throttle_Off(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,78 :: 		current_DC_2 = 5.0;
MOVW	R1, #0
MOVT	R1, #16544
MOVW	R0, #lo_addr(_current_DC_2+0)
MOVT	R0, #hi_addr(_current_DC_2+0)
STR	R1, [R0, #0]
;FlightControl.c,79 :: 		DC_time = (current_DC_2*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #0
MOVT	R0, #16544
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,80 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,81 :: 		}
L_end_Throttle_Off:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Throttle_Off
_DisArm:
;FlightControl.c,83 :: 		void DisArm(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,85 :: 		Throttle_Off();
BL	_Throttle_Off+0
;FlightControl.c,87 :: 		Delay_ms(1000);
MOVW	R7, #38527
MOVT	R7, #152
NOP
NOP
L_DisArm8:
SUBS	R7, R7, #1
BNE	L_DisArm8
NOP
NOP
NOP
;FlightControl.c,89 :: 		DC_time = (current_DC_2*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_2+0)
MOVT	R0, #hi_addr(_current_DC_2+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,90 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,91 :: 		Delay_ms(3000);  //Delay for Arducopter to notice 'DISARM motors' command  (~2000 ms is the smallest amount to use)  http://copter.ardupilot.com/wiki/arming_the_motors/
MOVW	R7, #50047
MOVT	R7, #457
NOP
NOP
L_DisArm10:
SUBS	R7, R7, #1
BNE	L_DisArm10
NOP
NOP
NOP
;FlightControl.c,94 :: 		DC_time = (current_DC*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC+0)
MOVT	R0, #hi_addr(_current_DC+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,95 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,96 :: 		Delay_ms(2000);   //Probably non necessary delay but allows time for the Ardupilot to register the DisArm stick position
MOVW	R7, #11519
MOVT	R7, #305
NOP
NOP
L_DisArm12:
SUBS	R7, R7, #1
BNE	L_DisArm12
NOP
NOP
NOP
;FlightControl.c,97 :: 		}
L_end_DisArm:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DisArm
_TakeOff:
;FlightControl.c,99 :: 		boolean TakeOff()
SUB	SP, SP, #12
STR	LR, [SP, #0]
;FlightControl.c,102 :: 		current_DC_3 = STARTING_THROTTLE_VALUE;  //Start motors at this value to predict timing-iterations in launch sequence
MOVW	R1, #39322
MOVT	R1, #16569
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
STR	R1, [R0, #0]
;FlightControl.c,103 :: 		UARTSendString("Taking off7.");
MOVW	R0, #lo_addr(?lstr1_FlightControl+0)
MOVT	R0, #hi_addr(?lstr1_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,104 :: 		while(current_DC_3 < MAX_THROTTLE_VALUE){
L_TakeOff14:
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
LDR	R2, [R0, #0]
MOVW	R0, #52429
MOVT	R0, #16604
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__TakeOff61
MOVS	R0, #1
L__TakeOff61:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_TakeOff15
;FlightControl.c,105 :: 		current_DC_3 += THROTLE_STEP_SIZE;
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
STR	R0, [SP, #8]
LDR	R2, [R0, #0]
MOVW	R0, #52429
MOVT	R0, #15692
BL	__Add_FP+0
LDR	R1, [SP, #8]
STR	R0, [R1, #0]
;FlightControl.c,107 :: 		DC_time = (current_DC_3*pwm_period2)/100;
MOVW	R1, #lo_addr(_pwm_period2+0)
MOVT	R1, #hi_addr(_pwm_period2+0)
LDR	R2, [R1, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,108 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,110 :: 		if(current_DC_3 >= LIMIT_THROTTLE_VALUE)
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
LDR	R2, [R0, #0]
MOVW	R0, #13107
MOVT	R0, #16595
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__TakeOff62
MOVS	R0, #1
L__TakeOff62:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_TakeOff16
;FlightControl.c,112 :: 		sonarReadValue = alitudeSonarRead();
BL	_alitudeSonarRead+0
STRH	R0, [SP, #4]
;FlightControl.c,113 :: 		UARTSendString("Sonar average.");
MOVW	R0, #lo_addr(?lstr2_FlightControl+0)
MOVT	R0, #hi_addr(?lstr2_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,114 :: 		UARTSendUint16(sonarReadValue);
LDRH	R0, [SP, #4]
BL	_UARTSendUint16+0
;FlightControl.c,115 :: 		UARTSendNewLine();
BL	_UARTSendNewLine+0
;FlightControl.c,116 :: 		UARTSendString("Throttle");
MOVW	R0, #lo_addr(?lstr3_FlightControl+0)
MOVT	R0, #hi_addr(?lstr3_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,117 :: 		UARTSendDouble(current_DC_3);
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
LDR	R0, [R0, #0]
BL	_UARTSendDouble+0
;FlightControl.c,120 :: 		if (sonarReadValue <= MINIMUM_ALITITUDE && current_DC_3 >= MAX_THROTTLE_VALUE)
LDRH	R0, [SP, #4]
CMP	R0, #12
IT	HI
BHI	L__TakeOff49
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
LDR	R2, [R0, #0]
MOVW	R0, #52429
MOVT	R0, #16604
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__TakeOff63
MOVS	R0, #1
L__TakeOff63:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__TakeOff48
L__TakeOff47:
;FlightControl.c,122 :: 		UARTSendString("Failed to reach altitude.");
MOVW	R0, #lo_addr(?lstr4_FlightControl+0)
MOVT	R0, #hi_addr(?lstr4_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,123 :: 		Throttle_Off();
BL	_Throttle_Off+0
;FlightControl.c,124 :: 		GPIOC_ODR.B9 = 0; //Green LED Off - Indicates that the max throttle was reached but height off ground not acheived
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,125 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_TakeOff
;FlightControl.c,120 :: 		if (sonarReadValue <= MINIMUM_ALITITUDE && current_DC_3 >= MAX_THROTTLE_VALUE)
L__TakeOff49:
L__TakeOff48:
;FlightControl.c,127 :: 		if (current_DC_3 >= MAX_THROTTLE_VALUE)
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
LDR	R2, [R0, #0]
MOVW	R0, #52429
MOVT	R0, #16604
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__TakeOff64
MOVS	R0, #1
L__TakeOff64:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_TakeOff20
;FlightControl.c,129 :: 		UARTSendString("Max Throttle.");
MOVW	R0, #lo_addr(?lstr5_FlightControl+0)
MOVT	R0, #hi_addr(?lstr5_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,130 :: 		GPIOC_ODR.B9 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,131 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_TakeOff
;FlightControl.c,132 :: 		}
L_TakeOff20:
;FlightControl.c,133 :: 		if(sonarReadValue == 255)
LDRH	R0, [SP, #4]
CMP	R0, #255
IT	NE
BNE	L_TakeOff21
;FlightControl.c,135 :: 		UARTSendString("Sonar reads 255 return false.");
MOVW	R0, #lo_addr(?lstr6_FlightControl+0)
MOVT	R0, #hi_addr(?lstr6_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,136 :: 		GPIOC_ODR.B9 = 0; //Green LED Off - Indicates that the max throttle was reached but height off ground not acheived
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,137 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_TakeOff
;FlightControl.c,138 :: 		}
L_TakeOff21:
;FlightControl.c,139 :: 		if (sonarReadValue >= TAKEOFF_ALITITUDE)
LDRH	R0, [SP, #4]
CMP	R0, #48
IT	CC
BCC	L_TakeOff22
;FlightControl.c,141 :: 		UARTSendString("Reached Alitutude.");
MOVW	R0, #lo_addr(?lstr7_FlightControl+0)
MOVT	R0, #hi_addr(?lstr7_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,142 :: 		GPIOC_ODR.B9 = 1;   //Green LED Solid On - Indicates that target height off ground acheived
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,143 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_TakeOff
;FlightControl.c,144 :: 		}
L_TakeOff22:
;FlightControl.c,145 :: 		}
L_TakeOff16:
;FlightControl.c,146 :: 		GPIOC_ODR.B9 = ~GPIOC_ODR.B9; // Toggle PORTC
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,147 :: 		Delay_ms(TAKEOFF_LOOP_DELAY_MS);
MOVW	R7, #19263
MOVT	R7, #76
NOP
NOP
L_TakeOff23:
SUBS	R7, R7, #1
BNE	L_TakeOff23
NOP
NOP
NOP
;FlightControl.c,148 :: 		}
IT	AL
BAL	L_TakeOff14
L_TakeOff15:
;FlightControl.c,149 :: 		}
L_end_TakeOff:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _TakeOff
_LoiterMode:
;FlightControl.c,151 :: 		void LoiterMode(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,152 :: 		DC_time = (current_DC_8*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_8+0)
MOVT	R0, #hi_addr(_current_DC_8+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,153 :: 		PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM3_Set_Duty+0
;FlightControl.c,154 :: 		}
L_end_LoiterMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _LoiterMode
_StabilizeMode:
;FlightControl.c,156 :: 		void StabilizeMode(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,157 :: 		DC_time = (current_DC_3*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,158 :: 		PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM3_Set_Duty+0
;FlightControl.c,159 :: 		}
L_end_StabilizeMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _StabilizeMode
_LandingMode:
;FlightControl.c,162 :: 		void LandingMode(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,163 :: 		DC_time = (current_DC_9*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_9+0)
MOVT	R0, #hi_addr(_current_DC_9+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,164 :: 		PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM3_Set_Duty+0
;FlightControl.c,165 :: 		}
L_end_LandingMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _LandingMode
_Land:
;FlightControl.c,167 :: 		void Land(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,168 :: 		DC_time = (current_DC_7*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_7+0)
MOVT	R0, #hi_addr(_current_DC_7+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,169 :: 		PWM_TIM3_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM3_Set_Duty+0
;FlightControl.c,170 :: 		}
L_end_Land:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Land
_Yaw_Left:
;FlightControl.c,172 :: 		void Yaw_Left(uint16 timeToYaw_ms){
; timeToYaw_ms start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R8, R0
; timeToYaw_ms end address is: 0 (R0)
; timeToYaw_ms start address is: 32 (R8)
;FlightControl.c,173 :: 		DC_time = (8.0*pwm_period2)/100;
MOVW	R1, #lo_addr(_pwm_period2+0)
MOVT	R1, #hi_addr(_pwm_period2+0)
LDR	R2, [R1, #0]
MOV	R0, #1090519040
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,174 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
UXTH	R1, R0
MOVS	R2, #1
UXTH	R0, R1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,175 :: 		Vdelay_ms(timeToYaw_ms);
UXTH	R0, R8
; timeToYaw_ms end address is: 32 (R8)
BL	_VDelay_ms+0
;FlightControl.c,176 :: 		Yaw_Stop();
BL	_Yaw_Stop+0
;FlightControl.c,177 :: 		}
L_end_Yaw_Left:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Yaw_Left
_Yaw_Right:
;FlightControl.c,179 :: 		void Yaw_Right(const uint16 timeToYaw_ms){
; timeToYaw_ms start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R8, R0
; timeToYaw_ms end address is: 0 (R0)
; timeToYaw_ms start address is: 32 (R8)
;FlightControl.c,180 :: 		DC_time = (6.8*pwm_period2)/100;
MOVW	R1, #lo_addr(_pwm_period2+0)
MOVT	R1, #hi_addr(_pwm_period2+0)
LDR	R2, [R1, #0]
MOVW	R0, #39322
MOVT	R0, #16601
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,181 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
UXTH	R1, R0
MOVS	R2, #1
UXTH	R0, R1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,182 :: 		Vdelay_ms(timeToYaw_ms);
UXTH	R0, R8
; timeToYaw_ms end address is: 32 (R8)
BL	_VDelay_ms+0
;FlightControl.c,183 :: 		Yaw_Stop();
BL	_Yaw_Stop+0
;FlightControl.c,184 :: 		}
L_end_Yaw_Right:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Yaw_Right
_Yaw_Stop:
;FlightControl.c,186 :: 		void Yaw_Stop(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,187 :: 		DC_time = (current_DC*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC+0)
MOVT	R0, #hi_addr(_current_DC+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,188 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL2);       //for YAW
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,189 :: 		}
L_end_Yaw_Stop:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Yaw_Stop
_Forward_Flight:
;FlightControl.c,191 :: 		void Forward_Flight(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,192 :: 		DC_time = (6.5*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #0
MOVT	R0, #16592
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,193 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);       //for PITCH
MOVS	R2, #2
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,194 :: 		}
L_end_Forward_Flight:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Forward_Flight
_Stop_Forward:
;FlightControl.c,196 :: 		void Stop_Forward(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;FlightControl.c,197 :: 		DC_time = (current_DC*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC+0)
MOVT	R0, #hi_addr(_current_DC+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,198 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL3);       //for PITCH
MOVS	R2, #2
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,199 :: 		}
L_end_Stop_Forward:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Stop_Forward
_alitudeSonarRead:
;FlightControl.c,201 :: 		uint16 alitudeSonarRead()
SUB	SP, SP, #52
STR	LR, [SP, #0]
;FlightControl.c,203 :: 		uint16 sonarArray[SONAR_ITERATIONS] = {0};
ADD	R11, SP, #8
ADD	R10, R11, #25
MOVW	R12, #lo_addr(?ICSalitudeSonarRead_sonarArray_L0+0)
MOVT	R12, #hi_addr(?ICSalitudeSonarRead_sonarArray_L0+0)
BL	___CC2DW+0
;FlightControl.c,204 :: 		int16 i = 0;
;FlightControl.c,205 :: 		uint32 sonarAvg = 0;
;FlightControl.c,206 :: 		uint32 secondAvg = 0;
;FlightControl.c,207 :: 		uint8 anomolyCount = 0;
;FlightControl.c,209 :: 		UARTSendString("reading sonar");
MOVW	R0, #lo_addr(?lstr8_FlightControl+0)
MOVT	R0, #hi_addr(?lstr8_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,212 :: 		for(i=0; i < SONAR_ITERATIONS; i++)
; i start address is: 12 (R3)
MOVS	R3, #0
SXTH	R3, R3
; i end address is: 12 (R3)
L_alitudeSonarRead25:
; i start address is: 12 (R3)
CMP	R3, #10
IT	GE
BGE	L_alitudeSonarRead26
;FlightControl.c,214 :: 		sonarArray[i] = ADC1_Get_Sample(13);                          // Get ADC value from corresponding channel
ADD	R1, SP, #8
STR	R1, [SP, #48]
LSLS	R0, R3, #1
ADDS	R0, R1, R0
STR	R0, [SP, #44]
STRH	R3, [SP, #4]
MOVS	R0, #13
BL	_ADC1_Get_Sample+0
LDRSH	R3, [SP, #4]
LDR	R1, [SP, #44]
STRH	R0, [R1, #0]
;FlightControl.c,215 :: 		sonarArray[i] >>= 4;
LSLS	R0, R3, #1
LDR	R2, [SP, #48]
ADDS	R1, R2, R0
LDRH	R0, [R1, #0]
LSRS	R0, R0, #4
STRH	R0, [R1, #0]
;FlightControl.c,216 :: 		UARTSendUint16(sonarArray[i]);
LSLS	R0, R3, #1
ADDS	R0, R2, R0
LDRH	R0, [R0, #0]
STRH	R3, [SP, #4]
BL	_UARTSendUint16+0
LDRSH	R3, [SP, #4]
;FlightControl.c,217 :: 		if(sonarArray[i] >= SONAR_MAX_VALUE)
ADD	R1, SP, #8
LSLS	R0, R3, #1
ADDS	R0, R1, R0
LDRH	R0, [R0, #0]
CMP	R0, #240
IT	CC
BCC	L_alitudeSonarRead28
;FlightControl.c,220 :: 		i--;
SUBS	R1, R3, #1
SXTH	R1, R1
; i end address is: 12 (R3)
; i start address is: 4 (R1)
;FlightControl.c,221 :: 		anomolyCount++;
LDRB	R0, [SP, #32]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [SP, #32]
;FlightControl.c,222 :: 		if(anomolyCount > 20)
CMP	R0, #20
IT	LS
BLS	L_alitudeSonarRead29
; i end address is: 4 (R1)
;FlightControl.c,224 :: 		return 255;
MOVS	R0, #255
IT	AL
BAL	L_end_alitudeSonarRead
;FlightControl.c,225 :: 		}
L_alitudeSonarRead29:
;FlightControl.c,226 :: 		}
; i start address is: 4 (R1)
; i end address is: 4 (R1)
IT	AL
BAL	L_alitudeSonarRead30
L_alitudeSonarRead28:
;FlightControl.c,229 :: 		sonarAvg += sonarArray[i];
; i start address is: 12 (R3)
ADD	R1, SP, #8
LSLS	R0, R3, #1
ADDS	R0, R1, R0
LDRH	R1, [R0, #0]
LDR	R0, [SP, #28]
ADDS	R0, R0, R1
STR	R0, [SP, #28]
; i end address is: 12 (R3)
SXTH	R1, R3
;FlightControl.c,230 :: 		}
L_alitudeSonarRead30:
;FlightControl.c,231 :: 		Delay_ms(ALITUDE_SONAR_READ_DELAY);
; i start address is: 4 (R1)
MOVW	R7, #41247
MOVT	R7, #7
NOP
NOP
L_alitudeSonarRead31:
SUBS	R7, R7, #1
BNE	L_alitudeSonarRead31
NOP
NOP
NOP
;FlightControl.c,212 :: 		for(i=0; i < SONAR_ITERATIONS; i++)
ADDS	R0, R1, #1
SXTH	R0, R0
; i end address is: 4 (R1)
; i start address is: 0 (R0)
;FlightControl.c,232 :: 		}
SXTH	R3, R0
; i end address is: 0 (R0)
IT	AL
BAL	L_alitudeSonarRead25
L_alitudeSonarRead26:
;FlightControl.c,233 :: 		sonarAvg = sonarAvg/SONAR_ITERATIONS;
LDR	R1, [SP, #28]
MOVS	R0, #10
UDIV	R0, R1, R0
STR	R0, [SP, #28]
;FlightControl.c,234 :: 		secondAvg = 0;
; secondAvg start address is: 16 (R4)
MOVS	R4, #0
;FlightControl.c,235 :: 		for(i=0; i < SONAR_ITERATIONS; i++)
; i start address is: 12 (R3)
MOVS	R3, #0
SXTH	R3, R3
; i end address is: 12 (R3)
; secondAvg end address is: 16 (R4)
SXTH	R2, R3
MOV	R3, R4
L_alitudeSonarRead33:
; i start address is: 8 (R2)
; secondAvg start address is: 12 (R3)
CMP	R2, #10
IT	GE
BGE	L_alitudeSonarRead34
;FlightControl.c,237 :: 		if(sonarArray[i] >= sonarAvg + SONAR_OUTLIER_OFFSET)
ADD	R1, SP, #8
LSLS	R0, R2, #1
ADDS	R0, R1, R0
LDRH	R1, [R0, #0]
LDR	R0, [SP, #28]
ADDS	R0, #40
CMP	R1, R0
IT	CC
BCC	L_alitudeSonarRead36
;FlightControl.c,239 :: 		sonarArray[i] = sonarAvg;
ADD	R1, SP, #8
LSLS	R0, R2, #1
ADDS	R1, R1, R0
LDR	R0, [SP, #28]
STRH	R0, [R1, #0]
;FlightControl.c,240 :: 		}
L_alitudeSonarRead36:
;FlightControl.c,241 :: 		secondAvg += sonarArray[i];
ADD	R1, SP, #8
LSLS	R0, R2, #1
ADDS	R0, R1, R0
LDRH	R0, [R0, #0]
ADDS	R0, R3, R0
; secondAvg end address is: 12 (R3)
; secondAvg start address is: 16 (R4)
MOV	R4, R0
;FlightControl.c,235 :: 		for(i=0; i < SONAR_ITERATIONS; i++)
ADDS	R0, R2, #1
; i end address is: 8 (R2)
; i start address is: 0 (R0)
;FlightControl.c,242 :: 		}
MOV	R3, R4
; secondAvg end address is: 16 (R4)
; i end address is: 0 (R0)
SXTH	R2, R0
IT	AL
BAL	L_alitudeSonarRead33
L_alitudeSonarRead34:
;FlightControl.c,243 :: 		return((uint16)secondAvg/SONAR_ITERATIONS);
; secondAvg start address is: 12 (R3)
UXTH	R1, R3
; secondAvg end address is: 12 (R3)
MOVS	R0, #10
UDIV	R0, R1, R0
;FlightControl.c,244 :: 		}
L_end_alitudeSonarRead:
LDR	LR, [SP, #0]
ADD	SP, SP, #52
BX	LR
; end of _alitudeSonarRead
_Alitutde_Hover:
;FlightControl.c,246 :: 		void Alitutde_Hover()
SUB	SP, SP, #16
STR	LR, [SP, #0]
;FlightControl.c,248 :: 		uint16 sonarAlititude = 0;
;FlightControl.c,249 :: 		uint8 loopIteration = 0;
MOVS	R0, #0
STRB	R0, [SP, #6]
MOVS	R0, #0
STRB	R0, [SP, #7]
;FlightControl.c,250 :: 		uint8 failSafeCounter = 0;
;FlightControl.c,252 :: 		current_DC_3 = HOVER_THROTTLE_VALUE;
MOVW	R1, #39322
MOVT	R1, #16585
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
STR	R1, [R0, #0]
;FlightControl.c,253 :: 		DC_time = (current_DC_3*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #39322
MOVT	R0, #16585
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,254 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,256 :: 		UARTSendString("Stablilizing Alititude.");
MOVW	R0, #lo_addr(?lstr9_FlightControl+0)
MOVT	R0, #hi_addr(?lstr9_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,257 :: 		sonarAlititude = alitudeSonarRead();
BL	_alitudeSonarRead+0
STRH	R0, [SP, #4]
;FlightControl.c,258 :: 		UARTSendString("1st Sonar average.");
MOVW	R0, #lo_addr(?lstr10_FlightControl+0)
MOVT	R0, #hi_addr(?lstr10_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,259 :: 		UARTSendUint16(sonarAlititude);
LDRH	R0, [SP, #4]
BL	_UARTSendUint16+0
;FlightControl.c,260 :: 		UARTSendNewLine();
BL	_UARTSendNewLine+0
;FlightControl.c,262 :: 		while((sonarAlititude < (ALTITUDE_HOLD - SONAR_ALITUDE_RANGE)) || (sonarAlititude > (ALTITUDE_HOLD + SONAR_ALITUDE_RANGE)))
L_Alitutde_Hover37:
LDRH	R0, [SP, #4]
CMP	R0, #91
IT	CC
BCC	L__Alitutde_Hover52
LDRH	R0, [SP, #4]
CMP	R0, #101
IT	HI
BHI	L__Alitutde_Hover51
IT	AL
BAL	L_Alitutde_Hover38
L__Alitutde_Hover52:
L__Alitutde_Hover51:
;FlightControl.c,264 :: 		if(failSafeCounter >= 50)
LDRB	R0, [SP, #7]
CMP	R0, #50
IT	CC
BCC	L_Alitutde_Hover41
;FlightControl.c,266 :: 		UARTSendString("Breaking out at 50 iterations.");
MOVW	R0, #lo_addr(?lstr11_FlightControl+0)
MOVT	R0, #hi_addr(?lstr11_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,267 :: 		return;
IT	AL
BAL	L_end_Alitutde_Hover
;FlightControl.c,268 :: 		}
L_Alitutde_Hover41:
;FlightControl.c,269 :: 		else if(loopIteration >= ALITITUDE_SONAR_READ_ITER)
LDRB	R0, [SP, #6]
CMP	R0, #3
IT	CC
BCC	L_Alitutde_Hover43
;FlightControl.c,271 :: 		loopIteration = 0;
MOVS	R0, #0
STRB	R0, [SP, #6]
;FlightControl.c,272 :: 		if(sonarAlititude > ALTITUDE_HOLD)
LDRH	R0, [SP, #4]
CMP	R0, #96
IT	LS
BLS	L_Alitutde_Hover44
;FlightControl.c,274 :: 		current_DC_3 -= THROTLE_STEP_SIZE;
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
STR	R0, [SP, #12]
LDR	R0, [R0, #0]
MOVW	R2, #52429
MOVT	R2, #15692
BL	__Sub_FP+0
LDR	R1, [SP, #12]
STR	R0, [R1, #0]
;FlightControl.c,275 :: 		UARTSendString("Decrease Throttle.");
MOVW	R0, #lo_addr(?lstr12_FlightControl+0)
MOVT	R0, #hi_addr(?lstr12_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,276 :: 		}
IT	AL
BAL	L_Alitutde_Hover45
L_Alitutde_Hover44:
;FlightControl.c,277 :: 		else if(sonarAlititude < ALTITUDE_HOLD)
LDRH	R0, [SP, #4]
CMP	R0, #96
IT	CS
BCS	L_Alitutde_Hover46
;FlightControl.c,279 :: 		current_DC_3 += THROTLE_STEP_SIZE;
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
STR	R0, [SP, #12]
LDR	R2, [R0, #0]
MOVW	R0, #52429
MOVT	R0, #15692
BL	__Add_FP+0
LDR	R1, [SP, #12]
STR	R0, [R1, #0]
;FlightControl.c,280 :: 		UARTSendString("Increase Throttle.");
MOVW	R0, #lo_addr(?lstr13_FlightControl+0)
MOVT	R0, #hi_addr(?lstr13_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,281 :: 		}
L_Alitutde_Hover46:
L_Alitutde_Hover45:
;FlightControl.c,282 :: 		GPIOC_ODR.B8 = ~GPIOC_ODR.B8;
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;FlightControl.c,283 :: 		DC_time = (current_DC_3*pwm_period2)/100;
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_current_DC_3+0)
MOVT	R0, #hi_addr(_current_DC_3+0)
LDR	R0, [R0, #0]
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17096
BL	__Div_FP+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_DC_time+0)
MOVT	R1, #hi_addr(_DC_time+0)
STRH	R0, [R1, #0]
;FlightControl.c,284 :: 		PWM_TIM2_Set_Duty(DC_time, _PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;FlightControl.c,285 :: 		}
L_Alitutde_Hover43:
;FlightControl.c,286 :: 		sonarAlititude = alitudeSonarRead();
BL	_alitudeSonarRead+0
STRH	R0, [SP, #4]
;FlightControl.c,287 :: 		UARTSendString("Sonar average.");
MOVW	R0, #lo_addr(?lstr14_FlightControl+0)
MOVT	R0, #hi_addr(?lstr14_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,288 :: 		UARTSendUint16(sonarAlititude);
LDRH	R0, [SP, #4]
BL	_UARTSendUint16+0
;FlightControl.c,289 :: 		UARTSendNewLine();
BL	_UARTSendNewLine+0
;FlightControl.c,290 :: 		failSafeCounter++;
LDRB	R0, [SP, #7]
ADDS	R0, R0, #1
STRB	R0, [SP, #7]
;FlightControl.c,291 :: 		loopIteration++;
LDRB	R0, [SP, #6]
ADDS	R0, R0, #1
STRB	R0, [SP, #6]
;FlightControl.c,292 :: 		}
IT	AL
BAL	L_Alitutde_Hover37
L_Alitutde_Hover38:
;FlightControl.c,293 :: 		UARTSendString("Reached Altitude.");
MOVW	R0, #lo_addr(?lstr15_FlightControl+0)
MOVT	R0, #hi_addr(?lstr15_FlightControl+0)
BL	_UARTSendString+0
;FlightControl.c,294 :: 		}
L_end_Alitutde_Hover:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _Alitutde_Hover
