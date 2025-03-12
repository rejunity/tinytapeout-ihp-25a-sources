from amaranth import Module, Signal, Cat
from amaranth.back import verilog

m = Module()

# inputs
pix_x = Signal(10)
pix_y = Signal(10)
counter = Signal(10)
switches = Signal(8)
below = Signal(6)

# outputs
above = Signal(6)

# wires
layer_x = Signal(10)
layer_y = Signal(10)
layer_sel = Signal()
layer_color = Signal(6)

# continuous assignments
m.d.comb += [
  layer_x.eq(pix_x + counter*16),
  layer_y.eq(pix_y + counter*2),
  layer_sel.eq((layer_x[8] ^ layer_y[8]) & (pix_y[1] ^ pix_x[0])),
  layer_color.eq(Cat(switches[0], switches[6], switches[1], switches[6], switches[2], switches[6])),
]

# combinational always block
with m.If(layer_sel):
    m.d.comb += above.eq(layer_color)
with m.Else():
    m.d.comb += above.eq(below)

# generate Verilog
with open("layer_a.v", "w") as f:
    f.write(verilog.convert(m, name="layer_a", ports=[pix_x, pix_y, counter, switches, below, above]))

