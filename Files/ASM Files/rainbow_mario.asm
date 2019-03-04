; [This section is to support sa-1]
lorom
!bank = $800000
!addr = $0000

if read1($00ffd5) == $23
	sa1rom
	!bank = $000000
	!addr = $6000
endif
;[end]

ORG $F6F6 ; Origin/Original address in ScrollingRoutine, DOESN'T get called outside of levels.
autoclean JSL rainbow
NOP ; One leftover byte, do nothing

freecode ; Use free space in the RAM for our hijack.

rainbow: ; Classified on line 2
INC $19 ; Increases player powerstate by 1 using $7E0019 (shortened to $19)
LDA $1464 ; Original code to keep scrolling intact.
STA $001C ; Original code to keep scrolling intact.
RTL ; Return JSL.