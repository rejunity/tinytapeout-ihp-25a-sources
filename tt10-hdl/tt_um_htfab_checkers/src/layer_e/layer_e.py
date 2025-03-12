from pymtl3 import *
from pymtl3.passes.backends.verilog import *

class LayerE(Component):

    def construct(s):
        s.pix_x = InPort(10)
        s.pix_y = InPort(10)
        s.counter = InPort(10)
        s.switches = InPort(8)
        s.below = InPort(6)
        s.above = OutPort(6)

        s.layer_x = Wire(10)
        s.layer_y = Wire(10)
        s.layer_sel = Wire(1)
        s.layer_color = Wire(6)

        @update
        def comb_logic():
            s.layer_x @= s.pix_x + s.counter/2
            s.layer_y @= s.pix_y + s.counter/6
            s.layer_sel @= (s.layer_x[4] ^ s.layer_y[4]) & (s.pix_y[1] ^ s.pix_x[0])
            s.layer_color @= concat(s.switches[7], s.switches[5], s.switches[7], s.switches[4], s.switches[7], s.switches[3])
            if s.layer_sel:
                s.above @= s.layer_color
            else:
                s.above @= s.below


m = LayerE()
m.elaborate()
m.set_metadata(VerilogTranslationPass.enable, True)
m.set_metadata(VerilogTranslationPass.explicit_module_name, "layer_e")
m.set_metadata(VerilogTranslationPass.explicit_file_name, "layer_e.v")
m.apply(VerilogTranslationPass())
