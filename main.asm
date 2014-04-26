_mainTestingThread:
;main.c,51 :: 		void mainTestingThread()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,59 :: 		UARTSendString("Delay for GPS Signal.");
MOVW	R0, #lo_addr(?lstr1_main+0)
MOVT	R0, #hi_addr(?lstr1_main+0)
BL	_UARTSendString+0
;main.c,60 :: 		Delay_ms(10000);
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
;main.c,61 :: 		UARTSendString("Starting test1234.");
MOVW	R0, #lo_addr(?lstr2_main+0)
MOVT	R0, #hi_addr(?lstr2_main+0)
BL	_UARTSendString+0
;main.c,63 :: 		StabilizeMode();  //Set to Stabilize mode for takeoff (Only needed for loop mode - the StabilizeMode() above will place the quad in correct mode for arming
BL	_StabilizeMode+0
;main.c,64 :: 		Delay_ms(500);
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
;main.c,65 :: 		Arm();            //Arm the quad rotors
BL	_Arm+0
;main.c,66 :: 		success = TakeOff();
BL	_TakeOff+0
;main.c,68 :: 		if(success == true)
CMP	R0, #0
IT	NE
BNE	L_mainTestingThread4
;main.c,70 :: 		UARTSendString("LoiterMode");
MOVW	R0, #lo_addr(?lstr3_main+0)
MOVT	R0, #hi_addr(?lstr3_main+0)
BL	_UARTSendString+0
;main.c,71 :: 		LoiterMode();
BL	_LoiterMode+0
;main.c,72 :: 		UARTSendNewLine();
BL	_UARTSendNewLine+0
;main.c,73 :: 		sonarWes = sonarGeneric();
BL	_sonarGeneric+0
MOVW	R1, #lo_addr(_sonarWes+0)
MOVT	R1, #hi_addr(_sonarWes+0)
STRH	R0, [R1, #0]
;main.c,74 :: 		UARTSendString("Sonar Read Raw.");
MOVW	R0, #lo_addr(?lstr4_main+0)
MOVT	R0, #hi_addr(?lstr4_main+0)
BL	_UARTSendString+0
;main.c,75 :: 		UARTSendUint16(sonarWes);
MOVW	R0, #lo_addr(_sonarWes+0)
MOVT	R0, #hi_addr(_sonarWes+0)
LDRSH	R0, [R0, #0]
BL	_UARTSendUint16+0
;main.c,77 :: 		Delay_ms(2000);
MOVW	R7, #11519
MOVT	R7, #305
NOP
NOP
L_mainTestingThread5:
SUBS	R7, R7, #1
BNE	L_mainTestingThread5
NOP
NOP
NOP
;main.c,81 :: 		for (i=0; i<=9; i++){
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_mainTestingThread7:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #9
IT	GT
BGT	L_mainTestingThread8
;main.c,82 :: 		sonarWes = sonarGeneric();
BL	_sonarGeneric+0
MOVW	R1, #lo_addr(_sonarWes+0)
MOVT	R1, #hi_addr(_sonarWes+0)
STRH	R0, [R1, #0]
;main.c,83 :: 		UARTSendString("Sonar Read Raw.");
MOVW	R0, #lo_addr(?lstr5_main+0)
MOVT	R0, #hi_addr(?lstr5_main+0)
BL	_UARTSendString+0
;main.c,84 :: 		UARTSendUint16(sonarWes);
MOVW	R0, #lo_addr(_sonarWes+0)
MOVT	R0, #hi_addr(_sonarWes+0)
LDRSH	R0, [R0, #0]
BL	_UARTSendUint16+0
;main.c,85 :: 		UARTSendNewLine();
BL	_UARTSendNewLine+0
;main.c,86 :: 		Delay_ms(1000);
MOVW	R7, #38527
MOVT	R7, #152
NOP
NOP
L_mainTestingThread10:
SUBS	R7, R7, #1
BNE	L_mainTestingThread10
NOP
NOP
NOP
;main.c,81 :: 		for (i=0; i<=9; i++){
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;main.c,87 :: 		}
IT	AL
BAL	L_mainTestingThread7
L_mainTestingThread8:
;main.c,126 :: 		}
L_mainTestingThread4:
;main.c,127 :: 		UARTSendString("Returning to base.");
MOVW	R0, #lo_addr(?lstr6_main+0)
MOVT	R0, #hi_addr(?lstr6_main+0)
BL	_UARTSendString+0
;main.c,128 :: 		LandingMode();
BL	_LandingMode+0
;main.c,129 :: 		Delay_ms(30000);
MOVW	R7, #41727
MOVT	R7, #4577
NOP
NOP
L_mainTestingThread12:
SUBS	R7, R7, #1
BNE	L_mainTestingThread12
NOP
NOP
NOP
;main.c,130 :: 		UARTSendString("Disarm in 10 seconds.");
MOVW	R0, #lo_addr(?lstr7_main+0)
MOVT	R0, #hi_addr(?lstr7_main+0)
BL	_UARTSendString+0
;main.c,131 :: 		Delay_ms(10000);
MOVW	R7, #57599
MOVT	R7, #1525
NOP
NOP
L_mainTestingThread14:
SUBS	R7, R7, #1
BNE	L_mainTestingThread14
NOP
NOP
NOP
;main.c,132 :: 		DisArm();
BL	_DisArm+0
;main.c,134 :: 		while(1)
L_mainTestingThread16:
;main.c,136 :: 		Delay_ms(500);
MOVW	R7, #19263
MOVT	R7, #76
NOP
NOP
L_mainTestingThread18:
SUBS	R7, R7, #1
BNE	L_mainTestingThread18
NOP
NOP
NOP
;main.c,137 :: 		}
IT	AL
BAL	L_mainTestingThread16
;main.c,138 :: 		}
L_end_mainTestingThread:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _mainTestingThread
_InitSysTick:
;main.c,172 :: 		void InitSysTick()
;main.c,175 :: 		NVIC_SYSTICKCSR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_SYSTICKCSR+0)
MOVT	R0, #hi_addr(NVIC_SYSTICKCSR+0)
STR	R1, [R0, #0]
;main.c,178 :: 		NVIC_SYSTICKRVR = 60000;
MOVW	R1, #60000
MOVW	R0, #lo_addr(NVIC_SYSTICKRVR+0)
MOVT	R0, #hi_addr(NVIC_SYSTICKRVR+0)
STR	R1, [R0, #0]
;main.c,183 :: 		NVIC_SYSTICKCVR = 0; // Set Curent Value Register
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_SYSTICKCVR+0)
MOVT	R0, #hi_addr(NVIC_SYSTICKCVR+0)
STR	R1, [R0, #0]
;main.c,186 :: 		NVIC_SYSTICKCALVR = 9000;
MOVW	R1, #9000
MOVW	R0, #lo_addr(NVIC_SYSTICKCALVR+0)
MOVT	R0, #hi_addr(NVIC_SYSTICKCALVR+0)
STR	R1, [R0, #0]
;main.c,189 :: 		NVIC_SYSTICKCSR.B0 = 1; // SysTick Timer Enable
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_SYSTICKCSR+0)
MOVT	R1, #hi_addr(NVIC_SYSTICKCSR+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #0, #1
STR	R0, [R1, #0]
;main.c,190 :: 		NVIC_SYSTICKCSR.B1 = 1; // Enable SysTick Interrupt generation
MOVW	R1, #lo_addr(NVIC_SYSTICKCSR+0)
MOVT	R1, #hi_addr(NVIC_SYSTICKCSR+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #1, #1
STR	R0, [R1, #0]
;main.c,191 :: 		NVIC_SYSTICKCSR.B2 = 1; // Use processor free runing clock
MOVW	R1, #lo_addr(NVIC_SYSTICKCSR+0)
MOVT	R1, #hi_addr(NVIC_SYSTICKCSR+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #2, #1
STR	R0, [R1, #0]
;main.c,192 :: 		}
L_end_InitSysTick:
BX	LR
; end of _InitSysTick
_SysTick_ISR:
;main.c,198 :: 		void SysTick_ISR() iv IVT_INT_SysTick ics ICS_AUTO          // once every mS
;main.c,200 :: 		GPIOC_ODR ^= _GPIO_PINMASK_9;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
EOR	R1, R0, #512
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;main.c,201 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;main.c,202 :: 		msTicks++;
MOVW	R0, #lo_addr(_msTicks+0)
MOVT	R0, #hi_addr(_msTicks+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_msTicks+0)
MOVT	R0, #hi_addr(_msTicks+0)
STR	R1, [R0, #0]
;main.c,203 :: 		current_func++;                                           //switch to next function
MOVW	R1, #lo_addr(_current_func+0)
MOVT	R1, #hi_addr(_current_func+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;main.c,204 :: 		if (current_func == NUM_FUNC)                              //test for end of function
CMP	R0, #1
IT	NE
BNE	L_SysTick_ISR20
;main.c,205 :: 		current_func = 0;                                        //if so, restart at first function
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_current_func+0)
MOVT	R0, #hi_addr(_current_func+0)
STRH	R1, [R0, #0]
L_SysTick_ISR20:
;main.c,206 :: 		func_flag = 1;                                    //tell main() that there is a function ready
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_func_flag+0)
MOVT	R0, #hi_addr(_func_flag+0)
STRH	R1, [R0, #0]
;main.c,207 :: 		}
L_end_SysTick_ISR:
BX	LR
; end of _SysTick_ISR
_init_prog:
;main.c,211 :: 		void init_prog()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,223 :: 		UARTDebugInit();
BL	_UARTDebugInit+0
;main.c,224 :: 		Delay_ms(250);
MOVW	R7, #9631
MOVT	R7, #38
NOP
NOP
L_init_prog21:
SUBS	R7, R7, #1
BNE	L_init_prog21
NOP
NOP
NOP
;main.c,229 :: 		Flight_Control_Init();
BL	_Flight_Control_Init+0
;main.c,232 :: 		mainTestingThread();
BL	_mainTestingThread+0
;main.c,237 :: 		}
L_end_init_prog:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_prog
_main:
;main.c,241 :: 		void main()
;main.c,246 :: 		init_prog();
BL	_init_prog+0
;main.c,260 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_millis:
;main.c,263 :: 		unsigned long millis()
;main.c,265 :: 		return msTicks;                                      // function to return milliseconds
MOVW	R0, #lo_addr(_msTicks+0)
MOVT	R0, #hi_addr(_msTicks+0)
LDR	R0, [R0, #0]
;main.c,266 :: 		}
L_end_millis:
BX	LR
; end of _millis
