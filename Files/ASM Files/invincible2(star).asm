ORG $F6F6 ; Scrolling Routine
autoclean JSL starpower
NOP ; Left over byte, lets get rid of it

freecode ; Use free space in the RAM for the hijack

starpower: ; Classified on line 2
JSL $1C580 ; Star routine
LDA $1464 ; Original code to keep scrolling intact.
STA $001C ; Original code to keep scrolling intact.
RTL ; Return