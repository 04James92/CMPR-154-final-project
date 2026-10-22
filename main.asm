INCLUDE Irvine32.inc
.data
	outMenu BYTE "Shinobi Syntax Main Menu", 13, 10, "1. DISPLAY MY AVAILABLE CREDITS" , 13, 10, "2. ADD CREDITS TO MY ACCOUNT", 13,10, "3. PLAY THE GUESSING GAME", 13,10, "4. DISPLAY MY STATS",13,10 ,0
	exitMenu BYTE  "5.EXIT",13,10 ,0
	outChoice BYTE "you chose: ",0

.code
main proc

again:
	mov eax, 500
	call Delay

	call clrscr
	
	mov edx, OFFSET outMenu
	call writeString
	

	mov edx, OFFSET exitMenu
	call writeString

	call readInt

	mov edx, OFFSET outChoice
	call writeString
	call writeDec
	 
	 cmp eax, 5

	JZ terminate

	
	JMP again 

	terminate:

	


exit
main endp
end main
