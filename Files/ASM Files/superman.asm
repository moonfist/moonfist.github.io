; This is really buggy, and made just for the heck of it.
; Have fun.

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

ORG $8665 ; Origin/Original address in ControllerUpdate routine
autoclean JSL superman
NOP ; Two left over bytes, lets get rid of it
NOP

freecode ; Use free space in the RAM for the hijack

superman: ; Classified on line 2
LDA $13E4 ; Flag to determine if mario is running fully or not
CMP #$70 ; If #$70 then mario is in a full sprint.
BNE notrunning ; If not #$70 jump to not running
LDA $16 ; Controller input for buttons being pressed
AND #%10000000 ; The B Button
BEQ notrunning ; If anything else jump to notrunning (for sake of ez) as well
LDA #$07 ; Animation used when shooting out of pipes
STA $71 ; Address that sets the animation
notrunning: ; Classified on lines 10 and 13
LDA $4219 ; Original code.
STA $0DA2 ; Original code.
TAY ; Original code.
RTL ; Return