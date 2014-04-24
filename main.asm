_mainTestingThread:
;main.c,49 :: 		void mainTestingThread()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,57 :: 		Delay_ms(10000);
MOVW	R7, #57599
MOVT	R7, #1525
NOP
NOP
L_mainTestingThread0:
SUBS	R7, R7, #1
BNE	L_mainTestingThread0
NOP
NOP
NOP
;main.c,58 :: 		UARTSendString("Starting test8.");
MOVW	R0, #lo_addr(?lstr1_main+0)
MOVT	R0, #hi_addr(?lstr1_main+0)
BL	_UARTSendString+0
;main.c,60 :: 		StabilizeMode();  //Set to Stabilize mode for takeoff (Only needed for loop mode - the StabilizeMode() above will place the quad in correct mode for arming
BL	_StabilizeMode+0
;main.c,61 :: 		Delay_ms(500);
MOVW	R7, #19263
MOVT	R7, #76
NOP
NOP
L_mainTestingThread2:
SUBS	R7, R7, #1
BNE	L_mainTestingThread2
NOP
NOP
NOP
;main.c,62 :: 		Arm();            //Arm the quad rotors
BL	_Arm+0
;main.c,63 :: 		success = TakeOff();
BL	_TakeOff+0
;main.c,65 :: 		if(success == true)
CMP	R0, #0
IT	NE
BNE	L_mainTestingThread4
;main.c,67 :: 		LoiterMode();
BL	_LoiterMode+0
;main.c,68 :: 		Alitutde_Hover();
BL	_Alitutde_Hover+0
;main.c,69 :: 		LoiterMode();
BL	_LoiterMode+0
;main.c,70 :: 		Delay_ms(10000);
MOVW	R7, #57599
MOVT	R7, #1525
NOP
NOP
L_mainTestingThread5:
SUBS	R7, R7, #1
BNE	L_mainTestingThread5
NOP
NOP
NOP
;main.c,108 :: 		}
L_mainTestingThread4:
;main.c,109 :: 		UARTSendString("Returning to base.");
MOVW	R0, #lo_addr(?lstr2_main+0)
MOVT	R0, #hi_addr(?lstr2_main+0)
BL	_UARTSendString+0
;main.c,110 :: 		LandingMode();
BL	_LandingMode+0
;main.c,111 :: 		Delay_ms(20000);
MOVW	R7, #49663
MOVT	R7, #3051
NOP
NOP
L_mainTestingThread7:
SUBS	R7, R7, #1
BNE	L_mainTestingThread7
NOP
NOP
NOP
;main.c,112 :: 		DisArm();
BL	_DisArm+0
;main.c,114 :: 		while(1)
L_mainTestingThread9:
;main.c,116 :: 		Delay_ms(500);
MOVW	R7, #19263
MOVT	R7, #76
NOP
NOP
L_mainTestingThread11:
SUBS	R7, R7, #1
BNE	L_mainTestingThread11
NOP
NOP
NOP
;main.c,117 :: 		}
IT	AL
BAL	L_mainTestingThread9
;main.c,118 :: 		}
L_end_mainTestingThread:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _mainTestingThread
_InitSysTick:
;main.c,152 :: 		void InitSysTick()
;main.c,155 :: 		NVIC_SYSTICKCSR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_SYSTICKCSR+0)
MOVT	R0, #hi_addr(NVIC_SYSTICKCSR+0)
STR	R1, [R0, #0]
;main.c,158 :: 		NVIC_SYSTICKRVR = 60000;
MOVW	R1, #60000
MOVW	R0, #lo_addr(NVIC_SYSTICKRVR+0)
MOVT	R0, #hi_addr(NVIC_SYSTICKRVR+0)
STR	R1, [R0, #0]
;main.c,163 :: 		NVIC_SYSTICKCVR = 0; // Set Curent Value Register
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_SYSTICKCVR+0)
MOVT	R0, #hi_addr(NVIC_SYSTICKCVR+0)
STR	R1, [R0, #0]
;main.c,166 :: 		NVIC_SYSTICKCALVR = 9000;
MOVW	R1, #9000
MOVW	R0, #lo_addr(NVIC_SYSTICKCALVR+0)
MOVT	R0, #hi_addr(NVIC_SYSTICKCALVR+0)
STR	R1, [R0, #0]
;main.c,169 :: 		NVIC_SYSTICKCSR.B0 = 1; // SysTick Timer Enable
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_SYSTICKCSR+0)
MOVT	R1, #hi_addr(NVIC_SYSTICKCSR+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #0, #1
STR	R0, [R1, #0]
;main.c,170 :: 		NVIC_SYSTICKCSR.B1 = 1; // Enable SysTick Interrupt generation
MOVW	R1, #lo_addr(NVIC_SYSTICKCSR+0)
MOVT	R1, #hi_addr(NVIC_SYSTICKCSR+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #1, #1
STR	R0, [R1, #0]
;main.c,171 :: 		NVIC_SYSTICKCSR.B2 = 1; // Use processor free runing clock
MOVW	R1, #lo_addr(NVIC_SYSTICKCSR+0)
MOVT	R1, #hi_addr(NVIC_SYSTICKCSR+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #2, #1
STR	R0, [R1, #0]
;main.c,172 :: 		}
L_end_InitSysTick:
BX	LR
; end of _InitSysTick
_SysTick_ISR:
;main.c,178 :: 		void SysTick_ISR() iv IVT_INT_SysTick ics ICS_AUTO          // once every mS
;main.c,180 :: 		GPIOC_ODR ^= _GPIO_PINMASK_9;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
EOR	R1, R0, #512
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;main.c,181 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;main.c,182 :: 		msTicks++;
MOVW	R0, #lo_addr(_msTicks+0)
MOVT	R0, #hi_addr(_msTicks+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_msTicks+0)
MOVT	R0, #hi_addr(_msTicks+0)
STR	R1, [R0, #0]
;main.c,183 :: 		current_func++;                                           //switch to next function
MOVW	R1, #lo_addr(_current_func+0)
MOVT	R1, #hi_addr(_current_func+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;main.c,184 :: 		if (current_func == NUM_FUNC)                              //test for end of function
CMP	R0, #1
IT	NE
BNE	L_SysTick_ISR13
;main.c,185 :: 		current_func = 0;                                        //if so, restart at first function
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_current_func+0)
MOVT	R0, #hi_addr(_current_func+0)
STRH	R1, [R0, #0]
L_SysTick_ISR13:
;main.c,186 :: 		func_flag = 1;                                    //tell main() that there is a function ready
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_func_flag+0)
MOVT	R0, #hi_addr(_func_flag+0)
STRH	R1, [R0, #0]
;main.c,187 :: 		}
L_end_SysTick_ISR:
BX	LR
; end of _SysTick_ISR
_init_prog:
;main.c,191 :: 		void init_prog()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,203 :: 		UARTDebugInit();
BL	_UARTDebugInit+0
;main.c,204 :: 		Delay_ms(250);
MOVW	R7, #9631
MOVT	R7, #38
NOP
NOP
L_init_prog14:
SUBS	R7, R7, #1
BNE	L_init_prog14
NOP
NOP
NOP
;main.c,209 :: 		Flight_Control_Init();
BL	_Flight_Control_Init+0
;main.c,212 :: 		mainTestingThread();
BL	_mainTestingThread+0
;main.c,217 :: 		}
L_end_init_prog:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_prog
_main:
;main.c,221 :: 		void main()
;main.c,226 :: 		init_prog();
BL	_init_prog+0
;main.c,240 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_millis:
;main.c,243 :: 		unsigned long millis()
;main.c,245 :: 		return msTicks;                                      // function to return milliseconds
MOVW	R0, #lo_addr(_msTicks+0)
MOVT	R0, #hi_addr(_msTicks+0)
LDR	R0, [R0, #0]
;main.c,246 :: 		}
L_end_millis:
BX	LR
; end of _millis
