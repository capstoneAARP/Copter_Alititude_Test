_pathPlanningInit:
;PathPlanning.c,18 :: 		void pathPlanningInit(void)
;PathPlanning.c,21 :: 		for(row = 0; row < MAX_MAP_ROWS; row++)
; row start address is: 8 (R2)
MOVS	R2, #0
; row end address is: 8 (R2)
L_pathPlanningInit0:
; row start address is: 8 (R2)
CMP	R2, #16
IT	CS
BCS	L_pathPlanningInit1
;PathPlanning.c,23 :: 		for(col = 0; col < MAX_MAP_COLS; col++)
; col start address is: 12 (R3)
MOVS	R3, #0
; col end address is: 12 (R3)
; row end address is: 8 (R2)
L_pathPlanningInit3:
; col start address is: 12 (R3)
; row start address is: 8 (R2)
CMP	R3, #16
IT	CS
BCS	L_pathPlanningInit4
;PathPlanning.c,25 :: 		obstacleMap[row][col] = EMPTY;
LSLS	R1, R2, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R1, R0, R3
MOVS	R0, #253
STRB	R0, [R1, #0]
;PathPlanning.c,23 :: 		for(col = 0; col < MAX_MAP_COLS; col++)
ADDS	R3, R3, #1
UXTB	R3, R3
;PathPlanning.c,26 :: 		}
; col end address is: 12 (R3)
IT	AL
BAL	L_pathPlanningInit3
L_pathPlanningInit4:
;PathPlanning.c,21 :: 		for(row = 0; row < MAX_MAP_ROWS; row++)
ADDS	R2, R2, #1
UXTB	R2, R2
;PathPlanning.c,27 :: 		}
; row end address is: 8 (R2)
IT	AL
BAL	L_pathPlanningInit0
L_pathPlanningInit1:
;PathPlanning.c,28 :: 		rowQuad = (MAX_MAP_ROWS/2)-1;
MOVS	R1, #7
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
STRB	R1, [R0, #0]
;PathPlanning.c,29 :: 		colQuad = (MAX_MAP_COLS/2)-1;
MOVS	R1, #7
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
STRB	R1, [R0, #0]
;PathPlanning.c,30 :: 		obstacleMap[(MAX_MAP_ROWS/2)-1][(MAX_MAP_COLS/2)-1] = QUADCOPTER;
MOVS	R1, #255
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+119)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+119)
STRB	R1, [R0, #0]
;PathPlanning.c,31 :: 		rowGoal = 255;
MOVS	R1, #255
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
STRB	R1, [R0, #0]
;PathPlanning.c,32 :: 		colGoal = 255;
MOVS	R1, #255
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
STRB	R1, [R0, #0]
;PathPlanning.c,33 :: 		currentMode = BEACON_MODE;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_currentMode+0)
MOVT	R0, #hi_addr(PathPlanning_currentMode+0)
STRB	R1, [R0, #0]
;PathPlanning.c,34 :: 		validPath = false;
MOVS	R1, #1
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,35 :: 		}
L_end_pathPlanningInit:
BX	LR
; end of _pathPlanningInit
_checkObstacleFront:
;PathPlanning.c,37 :: 		boolean checkObstacleFront(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;PathPlanning.c,40 :: 		uint16 currentHeading = getCurrentHeading();
BL	_getCurrentHeading+0
;PathPlanning.c,42 :: 		switch(currentHeading)
IT	AL
BAL	L_checkObstacleFront6
;PathPlanning.c,44 :: 		case 0:
L_checkObstacleFront8:
;PathPlanning.c,45 :: 		for(i = rowQuad-1; i != -1; i--)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
SUBS	R2, R0, #1
SXTH	R2, R2
; i start address is: 8 (R2)
; i end address is: 8 (R2)
L_checkObstacleFront9:
; i start address is: 8 (R2)
CMP	R2, #-1
IT	EQ
BEQ	L_checkObstacleFront10
;PathPlanning.c,47 :: 		if(obstacleMap[i][colQuad] == OBSTACLE)
LSLS	R1, R2, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	NE
BNE	L_checkObstacleFront12
; i end address is: 8 (R2)
;PathPlanning.c,50 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_checkObstacleFront
;PathPlanning.c,51 :: 		}
L_checkObstacleFront12:
;PathPlanning.c,45 :: 		for(i = rowQuad-1; i != -1; i--)
; i start address is: 8 (R2)
SUBS	R2, R2, #1
SXTH	R2, R2
;PathPlanning.c,52 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_checkObstacleFront9
L_checkObstacleFront10:
;PathPlanning.c,53 :: 		break;
IT	AL
BAL	L_checkObstacleFront7
;PathPlanning.c,54 :: 		case 90:
L_checkObstacleFront13:
;PathPlanning.c,55 :: 		for(i = colQuad+1; i != MAX_MAP_COLS; i++)
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
ADDS	R2, R0, #1
SXTH	R2, R2
; i start address is: 8 (R2)
; i end address is: 8 (R2)
L_checkObstacleFront14:
; i start address is: 8 (R2)
CMP	R2, #16
IT	EQ
BEQ	L_checkObstacleFront15
;PathPlanning.c,57 :: 		if(obstacleMap[rowQuad][i] == OBSTACLE)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R2
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	NE
BNE	L_checkObstacleFront17
; i end address is: 8 (R2)
;PathPlanning.c,60 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_checkObstacleFront
;PathPlanning.c,61 :: 		}
L_checkObstacleFront17:
;PathPlanning.c,55 :: 		for(i = colQuad+1; i != MAX_MAP_COLS; i++)
; i start address is: 8 (R2)
ADDS	R2, R2, #1
SXTH	R2, R2
;PathPlanning.c,62 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_checkObstacleFront14
L_checkObstacleFront15:
;PathPlanning.c,63 :: 		break;
IT	AL
BAL	L_checkObstacleFront7
;PathPlanning.c,64 :: 		case 180:
L_checkObstacleFront18:
;PathPlanning.c,65 :: 		for(i = rowQuad+1; i != MAX_MAP_ROWS; i++)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
ADDS	R2, R0, #1
SXTH	R2, R2
; i start address is: 8 (R2)
; i end address is: 8 (R2)
L_checkObstacleFront19:
; i start address is: 8 (R2)
CMP	R2, #16
IT	EQ
BEQ	L_checkObstacleFront20
;PathPlanning.c,67 :: 		if(obstacleMap[i][colQuad] == OBSTACLE)
LSLS	R1, R2, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	NE
BNE	L_checkObstacleFront22
; i end address is: 8 (R2)
;PathPlanning.c,70 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_checkObstacleFront
;PathPlanning.c,71 :: 		}
L_checkObstacleFront22:
;PathPlanning.c,65 :: 		for(i = rowQuad+1; i != MAX_MAP_ROWS; i++)
; i start address is: 8 (R2)
ADDS	R2, R2, #1
SXTH	R2, R2
;PathPlanning.c,72 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_checkObstacleFront19
L_checkObstacleFront20:
;PathPlanning.c,73 :: 		break;
IT	AL
BAL	L_checkObstacleFront7
;PathPlanning.c,74 :: 		case 270:
L_checkObstacleFront23:
;PathPlanning.c,75 :: 		for(i = colQuad-1; i != -1; i--)
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
SUBS	R2, R0, #1
SXTH	R2, R2
; i start address is: 8 (R2)
; i end address is: 8 (R2)
L_checkObstacleFront24:
; i start address is: 8 (R2)
CMP	R2, #-1
IT	EQ
BEQ	L_checkObstacleFront25
;PathPlanning.c,77 :: 		if(obstacleMap[rowQuad][i] == OBSTACLE)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R2
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	NE
BNE	L_checkObstacleFront27
; i end address is: 8 (R2)
;PathPlanning.c,80 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_checkObstacleFront
;PathPlanning.c,81 :: 		}
L_checkObstacleFront27:
;PathPlanning.c,75 :: 		for(i = colQuad-1; i != -1; i--)
; i start address is: 8 (R2)
SUBS	R2, R2, #1
SXTH	R2, R2
;PathPlanning.c,82 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_checkObstacleFront24
L_checkObstacleFront25:
;PathPlanning.c,83 :: 		break;
IT	AL
BAL	L_checkObstacleFront7
;PathPlanning.c,84 :: 		default:
L_checkObstacleFront28:
;PathPlanning.c,86 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_checkObstacleFront
;PathPlanning.c,87 :: 		}
L_checkObstacleFront6:
CMP	R0, #0
IT	EQ
BEQ	L_checkObstacleFront8
CMP	R0, #90
IT	EQ
BEQ	L_checkObstacleFront13
CMP	R0, #180
IT	EQ
BEQ	L_checkObstacleFront18
CMP	R0, #270
IT	EQ
BEQ	L_checkObstacleFront23
IT	AL
BAL	L_checkObstacleFront28
L_checkObstacleFront7:
;PathPlanning.c,89 :: 		return false;
MOVS	R0, #1
;PathPlanning.c,90 :: 		}
L_end_checkObstacleFront:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _checkObstacleFront
_updateMapGoal:
;PathPlanning.c,94 :: 		boolean updateMapGoal(uint8 newRowGoal, uint8 newColGoal)
; newColGoal start address is: 4 (R1)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
UXTB	R5, R1
; newColGoal end address is: 4 (R1)
; newRowGoal start address is: 16 (R4)
; newColGoal start address is: 20 (R5)
;PathPlanning.c,96 :: 		if(newRowGoal >= MAX_MAP_ROWS || newColGoal >= MAX_MAP_COLS)
CMP	R4, #16
IT	CS
BCS	L__updateMapGoal125
CMP	R5, #16
IT	CS
BCS	L__updateMapGoal124
IT	AL
BAL	L_updateMapGoal31
; newRowGoal end address is: 16 (R4)
; newColGoal end address is: 20 (R5)
L__updateMapGoal125:
L__updateMapGoal124:
;PathPlanning.c,98 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_updateMapGoal
;PathPlanning.c,99 :: 		}
L_updateMapGoal31:
;PathPlanning.c,101 :: 		removePathPlan();
; newColGoal start address is: 20 (R5)
; newRowGoal start address is: 16 (R4)
BL	_removePathPlan+0
;PathPlanning.c,102 :: 		obstacleMap[newRowGoal][newColGoal] = GOAL;
LSLS	R3, R4, #4
MOVW	R2, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R2, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R2, R2, R3
ADDS	R3, R2, R5
MOVS	R2, #0
STRB	R2, [R3, #0]
;PathPlanning.c,103 :: 		rowGoal = newRowGoal;
MOVW	R2, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R2, #hi_addr(PathPlanning_rowGoal+0)
STRB	R4, [R2, #0]
; newRowGoal end address is: 16 (R4)
;PathPlanning.c,104 :: 		colGoal = newColGoal;
MOVW	R2, #lo_addr(PathPlanning_colGoal+0)
MOVT	R2, #hi_addr(PathPlanning_colGoal+0)
STRB	R5, [R2, #0]
; newColGoal end address is: 20 (R5)
;PathPlanning.c,106 :: 		return true;
MOVS	R0, #0
;PathPlanning.c,107 :: 		}
L_end_updateMapGoal:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _updateMapGoal
_addObstacle:
;PathPlanning.c,110 :: 		boolean addObstacle(uint8 rowObstacle, uint8 colObstacle)
; colObstacle start address is: 4 (R1)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
UXTB	R5, R1
; colObstacle end address is: 4 (R1)
; rowObstacle start address is: 16 (R4)
; colObstacle start address is: 20 (R5)
;PathPlanning.c,112 :: 		if(rowObstacle >= MAX_MAP_ROWS || colObstacle >= MAX_MAP_COLS)
CMP	R4, #16
IT	CS
BCS	L__addObstacle128
CMP	R5, #16
IT	CS
BCS	L__addObstacle127
IT	AL
BAL	L_addObstacle34
; rowObstacle end address is: 16 (R4)
; colObstacle end address is: 20 (R5)
L__addObstacle128:
L__addObstacle127:
;PathPlanning.c,114 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_addObstacle
;PathPlanning.c,115 :: 		}
L_addObstacle34:
;PathPlanning.c,116 :: 		if(obstacleMap[rowObstacle][colObstacle] != OBSTACLE)
; colObstacle start address is: 20 (R5)
; rowObstacle start address is: 16 (R4)
LSLS	R3, R4, #4
MOVW	R2, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R2, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R2, R2, R3
ADDS	R2, R2, R5
LDRB	R2, [R2, #0]
CMP	R2, #254
IT	EQ
BEQ	L_addObstacle35
;PathPlanning.c,118 :: 		removePathPlan();
BL	_removePathPlan+0
;PathPlanning.c,119 :: 		obstacleMap[rowObstacle][colObstacle] = OBSTACLE;
LSLS	R3, R4, #4
; rowObstacle end address is: 16 (R4)
MOVW	R2, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R2, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R2, R2, R3
ADDS	R3, R2, R5
; colObstacle end address is: 20 (R5)
MOVS	R2, #254
STRB	R2, [R3, #0]
;PathPlanning.c,120 :: 		}
L_addObstacle35:
;PathPlanning.c,121 :: 		return true;
MOVS	R0, #0
;PathPlanning.c,122 :: 		}
L_end_addObstacle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _addObstacle
_removePathPlan:
;PathPlanning.c,124 :: 		void removePathPlan(void)
;PathPlanning.c,127 :: 		for(row = 0; row < MAX_MAP_ROWS; row++)
; row start address is: 8 (R2)
MOVS	R2, #0
; row end address is: 8 (R2)
L_removePathPlan36:
; row start address is: 8 (R2)
CMP	R2, #16
IT	CS
BCS	L_removePathPlan37
;PathPlanning.c,129 :: 		for(col = 0; col < MAX_MAP_COLS; col++)
; col start address is: 12 (R3)
MOVS	R3, #0
; col end address is: 12 (R3)
; row end address is: 8 (R2)
L_removePathPlan39:
; col start address is: 12 (R3)
; row start address is: 8 (R2)
CMP	R3, #16
IT	CS
BCS	L_removePathPlan40
;PathPlanning.c,132 :: 		if(obstacleMap[row][col] < OBSTACLE && obstacleMap[row][col] != GOAL)
LSLS	R1, R2, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #254
IT	CS
BCS	L__removePathPlan122
LSLS	R1, R2, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__removePathPlan121
L__removePathPlan120:
;PathPlanning.c,134 :: 		obstacleMap[row][col] = EMPTY;
LSLS	R1, R2, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R1, R0, R3
MOVS	R0, #253
STRB	R0, [R1, #0]
;PathPlanning.c,132 :: 		if(obstacleMap[row][col] < OBSTACLE && obstacleMap[row][col] != GOAL)
L__removePathPlan122:
L__removePathPlan121:
;PathPlanning.c,129 :: 		for(col = 0; col < MAX_MAP_COLS; col++)
ADDS	R3, R3, #1
UXTB	R3, R3
;PathPlanning.c,136 :: 		}
; col end address is: 12 (R3)
IT	AL
BAL	L_removePathPlan39
L_removePathPlan40:
;PathPlanning.c,127 :: 		for(row = 0; row < MAX_MAP_ROWS; row++)
ADDS	R2, R2, #1
UXTB	R2, R2
;PathPlanning.c,137 :: 		}
; row end address is: 8 (R2)
IT	AL
BAL	L_removePathPlan36
L_removePathPlan37:
;PathPlanning.c,138 :: 		validPath = false;
MOVS	R1, #1
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,139 :: 		}
L_end_removePathPlan:
BX	LR
; end of _removePathPlan
_updateMode:
;PathPlanning.c,142 :: 		boolean updateMode(uint8 newMode)
;PathPlanning.c,144 :: 		if(currentMode >= MAX_MODE)
MOVW	R1, #lo_addr(PathPlanning_currentMode+0)
MOVT	R1, #hi_addr(PathPlanning_currentMode+0)
LDRB	R1, [R1, #0]
CMP	R1, #4
IT	CC
BCC	L_updateMode45
;PathPlanning.c,146 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_updateMode
;PathPlanning.c,147 :: 		}
L_updateMode45:
;PathPlanning.c,148 :: 		currentMode = newMode;
MOVW	R1, #lo_addr(PathPlanning_currentMode+0)
MOVT	R1, #hi_addr(PathPlanning_currentMode+0)
STRB	R0, [R1, #0]
;PathPlanning.c,149 :: 		return true;
MOVS	R0, #0
;PathPlanning.c,150 :: 		}
L_end_updateMode:
BX	LR
; end of _updateMode
_findPath:
;PathPlanning.c,153 :: 		boolean findPath(void)
SUB	SP, SP, #128
;PathPlanning.c,157 :: 		uint8 currentDepthCount = 0;
; currentDepthCount start address is: 28 (R7)
MOVS	R7, #0
;PathPlanning.c,158 :: 		uint8 nextDepthCount = 0;
; nextDepthCount start address is: 20 (R5)
MOVS	R5, #0
;PathPlanning.c,160 :: 		uint8 rowCheck = 0;
;PathPlanning.c,161 :: 		uint8 colCheck = 0;
;PathPlanning.c,162 :: 		uint8 iteration = 2;
; iteration start address is: 24 (R6)
MOVS	R6, #2
;PathPlanning.c,164 :: 		if(rowGoal == 255 && colGoal == 255)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L__findPath131
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L__findPath130
; nextDepthCount end address is: 20 (R5)
; iteration end address is: 24 (R6)
; currentDepthCount end address is: 28 (R7)
L__findPath129:
;PathPlanning.c,167 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_findPath
;PathPlanning.c,164 :: 		if(rowGoal == 255 && colGoal == 255)
L__findPath131:
; currentDepthCount start address is: 28 (R7)
; iteration start address is: 24 (R6)
; nextDepthCount start address is: 20 (R5)
L__findPath130:
;PathPlanning.c,170 :: 		if(validPath == true)
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_findPath49
; nextDepthCount end address is: 20 (R5)
; iteration end address is: 24 (R6)
; currentDepthCount end address is: 28 (R7)
;PathPlanning.c,173 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,174 :: 		}
L_findPath49:
;PathPlanning.c,178 :: 		if(rowGoal != 0)
; currentDepthCount start address is: 28 (R7)
; iteration start address is: 24 (R6)
; nextDepthCount start address is: 20 (R5)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__findPath133
;PathPlanning.c,180 :: 		if(obstacleMap[rowGoal-1][colGoal] == QUADCOPTER)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L_findPath51
; nextDepthCount end address is: 20 (R5)
; iteration end address is: 24 (R6)
; currentDepthCount end address is: 28 (R7)
;PathPlanning.c,183 :: 		validPath = true;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,184 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,185 :: 		}
L_findPath51:
;PathPlanning.c,186 :: 		if(obstacleMap[rowGoal-1][colGoal] == EMPTY)
; currentDepthCount start address is: 28 (R7)
; iteration start address is: 24 (R6)
; nextDepthCount start address is: 20 (R5)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #253
IT	NE
BNE	L__findPath132
;PathPlanning.c,188 :: 		currentDepth[currentDepthCount] = (rowGoal-1)*MAX_MAP_COLS+colGoal;
ADD	R1, SP, #0
LSLS	R0, R7, #1
ADDS	R4, R1, R0
MOVW	R3, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R3, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R3, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
SXTH	R1, R1
MOVW	R2, #lo_addr(PathPlanning_colGoal+0)
MOVT	R2, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R2, #0]
ADDS	R0, R1, R0
STRH	R0, [R4, #0]
;PathPlanning.c,189 :: 		currentDepthCount++;
ADDS	R4, R7, #1
UXTB	R4, R4
; currentDepthCount end address is: 28 (R7)
; currentDepthCount start address is: 16 (R4)
;PathPlanning.c,190 :: 		obstacleMap[rowGoal-1][colGoal] = 1;
MOV	R0, R3
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
MOVS	R0, #1
STRB	R0, [R1, #0]
; currentDepthCount end address is: 16 (R4)
UXTB	R7, R4
;PathPlanning.c,191 :: 		}
IT	AL
BAL	L_findPath52
L__findPath132:
;PathPlanning.c,186 :: 		if(obstacleMap[rowGoal-1][colGoal] == EMPTY)
;PathPlanning.c,191 :: 		}
L_findPath52:
;PathPlanning.c,192 :: 		}
; currentDepthCount start address is: 28 (R7)
; currentDepthCount end address is: 28 (R7)
IT	AL
BAL	L_findPath50
L__findPath133:
;PathPlanning.c,178 :: 		if(rowGoal != 0)
;PathPlanning.c,192 :: 		}
L_findPath50:
;PathPlanning.c,194 :: 		if(rowGoal != MAX_MAP_ROWS-1)
; currentDepthCount start address is: 28 (R7)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
CMP	R0, #15
IT	EQ
BEQ	L__findPath135
;PathPlanning.c,196 :: 		if(obstacleMap[rowGoal+1][colGoal] == QUADCOPTER)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L_findPath54
; nextDepthCount end address is: 20 (R5)
; iteration end address is: 24 (R6)
; currentDepthCount end address is: 28 (R7)
;PathPlanning.c,199 :: 		validPath = true;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,200 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,201 :: 		}
L_findPath54:
;PathPlanning.c,202 :: 		if(obstacleMap[rowGoal+1][colGoal] == EMPTY)
; currentDepthCount start address is: 28 (R7)
; iteration start address is: 24 (R6)
; nextDepthCount start address is: 20 (R5)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #253
IT	NE
BNE	L__findPath134
;PathPlanning.c,204 :: 		currentDepth[currentDepthCount] = (rowGoal+1)*MAX_MAP_COLS+colGoal;
ADD	R1, SP, #0
LSLS	R0, R7, #1
ADDS	R4, R1, R0
MOVW	R3, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R3, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R3, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
SXTH	R1, R1
MOVW	R2, #lo_addr(PathPlanning_colGoal+0)
MOVT	R2, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R2, #0]
ADDS	R0, R1, R0
STRH	R0, [R4, #0]
;PathPlanning.c,205 :: 		currentDepthCount++;
ADDS	R4, R7, #1
UXTB	R4, R4
; currentDepthCount end address is: 28 (R7)
; currentDepthCount start address is: 16 (R4)
;PathPlanning.c,206 :: 		obstacleMap[rowGoal+1][colGoal] = 1;
MOV	R0, R3
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
MOVS	R0, #1
STRB	R0, [R1, #0]
; currentDepthCount end address is: 16 (R4)
UXTB	R7, R4
;PathPlanning.c,207 :: 		}
IT	AL
BAL	L_findPath55
L__findPath134:
;PathPlanning.c,202 :: 		if(obstacleMap[rowGoal+1][colGoal] == EMPTY)
;PathPlanning.c,207 :: 		}
L_findPath55:
;PathPlanning.c,208 :: 		}
; currentDepthCount start address is: 28 (R7)
; currentDepthCount end address is: 28 (R7)
IT	AL
BAL	L_findPath53
L__findPath135:
;PathPlanning.c,194 :: 		if(rowGoal != MAX_MAP_ROWS-1)
;PathPlanning.c,208 :: 		}
L_findPath53:
;PathPlanning.c,210 :: 		if(colGoal != 0)
; currentDepthCount start address is: 28 (R7)
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__findPath137
;PathPlanning.c,212 :: 		if(obstacleMap[rowGoal][colGoal-1] == QUADCOPTER)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L_findPath57
; nextDepthCount end address is: 20 (R5)
; iteration end address is: 24 (R6)
; currentDepthCount end address is: 28 (R7)
;PathPlanning.c,215 :: 		validPath = true;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,216 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,217 :: 		}
L_findPath57:
;PathPlanning.c,218 :: 		if(obstacleMap[rowGoal][colGoal-1] == EMPTY)
; currentDepthCount start address is: 28 (R7)
; iteration start address is: 24 (R6)
; nextDepthCount start address is: 20 (R5)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #253
IT	NE
BNE	L__findPath136
;PathPlanning.c,220 :: 		currentDepth[currentDepthCount] = (rowGoal)*MAX_MAP_COLS+colGoal-1;
ADD	R1, SP, #0
LSLS	R0, R7, #1
ADDS	R4, R1, R0
MOVW	R3, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R3, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R3, #0]
LSLS	R1, R0, #4
SXTH	R1, R1
MOVW	R2, #lo_addr(PathPlanning_colGoal+0)
MOVT	R2, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R2, #0]
ADDS	R0, R1, R0
SXTH	R0, R0
SUBS	R0, R0, #1
STRH	R0, [R4, #0]
;PathPlanning.c,221 :: 		currentDepthCount++;
ADDS	R4, R7, #1
UXTB	R4, R4
; currentDepthCount end address is: 28 (R7)
; currentDepthCount start address is: 16 (R4)
;PathPlanning.c,222 :: 		obstacleMap[rowGoal][colGoal-1] = 1;
MOV	R0, R3
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
ADDS	R1, R1, R0
MOVS	R0, #1
STRB	R0, [R1, #0]
; currentDepthCount end address is: 16 (R4)
UXTB	R7, R4
;PathPlanning.c,223 :: 		}
IT	AL
BAL	L_findPath58
L__findPath136:
;PathPlanning.c,218 :: 		if(obstacleMap[rowGoal][colGoal-1] == EMPTY)
;PathPlanning.c,223 :: 		}
L_findPath58:
;PathPlanning.c,224 :: 		}
; currentDepthCount start address is: 28 (R7)
; currentDepthCount end address is: 28 (R7)
IT	AL
BAL	L_findPath56
L__findPath137:
;PathPlanning.c,210 :: 		if(colGoal != 0)
;PathPlanning.c,224 :: 		}
L_findPath56:
;PathPlanning.c,226 :: 		if(colGoal != MAX_MAP_COLS-1)
; currentDepthCount start address is: 28 (R7)
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
CMP	R0, #15
IT	EQ
BEQ	L__findPath139
;PathPlanning.c,228 :: 		if(obstacleMap[rowGoal][colGoal+1] == QUADCOPTER)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L_findPath60
; nextDepthCount end address is: 20 (R5)
; iteration end address is: 24 (R6)
; currentDepthCount end address is: 28 (R7)
;PathPlanning.c,231 :: 		validPath = true;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,232 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,233 :: 		}
L_findPath60:
;PathPlanning.c,234 :: 		if(obstacleMap[rowGoal][colGoal+1] == EMPTY)
; currentDepthCount start address is: 28 (R7)
; iteration start address is: 24 (R6)
; nextDepthCount start address is: 20 (R5)
MOVW	R0, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R0, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colGoal+0)
MOVT	R0, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #253
IT	NE
BNE	L__findPath138
;PathPlanning.c,236 :: 		currentDepth[currentDepthCount] = (rowGoal)*MAX_MAP_COLS+colGoal+1;
ADD	R1, SP, #0
LSLS	R0, R7, #1
ADDS	R4, R1, R0
MOVW	R3, #lo_addr(PathPlanning_rowGoal+0)
MOVT	R3, #hi_addr(PathPlanning_rowGoal+0)
LDRB	R0, [R3, #0]
LSLS	R1, R0, #4
SXTH	R1, R1
MOVW	R2, #lo_addr(PathPlanning_colGoal+0)
MOVT	R2, #hi_addr(PathPlanning_colGoal+0)
LDRB	R0, [R2, #0]
ADDS	R0, R1, R0
SXTH	R0, R0
ADDS	R0, R0, #1
STRH	R0, [R4, #0]
;PathPlanning.c,237 :: 		currentDepthCount++;
ADDS	R0, R7, #1
; currentDepthCount end address is: 28 (R7)
; currentDepthCount start address is: 16 (R4)
UXTB	R4, R0
;PathPlanning.c,238 :: 		obstacleMap[rowGoal][colGoal+1] = 1;
MOV	R0, R3
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
ADDS	R1, R1, R0
MOVS	R0, #1
STRB	R0, [R1, #0]
; currentDepthCount end address is: 16 (R4)
UXTB	R0, R4
;PathPlanning.c,239 :: 		}
IT	AL
BAL	L_findPath61
L__findPath138:
;PathPlanning.c,234 :: 		if(obstacleMap[rowGoal][colGoal+1] == EMPTY)
UXTB	R0, R7
;PathPlanning.c,239 :: 		}
L_findPath61:
;PathPlanning.c,240 :: 		}
UXTB	R3, R0
IT	AL
BAL	L_findPath59
L__findPath139:
;PathPlanning.c,226 :: 		if(colGoal != MAX_MAP_COLS-1)
UXTB	R3, R7
;PathPlanning.c,240 :: 		}
L_findPath59:
;PathPlanning.c,242 :: 		while(currentDepthCount != 0)
; currentDepthCount start address is: 12 (R3)
UXTB	R7, R5
; nextDepthCount end address is: 20 (R5)
; iteration end address is: 24 (R6)
; currentDepthCount end address is: 12 (R3)
UXTB	R2, R6
L_findPath62:
; currentDepthCount start address is: 12 (R3)
; iteration start address is: 8 (R2)
; nextDepthCount start address is: 28 (R7)
CMP	R3, #0
IT	EQ
BEQ	L_findPath63
;PathPlanning.c,244 :: 		currentNode = 0;
; currentNode start address is: 16 (R4)
MOVS	R4, #0
; iteration end address is: 8 (R2)
; currentDepthCount end address is: 12 (R3)
; nextDepthCount end address is: 28 (R7)
; currentNode end address is: 16 (R4)
;PathPlanning.c,245 :: 		for(;currentNode < currentDepthCount; currentNode++)
L_findPath64:
; currentNode start address is: 16 (R4)
; nextDepthCount start address is: 28 (R7)
; iteration start address is: 8 (R2)
; currentDepthCount start address is: 12 (R3)
CMP	R4, R3
IT	CS
BCS	L_findPath65
;PathPlanning.c,248 :: 		colCheck = currentDepth[currentNode] % MAX_MAP_COLS;
ADD	R1, SP, #0
LSLS	R0, R4, #1
ADDS	R0, R1, R0
LDRH	R1, [R0, #0]
AND	R0, R1, #15
; colCheck start address is: 20 (R5)
UXTB	R5, R0
;PathPlanning.c,249 :: 		rowCheck = currentDepth[currentNode] / MAX_MAP_COLS;
LSRS	R0, R1, #4
; rowCheck start address is: 24 (R6)
UXTB	R6, R0
;PathPlanning.c,251 :: 		if(rowCheck != 0)
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__findPath141
;PathPlanning.c,253 :: 		if(obstacleMap[rowCheck-1][colCheck] == QUADCOPTER)
SUBS	R0, R6, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L_findPath68
; iteration end address is: 8 (R2)
; currentDepthCount end address is: 12 (R3)
; colCheck end address is: 20 (R5)
; rowCheck end address is: 24 (R6)
; nextDepthCount end address is: 28 (R7)
; currentNode end address is: 16 (R4)
;PathPlanning.c,256 :: 		validPath = true;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,257 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,258 :: 		}
L_findPath68:
;PathPlanning.c,259 :: 		if(obstacleMap[rowCheck-1][colCheck] == EMPTY)
; currentNode start address is: 16 (R4)
; nextDepthCount start address is: 28 (R7)
; rowCheck start address is: 24 (R6)
; colCheck start address is: 20 (R5)
; currentDepthCount start address is: 12 (R3)
; iteration start address is: 8 (R2)
SUBS	R0, R6, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
CMP	R0, #253
IT	NE
BNE	L__findPath140
;PathPlanning.c,261 :: 		nextDepth[nextDepthCount] = (rowCheck-1)*MAX_MAP_COLS+colCheck;
ADD	R1, SP, #64
LSLS	R0, R7, #1
ADDS	R1, R1, R0
SUBS	R0, R6, #1
SXTH	R0, R0
LSLS	R0, R0, #4
SXTH	R0, R0
ADDS	R0, R0, R5
STRH	R0, [R1, #0]
;PathPlanning.c,262 :: 		nextDepthCount++;
ADDS	R7, R7, #1
UXTB	R7, R7
;PathPlanning.c,263 :: 		obstacleMap[rowCheck-1][colCheck] = iteration;
SUBS	R0, R6, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R5
STRB	R2, [R0, #0]
; nextDepthCount end address is: 28 (R7)
;PathPlanning.c,264 :: 		}
IT	AL
BAL	L_findPath69
L__findPath140:
;PathPlanning.c,259 :: 		if(obstacleMap[rowCheck-1][colCheck] == EMPTY)
;PathPlanning.c,264 :: 		}
L_findPath69:
;PathPlanning.c,265 :: 		}
; nextDepthCount start address is: 28 (R7)
; nextDepthCount end address is: 28 (R7)
IT	AL
BAL	L_findPath67
L__findPath141:
;PathPlanning.c,251 :: 		if(rowCheck != 0)
;PathPlanning.c,265 :: 		}
L_findPath67:
;PathPlanning.c,267 :: 		if(rowCheck != MAX_MAP_ROWS-1)
; nextDepthCount start address is: 28 (R7)
CMP	R6, #15
IT	EQ
BEQ	L__findPath143
;PathPlanning.c,269 :: 		if(obstacleMap[rowCheck+1][colCheck] == QUADCOPTER)
ADDS	R0, R6, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L_findPath71
; iteration end address is: 8 (R2)
; currentDepthCount end address is: 12 (R3)
; colCheck end address is: 20 (R5)
; rowCheck end address is: 24 (R6)
; nextDepthCount end address is: 28 (R7)
; currentNode end address is: 16 (R4)
;PathPlanning.c,272 :: 		validPath = true;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,273 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,274 :: 		}
L_findPath71:
;PathPlanning.c,275 :: 		if(obstacleMap[rowCheck+1][colCheck] == EMPTY)
; currentNode start address is: 16 (R4)
; nextDepthCount start address is: 28 (R7)
; rowCheck start address is: 24 (R6)
; colCheck start address is: 20 (R5)
; currentDepthCount start address is: 12 (R3)
; iteration start address is: 8 (R2)
ADDS	R0, R6, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R5
LDRB	R0, [R0, #0]
CMP	R0, #253
IT	NE
BNE	L__findPath142
;PathPlanning.c,277 :: 		nextDepth[nextDepthCount] = (rowCheck+1)*MAX_MAP_COLS+colCheck;
ADD	R1, SP, #64
LSLS	R0, R7, #1
ADDS	R1, R1, R0
ADDS	R0, R6, #1
SXTH	R0, R0
LSLS	R0, R0, #4
SXTH	R0, R0
ADDS	R0, R0, R5
STRH	R0, [R1, #0]
;PathPlanning.c,278 :: 		nextDepthCount++;
ADDS	R7, R7, #1
UXTB	R7, R7
;PathPlanning.c,279 :: 		obstacleMap[rowCheck+1][colCheck] = iteration;
ADDS	R0, R6, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R5
STRB	R2, [R0, #0]
; nextDepthCount end address is: 28 (R7)
;PathPlanning.c,280 :: 		}
IT	AL
BAL	L_findPath72
L__findPath142:
;PathPlanning.c,275 :: 		if(obstacleMap[rowCheck+1][colCheck] == EMPTY)
;PathPlanning.c,280 :: 		}
L_findPath72:
;PathPlanning.c,281 :: 		}
; nextDepthCount start address is: 28 (R7)
; nextDepthCount end address is: 28 (R7)
IT	AL
BAL	L_findPath70
L__findPath143:
;PathPlanning.c,267 :: 		if(rowCheck != MAX_MAP_ROWS-1)
;PathPlanning.c,281 :: 		}
L_findPath70:
;PathPlanning.c,283 :: 		if(colCheck != 0)
; nextDepthCount start address is: 28 (R7)
CMP	R5, #0
IT	EQ
BEQ	L__findPath145
;PathPlanning.c,285 :: 		if(obstacleMap[rowCheck][colCheck-1] == QUADCOPTER)
LSLS	R1, R6, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
SUBS	R0, R5, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L_findPath74
; iteration end address is: 8 (R2)
; currentDepthCount end address is: 12 (R3)
; colCheck end address is: 20 (R5)
; rowCheck end address is: 24 (R6)
; nextDepthCount end address is: 28 (R7)
; currentNode end address is: 16 (R4)
;PathPlanning.c,288 :: 		validPath = true;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,289 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,290 :: 		}
L_findPath74:
;PathPlanning.c,291 :: 		if(obstacleMap[rowCheck][colCheck-1] == EMPTY)
; currentNode start address is: 16 (R4)
; nextDepthCount start address is: 28 (R7)
; rowCheck start address is: 24 (R6)
; colCheck start address is: 20 (R5)
; currentDepthCount start address is: 12 (R3)
; iteration start address is: 8 (R2)
LSLS	R1, R6, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
SUBS	R0, R5, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #253
IT	NE
BNE	L__findPath144
;PathPlanning.c,293 :: 		nextDepth[nextDepthCount] = (rowCheck)*MAX_MAP_COLS+colCheck-1;
ADD	R1, SP, #64
LSLS	R0, R7, #1
ADDS	R1, R1, R0
LSLS	R0, R6, #4
SXTH	R0, R0
ADDS	R0, R0, R5
SXTH	R0, R0
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;PathPlanning.c,294 :: 		nextDepthCount++;
ADDS	R7, R7, #1
UXTB	R7, R7
;PathPlanning.c,295 :: 		obstacleMap[rowCheck][colCheck-1] = iteration;
LSLS	R1, R6, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
SUBS	R0, R5, #1
SXTH	R0, R0
ADDS	R0, R1, R0
STRB	R2, [R0, #0]
; nextDepthCount end address is: 28 (R7)
;PathPlanning.c,296 :: 		}
IT	AL
BAL	L_findPath75
L__findPath144:
;PathPlanning.c,291 :: 		if(obstacleMap[rowCheck][colCheck-1] == EMPTY)
;PathPlanning.c,296 :: 		}
L_findPath75:
;PathPlanning.c,297 :: 		}
; nextDepthCount start address is: 28 (R7)
; nextDepthCount end address is: 28 (R7)
IT	AL
BAL	L_findPath73
L__findPath145:
;PathPlanning.c,283 :: 		if(colCheck != 0)
;PathPlanning.c,297 :: 		}
L_findPath73:
;PathPlanning.c,299 :: 		if(colCheck != MAX_MAP_COLS-1)
; nextDepthCount start address is: 28 (R7)
CMP	R5, #15
IT	EQ
BEQ	L__findPath147
;PathPlanning.c,301 :: 		if(obstacleMap[rowCheck][colCheck+1] == QUADCOPTER)
LSLS	R1, R6, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
ADDS	R0, R5, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	NE
BNE	L_findPath77
; iteration end address is: 8 (R2)
; currentDepthCount end address is: 12 (R3)
; colCheck end address is: 20 (R5)
; rowCheck end address is: 24 (R6)
; nextDepthCount end address is: 28 (R7)
; currentNode end address is: 16 (R4)
;PathPlanning.c,304 :: 		validPath = true;
MOVS	R1, #0
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
STRB	R1, [R0, #0]
;PathPlanning.c,305 :: 		return true;
MOVS	R0, #0
IT	AL
BAL	L_end_findPath
;PathPlanning.c,306 :: 		}
L_findPath77:
;PathPlanning.c,307 :: 		if(obstacleMap[rowCheck][colCheck+1] == EMPTY)
; currentNode start address is: 16 (R4)
; nextDepthCount start address is: 28 (R7)
; rowCheck start address is: 24 (R6)
; colCheck start address is: 20 (R5)
; currentDepthCount start address is: 12 (R3)
; iteration start address is: 8 (R2)
LSLS	R1, R6, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
ADDS	R0, R5, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #253
IT	NE
BNE	L__findPath146
;PathPlanning.c,309 :: 		nextDepth[nextDepthCount] = (rowCheck)*MAX_MAP_COLS+colCheck+1;
ADD	R1, SP, #64
LSLS	R0, R7, #1
ADDS	R1, R1, R0
LSLS	R0, R6, #4
SXTH	R0, R0
ADDS	R0, R0, R5
SXTH	R0, R0
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;PathPlanning.c,310 :: 		nextDepthCount++;
ADDS	R7, R7, #1
UXTB	R7, R7
;PathPlanning.c,311 :: 		obstacleMap[rowCheck][colCheck+1] = iteration;
LSLS	R1, R6, #4
; rowCheck end address is: 24 (R6)
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
ADDS	R0, R5, #1
SXTH	R0, R0
; colCheck end address is: 20 (R5)
ADDS	R0, R1, R0
STRB	R2, [R0, #0]
; nextDepthCount end address is: 28 (R7)
;PathPlanning.c,312 :: 		}
IT	AL
BAL	L_findPath78
L__findPath146:
;PathPlanning.c,307 :: 		if(obstacleMap[rowCheck][colCheck+1] == EMPTY)
;PathPlanning.c,312 :: 		}
L_findPath78:
;PathPlanning.c,313 :: 		}
; nextDepthCount start address is: 28 (R7)
; nextDepthCount end address is: 28 (R7)
IT	AL
BAL	L_findPath76
L__findPath147:
;PathPlanning.c,299 :: 		if(colCheck != MAX_MAP_COLS-1)
;PathPlanning.c,313 :: 		}
L_findPath76:
;PathPlanning.c,245 :: 		for(;currentNode < currentDepthCount; currentNode++)
; nextDepthCount start address is: 28 (R7)
ADDS	R4, R4, #1
UXTB	R4, R4
;PathPlanning.c,314 :: 		}
; currentDepthCount end address is: 12 (R3)
; currentNode end address is: 16 (R4)
IT	AL
BAL	L_findPath64
L_findPath65:
;PathPlanning.c,316 :: 		for(currentNode = 0; currentNode < nextDepthCount; currentNode++)
; currentNode start address is: 20 (R5)
MOVS	R5, #0
; iteration end address is: 8 (R2)
; nextDepthCount end address is: 28 (R7)
; currentNode end address is: 20 (R5)
UXTB	R4, R7
UXTB	R3, R2
L_findPath79:
; currentNode start address is: 20 (R5)
; iteration start address is: 12 (R3)
; nextDepthCount start address is: 16 (R4)
CMP	R5, R4
IT	CS
BCS	L_findPath80
;PathPlanning.c,318 :: 		currentDepth[currentNode] = nextDepth[currentNode];
ADD	R0, SP, #0
LSLS	R2, R5, #1
ADDS	R1, R0, R2
ADD	R0, SP, #64
ADDS	R0, R0, R2
LDRH	R0, [R0, #0]
STRH	R0, [R1, #0]
;PathPlanning.c,316 :: 		for(currentNode = 0; currentNode < nextDepthCount; currentNode++)
ADDS	R5, R5, #1
UXTB	R5, R5
;PathPlanning.c,319 :: 		}
; currentNode end address is: 20 (R5)
IT	AL
BAL	L_findPath79
L_findPath80:
;PathPlanning.c,320 :: 		currentDepthCount = nextDepthCount;
; currentDepthCount start address is: 4 (R1)
UXTB	R1, R4
; nextDepthCount end address is: 16 (R4)
;PathPlanning.c,321 :: 		nextDepthCount = 0;
; nextDepthCount start address is: 8 (R2)
MOVS	R2, #0
;PathPlanning.c,322 :: 		iteration++;
ADDS	R0, R3, #1
; iteration end address is: 12 (R3)
;PathPlanning.c,323 :: 		}
UXTB	R7, R2
; currentDepthCount end address is: 4 (R1)
; nextDepthCount end address is: 8 (R2)
UXTB	R2, R0
UXTB	R3, R1
IT	AL
BAL	L_findPath62
L_findPath63:
;PathPlanning.c,325 :: 		return false;
MOVS	R0, #1
;PathPlanning.c,326 :: 		}
L_end_findPath:
ADD	SP, SP, #128
BX	LR
; end of _findPath
_nextStep:
;PathPlanning.c,328 :: 		boolean nextStep(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;PathPlanning.c,330 :: 		uint8 lowestNumber = EMPTY;
; lowestNumber start address is: 32 (R8)
MOVW	R8, #253
;PathPlanning.c,331 :: 		direction dir = 255;
; dir start address is: 36 (R9)
MOVW	R9, #255
;PathPlanning.c,333 :: 		if(!validPath)
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_nextStep82
;PathPlanning.c,335 :: 		findPath();
BL	_findPath+0
;PathPlanning.c,336 :: 		if(!validPath)
MOVW	R0, #lo_addr(PathPlanning_validPath+0)
MOVT	R0, #hi_addr(PathPlanning_validPath+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_nextStep83
; lowestNumber end address is: 32 (R8)
; dir end address is: 36 (R9)
;PathPlanning.c,339 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_nextStep
;PathPlanning.c,340 :: 		}
L_nextStep83:
;PathPlanning.c,341 :: 		}
; dir start address is: 36 (R9)
; lowestNumber start address is: 32 (R8)
L_nextStep82:
;PathPlanning.c,345 :: 		if(rowQuad != 0)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__nextStep149
;PathPlanning.c,347 :: 		if(obstacleMap[rowQuad-1][colQuad] < lowestNumber)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, R8
IT	CS
BCS	L__nextStep148
; lowestNumber end address is: 32 (R8)
; dir end address is: 36 (R9)
;PathPlanning.c,349 :: 		lowestNumber = obstacleMap[rowQuad-1][colQuad];
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R2, [R0, #0]
; lowestNumber start address is: 8 (R2)
;PathPlanning.c,350 :: 		dir = NORTH;
MOVS	R0, #0
; lowestNumber end address is: 8 (R2)
UXTB	R3, R0
;PathPlanning.c,351 :: 		}
IT	AL
BAL	L_nextStep85
L__nextStep148:
;PathPlanning.c,347 :: 		if(obstacleMap[rowQuad-1][colQuad] < lowestNumber)
UXTB	R3, R9
UXTB	R2, R8
;PathPlanning.c,351 :: 		}
L_nextStep85:
;PathPlanning.c,352 :: 		}
; dir start address is: 12 (R3)
; lowestNumber start address is: 8 (R2)
; lowestNumber end address is: 8 (R2)
; dir end address is: 12 (R3)
IT	AL
BAL	L_nextStep84
L__nextStep149:
;PathPlanning.c,345 :: 		if(rowQuad != 0)
UXTB	R2, R8
UXTB	R3, R9
;PathPlanning.c,352 :: 		}
L_nextStep84:
;PathPlanning.c,354 :: 		if(rowQuad != MAX_MAP_ROWS-1)
; lowestNumber start address is: 8 (R2)
; dir start address is: 12 (R3)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
CMP	R0, #15
IT	EQ
BEQ	L__nextStep151
;PathPlanning.c,356 :: 		if(obstacleMap[rowQuad+1][colQuad] < lowestNumber)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, R2
IT	CS
BCS	L__nextStep150
; lowestNumber end address is: 8 (R2)
; dir end address is: 12 (R3)
;PathPlanning.c,358 :: 		lowestNumber = obstacleMap[rowQuad+1][colQuad];
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
LDRB	R2, [R0, #0]
; lowestNumber start address is: 8 (R2)
;PathPlanning.c,359 :: 		dir = SOUTH;
MOVS	R0, #1
; lowestNumber end address is: 8 (R2)
UXTB	R3, R0
;PathPlanning.c,360 :: 		}
IT	AL
BAL	L_nextStep87
L__nextStep150:
;PathPlanning.c,356 :: 		if(obstacleMap[rowQuad+1][colQuad] < lowestNumber)
;PathPlanning.c,360 :: 		}
L_nextStep87:
;PathPlanning.c,361 :: 		}
; dir start address is: 12 (R3)
; lowestNumber start address is: 8 (R2)
; lowestNumber end address is: 8 (R2)
; dir end address is: 12 (R3)
IT	AL
BAL	L_nextStep86
L__nextStep151:
;PathPlanning.c,354 :: 		if(rowQuad != MAX_MAP_ROWS-1)
;PathPlanning.c,361 :: 		}
L_nextStep86:
;PathPlanning.c,363 :: 		if(colQuad != 0)
; lowestNumber start address is: 8 (R2)
; dir start address is: 12 (R3)
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__nextStep153
;PathPlanning.c,365 :: 		if(obstacleMap[rowQuad][colQuad-1] < lowestNumber)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, R2
IT	CS
BCS	L__nextStep152
; lowestNumber end address is: 8 (R2)
; dir end address is: 12 (R3)
;PathPlanning.c,367 :: 		lowestNumber = obstacleMap[rowQuad][colQuad-1];
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R2, [R0, #0]
; lowestNumber start address is: 8 (R2)
;PathPlanning.c,368 :: 		dir = EAST;
MOVS	R0, #2
; lowestNumber end address is: 8 (R2)
UXTB	R3, R0
;PathPlanning.c,369 :: 		}
IT	AL
BAL	L_nextStep89
L__nextStep152:
;PathPlanning.c,365 :: 		if(obstacleMap[rowQuad][colQuad-1] < lowestNumber)
;PathPlanning.c,369 :: 		}
L_nextStep89:
;PathPlanning.c,370 :: 		}
; dir start address is: 12 (R3)
; lowestNumber start address is: 8 (R2)
; lowestNumber end address is: 8 (R2)
; dir end address is: 12 (R3)
IT	AL
BAL	L_nextStep88
L__nextStep153:
;PathPlanning.c,363 :: 		if(colQuad != 0)
;PathPlanning.c,370 :: 		}
L_nextStep88:
;PathPlanning.c,372 :: 		if(colQuad != MAX_MAP_COLS-1)
; lowestNumber start address is: 8 (R2)
; dir start address is: 12 (R3)
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
CMP	R0, #15
IT	EQ
BEQ	L__nextStep155
;PathPlanning.c,374 :: 		if(obstacleMap[rowQuad][colQuad+1] < lowestNumber)
MOVW	R0, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R0, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(PathPlanning_colQuad+0)
MOVT	R0, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, R2
IT	CS
BCS	L__nextStep154
; lowestNumber end address is: 8 (R2)
; dir end address is: 12 (R3)
;PathPlanning.c,377 :: 		dir = WEST;
MOVS	R0, #3
;PathPlanning.c,378 :: 		}
IT	AL
BAL	L_nextStep91
L__nextStep154:
;PathPlanning.c,374 :: 		if(obstacleMap[rowQuad][colQuad+1] < lowestNumber)
UXTB	R0, R3
;PathPlanning.c,378 :: 		}
L_nextStep91:
;PathPlanning.c,379 :: 		}
IT	AL
BAL	L_nextStep90
L__nextStep155:
;PathPlanning.c,372 :: 		if(colQuad != MAX_MAP_COLS-1)
UXTB	R0, R3
;PathPlanning.c,379 :: 		}
L_nextStep90:
;PathPlanning.c,382 :: 		switch(dir)
IT	AL
BAL	L_nextStep92
;PathPlanning.c,384 :: 		case NORTH:
L_nextStep94:
;PathPlanning.c,385 :: 		moveQuad(NORTH, SQUARE_SIDE_LENGTH);
MOVS	R1, #100
MOVS	R0, #0
BL	_moveQuad+0
;PathPlanning.c,386 :: 		obstacleMap[rowQuad][colQuad] = EMPTY;
MOVW	R3, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R3, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R3, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R2, #lo_addr(PathPlanning_colQuad+0)
MOVT	R2, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R2, #0]
ADDS	R1, R1, R0
MOVS	R0, #253
STRB	R0, [R1, #0]
;PathPlanning.c,387 :: 		rowQuad--;
MOV	R0, R3
LDRB	R0, [R0, #0]
SUBS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R3, #0]
;PathPlanning.c,388 :: 		obstacleMap[rowQuad][colQuad] = QUADCOPTER;
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
MOVS	R0, #255
STRB	R0, [R1, #0]
;PathPlanning.c,389 :: 		break;
IT	AL
BAL	L_nextStep93
;PathPlanning.c,390 :: 		case SOUTH:
L_nextStep95:
;PathPlanning.c,391 :: 		moveQuad(SOUTH, SQUARE_SIDE_LENGTH);
MOVS	R1, #100
MOVS	R0, #1
BL	_moveQuad+0
;PathPlanning.c,392 :: 		obstacleMap[rowQuad][colQuad] = EMPTY;
MOVW	R3, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R3, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R3, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R2, #lo_addr(PathPlanning_colQuad+0)
MOVT	R2, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R2, #0]
ADDS	R1, R1, R0
MOVS	R0, #253
STRB	R0, [R1, #0]
;PathPlanning.c,393 :: 		rowQuad++;
MOV	R0, R3
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R3, #0]
;PathPlanning.c,394 :: 		obstacleMap[rowQuad][colQuad] = QUADCOPTER;
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
MOVS	R0, #255
STRB	R0, [R1, #0]
;PathPlanning.c,395 :: 		break;
IT	AL
BAL	L_nextStep93
;PathPlanning.c,396 :: 		case EAST:
L_nextStep96:
;PathPlanning.c,397 :: 		moveQuad(EAST, SQUARE_SIDE_LENGTH);
MOVS	R1, #100
MOVS	R0, #2
BL	_moveQuad+0
;PathPlanning.c,398 :: 		obstacleMap[rowQuad][colQuad] = EMPTY;
MOVW	R4, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R4, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R4, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R3, #lo_addr(PathPlanning_colQuad+0)
MOVT	R3, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R3, #0]
ADDS	R1, R1, R0
MOVS	R0, #253
STRB	R0, [R1, #0]
;PathPlanning.c,399 :: 		colQuad--;
MOV	R0, R3
LDRB	R0, [R0, #0]
SUBS	R2, R0, #1
UXTB	R2, R2
STRB	R2, [R3, #0]
;PathPlanning.c,400 :: 		obstacleMap[rowQuad][colQuad] = QUADCOPTER;
MOV	R0, R4
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R1, R0, R2
MOVS	R0, #255
STRB	R0, [R1, #0]
;PathPlanning.c,401 :: 		break;
IT	AL
BAL	L_nextStep93
;PathPlanning.c,402 :: 		case WEST:
L_nextStep97:
;PathPlanning.c,403 :: 		moveQuad(WEST, SQUARE_SIDE_LENGTH);
MOVS	R1, #100
MOVS	R0, #3
BL	_moveQuad+0
;PathPlanning.c,404 :: 		obstacleMap[rowQuad][colQuad] = EMPTY;
MOVW	R4, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R4, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R0, [R4, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
MOVW	R3, #lo_addr(PathPlanning_colQuad+0)
MOVT	R3, #hi_addr(PathPlanning_colQuad+0)
LDRB	R0, [R3, #0]
ADDS	R1, R1, R0
MOVS	R0, #253
STRB	R0, [R1, #0]
;PathPlanning.c,405 :: 		colQuad++;
MOV	R0, R3
LDRB	R0, [R0, #0]
ADDS	R2, R0, #1
UXTB	R2, R2
STRB	R2, [R3, #0]
;PathPlanning.c,406 :: 		obstacleMap[rowQuad][colQuad] = QUADCOPTER;
MOV	R0, R4
LDRB	R0, [R0, #0]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R0, R0, R1
ADDS	R1, R0, R2
MOVS	R0, #255
STRB	R0, [R1, #0]
;PathPlanning.c,407 :: 		break;
IT	AL
BAL	L_nextStep93
;PathPlanning.c,408 :: 		default:
L_nextStep98:
;PathPlanning.c,410 :: 		removePathPlan();
BL	_removePathPlan+0
;PathPlanning.c,411 :: 		return false;
MOVS	R0, #1
IT	AL
BAL	L_end_nextStep
;PathPlanning.c,412 :: 		}
L_nextStep92:
CMP	R0, #0
IT	EQ
BEQ	L_nextStep94
CMP	R0, #1
IT	EQ
BEQ	L_nextStep95
CMP	R0, #2
IT	EQ
BEQ	L_nextStep96
CMP	R0, #3
IT	EQ
BEQ	L_nextStep97
IT	AL
BAL	L_nextStep98
L_nextStep93:
;PathPlanning.c,413 :: 		return true;
MOVS	R0, #0
;PathPlanning.c,415 :: 		}
L_end_nextStep:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _nextStep
_getMode:
;PathPlanning.c,418 :: 		mode getMode(void)
;PathPlanning.c,420 :: 		return currentMode;
MOVW	R0, #lo_addr(PathPlanning_currentMode+0)
MOVT	R0, #hi_addr(PathPlanning_currentMode+0)
LDRB	R0, [R0, #0]
;PathPlanning.c,421 :: 		}
L_end_getMode:
BX	LR
; end of _getMode
_getQuadPostion:
;PathPlanning.c,424 :: 		void getQuadPostion(uint8 * rowHolder, uint8 * colHolder)
; colHolder start address is: 4 (R1)
; colHolder end address is: 4 (R1)
; colHolder start address is: 4 (R1)
;PathPlanning.c,426 :: 		*rowHolder = rowQuad;
MOVW	R2, #lo_addr(PathPlanning_rowQuad+0)
MOVT	R2, #hi_addr(PathPlanning_rowQuad+0)
LDRB	R2, [R2, #0]
STRB	R2, [R0, #0]
;PathPlanning.c,427 :: 		*colHolder = colQuad;
MOVW	R2, #lo_addr(PathPlanning_colQuad+0)
MOVT	R2, #hi_addr(PathPlanning_colQuad+0)
LDRB	R2, [R2, #0]
STRB	R2, [R1, #0]
; colHolder end address is: 4 (R1)
;PathPlanning.c,428 :: 		}
L_end_getQuadPostion:
BX	LR
; end of _getQuadPostion
_printMap:
;PathPlanning.c,431 :: 		void printMap(void)
SUB	SP, SP, #16
STR	LR, [SP, #0]
;PathPlanning.c,434 :: 		for(row = 0; row < MAX_MAP_ROWS; row++)
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #4]
L_printMap99:
LDRSH	R0, [SP, #4]
CMP	R0, #16
IT	GE
BGE	L_printMap100
;PathPlanning.c,436 :: 		for(col = 0; col < MAX_MAP_COLS*2; col++)
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #6]
L_printMap102:
LDRSH	R0, [SP, #6]
CMP	R0, #32
IT	GE
BGE	L_printMap103
;PathPlanning.c,438 :: 		UARTSendChar('_');
MOVS	R0, #95
BL	_UARTSendChar+0
;PathPlanning.c,436 :: 		for(col = 0; col < MAX_MAP_COLS*2; col++)
LDRSH	R0, [SP, #6]
ADDS	R0, R0, #1
STRH	R0, [SP, #6]
;PathPlanning.c,439 :: 		}
IT	AL
BAL	L_printMap102
L_printMap103:
;PathPlanning.c,440 :: 		UARTSendChar('\n');
MOVS	R0, #10
BL	_UARTSendChar+0
;PathPlanning.c,441 :: 		UARTSendChar('|');
MOVS	R0, #124
BL	_UARTSendChar+0
;PathPlanning.c,442 :: 		for(col = 0; col < MAX_MAP_COLS; col++)
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #6]
L_printMap105:
LDRSH	R0, [SP, #6]
CMP	R0, #16
IT	GE
BGE	L_printMap106
;PathPlanning.c,444 :: 		switch(obstacleMap[row][col])
LDRSH	R0, [SP, #4]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
LDRSH	R0, [SP, #6]
ADDS	R0, R1, R0
STR	R0, [SP, #12]
IT	AL
BAL	L_printMap108
;PathPlanning.c,446 :: 		case QUADCOPTER:
L_printMap110:
;PathPlanning.c,447 :: 		UARTSendChar('A');
MOVS	R0, #65
BL	_UARTSendChar+0
;PathPlanning.c,448 :: 		UARTSendChar('|');
MOVS	R0, #124
BL	_UARTSendChar+0
;PathPlanning.c,449 :: 		break;
IT	AL
BAL	L_printMap109
;PathPlanning.c,450 :: 		case OBSTACLE:
L_printMap111:
;PathPlanning.c,451 :: 		UARTSendChar('X');
MOVS	R0, #88
BL	_UARTSendChar+0
;PathPlanning.c,452 :: 		UARTSendChar('|');
MOVS	R0, #124
BL	_UARTSendChar+0
;PathPlanning.c,453 :: 		break;
IT	AL
BAL	L_printMap109
;PathPlanning.c,454 :: 		case GOAL:
L_printMap112:
;PathPlanning.c,455 :: 		UARTSendChar('G');
MOVS	R0, #71
BL	_UARTSendChar+0
;PathPlanning.c,456 :: 		UARTSendChar('|');
MOVS	R0, #124
BL	_UARTSendChar+0
;PathPlanning.c,457 :: 		break;
IT	AL
BAL	L_printMap109
;PathPlanning.c,458 :: 		case EMPTY:
L_printMap113:
;PathPlanning.c,459 :: 		UARTSendChar(' ');
MOVS	R0, #32
BL	_UARTSendChar+0
;PathPlanning.c,460 :: 		UARTSendChar(' ');
MOVS	R0, #32
BL	_UARTSendChar+0
;PathPlanning.c,461 :: 		UARTSendChar('|');
MOVS	R0, #124
BL	_UARTSendChar+0
;PathPlanning.c,462 :: 		break;
IT	AL
BAL	L_printMap109
;PathPlanning.c,463 :: 		default:
L_printMap114:
;PathPlanning.c,464 :: 		if(obstacleMap[row][col] < 10)
LDRSH	R0, [SP, #4]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
LDRSH	R0, [SP, #6]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	CS
BCS	L_printMap115
;PathPlanning.c,466 :: 		UARTSendChar(obstacleMap[row][col]+48);
LDRSH	R0, [SP, #4]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
LDRSH	R0, [SP, #6]
ADDS	R0, R1, R0
LDRB	R0, [R0, #0]
ADDS	R0, #48
UXTB	R0, R0
BL	_UARTSendChar+0
;PathPlanning.c,467 :: 		}
IT	AL
BAL	L_printMap116
L_printMap115:
;PathPlanning.c,470 :: 		UARTSendChar((obstacleMap[row][col]/10)+48);
LDRSH	R0, [SP, #4]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
LDRSH	R0, [SP, #6]
ADDS	R0, R1, R0
LDRB	R1, [R0, #0]
MOVS	R0, #10
UDIV	R0, R1, R0
UXTB	R0, R0
ADDS	R0, #48
UXTB	R0, R0
BL	_UARTSendChar+0
;PathPlanning.c,471 :: 		UARTSendChar((obstacleMap[row][col]%10)+48);
LDRSH	R0, [SP, #4]
LSLS	R1, R0, #4
MOVW	R0, #lo_addr(PathPlanning_obstacleMap+0)
MOVT	R0, #hi_addr(PathPlanning_obstacleMap+0)
ADDS	R1, R0, R1
LDRSH	R0, [SP, #6]
ADDS	R0, R1, R0
LDRB	R2, [R0, #0]
MOVS	R1, #10
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
UXTB	R0, R0
ADDS	R0, #48
UXTB	R0, R0
BL	_UARTSendChar+0
;PathPlanning.c,472 :: 		}
L_printMap116:
;PathPlanning.c,473 :: 		UARTSendChar('|');
MOVS	R0, #124
BL	_UARTSendChar+0
;PathPlanning.c,474 :: 		break;
IT	AL
BAL	L_printMap109
;PathPlanning.c,475 :: 		}
L_printMap108:
LDR	R1, [SP, #12]
LDRB	R0, [R1, #0]
CMP	R0, #255
IT	EQ
BEQ	L_printMap110
LDRB	R0, [R1, #0]
CMP	R0, #254
IT	EQ
BEQ	L_printMap111
LDRB	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_printMap112
LDRB	R0, [R1, #0]
CMP	R0, #253
IT	EQ
BEQ	L_printMap113
IT	AL
BAL	L_printMap114
L_printMap109:
;PathPlanning.c,442 :: 		for(col = 0; col < MAX_MAP_COLS; col++)
LDRSH	R0, [SP, #6]
ADDS	R0, R0, #1
STRH	R0, [SP, #6]
;PathPlanning.c,476 :: 		}
IT	AL
BAL	L_printMap105
L_printMap106:
;PathPlanning.c,477 :: 		UARTSendChar('\n');
MOVS	R0, #10
BL	_UARTSendChar+0
;PathPlanning.c,434 :: 		for(row = 0; row < MAX_MAP_ROWS; row++)
LDRSH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;PathPlanning.c,478 :: 		}
IT	AL
BAL	L_printMap99
L_printMap100:
;PathPlanning.c,479 :: 		for(col = 0; col < MAX_MAP_COLS*2; col++)
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #6]
L_printMap117:
LDRSH	R0, [SP, #6]
CMP	R0, #32
IT	GE
BGE	L_printMap118
;PathPlanning.c,481 :: 		UARTSendChar('_');
MOVS	R0, #95
BL	_UARTSendChar+0
;PathPlanning.c,479 :: 		for(col = 0; col < MAX_MAP_COLS*2; col++)
LDRSH	R0, [SP, #6]
ADDS	R0, R0, #1
STRH	R0, [SP, #6]
;PathPlanning.c,482 :: 		}
IT	AL
BAL	L_printMap117
L_printMap118:
;PathPlanning.c,483 :: 		UARTSendChar('\n');
MOVS	R0, #10
BL	_UARTSendChar+0
;PathPlanning.c,484 :: 		}
L_end_printMap:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _printMap
