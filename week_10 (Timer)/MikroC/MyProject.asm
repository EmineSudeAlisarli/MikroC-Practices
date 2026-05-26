
_InitTimer0:

;MyProject.c,3 :: 		void InitTimer0(){
;MyProject.c,4 :: 		OPTION_REG.T0CS = 0;//Harici Clock
	BCF        OPTION_REG+0, 5
;MyProject.c,5 :: 		OPTION_REG.PSA = 0;//Prescaler Timer'a hizmet edicek
	BCF        OPTION_REG+0, 3
;MyProject.c,8 :: 		OPTION_REG.PS2 = 1;
	BSF        OPTION_REG+0, 2
;MyProject.c,9 :: 		OPTION_REG.PS1 = 0;
	BCF        OPTION_REG+0, 1
;MyProject.c,10 :: 		OPTION_REG.PS0 = 1;
	BSF        OPTION_REG+0, 0
;MyProject.c,12 :: 		TMR0 = 99;//10ms
	MOVLW      99
	MOVWF      TMR0+0
;MyProject.c,14 :: 		INTCON.TMR0IE = 1;//Kesme bayragini kulllanmak icin
	BSF        INTCON+0, 5
;MyProject.c,15 :: 		INTCON.PEIE = 1; //1 olmasi gerek
	BSF        INTCON+0, 6
;MyProject.c,16 :: 		INTCON.GIE = 1;//1 olmasi gerek
	BSF        INTCON+0, 7
;MyProject.c,17 :: 		}
L_end_InitTimer0:
	RETURN
; end of _InitTimer0

_Interrupt:

;MyProject.c,19 :: 		void Interrupt(){
;MyProject.c,20 :: 		if(INTCON.TMR0IF == 1){
	BTFSS      INTCON+0, 2
	GOTO       L_Interrupt0
;MyProject.c,21 :: 		INTCON.TMR0IF = 0;
	BCF        INTCON+0, 2
;MyProject.c,22 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;MyProject.c,24 :: 		counter1++;
	INCF       _counter1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter1+1, 1
;MyProject.c,25 :: 		counter2++;
	INCF       _counter2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter2+1, 1
;MyProject.c,27 :: 		if(counter1 == 100){
	MOVLW      0
	XORWF      _counter1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt9
	MOVLW      100
	XORWF      _counter1+0, 0
L__Interrupt9:
	BTFSS      STATUS+0, 2
	GOTO       L_Interrupt1
;MyProject.c,28 :: 		counter1 = 0;
	CLRF       _counter1+0
	CLRF       _counter1+1
;MyProject.c,29 :: 		PORTB.f0 = ~PORTB.f0;
	MOVLW      1
	XORWF      PORTB+0, 1
;MyProject.c,30 :: 		}
L_Interrupt1:
;MyProject.c,32 :: 		if(counter2 == 300){
	MOVF       _counter2+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt10
	MOVLW      44
	XORWF      _counter2+0, 0
L__Interrupt10:
	BTFSS      STATUS+0, 2
	GOTO       L_Interrupt2
;MyProject.c,33 :: 		counter2 = 0;
	CLRF       _counter2+0
	CLRF       _counter2+1
;MyProject.c,34 :: 		PORTB.f1 = ~PORTB.f1;
	MOVLW      2
	XORWF      PORTB+0, 1
;MyProject.c,35 :: 		}
L_Interrupt2:
;MyProject.c,36 :: 		}
L_Interrupt0:
;MyProject.c,37 :: 		}
L_end_Interrupt:
	RETURN
; end of _Interrupt

_main:

;MyProject.c,39 :: 		void main() {
;MyProject.c,40 :: 		int i=0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;MyProject.c,41 :: 		InitTimer0();
	CALL       _InitTimer0+0
;MyProject.c,42 :: 		TRISB = 0;
	CLRF       TRISB+0
;MyProject.c,43 :: 		PORTB = 0;
	CLRF       PORTB+0
;MyProject.c,45 :: 		TRISD = 0;
	CLRF       TRISD+0
;MyProject.c,46 :: 		PORTD = 0;
	CLRF       PORTD+0
;MyProject.c,48 :: 		for(i=0;i<255;i++){
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main3:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVLW      255
	SUBWF      main_i_L0+0, 0
L__main12:
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;MyProject.c,49 :: 		PORTD = i;
	MOVF       main_i_L0+0, 0
	MOVWF      PORTD+0
;MyProject.c,50 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
	NOP
;MyProject.c,48 :: 		for(i=0;i<255;i++){
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;MyProject.c,51 :: 		}
	GOTO       L_main3
L_main4:
;MyProject.c,52 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
