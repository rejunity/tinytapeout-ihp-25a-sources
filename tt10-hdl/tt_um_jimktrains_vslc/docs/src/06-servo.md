## Servo

The servo timer is designed to produce a 50Hz with a duty-cycle between
5% and 13% or pulse-length of between 1ms and 2.6ms. The servo can be set to
one of two positions based on the value of the servo's value SFR. Due to space
constraints, only the set value (i.e. when the servo's value is 1) can be
changed. The reset value is fixed at 11 (1ms pulse). The set value can be
set to any value up to 31 (2.6ms pulse). The default set value is 23 (1.9ms
pulse).  Servos typically accept between 1ms and 2ms to go from 0&deg; and
180&deg;. Practically, this leaves 12 steps (of 15&deg; each) between the
servo's home position and max rotation.

The servo's output is always available on `uio_out[6]`;

### SFR

* 0x2 Servo Enable - Turns the servo counter on when set.
* 0x3 Servo Value - Place the servo at either its set or reset position.
* 0x4 Servo Output - The output of the timer. (Even when the servo is disabled.) This is available to the program.

### Parameter
* 0x4 Servo0 Clock Divider (Not Implemented)
* 0x5 Servo0 Frequency Value (Not Implemented)
* 0x6 Servo0 Reset Value (Not Implemented)
* 0x7 Servo0 Set Value (4 bits)
