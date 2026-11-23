; -----------------------------------
; Program Description : A guessing game
; Author: Muhammad Jafri, Jaime Organista, Juan Campos, Melody Ventura
; Creation Date : October 22 2026
; Language: IA - 32 x86
; Assembler: Microsoft Macro Assembler(MASM)
; Collaboration: None
; ----------------------------------

INCLUDE Irvine32.inc
.data
  outName BYTE "Please input a name (15 character limit):", 13, 10, 0
  outMenu BYTE "**********Welcome to Shinobi Syntax's Guess a Number Game:**********", 13, 10, ; Opening greeting message.
  "1.DISPLAY MY AVAILABLE CREDITS", 13, 10,
  "2.ADD CREDITS TO MY ACCOUNT", 13, 10,
  "3.PLAY THE GUESSING GAME", 13, 10,
  "4.DISPLAY MY STATS", 13, 10,
  "5.EXIT", 13, 10,
  "Choose one of the following options: ", 0
  outChoice BYTE "you chose: ", 0
  outInvalidChoice BYTE "Invalid input try again ", 0
  outBalance BYTE "Your avaliable balance is: $", 0
  outAddCred BYTE "Please Enter the amount you would like to add: ", 0
  outErrorAddCredNeg BYTE "ERROR: cannot add negative numbers!", 0
  outErrorAddCredit BYTE "ERROR Too many credits in balance. Maximum allowable credit is $20.00", 0
  outInsufficientFunds BYTE "Not enough credits to play. Please add some to play", 0
  outInvalidGuess BYTE "Your answer was invalid. Please pick a number between 1-10", 0
  outGuess BYTE "Please guess the number between 1-10: ", 0
  outCorrectAns BYTE "Congrats! you guessed it correct ", 0
  outIncorrectAns BYTE "You Lost!", 13, 10, "The correct answer is ", 0
  outPlayAgain BYTE "Do you want to play again? Enter 1 for yes, 2 for no ", 0
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
  
  
  balance DWORD 0				; the amount of credits they have
  correctGuesses DWORD 0		; Stores correct gusess they made
  missedGuesses DWORD 0		; Stores incorrect guesses they made
  gamesPlayed DWORD 0			; Stores how many times they have played the guessing game
  moneyWon DWORD 0			; The balance won playing the guessing game
  moneyLost DWORD 0			; The balance lost when plyaing the guessing game
  MAX_ALLOWED EQU 20			; For add credits(makes sure that they cannot add credits when they have more than 20 credits)
  randomNum DWORD ?			; stores the random number for guessing game
  playerName BYTE 16 DUP(?)	; Store up to 15 digits + 1 for null term
  exitStats BYTE 2 DUP(?)	; Store up to 1 digit + 1 for null term



.code
main proc

call Randomize

mov edx, OFFSET outName
call writeString

mov edx, OFFSET playerName
mov ecx, 16
call readString		; Checks ecx and does 16 - 1 to store 15 digits and then a null terminator

menu :
  mov eax, 1500
  call Delay; creates 1500 ms delay
  
  call clrscr; clears screen
  
  mov edx, OFFSET outMenu
  call writeString
  call readInt
  call crlf
  
  cmp eax, 5
  JZ terminate; Jumps to end of program
  
  cmp eax, 1
  JZ display_Credits; Jumps to display credits
  
  cmp eax, 2
  JZ add_Credits; Jumps to add credits
  
  cmp eax, 3
  JZ play_Game; Jumps to play game
  
  cmp eax, 4
  JZ display_Stats; Jumps to display stats
  
  JMP invalid_Choice


; Display Credits Label

display_Credits : ; Displays the amount of credits and then goes to menu
  mov edx, OFFSET outBalance
  call writeString
  
  mov eax, balance
  call writeDec; print balance
  
  JMP menu


;Add Credits Label

add_Credits :
  mov edx, OFFSET outAddCred
  call writeString
  call readDec
  
  cmp eax, 0
  JZ error_Add_Credits_Neg	; Jump if entered amount isnt positive
  
  add eax, balance
  cmp eax, MAX_ALLOWED
  JA error_Add_Credits	; Jump if balance is over $20
  
  mov balance, eax
  JMP menu; back to menu
  
  
  error_Add_Credits :
    mov edx, OFFSET outErrorAddCredit
    call writeString
    JMP menu
  
  error_Add_Credits_Neg:
    mov edx, OFFSET outErrorAddCredNeg
    call writeString
    JMP menu


;Play the Game Label

play_Game :				; Plays the game
  CMP balance, 0
  JZ insufficient_Funds	; Jumps if there is no money in balance
  
  dec balance				; decrements everytime user plays
  
  mov eax, 10				; gives the range used in RandomRange
  call RandomRange		; gives random number between 0 - 9
  inc eax					; increments so the number is always between 1 - 10
  mov randomNum, eax		; store the randon number user has to guess
  
  guess_Again :			; label you will go to after displaying invalid input if the user guess isnt between 1 - 10
  mov edx, OFFSET outGuess
  call writeString
  call ReadDec
  
  ; makes sure guess is between 1 - 10 and if not jump to error msg and give user another chance to guess
  CMP eax, 10
  JA invalid_Guess
  CMP eax, 0
  JBE invalid_Guess
  
  inc gamesPlayed
  
  cmp eax, randomNum		; checks to see if guess was correct
  JZ guess_Correct
  JMP guess_Incorrect
  
  invalid_Guess :			; User inputs something outside of 1 - 10 warns user the input is invalid and lets them guess again
    mov edx, OFFSET outInvalidGuess
    call writeString
    call crlf
    JMP guess_Again
    
  guess_Correct :			; User guesses correctly
    mov edx, OFFSET outCorrectAns
    call writeString
    call crlf
    
    add balance, 2
    inc correctGuesses
    add moneyWon, 2
  
    JMP play_Again
  
  guess_Incorrect :		; User guesses incorrectly
    mov edx, OFFSET outIncorrectAns
    call writeString
    mov eax, randomNum
    call writeDec			; inputs the random number
    call crlf
    
    inc missedGuesses
    inc moneyLost
    
    JMP play_Again
  
  play_Again :			; asks user if they want to play again
    mov edx, OFFSET outPlayAgain
    call writeString
    call ReadDec
    
    cmp eax, 1
    JZ play_Game			; plays game again if user inputs 1
    
    cmp eax, 2
    JZ menu					; goes to menu if user inputs 2
    
    mov edx, OFFSET outErrorPlayAgain
    call writeString
    JMP play_Again			; if user doesnt pick 1 or 2, tells user that input is invalid and then gives them to option to choose if they want to play again or not
    
  
  
  insufficient_Funds:		; When the user has 0 credits and trys playing game
    mov edx, OFFSET  outInsufficientFunds
    call writeString
    JMP menu



display_Stats:			; Displays a header then all the players stats
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

invalid_Choice :		; prints invalid input if a valid menu choice isnt picked
  mov edx, OFFSET outInvalidChoice
  call writeString
  JMP menu


terminate :				; jumps to end the program
exit
main endp
end main
