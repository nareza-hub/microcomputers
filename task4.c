#include "pic24_all.h"  
 
#if __dsPIC33EP128GP502__ 
 #define LED1 _LATB15     
 #define CONFIG_LED1() ENABLE_RB15_OPENDRAIN(); 
 #define RLED _LATA0 //Red LED (connect to RA0)
 #define GLED _LATA4 //Green LED (connect to RA4)
 #define BLED _LATB2 //Blue LED (connect to RB4)

 inline void CONFIG_RGB() { 
   CONFIG_RA0_AS_DIG_OUTPUT(); //config. red LED pin as output
   CONFIG_RA4_AS_DIG_OUTPUT(); //config. green LED pin as output
   CONFIG_RB2_AS_DIG_OUTPUT();} //config. blue LED pin as output
 
  #define SW1 _RB0 
  inline void CONFIG_SW1() { 
   CONFIG_RB0_AS_DIG_INPUT(); 
   ENABLE_RB0_PULLUP(); } 

  #define SW2 _RB1 //define SW2
  inline void CONFIG_SW2() {
   CONFIG_RB1_AS_DIG_INPUT();
   ENABLE_RB1_PULLUP(); }
#endif 
// NEOMA REZA
int main(void) { 
 // the code below configures the dsPIC33 using functions provided by 
 // the textbook authors.  
 configClock(); 
 configPinsForLowPower(); 
 configHeartbeat(); 
						 
 // the code below is to setup LED1, SW1, and the RGB LED 
 CONFIG_LED1(); //configure LED1
 CONFIG_RGB(); //configure RGB LED
 CONFIG_SW1(); //configure switch 1
 CONFIG_SW2(); //configure switch 2
 DELAY_US(1); //delay 1 us
 
 while (1) { // Infinite while loop 
  if((SW1 == 0) && (SW2 == 1)) { //only SW1 is pressed
   LED1 = 1;  // turn on LED1 
   RLED = 0; // turn off red color of RGB 
   GLED = 0; //turn off green color of RGB 
   BLED = 0; }//turn off blue color of RGB 
  else if ((SW2 == 0)&& (SW1 == 1)){ //only SW2 is pressed 
   LED1 = 0; //turn off LED1
   RLED = 1; //turn on red color of RGB
   GLED = 1; //turn on green color of RGB
   BLED = 1; }//trun on blue color of RGB
  else { //both pressed or neither pressed
   LED1 = 0; //turn off LED1
   RLED = 0; //turn off red color of RGB
   GLED = 0; //turn off green color of RGB
   BLED = 0; }//turn off blue color of RGB
												 
  DELAY_MS(15);      // Delay 15 ms 
						} 
  return 0; 
}