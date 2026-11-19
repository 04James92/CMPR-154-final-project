; ---------------------------------- -
; Program Description : A guessing game
; Author: Muhammad Jafri, Jaime Organista, Juan Campos, Melody Ventura
; Creation Date : October 22 2026
; Language: IA - 32 x86
; Assembler: Microsoft Macro Assembler(MASM)
; Collaboration:
; ----------------------------------

INCLUDE Irvine32.inc
.data
outName BYTE "Please input a name (15 character limit):", 13, 10, 0
outMenu BYTE "**********Welcome to Shinobi Syntax's Guess a Number Game:**********", 13, 10, ;Opening greeting message. 
"1.DISPLAY MY AVAILABLE CREDITS", 13, 10,
"2.ADD CREDITS TO MY ACCOUNT", 13, 10,
"3.PLAY THE GUESSING GAME", 13, 10,
"4.DISPLAY MY STATS", 13, 10,
"5.EXIT", 13, 10,
"Choose one of the following options: ", 0d
outChoice BYTE "you chose: ", 0
outInvalidChoice BYTE "Invalid input try again ", 0
outBalance BYTE "Your avaliable balance is: $", 0
outAddCred BYTE "Please Enter the amount you would like to add: ", 0
outErrorAddCredit BYTE "ERROR Too many credits in balance. Maximum allowable credit is $20.00", 0
outInsufficientFunds BYTE "Not enough credits to play. Please add some to play", 0
outInvalidGuess BYTE "Your answer was invalid. Please pick a number between 1-10", 0
outGuess BYTE "Please guess the number between 1-10: ", 0
outCorrectAns BYTE "Congrats! you guessed it correct ", 0
outIncorrectAns BYTE "You Lost!", 13, 10, "The correct answer is ", 0
outPlayAgain BYTE " Do you want to play again? Enter 1 for yes, 2 for no ", 0
outErrorPlayAgain BYTE "Error invalid input try again", 0

outStatHeader BYTE "=========PLAYER STATS=========", 0
outPlayerName BYTE "Player name: ", 0
outAvaliableCred BYTE "Avaliable Credit: $", 0
outGamesPlayed BYTE "Games Played: ", 0
outCorrectGuesses BYTE "Correct Guesses: ", 0
outMissedGuesses BYTE "Missed Guesses: ", 0
outMoneyWon BYTE "Money you won: $", 0
outMoneyLost BYTE "Money you lost: $", 0
outLeaveStats BYTE "Press Enter to return to the main menu", 0


balance DWORD 0
correctGuesses DWORD 0
missedGuesses DWORD 0
gamesPlayed DWORD 0
moneyWon DWORD 0
moneyLost DWORD 0
MAX_ALLOWED EQU 20
randomNum DWORD ?
playerName BYTE 16 DUP(? )	;Store up to 15 digits + 1 for null term
exitStats BYTE 2 DUP(? )	;stores



.code
main proc

call Randomize

mov edx, OFFSET outName
call writeString

mov edx, OFFSET playerName
mov ecx, 16
call readString; Checks ecx and does 16 - 1 to store 15 digits and then a null terminator

menu :
mov eax, 1000
call Delay; creates 1000 ms delay

call clrscr; clears screen

mov edx, OFFSET outMenu
call writeString
call readInt
call crlf

cmp eax, 5
JZ terminate; Jumps to end of program

cmp eax, 1
JZ display_Credits; Jumps to choice1

cmp eax, 2
JZ add_Credits; Jumps to choice2

cmp eax, 3
JZ play_Game; Jumps to choice3

cmp eax, 4
JZ display_Stats; Jumps to choice4

JMP invalid_Choice


display_Credits :
mov edx, OFFSET outBalance
call writeString

mov eax, balance
call writeDec; print balance

JMP menu

add_Credits :
mov edx, OFFSET outAddCred
call writeString
call readDec

cmp eax, 0
JZ error_Add_Credits; Jump if entered amount isnt positive

add eax, balance
cmp eax, MAX_ALLOWED
JA error_Add_Credits; Jump if balance is over $20

mov balance, eax
JMP menu; back to menu

error_Add_Credits :
mov edx, OFFSET outErrorAddCredit
call writeString
JMP menu


play_Game :
CMP balance, 0
JZ insufficient_Funds; Jumps if there is no money in balance

dec balance

mov eax, 10
call RandomRange; gives random number between 0 - 9
inc eax; increments so the number is always between 1 - 10
mov randomNum, eax

guess_Again : ; label you will go to after displaying invalid input if the user guess isnt between 1 - 10
mov edx, OFFSET outGuess
call writeString
call ReadDec

; makes sure guess is between 1 - 10 and if not jump to error msg and give user another chance to guess
CMP eax, 10
JA invalid_Guess
CMP eax, 0
JBE invalid_Guess

inc gamesPlayed

cmp eax, randomNum; checks to see if guess was correct
JZ guess_Correct
JMP guess_Incorrect

invalid_Guess :
mov edx, OFFSET outInvalidGuess
call writeString
call crlf
JMP guess_Again

guess_Correct :
mov edx, OFFSET outCorrectAns
call writeString
call crlf

add balance, 2
inc correctGuesses
add moneyWon, 2

JMP play_Again

guess_Incorrect :
mov edx, OFFSET outIncorrectAns
call writeString
mov eax, randomNum
call writeDec
call crlf

inc missedGuesses
inc moneyLost

JMP play_Again

play_Again :
mov edx, OFFSET outPlayAgain
call writeString
call ReadDec

cmp eax, 1
JZ play_Game

cmp eax, 2
JZ menu

mov edx, OFFSET outErrorPlayAgain
call writeString
JMP play_Again



insufficient_Funds:
mov edx, OFFSET  outInsufficientFunds
call writeString
JMP menu



display_Stats:
mov edx, OFFSET outStatHeader
call writeString
call crlf
call crlf

mov edx, OFFSET outPlayerName
call writeString
mov edx, OFFSET playerName
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
call crlf

mov edx, OFFSET outLeaveStats
call writeString
mov edx, OFFSET exitStats
mov ecx, 2
call readString

JMP menu

invalid_Choice : ; prints invalid input if a valid menu choice isnt picked
mov edx, OFFSET outInvalidChoice
call writeString
JMP menu


terminate :
exit
main endp
end main
