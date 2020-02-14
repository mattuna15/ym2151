10 REM THIS PROGRAM IS PART 3 OF THE YM2151 TUTORIAL.

REM CHANNEL 0 MODULATOR 1 ATTACK RATE
100 POKE $9FE0, $80: POKE $9FE1, $1F

REM CHANNEL 0 MODULATOR 1 FIRST DECAY RATE
110 POKE $9FE0, $A0: POKE $9FE1, $0A

REM CHANNEL 0 MODULATOR 1 FIRST DECAY LEVEL, RELEASE RATE
120 POKE $9FE0, $E0: POKE $9FE1, $FF


REM CHANNEL 0 CARRIER 1 ATTACK RATE
200 POKE $9FE0, $88: POKE $9FE1, $1F

REM CHANNEL 0 CARRIER 1 FIRST DECAY RATE
210 POKE $9FE0, $A8: POKE $9FE1, $0A

REM CHANNEL 0 CARRIER 1 FIRST DECAY LEVEL, RELEASE RATE
220 POKE $9FE0, $E8: POKE $9FE1, $FF


REM CHANNEL 0 CONNECTION, M1 FEEDBACK
300 POKE $9FE0, $20: POKE $9FE1, $D6

REM CHANNEL 0 KEY CODE (E5)
310 POKE $9FE0, $28: POKE $9FE1, $54

REM CHANNEL 0 KEY ON
320 POKE $9FE0, $08: POKE $9FE1, $78


