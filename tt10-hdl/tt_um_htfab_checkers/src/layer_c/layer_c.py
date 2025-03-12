from pycde import Input, Output, Module, System
from pycde import generator, circt
from pycde.types import Bits, UInt
from pycde.dialects import comb
from pycde.behavioral import If, EndIf

class LayerC(Module):
    module_name = "layer_c"
    pix_x = Input(UInt(10))
    pix_y = Input(UInt(10))
    counter = Input(UInt(10))
    switches = Input(Bits(8))
    below = Input(Bits(6))
    test = Input(Bits(1))
    above = Output(Bits(6))

    @generator
    def construct(self):
        layer_x = self.pix_x + self.counter*4
        layer_y = self.pix_y + self.counter/2
        layer_sel = layer_x.as_bits(10)[6] ^ layer_y.as_bits(10)[6]
        layer_color = comb.ConcatOp(
            self.switches[2], self.switches[7],
            self.switches[1], self.switches[7],
            self.switches[0], self.switches[7])
        above = self.below
        with If(layer_sel):
            above = layer_color
        EndIf()
        self.above = above

system = System([LayerC], output_directory=".")
system.generate()
system.run_passes()
circt.export_verilog(system.mod, open("layer_c.v", "w"))

