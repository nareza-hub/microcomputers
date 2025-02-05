.include "p24Hxxxx.inc"
.global __reset          ;The label for the first line of code. 
.bss          		     ;unitialized data section
;;These start at location 0x0800 because 0-0x07FF reserved for SFRs
;check_val:			.space 2        ;Allocating space (in bytes) to variable.
;ones_count:			.space 1		;Allocating space (in bytes) to variable.
;first_one:			.space 1		;Allocating space (in bytes) to variable.
;..............................................................................
;Code Section in Program Memory
;..............................................................................
.text           ;Start of Code section
__reset:                 ; first instruction located at __reset label
        mov #__SP_init, w15       ;Initalize the Stack Pointer
        mov #__SPLIM_init,W0   
        mov W0, SPLIM             ;Initialize the stack limit register
;__SP_init set by linker to be after allocated data      
/* Neoma Reza */

reset_initialize:
MOV #0x0800, W15 ;initialize stack pointer
bclr TRISA, #2	;clear TRISA bit 2 to config. RA2 as output
bset TRISB, #13 ;set TRISB bit 13 to config. RB13 as input
bset CNPU1, #13 ;enable pull-up on RB13
main_loop:
;CHECK SWITCH STATUS
btss PORTB, #13 ;skip if RB13 is set (button not pressed)
bra turnOnLed	;branch unconditionally
;TURN OFF LED
bclr LATA, #2	;clear LATA bit 2 to turn off the LED
bra main_loop	;go back to main_loop
;----------------------------------------------------------------
turnOnLed:		;turn on LED
bset LATA, #2	;set LATA bit 2 to turn on the LED
bra main_loop	;go back to main_loop
.end       ;End of program code in this file
