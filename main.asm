INCLUDE Irvine32.inc
.data
	outMenu BYTE "*** Team Name *** *** MAIN MENU ***", 
	13, 10, 
	13, 10,
	"Please select one of the following:",
	13, 10,
	13, 10,
	"  1: Display my available credit",
	13, 10,
	"  2: Add credits to my account",
	13, 10,
	"  3: Play the guessing game",
	13, 10,
	"  4: Display my statistics",
	13, 10,
	"  5: Exit",
	13, 10, 13, 10, 0
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
