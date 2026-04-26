
_main:

;MyProject.c,20 :: 		void main() {
;MyProject.c,22 :: 		ADC_Init();              // ADC modulunu baslat
	CALL       _ADC_Init+0
;MyProject.c,23 :: 		ADCON1 = 0x00001110;     // AN0 analog, digerleri dijital
	MOVLW      16
	MOVWF      ADCON1+0
;MyProject.c,24 :: 		TRISA.F0 = 1;            // AN0 giris
	BSF        TRISA+0, 0
;MyProject.c,27 :: 		Lcd_Init();              // LCD'yi baslat
	CALL       _Lcd_Init+0
;MyProject.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);     // Ekrani temizle
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,29 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);// Ýmleci kapat
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,31 :: 		TRISC.F2 = 0;            // RC2 (CCP1) çýkýþ (PWM için)
	BCF        TRISC+0, 2
;MyProject.c,34 :: 		PR2 = 124;               // Period Register 2, period register = 124, bize 500Hz Frequency vermesi için
	MOVLW      124
	MOVWF      PR2+0
;MyProject.c,35 :: 		T2CKPS1_bit = 1;         // Prescaler 1:16
	BSF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;MyProject.c,36 :: 		T2CKPS0_bit = 1;         // Timer2' nin Prescaler ayarlarýný yapmak için
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;MyProject.c,47 :: 		PWM1_Init(500);          // PWM1 modülünü 500Hz'e ayarla
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;MyProject.c,48 :: 		PWM1_Start();            // PWM'i baþlat
	CALL       _PWM1_Start+0
;MyProject.c,50 :: 		while(1) {
L_main0:
;MyProject.c,52 :: 		adc_degeri = ADC_Read(0);        // AN0'dan oku (0-1023)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_degeri+0
	MOVF       R0+1, 0
	MOVWF      _adc_degeri+1
;MyProject.c,53 :: 		duty_oran = adc_degeri / 4;      // 10-bit deðeri 8-bit'e (0-255) düþür
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	MOVF       R2+0, 0
	MOVWF      _duty_oran+0
;MyProject.c,58 :: 		TRISD.F0 = 1;
	BSF        TRISD+0, 0
;MyProject.c,59 :: 		if (PORTD.F0 == 1) {               // EÐER BUTONA BASILIYORSA (GND'ye çekildiyse)
	BTFSS      PORTD+0, 0
	GOTO       L_main2
;MyProject.c,60 :: 		PWM1_Set_Duty(duty_oran);     // Motoru ADC'den gelen hýzla döndür
	MOVF       _duty_oran+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,61 :: 		}
L_main2:
;MyProject.c,62 :: 		if (PORTD.F0 == 0) {               // EÐER BUTONA BASILIYORSA (GND'ye çekildiyse)
	BTFSC      PORTD+0, 0
	GOTO       L_main3
;MyProject.c,63 :: 		PWM1_Set_Duty(0);     // Motoru ADC'den gelen hýzla döndür
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,64 :: 		}
L_main3:
;MyProject.c,72 :: 		Lcd_Out(1,1,"ADC:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,73 :: 		IntToStr(adc_degeri, txt);
	MOVF       _adc_degeri+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _adc_degeri+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,74 :: 		Lcd_Out(1,5,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,76 :: 		Lcd_Out(2,1,"Duty:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,77 :: 		ByteToStr(duty_oran, txt);
	MOVF       _duty_oran+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;MyProject.c,78 :: 		Lcd_Out(2,6,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,80 :: 		Delay_ms(100);                   // Kararlýlýk için kýsa bekleme [cite: 515, 670]
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
;MyProject.c,81 :: 		}
	GOTO       L_main0
;MyProject.c,82 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
