;---------------------------------- -
; Program Description :
; Author:
; Creation Date :
; Language: IA - 32 x86
; Assembler: Microsoft Macro Assembler(MASM)
; Collaboration:
;----------------------------------

INCLUDE Irvine32.inc
.data
  outMenu BYTE "Shinobi Syntax Main Menu", 13, 10, 
  "1. DISPLAY MY AVAILABLE CREDITS", 13, 10, 
  "2. ADD CREDITS TO MY ACCOUNT", 13, 10, 
  "3. PLAY THE GUESSING GAME", 13, 10, 
  "4. DISPLAY MY STATS", 13, 10, 
  "5.EXIT", 13, 10, 0
  outChoice BYTE "you chose: ", 0
  outInvalidChoice BYTE "Invalid input try again ", 0
  outDisplayBalance BYTE "Your avaliable balance is: $", 0
  
  outStatHeader BYTE "=========PLAYER STATS=========",0
  outPlayerName BYTE "Player name: ",0
  outAvaliableCred BYTE "Avaliable Credit: $",0
  outGamesPlayed BYTE "Games Played: ",0
  outCorrectGuesses BYTE "Correct Guesses: ",0
  outMissedGuesses BYTE "Missed Guesses: ",0
  outMoneyWon BYTE "Money you won: $",0
  outMoneyLost BYTE "Money you lost: $",0
  
  
  balance DWORD 0
  amount DWORD 0
  correctGuesses DWORD 0
  missedGuesses DWORD 0
  gamesPlayed DWORD 0
  moneyWon DWORD 0
  moneyLost DWORD 0
  MAX_ALLOWED EQU 20


.code
main proc

menu:
  mov eax, 500
  call Delay;creates 500 ms delay
  
  call clrscr;clears screen
  
  mov edx, OFFSET outMenu
  call writeString
  
  call readInt
  call writeDec
  call crlf
  
  cmp eax, 5
  JZ terminate ;Jumps to end of program
  
  cmp eax, 1
  JZ display_Credits ;Jumps to choice1
  
  cmp eax, 2
  JZ add_Credits ;Jumps to choice2
  
  cmp eax, 3
  JZ play_Game ;Jumps to choice3
  
  cmp eax, 4
  JZ display_Stats ;Jumps to choice4

  JMP invalid_Choice


display_Credits:
  mov edx, OFFSET outDisplayBalance
  call writeString
  
  mov eax, balance
  call writeDec;print balance
  
  JMP menu

add_Credits:
  JMP menu

play_Game:
  JMP menu

display_Stats:
	mov edx, OFFSET outStatHeader
	call writeString 
	call crlf
	call crlf

	mov edx, OFFSET outPlayerName 
	call writeString 
	call crlf

	mov edx, OFFSET outAvaliableCred
	call writeString 
	mov eax, balance
	call writeDec
	call crlf

	mov edx, OFFSET outGamesPlayed
	call writeString
	mov eax, gamesPlayed
	call writeDec
	call crlf

	mov edx, OFFSET outCorrectGuesses
	call writeString
	mov eax, correctGuesses
	call writeDec
	call crlf

	mov edx, OFFSET outMissedGuesses 
	call writeString
	mov eax, missedGuesses
	call writeDec
	call crlf

	mov edx, OFFSET outMoneyWon
	call writeString
	mov eax, moneyWon
	call writeDec
	call crlf

	mov edx, OFFSET outMoneyLost
	call writeString
	mov eax, moneyLost
	call writeDec
	call crlf


	mov eax, 5000
	call Delay
	JMP menu

invalid_Choice:
  mov edx, OFFSET outInvalidChoice
  call writeString
  JMP menu


terminate :
exit
main endp
end main
