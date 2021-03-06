# The YM2151 regsiter interface

| Address |  Bits  | Function | Description       |
| ------- | ------ | -------- | ----------------- |
|  $01    |   1    | Vibrato  | LFO reset         |
|  $08    |  2-0   | Key      | Channel select    |
|         |   3    |          | Carrier 2         |
|         |   4    |          | Modulator 2       |
|         |   5    |          | Carrier 1         |
|         |   6    |          | Modulator 1       |
|  $0F    |   7    | Noise    | NE                |
|         |  4-0   |          | Noise frequency   |
|  $11    |  7-0   | General  | Timer A1          |
|  $12    |  1-0   | General  | Timer A2          |
|  $13    |  7-0   | General  | Timer B           |
|  $14    |   7    | General  | CSM               |
|         |  5-4   |          | F Reset           |
|         |  3-2   |          | IRQ Enable        |
|         |  1-0   |          | Load              |
|  $18    |  7-0   | Vibrato  | LFO frequency     |
|  $19    |   7    | Vibrato  | Select            |
|         |  6-0   |          | Modulation depth  |
|  $1B    |   7    | General  | CT2               |
|         |   6    | General  | CT1               |
|         |  1-0   | Vibrato  | LFO waveform      |
|  $20    |   7    | General  | Right             |
|         |   6    | General  | Left              |
|         |  5-3   | General  | FB                |
|         |  2-0   | General  | Connect           |
| $28-$2F |  6-4   | Key      | Octave            |
|         |  3-0   | Key      | Note              |
| $30-$37 |  7-2   | Key      | Fraction          |
| $38-$3F |  6-4   | Waveform | PMS               |
|         |  1-0   |          | AMS               |
| $40-$5F |  6-4   | Waveform | Detune1           |
|         |  3-0   | Waveform | Phase Multiply    |
| $60-$7F |  6-0   | Envelope | Total level       |
| $80-$9F |  7-6   | Waveform | Key Scale         |
|         |  4-0   | Envelope | Attack Rate       |
| $A0-$BF |   7    | Waveform | AM sensitivity    |
|         |  4-0   | Envelope | First Decay Rate  |
| $C0-$DF |  7-6   | Waveform | Detune2           |
|         |  3-0   | Envelope | Second Decay Rate |
| $E0-$FF |  7-4   | Envelope | First Decay Level |
|         |  3-0   | Envelope | Release Rate      |


