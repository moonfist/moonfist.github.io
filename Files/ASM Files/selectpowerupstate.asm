; Hold down Select and press UP or DOWN to toggle through powerstates.

ORG $8650 ; Origin/Original address in ControllerUpdate routine
autoclean JSL playerstate
NOP ; Left over byte, lets get rid of it

freecode ; Use free space in the RAM for the hijack

playerstate: ; Classified on line 2
LDA $15 ; Controller input for buttons being held down
AND #%00100000 ; The Select Button
BEQ defnotpressed ; If the button is anything else jump to notpressed
LDA $16 ; Controller input for buttons being pressed
AND #%00001000 ; The Up Button
BEQ notpressed ; If anything else jump to notpressed as well
INC $19 ; Increase the powerup state by 1
notpressed: ; Classified on line 13
LDA $16 ; Line 11
AND #%00000100 ; The Down Button
BEQ defnotpressed ; If anything else jump to defnotpressed
DEC $19 ; Decrease powerup state by 1
defnotpressed: ; Classified on line 10 and 18
LDA $4218 ; Original code.
AND #$F0 ; Original code.
RTL ; Return