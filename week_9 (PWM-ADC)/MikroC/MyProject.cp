#line 1 "C:/Users/HP/OneDrive/Masaüstü/2. Sýnýf/Mikro Ýþlemciler ve Mikrodenetleyiciler/Mikro_ders/MikroC/9_1/MyProject.c"

sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

unsigned int adc_degeri;
unsigned short duty_oran;
char txt[10];

void main() {

 ADC_Init();
 ADCON1 = 0x00001110;
 TRISA.F0 = 1;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 TRISC.F2 = 0;


 PR2 = 124;
 T2CKPS1_bit = 1;
 T2CKPS0_bit = 1;
#line 47 "C:/Users/HP/OneDrive/Masaüstü/2. Sýnýf/Mikro Ýþlemciler ve Mikrodenetleyiciler/Mikro_ders/MikroC/9_1/MyProject.c"
 PWM1_Init(500);
 PWM1_Start();

 while(1) {

 adc_degeri = ADC_Read(0);
 duty_oran = adc_degeri / 4;




 TRISD.F0 = 1;
 if (PORTD.F0 == 1) {
 PWM1_Set_Duty(duty_oran);
 }
 if (PORTD.F0 == 0) {
 PWM1_Set_Duty(0);
 }
#line 72 "C:/Users/HP/OneDrive/Masaüstü/2. Sýnýf/Mikro Ýþlemciler ve Mikrodenetleyiciler/Mikro_ders/MikroC/9_1/MyProject.c"
 Lcd_Out(1,1,"ADC:");
 IntToStr(adc_degeri, txt);
 Lcd_Out(1,5,txt);

 Lcd_Out(2,1,"Duty:");
 ByteToStr(duty_oran, txt);
 Lcd_Out(2,6,txt);

 Delay_ms(100);
 }
}
