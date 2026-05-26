//LCD pin ayarlari
sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;
//Pin yonlendirme
sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;

char txt[16];//LCD'ye yazdýrmak icin
void main() {
 int sayac=0;
 Lcd_Init();//LCD'nin baslamasi icin
 Lcd_Out(1,1,"HOSGELDIN");//LCD'ye cikti vermek icin
 Delay_ms(1000);//1 sn'ye bekler.
 Lcd_Cmd(_LCD_CLEAR);//LCD ekranýný temizler
 Lcd_Cmd(_LCD_CURSOR_OFF);//isaretciyi kapatir
 while(1){
  sayac++;
  IntToStr(sayac, txt);//Integeri String'e cevirir
  Lcd_Out(1,1,txt);
  Delay_ms(1000);
  Lcd_Cmd(_LCD_SHIFT_RIGHT);//Saga kaydirir
  Delay_ms(1000);
  Lcd_Cmd(_LCD_SHIFT_LEFT);//sola kaydirir
  Delay_ms(1000);
 }
}

