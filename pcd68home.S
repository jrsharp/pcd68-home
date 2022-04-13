# PCD-68 Homepage
#

# Define ScrnBase, location in memory containing the start of video memory
.equ ScrnBase, 0x810000

start:
    movel   #400, %d2   // Rotate through screen 400 times
    movel   #0, %d3

screen_top:
	moveal	#ScrnBase, %a2
    addal   %d3, %a2
	moveb	#0x00, %d0
	movel	#0x1D4C0, %d1

fill_loop:
	moveb	%d0, (%a2)+
    addi    #1, %d0
	subil   #1, %d1
	bne	fill_loop

check_dec:
    addi    #4, %d3
	subi	#1, %d2
	bne	screen_top

end_loop:
	movel	#1000, %d1
delay_loop:
	nop
	subi	#1, %d1
	bne	delay_loop
	bra	end_loop
end:

