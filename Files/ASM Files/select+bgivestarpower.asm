; NOT COMPATABILE WITH: selectpowerupstate.asm

; Hold down Select and press B to get star power

ORG $8650 ; Origin/Original address in ControllerUpdate routine
autoclean JSL starpower
NOP ; Left over byte, lets get rid of it

freecode ; Use free space in the RAM for the hijack

starpower: ; Classified on line 2
LDA $15 ; Controller input for buttons being held down
AND #%00100000 ; The Select Button
BEQ notpressed ; If the button is anything else jump to notpressed
LDA $16 ; Controller input for buttons being pressed
AND #%10000000 ; The B Button
BEQ notpressed ; If anything else jump to notpressed as well
JSL $1C580 ; Star routine
notpressed: ; Classified on line 13
LDA $4218 ; Original code.
AND #$F0 ; Original code.
RTL ; Return