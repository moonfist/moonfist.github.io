; --NEED TO KNOWS--
; 1. May not be compatable with Wall Kick.
; 2. SHOULDNT be used in full hacks, as this is very sloppy, doesn't support SA-1, and can ruin your game.
; 3. Always make backups before using this.
; 4. Developers trying to learn from this code must remove this entire section or else most lines
;  stating where the line is classified/branches/jumps to will be about 13 lines off.
;  Etc. ( BRA Doug ; Branches to line 50) would really be line 63. (UNLESS THIS IS REMOVED).
;
; 5. Controls as follows:
; YOU WILL NEED TO HAVE SELECT HELD DOWN TO CYCLE THROUGH CHEATS/ACTIVATE CHEATS
;
; Hold select, and use left/right movement keys to cycle through cheat modes. B will reset the cheat mode to 0.
; Cheatmodes will be displayed in place of the coin counter (coins will change your cheatmode, sorry,
; even cheaters lose at some things.
; 1 (01) = Powerup state (use UP/DOWN) to change players powerup state
; 2 (02) = Star power (will be an infinite star power, unless coin value changes
; 3 (03) = Lives (use UP/DOWN) to change the amount of lives the player has
; 4 (04) = Timer modifier (use UP/DOWN/Y) up/down will change the timers tens place, for example
;          the time "540" the up/down buttons will change the "4", B will make the time "999"
; 5 (05) = Final Level teleport (use Y) will teleport you to bowsers castle.
; 6 (06) = Exits Control (use UP/DOWN/Y) Up will spawn a keyhole, down will spawn the key, Y will spawn
;          an exit goal.
; 7 (07) = Yoshi Spawn (use Y) Will spawn a yoshi.
; 8 (08) = Grower Spawn (use Y) Will spawn a growing vine.
; 9 (09) = Cloud Spawn (use Y) Will spawn a lakitu cloud (no time limit)
; P5 (FF) = This will kill mario if he presses Y, was used as a test and never removed.
;
; THIS CODE IS VERY VERY SLOPPY, AND JUST HACKED TOGETHER TO WORK.
; HOWEVER, IT DOES WORK, AND HAS SOME VERY GOOD LEARNING POINTS.
; EVEN MYSELF LEARNED SOMETHING WHEN MAKING THIS. ENJOY.
; DEVELOPERS WANTING TO READ THE CODE REMOVE FROM HERE TO LINE 1
ORG $00A2A1 ; SS (may or may not be compat with hacks using wallkick)
autoclean JSL supercheater_init

freecode ; Find freespace for our code

supercheater_init: ; Classified on line 2
JSL $0586F1 ; Original code
JMP real_init ; Jump to line 10
RTL ; Return
real_init: ; Classified on line 8
LDA #$1C ; The letter S
STA $0F10 ; Store onto the statusbar
LDA #$0C ; The letter C
STA $0F11 ; Store onto the statusbar
LDA #$78 ; The : symbol
STA $0F12 ; Store onto the statusbar
LDA $DBF ; Players current coins
CMP #$02 ; If the player has two coins
BEQ IsStarCheat ; Branch to line 21
BRA AFTERSTAR ; If not two coins, branch over star power to line 23
IsStarCheat: ; Classified on line 19
JSL $1C580 ; Star power routine
BRA AFTERSTAR ; Branch to line 24
AFTERSTAR: ; Classified on line(s) 20 & 24
LDA $15 ; Currently held down controller buttons
AND #$20 ; The Select button
BNE isHeldDown ; If select is held down branch to line 29
RTL ; Return if not
isHeldDown: ; Classified on line 27
LDA $16 ; Buttons pressed current frame
AND #$01 ; Right button
BNE IncreaseSC ; Branch to line 57
LDA $16 ; Buttons pressed current frame
AND #$02 ; Left button
BNE DecreaseSC ; Branch to line 60
LDA $16 ; Buttons pressed current frame
AND #$80 ; B button
BNE ResetSC ; Branch to line 63
LDA $DBF ; Players current coins
CMP #$01 ; If the player has 1 coin
BEQ IsPowerupCheats ; Branch to line 82 (powerup cheats)
LDA $DBF ; Players current coins
CMP #$03 ; If the player has 3 coin
BEQ IsLivesCheat ; Branch to line 67 (lives cheats)
LDA $DBF ; Players current coins
CMP #$04 ; If the player has 4 coin
BEQ IsTimeCheat ; Branch to line 97 (time cheats)
LDA $DBF ; Players current coins
CMP #$FF ; If the player has P5 coins
BEQ RunThisCode ; Branch to line 55 (more cheats)
LDA $DBF ; Players current coins
CMP #$05 ; If the player has 5 coin
BEQ RunThisCode ; Branch to line 55 (more cheats)
BRA RunThisCode ; Branch to line 54.. lol. (more cheats)
RunThisCode: ; Classified on line(s) 50 & 53
JMP MoreCheats ; Jump to more cheats (hacky workaround branch range limit)
IncreaseSC: ; Classified on line 32
INC $DBF ; Increase players coin count
RTL ; Return
DecreaseSC: ; Classified on line 35
DEC $DBF ; Decrease players coin count
RTL ; Return
ResetSC: ; Classified on line 38
STZ $DBF ; Set coin count to 0
RTL ; Return

IsLivesCheat: ; Classified on line 44
LDA $16 ; Buttons pressed current frame
AND #$08 ; Up button ; Up button
BNE IncreaseLivesCheat ; Branch to line 75
LDA $16 ; Buttons pressed current frame
AND #$04 ; Down button ; Down button
BNE DecreaseLivesCheat ; Branch to line 78
RTL ; Return
IncreaseLivesCheat: ; Classified on line 70
INC $DBE ; Increase current players lives
RTL ; Return
DecreaseLivesCheat:
DEC $DBE ; Decrease current players lives
RTL ; Return

IsPowerupCheats: ; Classified on line 41
LDA $16 ; Buttons pressed current frame
AND #$08 ; Up button
BNE IncreasePowerUpCheat ; Branch to line 90
LDA $16 ; Buttons pressed current frame 
AND #$04 ; Down button
BNE DecreasePowerUpCheat ; Branch to line 93
RTL ; Return
IncreasePowerUpCheat: ; Classified on line 85
INC $19 ; Increase player powerup
RTL ; Return
DecreasePowerUpCheat: ; Classified on line 88
DEC $19 ; Decrease player powerup
RTL ; Return

IsTimeCheat: ; Classified on line 47
LDA $16 ; Buttons pressed current frame 
AND #$08 ; Up button
BNE IncreaseTimeCheat ; Branch to line 114
LDA $16 ; Buttons pressed current frame 
AND #$04 ; Down button
BNE HalfWay ; Branch to line 108
LDA $16 ; Buttons pressed current frame 
AND #$40 ; Y Button
BNE HalfWay2 ; Branch to line 111
RTL ; Return
HalfWay: ; Classified on line 103
JMP DecreaseTimeCheat ; Jump to line 121 (hacky branch range workaround)
RTL ; Return
HalfWay2: ; Classified on line 106
JMP MaxTime ; Jump to line 135 (hacky branch range workaround)
RTL ; Return
IncreaseTimeCheat: ; Classified on line 100
INC $F32 ; Increase time tens place
LDA $F32 ; Load time tens place value
CMP #$0A ; If value A (above 9)
BEQ CarryOver ; Branch to line 120
RTL ; Return if not
CarryOver: ; Classified on line 118
INC $F31 ; Increase time hundreths place
STZ $F32 ; Set time tens place to 0
RTL ; Return
DecreaseTimeCheat: ; Classified on line 109
DEC $F32 ; Decrease time tens place
LDA $F32 ; Load time tens place value
CMP #$00 ; If value 0 (below 1)
BEQ CarryOverUnder ; Branch to line 127 (sloppy as fuck)
RTL ; Return
CarryOverUnder: ; Classified on ine 128
JMP CarryUnder ; Jump to line 130 (hacky branch range workaround)
RTL ; Return
CarryUnder: ; Classified on line 131
LDA #$09 ; The number 9
STA $F32 ; Store it into the time tens place
DEC $F31 ; Decrease the time hundreths place
RTL ; Return
MaxTime: ; Classified on line 112
LDA #$09 ; The number 9
STA $F31 ; Store into time hundreths place
LDA #$09 ; The number 9
STA $F32 ; Store into time tens place
LDA #$09 ; The number 9
STA $F33 ; Store into time ones place
RTL ; Return

MoreCheats: ; Classified on line 56
LDA $DBF ; Player coins
CMP #$05 ; If 05
BEQ FinalLevel ; Branch to line 168
LDA $DBF ; Player coins
CMP #$FF ; If P5
BEQ KillMario ; Branch to line 189
LDA $DBF ; Player coins
CMP #$06 ; If 6
BEQ SpawnKeyAndHoleAndExit ; Branch to line 202
LDA $DBF ; Player coins
CMP #$07 ; If 7
BEQ SpawnYoshi ; Branch to line 161
BRA EvenMoreCheats
SpawnYoshi: ; Classified on line 159
JMP RealSpawnYoshi ; sloppy
RTL ; Return
EvenMoreCheats: ; Classified on line 160
JMP MoreMoreCheats ; sloppy
RTL ; Return

FinalLevel: ; Classified on line 150
LDA $16 ; Buttons pressed current frame 
AND #$40 ; Y Button
BNE WarpToLevel ; Branch to line 173  
RTL ; Return
WarpToLevel: ; Classified on line 171
PHX               ; This chunk is to handle sending the player to the level
LDX $95           ; Load the value of $95 into X
PEA $010D         ; Push level to the stack
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
RTL ; Return

KillMario: ; Classified on line 153
LDA $16 ; Buttons pressed current frame 
AND #$40 ; Y Button
BNE Dead ; Branch to line 194
RTL ; Return
Dead: ; Classified on line 192
JSL $F606 ; Mario death routine
RTL ; Return

MOSTLYDONE: ; Ihaterangeerrors
JMP DONE ; Ihaterangeerrors
RTL ; Ihaterangeerrors

SpawnKeyAndHoleAndExit: ; Classified on line 156
LDA $16 ; Buttons pressed current frame 
AND #$08 ; Up Button
BNE KeyHole ; Branch to line 216
LDA $16 ; Buttons pressed current frame 
AND #$04 ; Down Button
BNE Key ; Branch to line 244
LDA $16 ; Buttons pressed current frame 
AND #$40 ; Y Button
BNE MajorExit ; Branch to line 213
RTL ; Return
MajorExit: ; Classified on line 211
JMP Exit ; Jump to line 272
RTL ; Return
KeyHole: ; Classified on line
LDA $186C,x ; ?? Thank smwcentral
BNE MOSTLYDONE ; Branch to line 198
JSL $02A9DE ; ?? Thank smwcentral
BMI MOSTLYDONE ; Branch to line 198
LDA #$01 ; State
STA $14C8,y ; Store state
LDA #$0E ; Keyhole
STA $009E,y ; Store keyhole
LDA $94 ; Mario x-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00E4,y ; Store x-Pos
LDA $95 ; Marios x-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14E0,y ; Store x-Pos (low)
LDA $96 ; Marios y-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00D8,y ; Store y-Pos
LDA $97 ; Marios y-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14D4,y ; Store y-Pos (low)
PHX ; Push
TYX ; Transfer
JSL $07F7D2 ; Jump to ??? routine
PLX ; Pull
RTL ; Return
Key: ; Classified on line
LDA $186C,x ; ?? Thank smwcentral
BNE MOSTLYDONE ; Branch to line 198
JSL $02A9DE ; ?? Thank smwcentral
BMI MOSTLYDONE ; Branch to line 198
LDA #$01 ; State
STA $14C8,y ; Store state
LDA #$80 ; Key
STA $009E,y ; Store keyhole
LDA $94 ; Mario x-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00E4,y ; Store x-Pos
LDA $95 ; Marios x-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14E0,y ; Store x-Pos (low)
LDA $96 ; Marios y-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00D8,y ; Store y-Pos
LDA $97 ; Marios y-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14D4,y ; Store y-Pos (low)
PHX ; Push
TYX ; Transfer
JSL $07F7D2 ; Jump to ??? routine
PLX ; Pull
RTL ; Return
Exit: ; Classified on line 214
LDA $186C,x ; ?? Thank smwcentral
BNE PRETTYMUCHDONE ; Branch to line 301
JSL $02A9DE ; ?? Thank smwcentral
BMI PRETTYMUCHDONE ; Branch to line 301
LDA #$01 ; State
STA $14C8,y ; Store state
LDA #$7B ; Exit
STA $009E,y ; Store keyhole
LDA $94 ; Mario x-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00E4,y ; Store x-Pos
LDA $95 ; Marios x-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14E0,y ; Store x-Pos (low)
LDA $96 ; Marios y-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00D8,y ; Store y-Pos
LDA $97 ; Marios y-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14D4,y ; Store y-Pos (low)
PHX ; Push
TYX ; Transfer
JSL $07F7D2 ; Jump to ??? routine
PLX ; Pull
RTL ; Return

PRETTYMUCHDONE: ; shittyerrors
JMP DONE ; shittyerrors
RTL ; shittyerrors

RealSpawnYoshi: ; Classified on line 162
LDA $16 ; Buttons pressed current frame 
AND #$40 ; Y Button
BNE Yoshi ; Branch to line 310
RTL ; Return
Yoshi: ; Classified on line 308
LDA $186C,x ; ?? Thank smwcentral
BNE PRETTYMUCHDONE ; Branch to line 301
JSL $02A9DE ; ?? Thank smwcentral
BMI PRETTYMUCHDONE ; Branch to line 301
LDA #$01 ; State
STA $14C8,y ; Store state
LDA #$35 ; Yoshi
STA $009E,y ; Store keyhole
LDA $94 ; Mario x-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00E4,y ; Store x-Pos
LDA $95 ; Marios x-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14E0,y ; Store x-Pos (low)
LDA $96 ; Marios y-Pos
STA $00D8,y ; Store y-Pos
LDA $97 ; Marios y-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14D4,y ; Store y-Pos (low)
PHX ; Push
TYX ; Transfer
JSL $07F7D2 ; Jump to ??? routine
PLX ; Pull
RTL ; Return

MoreMoreCheats: ; Classified on line 165
LDA $DBF ; Player coins
CMP #$08 ; If 05
BEQ VineMagic ; Branch to line
LDA $DBF ; Player coins
CMP #$09 ; If 09 .
BEQ Cloud ; Branch to line
RTL ; Return

Cloud: ; Classified on line 343
LDA $16 ; Buttons pressed current frame 
AND #$08 ; Up Button
BNE CCloud ; Branch to line 351
RTL ; Return
CCloud: ; Classified on line 349
JMP MainCloudCode ; Jump to line 392
RTL ; Return

SHORTCUT: ;shiterrors
JMP DONE ;shiterrors
RTL ;shiterrors

VineMagic: ; Classified on line 340
LDA $16 ; Buttons pressed current frame 
AND #$40 ; Y Button
BNE Vine ; Branch to line 364
RTL ; Return
Vine:
LDA $186C,x ; ?? Thank smwcentral
BNE SHORTCUT ; Branch to line 355
JSL $02A9DE ; ?? Thank smwcentral
BMI SHORTCUT ; Branch to line 355
LDA #$01 ; State
STA $14C8,y ; Store state
LDA #$79 ; Growing Vine
STA $009E,y ; Store keyhole
LDA $94 ; Mario x-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00E4,y ; Store x-Pos
LDA $95 ; Marios x-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14E0,y ; Store x-Pos (low)
LDA $96 ; Marios y-Pos
CLC ; Add 10
ADC #$10 ; Add 10
STA $00D8,y ; Store y-Pos
LDA $97 ; Marios y-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14D4,y ; Store y-Pos (low)
PHX ; Push
TYX ; Transfer
JSL $07F7D2 ; Jump to ??? routine
PLX ; Pull
RTL ; Return

MainCloudCode: ; Classified on line 352
LDA $186C,x ; ?? Thank smwcentral
BNE SHORTCUT ; Branch to line 355
JSL $02A9DE ; ?? Thank smwcentral
BMI SHORTCUT ; Branch to line 355
LDA #$01 ; State
STA $14C8,y ; Store state
LDA #$87 ; Cloud
STA $009E,y ; Store keyhole
LDA $94 ; Mario x-Pos
STA $00E4,y ; Store x-Pos
LDA $95 ; Marios x-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14E0,y ; Store x-Pos (low)
LDA $96 ; Marios y-Pos
CLC ; Add 10
ADC #$05 ; Add 10
STA $00D8,y ; Store y-Pos
LDA $97 ; Marios y-Pos (low)
ADC #$00 ; Add 0 (low)
STA $14D4,y ; Store y-Pos (low)
PHX ; Push
TYX ; Transfer
JSL $07F7D2 ; Jump to ??? routine
PLX ; Pull
RTL ; Return

DONE: ; Classified on line
JSL $0586F1 ; Original code
RTL ; Return
