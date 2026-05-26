
_main:

;cti.c,17 :: 		void main() {
;cti.c,18 :: 		int sayac=0;
	CLRF       main_sayac_L0+0
	CLRF       main_sayac_L0+1
;cti.c,19 :: 		Lcd_Init();//LCD'nin baslamasi icin
	CALL       _Lcd_Init+0
;cti.c,20 :: 		Lcd_Out(1,1,"HOSGELDIN");//LCD'ye cikti vermek icin
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_cti+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;cti.c,21 :: 		Delay_ms(1000);//1 sn'ye bekler.
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;cti.c,22 :: 		Lcd_Cmd(_LCD_CLEAR);//LCD ekranýný temizler
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;cti.c,23 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);//isaretciyi kapatir
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;cti.c,24 :: 		while(1){
L_main1:
;cti.c,25 :: 		sayac++;
	INCF       main_sayac_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_sayac_L0+1, 1
;cti.c,26 :: 		IntToStr(sayac, txt);//Integeri String'e cevirir
	MOVF       main_sayac_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_sayac_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;cti.c,27 :: 		Lcd_Out(1,1,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;cti.c,28 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;cti.c,29 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);//Saga kaydýrýr
	MOVLW      28
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;cti.c,30 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;cti.c,31 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);//sola kaydýrýr
	MOVLW      24
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;cti.c,32 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;cti.c,33 :: 		}
	GOTO       L_main1
;cti.c,34 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
