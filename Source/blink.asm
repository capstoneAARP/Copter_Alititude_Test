_blink_init:
;blink.c,3 :: 		void blink_init()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;blink.c,5 :: 		GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_10);   // LED pin
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
BL	_GPIO_Digital_Output+0
;blink.c,7 :: 		}
L_end_blink_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _blink_init
_blink_led:
;blink.c,9 :: 		void blink_led()                                      //function to blink the LED at ~1hz
;blink.c,11 :: 		GPIOC_ODR ^= _GPIO_PINMASK_9;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
EOR	R1, R0, #512
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;blink.c,12 :: 		return;
;blink.c,13 :: 		}
L_end_blink_led:
BX	LR
; end of _blink_led
