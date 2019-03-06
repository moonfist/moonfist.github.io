;Press or hold select to have mario pass his gas.

!FartSound = #$18 ; List of sounds can be found here: https://github.com/moonfist/moonfist.github.io/blob/master/Files/Documents/Soundlist.txt

ORG $8F53 ; Live counter located on statusbar, hijacked.
autoclean JSL fart_main ; Jump to line 11
NOP ; One byte left over

freecode ; Find freespace for our code

fart_main: ; Classified on line 6
JSL CheckForSelect ; Jump to line 18
LDX #$FC ; Original code		
STX $0F16 ; Original code		
RTL ; Return


CheckForSelect: ; Classified on line 12
LDA $15 ; Controller Buttons 
AND #$20 ; Select Button
BNE Fart ; If select button is pressed, branch to line 25
RTL ; Return if anything else


Fart: ; Classified on line 21
LDA #$38 ; Image for mario bending towards the background, showing his rump.
STA $13E0 ; Address we load the image to
LDY #$01            ; This chunk of code is to create smoke (marios gas)
FartEffectSlot:     ; Creates a loop
LDA $17C0,y         ; Smoke sprite
BEQ FartEffect      ; If slot found, branch to line 36
DEY                 ; Decreases Y
BPL FartEffectSlot  ; Go back to line 29, if no slot is available to research.
RTL                 ; Return

FartEffect:         ; Classified on line 31
LDA #$01            ; Smoke type
STA $17C0,y         ; Smoke sprite
LDA #$10            ; Smoke time length
STA $17CC,y         ; Smoke timer
LDA $96             ; Mario y-Pos
CLC                 ; Add 20 to Mario y-Pos
ADC #$14            ; Add 20 to Mario y-Pos
STA $17C4,y         ; Smoke sprite y-Pos
LDA $94             ; Mario x-Pos
STA $17C8,y         ; Smoke End
LDA !FartSound ; Sound value classified on line 3, Default: $18 = Thunder (lol)
STA $1DFC ; Play Sound
RTL ; Return


DONE:
RTL; Final return
