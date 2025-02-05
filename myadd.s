 
;
; Just check out MPLAB

		.include "p24Hxxxx.inc"

       .global __reset          ;The label for the first line of code. 

         .bss            ;unitialized data section
;;These start at location 0x0800 because 0-0x07FF reserved for SFRs
aa:       .space 1        ;Allocating space (in bytes) to variable.
bb:       .space 1        ;Allocating space (in bytes) to variable.
lsp:       .space 2        ;Allocating space (in bytes) to variable.
msp:		.space 2		;Allocating space (in bytes) to variable.
sum:		.space 2		;Allocating space (in bytes) to variable.


;..............................................................................
;Code Section in Program Memory
;..............................................................................

         .text           ;Start of Code section
__reset:                 ; first instruction located at __reset label
        mov #__SP_init, w15       ;Initalize the Stack Pointer
        mov #__SPLIM_init,W0   
        mov W0, SPLIM             ;Initialize the stack limit register
;__SP_init set by linker to be after allocated data      

;User Code starts here.
; C Program equivalent
;  #define avalue 2047
;  uint16_t i,j,k;
;
;     i = avalue;   /* myvalue = 2047 (0x7FF) */
;     i = i + 1;   /* i++, i = 2048 (0x800)  */
;     j = i;       /* j is 2048 (0x0800) */
;     j = j - 1;   /* j--, j is 2047   */
;     k = j + i;    /* k = 4095 (0x0FFF) */
;
		.equ avalue, 6003 
/* Neoma Reza */

;lsp = 0x6003
mov #0x6003, W0		;W0 = #0x6003
mov W0, lsp			;copy the value of W0 so lsp = #0x6003
;msp = 0x1228
mov #0x1228, W1		;W1 = #0x1228
mov W1, msp			;copy the value of W1 so msp = #0x1228
;sum = lsp + msp
add W0, W1, W0		;W0 = W0 + W1 (0x6003 + 0x1228)
mov W0, sum			;sum = lsp + msp
;sum = sum + aa + bb
;aa = #100
mov.b #100, W0		;W0 = #100
mov.b WREG, aa		;copy the value of WREG so aa = #0x64
ze W0, W0			;zero the msb of W0 which extend it to 16 bits
add sum				;sum = sum + WREG (#100)
;bb = #22
mov.b #22, W0		;W0 = #22	
mov.b WREG, bb		;copy the value of WREG so bb = #0x16
ze W0, W0			;zero the msb of W0 which extend it to 16 bits
add sum				;sum = (sum + #100) + WREG (#22)


done:
    goto     done    ;Place holder for last line of executed code

.end       ;End of program code in this file
