;四個按鈕分別為	+  -  確認 RESET
;前四個燈為mode1~4
;=======================================

		ORG	0000H ;主程式從0000開始

		MOV	P1,#11111110B		
		MOV	R0,#00000001B

;===============設定時間========================

MODE1:	MOV	P0,#10000000B 	;模式顯示:正在設定分鐘的十位數
		MOV	R1,#00000000B	  ;初始化為0，以下使用者開始設定數字

SET1:		MOV	A,#10000000B  ;變數A每次都更新為1000 0000
		ADD	A,R1		;將燈號A與R1(使用者設定的數字)相加，並取代A原本所存的變數
		MOV	P0,A		;將A輸出到燈(P0)上，此時有著mode1的燈號以及使用者所設定的變數(二進位顯示)

		ACALL	DELAY2

		JNB	P2.0,KEY00	;若按下最左邊的按鈕R1加一
		JNB	P2.1,KEY01	;若按下左邊數過來第二的按鈕R1減一
		JNB	P2.2,MODE2	;若按下第三個鍵跳到mode2
		JNB	P2.3,MODE1
		AJMP	SET1		;如果沒按下，則跳回set1並繼續等待使用者操作

MODE2:	MOV	P0,#01000000B ;模式顯示:正在設定分鐘的個位數
		MOV	R2,#00000000B

SET2:		MOV	A,#01000000B
		ADD	A,R2
		MOV	P0,A	

		ACALL	DELAY2

		JNB	P2.0,KEY02
		JNB	P2.1,KEY03
		JNB	P2.2,MODE3
		JNB	P2.3,MODE1

		AJMP	SET2

MODE3:	MOV	P0,#00100000B ;模式顯示:正在設定秒的十位數
		MOV	R3,#00000000B

SET3:		MOV	A,#00100000B
		ADD	A,R3
		MOV	P0,A	

		ACALL	DELAY2

		JNB	P2.0,KEY04
		JNB	P2.1,KEY05
		JNB	P2.2,MODE4
		JNB	P2.3,MODE1

		AJMP	SET3

MODE4:	MOV	P0,#00010000B ;模式顯示:正在設定秒的個位數
		MOV	R4,#00000000B

		

SET4:		MOV	A,#00010000B
		ADD	A,R4
		MOV	P0,A	

		ACALL	DELAY2

		JNB	P2.0,KEY06
		JNB	P2.1,KEY07
		JNB	P2.2,START ;按下確認鍵開始倒數計時
		JNB	P2.3,MODE01

		AJMP	SET4

;============間歇跳================

MODE01:	AJMP	MODE1

KEY00:	AJMP 	KEY0
KEY01:	AJMP 	KEY1
KEY02:	AJMP 	KEY2
KEY03:	AJMP 	KEY3
KEY04:	AJMP 	KEY4
KEY05:	AJMP 	KEY5
KEY06:	AJMP 	KEY6
KEY07:	AJMP 	KEY7

;=============開始倒數=====================================
;----------判斷輸入是否為0-----------
START:	MOV	P0,#11110000B	;前四個燈閃爍代表在倒數
	
		INC	R4		
		DJNZ	R4,SEC2
START01:	INC	R3
		DJNZ	R3,SEC1
START02:	INC	R2
		DJNZ	R2,MIN2
START03:	INC	R1
		DJNZ	R1,MIN1
		
		AJMP	TOUT	
	
;------------------秒個位數----------------
		
SEC2:		ACALL	DELAY1	;一秒鐘
		DJNZ	R4,SEC2 	;倒數DELAY一次為一秒，共倒數R4個一秒

		AJMP	START01

;------------------秒十位數-----------------

SEC1:		MOV	R5,#10	;倒數R3個10秒
DL1:		ACALL	DELAY1	;一秒鐘
		DJNZ	R5,DL1	
		DJNZ	R3,SEC1

		AJMP	START02
	
;------------------分個位數----------------

MIN2:		MOV	R5,#60	;倒數R2個60秒  ;一分鐘60秒
DL2:		ACALL	DELAY1 	;一秒鐘
		DJNZ	R5,DL2
	
		AJMP	START03

;-----------------分十位數------------------

MIN1:		MOV	R5,#60	;倒數R1個600秒  ;十分鐘600秒	;因為怕600會溢位，所以拆成60*10
DL3:		MOV	R6,#10	;十分鐘600秒
DL4:		ACALL	DELAY1 	;一秒鐘
		DJNZ	R6,DL4			
		DJNZ	R5,DL3	
		DJNZ	R1,MIN1

;=============時間到===================

TOUT:		MOV	P0,#00000000B ;時間到 閃爍燈
		ACALL	DELAY1
		MOV	P0,#11111111B
		ACALL	DELAY1
		JNB	P2.2,MODE01   ;按下確認鍵 回到mode1重新設定時間
		AJMP	TOUT          ;或者是隨時觸發中斷也能回到mode1	

;==========按鈕動作================
KEY0:		INC	R1	;R1+1
		AJMP	SET1
KEY1:		DEC	R1	;R1-1
		AJMP	SET1
KEY2:		INC	R2
		AJMP	SET2
KEY3:		DEC	R2
		AJMP	SET2
KEY4:		INC	R3
		AJMP	SET3
KEY5:		DEC	R3
		AJMP	SET3
KEY6:		INC	R4
		AJMP	SET4
KEY7:		DEC	R4
		AJMP	SET4

;============DELAY============
;----------1------------
DELAY1:	PUSH	05
		PUSH	06
		PUSH	07

		MOV	R5,#1	;10*0.1秒=1秒
D1:		MOV	R6,#250	
D2:		MOV	R7,#200
D3:		DJNZ	R7,D3
		DJNZ	R6,D2
		DJNZ	R5,D1

		POP	07
		POP	06
		POP	05
		
		RET

;----------2-----------
DELAY2:	PUSH	05
		PUSH	06
		PUSH	07

		MOV	R5,#1	;10*0.1秒=1秒
D4:		MOV	R6,#250
D5:		MOV	R7,#250
D6:		DJNZ	R7,D6
		DJNZ	R6,D5
		DJNZ	R5,D4

		POP	07
		POP	06
		POP	05

		RET