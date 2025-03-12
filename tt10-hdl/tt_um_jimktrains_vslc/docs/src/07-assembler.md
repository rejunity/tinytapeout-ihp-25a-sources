## Assembler

The compiler will generate a 1kB `.eeprom.bin` containing the code, and
a `.final.vslc` with the post-processed code.

### Comments

Anything after a semicolon, `;` on a line will be ignored.

### .define

    .define alias original

Allows aliasing values and register names.

#### Example

    .define leftsensor i0
    push leftsensor

is equivilent to

    push i0

### .logic

Allows writing propositional logic statments that will compile to
assembly. Parentheses, `(` and `)`, logical-and `&`, logical-or `|`, xor
`^`, and logical-not `~` are supported. Other values are assumed to be
register names and may be aliased via a `.define`.

#### Example

See [examples/prog2.vslc](examples/prog2.vslc) and [examples/prog2.final.vslc](examples/prog2.final.vslc) for an example
of implementing a counter and 7-segment decoder.

    .define segC o2
    
    .define t0 s6
    .define t1 s7
    .define t2 s8
    .define t3 s9

    .logic (~t3 & t2) | (t3 & ~t2) | (~t1 & t0) | (~t2 & ~t1) | (~t2 & t0)
     POP segC


will compile to

    PUSH S9
    NOT
    PUSH S8
    AND
    PUSH S9
    PUSH S8
    NOT
    AND
    PUSH S7
    NOT
    PUSH S6
    AND
    PUSH S8
    NOT
    PUSH S7
    NOT
    AND
    PUSH S8
    NOT
    PUSH S6
    AND
    OR
    OR
    OR
    OR
    POP o2
