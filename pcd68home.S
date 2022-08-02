# PCD-68 Homepage
#

# Define ScrnBase, location in memory containing the start of video memory
.equ ScrnBase, 0x810000
.equ TDABase, 0x410000
.equ KCTLBase, 0x420000
.equ KCTLStatus, 0x420000
.equ KCTLAscii, 0x420001
.equ KCTLKeycode, 0x420002

.org 0x000000
vectors:
    dc.l    0x000000    // Initial SP
    dc.l    start       // Start of program code
    dc.l    0x000000    // Bus error
    dc.l    0x000000    // Address error
    dc.l    0x000000    // Illegal instruction
    dc.l    0x000000    // Div by zero
    dc.l    0x000000    // CHK exception
    dc.l    0x000000    // TRAPV exception
    dc.l    0x000000    // Privilege violation
    dc.l    0x000000    // TRACE exception
    dc.l    0x000000    // Line-A emulator
    dc.l    0x000000    // Line-F emulator
    dc.l    0x000000    // Reserved (unused)
    dc.l    0x000000    // Co-proc protocol violation
    dc.l    0x000000    // Format error
    dc.l    0x000000    // Uninitialized Interrupt
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Spurious Interrupt
    dc.l    0x000000    // IRQ Level 1
    dc.l    0x000000    // IRQ Level 2 (EXT Interrupt)
    dc.l    0x000000    // IRQ Level 3
    dc.l    0x000000    // IRQ Level 4 (VDP Horizontal Interrupt)
    dc.l    0x000000    // IRQ Level 5
    dc.l    0x000000    // IRQ Level 6 (VDP Vertical Interrupt)
    dc.l    keyboard_handler    // IRQ Level 7
    dc.l    0x000000    // TRAP #00 Exception
    dc.l    0x000000    // TRAP #01 Exception
    dc.l    0x000000    // TRAP #02 Exception
    dc.l    0x000000    // TRAP #03 Exception
    dc.l    0x000000    // TRAP #04 Exception
    dc.l    0x000000    // TRAP #05 Exception
    dc.l    0x000000    // TRAP #06 Exception
    dc.l    0x000000    // TRAP #07 Exception
    dc.l    0x000000    // TRAP #08 Exception
    dc.l    0x000000    // TRAP #09 Exception
    dc.l    0x000000    // TRAP #10 Exception
    dc.l    0x000000    // TRAP #11 Exception
    dc.l    0x000000    // TRAP #12 Exception
    dc.l    0x000000    // TRAP #13 Exception
    dc.l    0x000000    // TRAP #14 Exception
    dc.l    0x000000    // TRAP #15 Exception
    dc.l    0x000000    // (FP) Branch or Set on Unordered Condition
    dc.l    0x000000    // (FP) Inexact Result
    dc.l    0x000000    // (FP) Divide by Zero
    dc.l    0x000000    // (FP) Underflow
    dc.l    0x000000    // (FP) Operand Error
    dc.l    0x000000    // (FP) Overflow
    dc.l    0x000000    // (FP) Signaling NAN
    dc.l    0x000000    // (FP) Unimplemented Data Type
    dc.l    0x000000    // MMU Configuration Error
    dc.l    0x000000    // MMU Illegal Operation Error
    dc.l    0x000000    // MMU Access Violation Error
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)
    dc.l    0x000000    // Reserved (NOT USED)

jump:
    bra     end_loop

.org 0x001000
start:
    movel   #1, %d2   // Rotate through screen 1 times
    movel   #0, %d3

screen_top:
	moveal	#TDABase, %a2
	moveal	#KCTLAscii, %a3
    addal   %d3, %a2
	moveb	#0x02, %d0
	movel	#140, %d1

fill_loop:
	moveb	%d0, (%a2)+
    addi    #1, %d0
	subil   #1, %d1
	bne     fill_loop

check_dec:
    addi    #4, %d3
	subi	#1, %d2
	bne     screen_top

	moveal	#TDABase + 1, %a2

end_loop:

	movel	#1000, %d1
delay_loop:
	nop
	subi	#1, %d1
	bne     delay_loop
	bra     end_loop
end:

keyboard_handler:
    moveb   (%a3), %d2
    moveb   %d2, (%a2)+
    rte

