#line 1 "C:/gitHub/MikroC-Practices/week_10 (Timer)/MikroC/MyProject.c"
int counter1 = 0;
int counter2 = 0;
void InitTimer0(){
 OPTION_REG.T0CS = 0;
 OPTION_REG.PSA = 0;


 OPTION_REG.PS2 = 1;
 OPTION_REG.PS1 = 0;
 OPTION_REG.PS0 = 1;

 TMR0 = 99;

 INTCON.TMR0IE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;
}

void Interrupt(){
 if(INTCON.TMR0IF == 1){
 INTCON.TMR0IF = 0;
 TMR0 = 99;

 counter1++;
 counter2++;

 if(counter1 == 100){
 counter1 = 0;
 PORTB.f0 = ~PORTB.f0;
 }

 if(counter2 == 300){
 counter2 = 0;
 PORTB.f1 = ~PORTB.f1;
 }
 }
}

void main() {
 int i=0;
 InitTimer0();
 TRISB = 0;
 PORTB = 0;

 TRISD = 0;
 PORTD = 0;

 for(i=0;i<255;i++){
 PORTD = i;
 Delay_ms(1000);
 }
}
