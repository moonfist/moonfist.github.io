ORG $A2A5 ; Uuhhh
autoclean JSL float_init

freecode ; Freespace for code

float_init: ; Classified on line 2
JSL $05BB39 ; Original code
JMP float_main ; Jump to ine 11
RTL ; Return

float_main: ; Classified on line 8
LDA $15 ; Controller
AND #$80 ; B Button
BNE isPressingB ; Branch if pressing B Button
RTL ; Return

isPressingB: ; Classified on line 14
REP #$20 ; 16-Bit A
LDA $96 ; Marios Y-Pos (16-Bit)
SEC ; Subtract 1
SBC #$0001 ; Subtract 1
STA $96 ; Store to Y-Pos
SEP #$20 ; Back to 8-Bit A
LDA #$EA ; Y-Speed Value
STA $7D ; Store to Y-Speed
RTL ; Return


DONE:
JSL $05BB39 ; Original code again
RTL ; Return

