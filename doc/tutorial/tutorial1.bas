10 REM THIS PROGRAM IS PART 1 OF THE YM2151 TUTORIAL.

REM CHANNEL 0 MODULATOR 1 ATTACK RATE
100 POKE $9FE0, $80: POKE $9FE1, $1F

REM CHANNEL 0 MODULATOR 1 RELEASE RATE
110 POKE $9FE0, $E0: POKE $9FE1, $0F


REM CHANNEL 0 CONNECTION
300 POKE $9FE0, $20: POKE $9FE1, $C7

REM CHANNEL 0 KEY CODE (E5)
310 POKE $9FE0, $28: POKE $9FE1, $54

REM CHANNEL 0 KEY ON
320 POKE $9FE0, $08: POKE $9FE1, $78

