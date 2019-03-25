ORG $A2A5 ; Uuhhh
autoclean JSL poisonmushroom

freecode ; Freespace for code

poisonmushroom: ; Classified on line 2
JSL $05BB39 ; Original code
JMP poisonmushroom_main ; Jump to ine 11
RTL ; Return

poisonmushroom_main: ; Classified on line 8
LDA $19 ; Powerstate
CMP #$03 ; Check if feather
BEQ IsFeather ; If feather branch to line 17
RTL ; Return

IsFeather: ; Classified on line 14
JSL $F606 ; Death routine
RTL ; Return


DONE:
JSL $05BB39 ; Original code again
RTL ; Return

