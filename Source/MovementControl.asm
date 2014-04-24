_movementControlInit:
;MovementControl.c,10 :: 		void movementControlInit(void)
;MovementControl.c,12 :: 		currentHeading = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(MovementControl_currentHeading+0)
MOVT	R0, #hi_addr(MovementControl_currentHeading+0)
STRH	R1, [R0, #0]
;MovementControl.c,13 :: 		}
L_end_movementControlInit:
BX	LR
; end of _movementControlInit
_moveQuad:
;MovementControl.c,16 :: 		boolean moveQuad(direction dir, uint8 distance)
; distance start address is: 4 (R1)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R0, [SP, #12]
UXTB	R9, R1
; distance end address is: 4 (R1)
; distance start address is: 36 (R9)
;MovementControl.c,22 :: 		switch(dir)
IT	AL
BAL	L_moveQuad0
;MovementControl.c,24 :: 		case NORTH:
L_moveQuad2:
;MovementControl.c,25 :: 		newHeading = 0;
MOVS	R0, #0
;MovementControl.c,26 :: 		break;
UXTH	R10, R0
IT	AL
BAL	L_moveQuad1
;MovementControl.c,27 :: 		case SOUTH:
L_moveQuad3:
;MovementControl.c,28 :: 		newHeading = 180;
MOVS	R0, #180
;MovementControl.c,29 :: 		break;
UXTH	R10, R0
IT	AL
BAL	L_moveQuad1
;MovementControl.c,30 :: 		case EAST:
L_moveQuad4:
;MovementControl.c,31 :: 		newHeading = 90;
MOVS	R0, #90
;MovementControl.c,32 :: 		break;
UXTH	R10, R0
IT	AL
BAL	L_moveQuad1
;MovementControl.c,33 :: 		case WEST:
L_moveQuad5:
;MovementControl.c,34 :: 		newHeading = 270;
MOVW	R0, #270
;MovementControl.c,35 :: 		break;
UXTH	R10, R0
; distance end address is: 36 (R9)
IT	AL
BAL	L_moveQuad1
;MovementControl.c,36 :: 		default:
L_moveQuad6:
;MovementControl.c,37 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_moveQuad
;MovementControl.c,38 :: 		}
L_moveQuad0:
; distance start address is: 36 (R9)
LDRB	R2, [SP, #12]
CMP	R2, #0
IT	EQ
BEQ	L_moveQuad2
LDRB	R2, [SP, #12]
CMP	R2, #1
IT	EQ
BEQ	L_moveQuad3
LDRB	R2, [SP, #12]
CMP	R2, #2
IT	EQ
BEQ	L_moveQuad4
LDRB	R2, [SP, #12]
CMP	R2, #3
IT	EQ
BEQ	L_moveQuad5
; distance end address is: 36 (R9)
IT	AL
BAL	L_moveQuad6
L_moveQuad1:
;MovementControl.c,40 :: 		switch(dir)
; newHeading start address is: 40 (R10)
; distance start address is: 36 (R9)
IT	AL
BAL	L_moveQuad7
;MovementControl.c,42 :: 		case NORTH:
L_moveQuad9:
;MovementControl.c,43 :: 		newLonFeet = lonFeet;
MOVW	R2, #lo_addr(MovementControl_lonFeet+0)
MOVT	R2, #hi_addr(MovementControl_lonFeet+0)
LDR	R2, [R2, #0]
STR	R2, [SP, #8]
;MovementControl.c,44 :: 		newLatFeet = latFeet+distance;
UXTB	R0, R9
BL	__UnsignedIntegralToFloat+0
; distance end address is: 36 (R9)
MOVW	R2, #lo_addr(MovementControl_latFeet+0)
MOVT	R2, #hi_addr(MovementControl_latFeet+0)
LDR	R2, [R2, #0]
BL	__Add_FP+0
STR	R0, [SP, #4]
;MovementControl.c,45 :: 		break;
IT	AL
BAL	L_moveQuad8
;MovementControl.c,46 :: 		case SOUTH:
L_moveQuad10:
;MovementControl.c,47 :: 		newLonFeet = lonFeet;
; distance start address is: 36 (R9)
MOVW	R2, #lo_addr(MovementControl_lonFeet+0)
MOVT	R2, #hi_addr(MovementControl_lonFeet+0)
LDR	R2, [R2, #0]
STR	R2, [SP, #8]
;MovementControl.c,48 :: 		newLatFeet = latFeet-distance;
UXTB	R0, R9
BL	__UnsignedIntegralToFloat+0
; distance end address is: 36 (R9)
STR	R0, [SP, #16]
STR	R0, [SP, #16]
LDR	R3, [SP, #16]
MOVW	R2, #lo_addr(MovementControl_latFeet+0)
MOVT	R2, #hi_addr(MovementControl_latFeet+0)
LDR	R0, [R2, #0]
MOV	R2, R3
BL	__Sub_FP+0
STR	R0, [SP, #4]
;MovementControl.c,49 :: 		break;
IT	AL
BAL	L_moveQuad8
;MovementControl.c,50 :: 		case EAST:
L_moveQuad11:
;MovementControl.c,51 :: 		newLatFeet = latFeet;
; distance start address is: 36 (R9)
MOVW	R2, #lo_addr(MovementControl_latFeet+0)
MOVT	R2, #hi_addr(MovementControl_latFeet+0)
LDR	R2, [R2, #0]
STR	R2, [SP, #4]
;MovementControl.c,52 :: 		newLonFeet = lonFeet+distance;
UXTB	R0, R9
BL	__UnsignedIntegralToFloat+0
; distance end address is: 36 (R9)
MOVW	R2, #lo_addr(MovementControl_lonFeet+0)
MOVT	R2, #hi_addr(MovementControl_lonFeet+0)
LDR	R2, [R2, #0]
BL	__Add_FP+0
STR	R0, [SP, #8]
;MovementControl.c,53 :: 		break;
IT	AL
BAL	L_moveQuad8
;MovementControl.c,54 :: 		case WEST:
L_moveQuad12:
;MovementControl.c,55 :: 		newLatFeet = latFeet;
; distance start address is: 36 (R9)
MOVW	R2, #lo_addr(MovementControl_latFeet+0)
MOVT	R2, #hi_addr(MovementControl_latFeet+0)
LDR	R2, [R2, #0]
STR	R2, [SP, #4]
;MovementControl.c,56 :: 		newLonFeet = lonFeet-distance;
UXTB	R0, R9
BL	__UnsignedIntegralToFloat+0
; distance end address is: 36 (R9)
STR	R0, [SP, #16]
STR	R0, [SP, #16]
LDR	R3, [SP, #16]
MOVW	R2, #lo_addr(MovementControl_lonFeet+0)
MOVT	R2, #hi_addr(MovementControl_lonFeet+0)
LDR	R0, [R2, #0]
MOV	R2, R3
BL	__Sub_FP+0
STR	R0, [SP, #8]
;MovementControl.c,57 :: 		break;
IT	AL
BAL	L_moveQuad8
; newHeading end address is: 40 (R10)
;MovementControl.c,58 :: 		default:
L_moveQuad13:
;MovementControl.c,59 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_moveQuad
;MovementControl.c,60 :: 		}
L_moveQuad7:
; newHeading start address is: 40 (R10)
; distance start address is: 36 (R9)
LDRB	R2, [SP, #12]
CMP	R2, #0
IT	EQ
BEQ	L_moveQuad9
LDRB	R2, [SP, #12]
CMP	R2, #1
IT	EQ
BEQ	L_moveQuad10
LDRB	R2, [SP, #12]
CMP	R2, #2
IT	EQ
BEQ	L_moveQuad11
LDRB	R2, [SP, #12]
CMP	R2, #3
IT	EQ
BEQ	L_moveQuad12
; distance end address is: 36 (R9)
; newHeading end address is: 40 (R10)
IT	AL
BAL	L_moveQuad13
L_moveQuad8:
;MovementControl.c,62 :: 		rotateCopter(newHeading);
; newHeading start address is: 40 (R10)
UXTH	R0, R10
; newHeading end address is: 40 (R10)
BL	_rotateCopter+0
;MovementControl.c,63 :: 		Forward_Flight();
BL	_Forward_Flight+0
;MovementControl.c,65 :: 		switch(dir)
IT	AL
BAL	L_moveQuad14
;MovementControl.c,67 :: 		case NORTH:
L_moveQuad16:
;MovementControl.c,68 :: 		while(1)
L_moveQuad17:
;MovementControl.c,70 :: 		if(latFeet >= newLatFeet)
LDR	R3, [SP, #4]
MOVW	R2, #lo_addr(MovementControl_latFeet+0)
MOVT	R2, #hi_addr(MovementControl_latFeet+0)
LDR	R0, [R2, #0]
MOV	R2, R3
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__moveQuad51
MOVS	R0, #1
L__moveQuad51:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_moveQuad19
;MovementControl.c,72 :: 		break;
IT	AL
BAL	L_moveQuad18
;MovementControl.c,73 :: 		}
L_moveQuad19:
;MovementControl.c,74 :: 		}
IT	AL
BAL	L_moveQuad17
L_moveQuad18:
;MovementControl.c,75 :: 		break;
IT	AL
BAL	L_moveQuad15
;MovementControl.c,76 :: 		case SOUTH:
L_moveQuad20:
;MovementControl.c,77 :: 		while(1)
L_moveQuad21:
;MovementControl.c,79 :: 		if(latFeet <= newLatFeet)
LDR	R3, [SP, #4]
MOVW	R2, #lo_addr(MovementControl_latFeet+0)
MOVT	R2, #hi_addr(MovementControl_latFeet+0)
LDR	R0, [R2, #0]
MOV	R2, R3
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__moveQuad52
MOVS	R0, #1
L__moveQuad52:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_moveQuad23
;MovementControl.c,81 :: 		break;
IT	AL
BAL	L_moveQuad22
;MovementControl.c,82 :: 		}
L_moveQuad23:
;MovementControl.c,83 :: 		}
IT	AL
BAL	L_moveQuad21
L_moveQuad22:
;MovementControl.c,84 :: 		break;
IT	AL
BAL	L_moveQuad15
;MovementControl.c,85 :: 		case EAST:
L_moveQuad24:
;MovementControl.c,86 :: 		while(1)
L_moveQuad25:
;MovementControl.c,88 :: 		if(lonFeet >= newLonFeet)
LDR	R3, [SP, #8]
MOVW	R2, #lo_addr(MovementControl_lonFeet+0)
MOVT	R2, #hi_addr(MovementControl_lonFeet+0)
LDR	R0, [R2, #0]
MOV	R2, R3
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__moveQuad53
MOVS	R0, #1
L__moveQuad53:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_moveQuad27
;MovementControl.c,90 :: 		break;
IT	AL
BAL	L_moveQuad26
;MovementControl.c,91 :: 		}
L_moveQuad27:
;MovementControl.c,92 :: 		}
IT	AL
BAL	L_moveQuad25
L_moveQuad26:
;MovementControl.c,93 :: 		break;
IT	AL
BAL	L_moveQuad15
;MovementControl.c,94 :: 		case WEST:
L_moveQuad28:
;MovementControl.c,95 :: 		while(1)
L_moveQuad29:
;MovementControl.c,97 :: 		if(lonFeet <= newLonFeet)
LDR	R3, [SP, #8]
MOVW	R2, #lo_addr(MovementControl_lonFeet+0)
MOVT	R2, #hi_addr(MovementControl_lonFeet+0)
LDR	R0, [R2, #0]
MOV	R2, R3
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__moveQuad54
MOVS	R0, #1
L__moveQuad54:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_moveQuad31
;MovementControl.c,99 :: 		break;
IT	AL
BAL	L_moveQuad30
;MovementControl.c,100 :: 		}
L_moveQuad31:
;MovementControl.c,101 :: 		}
IT	AL
BAL	L_moveQuad29
L_moveQuad30:
;MovementControl.c,102 :: 		break;
IT	AL
BAL	L_moveQuad15
;MovementControl.c,103 :: 		default:
L_moveQuad32:
;MovementControl.c,104 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_moveQuad
;MovementControl.c,105 :: 		}
L_moveQuad14:
LDRB	R2, [SP, #12]
CMP	R2, #0
IT	EQ
BEQ	L_moveQuad16
LDRB	R2, [SP, #12]
CMP	R2, #1
IT	EQ
BEQ	L_moveQuad20
LDRB	R2, [SP, #12]
CMP	R2, #2
IT	EQ
BEQ	L_moveQuad24
LDRB	R2, [SP, #12]
CMP	R2, #3
IT	EQ
BEQ	L_moveQuad28
IT	AL
BAL	L_moveQuad32
L_moveQuad15:
;MovementControl.c,106 :: 		Stop_Forward();
BL	_Stop_Forward+0
;MovementControl.c,108 :: 		return true;
MOVS	R0, #0
;MovementControl.c,109 :: 		}
L_end_moveQuad:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _moveQuad
_rotateCopter:
;MovementControl.c,112 :: 		boolean rotateCopter(uint16 newHeading)
SUB	SP, SP, #8
STR	LR, [SP, #0]
STRH	R0, [SP, #4]
;MovementControl.c,114 :: 		uint16 diff = currentHeading - newHeading;
LDRH	R2, [SP, #4]
MOVW	R1, #lo_addr(MovementControl_currentHeading+0)
MOVT	R1, #hi_addr(MovementControl_currentHeading+0)
LDRH	R1, [R1, #0]
SUB	R1, R1, R2
UXTH	R0, R1
;MovementControl.c,117 :: 		if((newHeading % 10) != 0)
LDRH	R3, [SP, #4]
MOVS	R2, #10
UDIV	R1, R3, R2
MLS	R1, R2, R1, R3
UXTH	R1, R1
CMP	R1, #0
IT	EQ
BEQ	L_rotateCopter33
;MovementControl.c,120 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_rotateCopter
;MovementControl.c,121 :: 		}
L_rotateCopter33:
;MovementControl.c,123 :: 		if(diff == 0)
CMP	R0, #0
IT	NE
BNE	L_rotateCopter34
;MovementControl.c,125 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_rotateCopter
;MovementControl.c,126 :: 		}
L_rotateCopter34:
;MovementControl.c,128 :: 		timeToYaw_ms = (diff/10)*MILI_SECONDS_PER_10_DEGREE_YAW;
MOVS	R1, #10
UDIV	R2, R0, R1
UXTH	R2, R2
MOVS	R1, #10
MULS	R1, R2, R1
; timeToYaw_ms start address is: 8 (R2)
UXTH	R2, R1
;MovementControl.c,131 :: 		if(diff < -180)
MVN	R1, #179
CMP	R0, R1
IT	CS
BCS	L_rotateCopter35
;MovementControl.c,133 :: 		Yaw_Left(timeToYaw_ms);
UXTH	R0, R2
; timeToYaw_ms end address is: 8 (R2)
BL	_Yaw_Left+0
;MovementControl.c,134 :: 		}
IT	AL
BAL	L_rotateCopter36
L_rotateCopter35:
;MovementControl.c,135 :: 		else if(diff < 0)
; timeToYaw_ms start address is: 8 (R2)
CMP	R0, #0
IT	CS
BCS	L_rotateCopter37
;MovementControl.c,137 :: 		Yaw_Right(timeToYaw_ms);
UXTH	R0, R2
; timeToYaw_ms end address is: 8 (R2)
BL	_Yaw_Right+0
;MovementControl.c,138 :: 		}
IT	AL
BAL	L_rotateCopter38
L_rotateCopter37:
;MovementControl.c,139 :: 		else if(diff < 180)
; timeToYaw_ms start address is: 8 (R2)
CMP	R0, #180
IT	CS
BCS	L_rotateCopter39
;MovementControl.c,141 :: 		Yaw_Left(timeToYaw_ms);
UXTH	R0, R2
; timeToYaw_ms end address is: 8 (R2)
BL	_Yaw_Left+0
;MovementControl.c,142 :: 		}
IT	AL
BAL	L_rotateCopter40
L_rotateCopter39:
;MovementControl.c,145 :: 		Yaw_Right(timeToYaw_ms);
; timeToYaw_ms start address is: 8 (R2)
UXTH	R0, R2
; timeToYaw_ms end address is: 8 (R2)
BL	_Yaw_Right+0
;MovementControl.c,146 :: 		}
L_rotateCopter40:
L_rotateCopter38:
L_rotateCopter36:
;MovementControl.c,148 :: 		currentHeading = newHeading;
LDRH	R2, [SP, #4]
MOVW	R1, #lo_addr(MovementControl_currentHeading+0)
MOVT	R1, #hi_addr(MovementControl_currentHeading+0)
STRH	R2, [R1, #0]
;MovementControl.c,149 :: 		return true;
MOVS	R0, #0
;MovementControl.c,150 :: 		}
L_end_rotateCopter:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _rotateCopter
_getCurrentHeading:
;MovementControl.c,152 :: 		uint16 getCurrentHeading(void)
;MovementControl.c,154 :: 		return currentHeading;
MOVW	R0, #lo_addr(MovementControl_currentHeading+0)
MOVT	R0, #hi_addr(MovementControl_currentHeading+0)
LDRH	R0, [R0, #0]
;MovementControl.c,155 :: 		}
L_end_getCurrentHeading:
BX	LR
; end of _getCurrentHeading
_updateGPSCoordinate:
;MovementControl.c,157 :: 		boolean updateGPSCoordinate(int8 lonDegrees, double lonMinutes, char lonDirection, int8 latDegrees, double latMinutes, char latDirection)
; latDegrees start address is: 12 (R3)
; lonDirection start address is: 8 (R2)
; lonMinutes start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
SXTB	R8, R0
UXTB	R9, R2
SXTB	R11, R3
; latDegrees end address is: 12 (R3)
; lonDirection end address is: 8 (R2)
; lonMinutes end address is: 4 (R1)
; lonDegrees start address is: 32 (R8)
; lonMinutes start address is: 4 (R1)
; lonDirection start address is: 36 (R9)
; latDegrees start address is: 44 (R11)
; latMinutes start address is: 48 (R12)
LDR	R12, [SP, #8]
; latDirection start address is: 16 (R4)
LDRB	R4, [SP, #12]
; latDirection end address is: 16 (R4)
;MovementControl.c,159 :: 		double lonFeetTemp = (lonDegrees + lonMinutes/SIXTY_MINUTES_PER_DEGREE)*FEET_PER_KM_PER_DEGREE;
MOVW	R2, #0
MOVT	R2, #17008
MOV	R0, R1
BL	__Div_FP+0
; lonMinutes end address is: 4 (R1)
STR	R0, [SP, #4]
SXTB	R0, R8
BL	__SignedIntegralToFloat+0
; lonDegrees end address is: 32 (R8)
LDR	R2, [SP, #4]
BL	__Add_FP+0
MOVW	R2, #65337
MOVT	R2, #18609
BL	__Mul_FP+0
; lonFeetTemp start address is: 40 (R10)
MOV	R10, R0
;MovementControl.c,160 :: 		double latFeetTemp = (latDegrees + latMinutes/SIXTY_MINUTES_PER_DEGREE)*FEET_PER_KM_PER_DEGREE;
MOVW	R2, #0
MOVT	R2, #17008
MOV	R0, R12
BL	__Div_FP+0
; latMinutes end address is: 48 (R12)
STR	R0, [SP, #4]
SXTB	R0, R11
BL	__SignedIntegralToFloat+0
; latDegrees end address is: 44 (R11)
LDR	R2, [SP, #4]
BL	__Add_FP+0
MOVW	R2, #65337
MOVT	R2, #18609
BL	__Mul_FP+0
; latFeetTemp start address is: 32 (R8)
MOV	R8, R0
;MovementControl.c,161 :: 		if(lonDirection == 'W')
CMP	R9, #87
IT	NE
BNE	L_updateGPSCoordinate41
;MovementControl.c,163 :: 		lonFeet = lonFeetTemp*-1;
MOVW	R0, #0
MOVT	R0, #49024
MOV	R2, R10
BL	__Mul_FP+0
; lonFeetTemp end address is: 40 (R10)
MOVW	R4, #lo_addr(MovementControl_lonFeet+0)
MOVT	R4, #hi_addr(MovementControl_lonFeet+0)
STR	R0, [R4, #0]
;MovementControl.c,164 :: 		}
IT	AL
BAL	L_updateGPSCoordinate42
L_updateGPSCoordinate41:
;MovementControl.c,165 :: 		else if(lonDirection == 'E')
; lonFeetTemp start address is: 40 (R10)
CMP	R9, #69
IT	NE
BNE	L_updateGPSCoordinate43
;MovementControl.c,167 :: 		lonFeet = lonFeetTemp;
MOVW	R4, #lo_addr(MovementControl_lonFeet+0)
MOVT	R4, #hi_addr(MovementControl_lonFeet+0)
STR	R10, [R4, #0]
; lonFeetTemp end address is: 40 (R10)
;MovementControl.c,168 :: 		}
IT	AL
BAL	L_updateGPSCoordinate44
; lonDirection end address is: 36 (R9)
; latFeetTemp end address is: 32 (R8)
L_updateGPSCoordinate43:
;MovementControl.c,171 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_updateGPSCoordinate
;MovementControl.c,172 :: 		}
L_updateGPSCoordinate44:
; latFeetTemp start address is: 32 (R8)
; lonDirection start address is: 36 (R9)
L_updateGPSCoordinate42:
;MovementControl.c,173 :: 		if(lonDirection == 'S')
CMP	R9, #83
IT	NE
BNE	L_updateGPSCoordinate45
; lonDirection end address is: 36 (R9)
;MovementControl.c,175 :: 		latFeet = latFeetTemp*-1;
MOVW	R0, #0
MOVT	R0, #49024
MOV	R2, R8
BL	__Mul_FP+0
; latFeetTemp end address is: 32 (R8)
MOVW	R4, #lo_addr(MovementControl_latFeet+0)
MOVT	R4, #hi_addr(MovementControl_latFeet+0)
STR	R0, [R4, #0]
;MovementControl.c,176 :: 		}
IT	AL
BAL	L_updateGPSCoordinate46
L_updateGPSCoordinate45:
;MovementControl.c,177 :: 		else if(lonDirection == 'N')
; latFeetTemp start address is: 32 (R8)
; lonDirection start address is: 36 (R9)
CMP	R9, #78
IT	NE
BNE	L_updateGPSCoordinate47
; lonDirection end address is: 36 (R9)
;MovementControl.c,179 :: 		latFeet = latFeetTemp;
MOVW	R4, #lo_addr(MovementControl_latFeet+0)
MOVT	R4, #hi_addr(MovementControl_latFeet+0)
STR	R8, [R4, #0]
; latFeetTemp end address is: 32 (R8)
;MovementControl.c,180 :: 		}
IT	AL
BAL	L_updateGPSCoordinate48
L_updateGPSCoordinate47:
;MovementControl.c,183 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_updateGPSCoordinate
;MovementControl.c,184 :: 		}
L_updateGPSCoordinate48:
L_updateGPSCoordinate46:
;MovementControl.c,185 :: 		return true;
MOVS	R0, #0
;MovementControl.c,186 :: 		}
L_end_updateGPSCoordinate:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _updateGPSCoordinate
