## Timer

Due to space constraints, the timer will only output a 50% duty cycle
signal and has a period of 366 timer-ticks long. The clock divider for
the timer can be adjusted from 0 (input clock) to 16
(input clock / 2<sup>16</sup>). At 12MHz, the default clock divider of 14
cycles the timer at 2Hz.

The timer's output is always avaiable on `uio_out[4]`. The complement is
available on `uio_out[5]`. There is a cycle of dead-time inserted between
transitions.

### SFR

* 0x00 Timer Enable - When set the timer will count
* 0x01 Timer Output - The current output of the timer (even when disabled). This is available to the program.

### Parameters

* 0x1 Timer0 Clock Divider (4 bits)
* 0x2 Timer0 Counter A (Not Implemented)
* 0x3 Timer0 Counter B (Not Implemented)
