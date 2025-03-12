## How to test

Place a program on EEPROM (or an emulator), and use the IO pins.

Example 0 is a short and a good place to start.

The file [examples/prog0.vslc](examples/prog0.vslc) is:

    PUSH i0
    DUP
    POP o0
    NOT
    PUSH o1

This program begins by taking the value of input 0 at the last positive
edge of the scan cycle clock and placing it on the stack.

    top of stack: [i0](i0)

It then duplicates that value.

    top of stack: [i0](i0) [i0](i0)

followd by popping one instance from the top of the stack and placing it
in the output 0 register.

    top of stack: [i0](i0)

The top of the stack is then inverted.

    top of stack: /[i0](i0)

Finally, that value is popped to output register 1.

If `o0` and `01` were attached to active-high LEDs and `i0` attached to an
active high momentary button, one LED would be on when the button isn't
pressed. Once the button is pressed, that LED turns off and the other turns
on. When the button is let go, the lights toggle.

To assemble the source code, we can run `./vslcc examples/prog0.vslc` and
get the output:

    line_num=1 line='PUSH i0'
      cur_addr=00 => PUSH I0 => 00(00000000)
    line_num=2 line='DUP'
      cur_addr=01 => DUP => b5(10110101)
    line_num=3 line='POP o0'
      cur_addr=02 => POP O0 => 18(00011000)
    line_num=4 line='NOT'
      cur_addr=03 => NOT => 8a(10001010)
    line_num=5 line='PUSH o1'
      cur_addr=04 => PUSH O1 => 09(00001001)
    cur_addr=9
    start_addr=b'\x00\x04' end_addr=b'\x00\x08'

The compiler/assembler generates `examples/prog0.eeprom.bin`. Checking that
it exists with `ls -l examples/prog0.eeprom.bin`

    -rw-rw-r-- 1 jim jim 1024 Feb 13 20:28 examples/prog0.eeprom.bin

shows us that the file is 1kB (8kb) in size! The compiler generates a file
adequate for a 8kb EEPROM, and pads the rest of the file with `0xff`.

We can then look at the generated 
output with `xxd examples/prog0.eeprom.bin| head -n 2`

    00000000: 0004 0008 00b5 188a 09ff ffff ffff ffff  ................
    00000010: ffff ffff ffff ffff ffff ffff ffff ffff  ................

we see the padded `0xff`s. The actual program also seems to be 4 bytes
longer than we would expect, as our program is 5 instructions long. The
first 16-bits are the start address for a new cycle. The second 16-bits
are the last valid program address, after which a new cycle should be
started.

There is also a disassembler. We can try
`./vslcd examples/prog0.eeprom.bin` and get

    ; starting address is the default
    ; .start 4
    PUSH i0
    DUP
    POP o1
    NOT
    PUSH o2
    ; ending address is the default
    ; .end 8

Nothing too exciting.

Once we start the controller, it will cycle the EEPROM chip select,
start a scan cycle which will latch the input,
send a read command (0x03) for address 0x0000, read the starting address of
0x0004, then the end address of 0x0008 then the end address of 0x0008.
It will then begin executing the next byte it receives. It will continue
to send the SPI clock and expect bytes in return. Once it has executed
the instruction at the ending address, the EEPROM chip select is cycled
and a new scan cycle is started which latches the input. The controller
will then send the read command (0x03) for address 0x0004 and begin
execution at the first byte it receives. This will continue until the
controller is powered down.
