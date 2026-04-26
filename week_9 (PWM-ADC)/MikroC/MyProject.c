//LCD baglanti tanýmlamalari
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
 // ADC kismi
 ADC_Init();              // ADC modulunu baslat
 ADCON1 = 0x00001110;     // AN0 analog, digerleri dijital
 TRISA.F0 = 1;            // AN0 giris
    
 // LCD islemleri
 Lcd_Init();              // LCD'yi baslat
 Lcd_Cmd(_LCD_CLEAR);     // Ekrani temizle
 Lcd_Cmd(_LCD_CURSOR_OFF);// Ýmleci kapat
    
 TRISC.F2 = 0;            // RC2 (CCP1) çýkýþ (PWM için)

 // PWM Ayarý: 500Hz frekans (8MHz kristal için)
 PR2 = 124;               // Period Register 2, period register = 124, bize 500Hz Frequency vermesi için
 T2CKPS1_bit = 1;         // Prescaler 1:16
 T2CKPS0_bit = 1;         // Timer2' nin Prescaler ayarlarýný yapmak için
 /*
 T2CKPS1_bit = 0;         // Prescaler 1:1
 T2CKPS0_bit = 0;

 T2CKPS1_bit = 0;         // Prescaler 1:4
 T2CKPS0_bit = 1;
    
 T2CKPS1_bit = 1;         // Prescaler 1:16
 T2CKPS0_bit = 1;
 */
 PWM1_Init(500);          // PWM1 modülünü 500Hz'e ayarla
 PWM1_Start();            // PWM'i baþlat

 while(1) {
  // 1. Önce ADC'den potansiyometre deðerini al
  adc_degeri = ADC_Read(0);        // AN0'dan oku (0-1023)
  duty_oran = adc_degeri / 4;      // 10-bit deðeri 8-bit'e (0-255) düþür
  // max ADC degeri / max PWM degeri = 4
        
  PWM1_Set_Duty(duty_oran);        // PWM doluluk oranýný güncelle

  // Ekrana Yazdýrma
  Lcd_Out(1,1,"ADC:");
  IntToStr(adc_degeri, txt);
  Lcd_Out(1,5,txt);
 
  Lcd_Out(2,1,"Duty:");
  ByteToStr(duty_oran, txt);
  Lcd_Out(2,6,txt);

  Delay_ms(100);                   // Kararlýlýk için kýsa bekleme
 }
}