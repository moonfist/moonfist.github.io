!YPos = #$19 ; Y-Position Value
!Level = $00C5 ; Level #

ORG $A2A1 ; Scrolling
autoclean JSL nextlevel ; Jump to line 9

freecode ; Find freespace for our code

nextlevel: ; Classified on line 5
JSL CheckForY ; Jump to line 14
JSL $0586F1 ; Original Code
RTL ; Return

CheckForY: ;Classified on line 10
LDA $D3 ; Marios Y-Pos
CMP !YPos ; Compare to value given on line 1
BEQ AdvanceLevel ; If equal to value, branch to line 20
RTL ; Return if else

AdvanceLevel: ; Classified on line 17
PHX               ; This chunk is to handle sending the player to the level
LDX $95           ; Load the value of $95 into X
PEA !Level        ; Push level to the stack
PLA               ; Takes level from the stack and stores (the level)
STA $19B8,x       ; ???
PLA               ; Stores from stack
ORA #$04          ; ???
STA $19D8,x       ; ???
LDA #$06          ; Loads the value 06
STA $71           ; Stores value to animations
STZ $89           ; Set pipe action to #$00
STZ $88           ; Set pipe wait time to #$00
PLX               ; End

DONE:
RTL ; Final return

