;-----------------------------------
; Program Description: 
; Author: 
; Creation Date: 
; Language: IA-32 x86
; Assembler: Microsoft Macro Assembler (MASM)
; Collaboration:
;----------------------------------

INCLUDE Irvine32.inc
.data
outMenu BYTE "Shinobi Syntax Main Menu", 13, 10, "1. DISPLAY MY AVAILABLE CREDITS", 13, 10, "2. ADD CREDITS TO MY ACCOUNT", 13, 10, "3. PLAY THE GUESSING GAME", 13, 10, "4. DISPLAY MY STATS", 13, 10, "5.EXIT", 13, 10, 0
outChoice BYTE "you chose: ", 0
outInvalidChoice BYTE "Invalid input try again ", 0
outDisplayBalance BYTE "Your avaliable balance is: $", 0

balance DWORD 0
amount DWORD 0
correctGuesses DWORD 0
missedGusses DWORD 0


.code
main proc

again :
	mov eax, 500
	call Delay;creates 500 ms delay

	call clrscr;clears screen

	mov edx, OFFSET outMenu
	call writeString

	call readInt
	call writeDec
	call crlf

	cmp eax, 5
	JZ terminate;Jumps to end of program

	cmp eax, 1
	JZ choice1;Jumps to choice1

	cmp eax, 2
	JZ choice2;Jumps to choice2

	cmp eax, 3
	JZ choice3;Jumps to choice3

	cmp eax, 4
	JZ choice4;Jumps to choice4

	JMP invalid_Choice


choice1:
	mov edx, OFFSET outDisplayBalance
	call writeString

	mov eax, balance
	call writeDec;print balance

	JMP again

choice2:
	JMP again

choice3:
	JMP again

choice4:
	JMP again

invalid_Choice:
	mov edx, OFFSET outInvalidChoice
	call writeString
	JMP again


terminate:
exit
main endp
end main
