import pyrtl

pix_x = pyrtl.Input(10, 'pix_x')
pix_y = pyrtl.Input(10, 'pix_y')
counter = pyrtl.Input(10, 'counter')
switches = pyrtl.Input(8, 'switches')
below = pyrtl.Input(6, 'below')
above = pyrtl.Output(6, 'above')

layer_x = pyrtl.WireVector(10, 'layer_x')
layer_y = pyrtl.WireVector(10, 'layer_y')
layer_sel = pyrtl.WireVector(1, 'layer_sel')
layer_color = pyrtl.WireVector(6, 'layer_color')

layer_x <<= pix_x + counter*2
layer_y <<= pix_y + pyrtl.shift_right_arithmetic(counter, 2)
layer_sel <<= layer_x[5] ^ layer_y[5]
layer_color <<= pyrtl.concat(switches[7], switches[2], switches[7], switches[1], switches[7], switches[0])

with pyrtl.conditional_assignment:
    with layer_sel:
        above |= layer_color
    with pyrtl.otherwise:
        above |= below

# patch output to rename the toplevel module
import io
vsio = io.StringIO()
pyrtl.output_to_verilog(vsio, add_reset=False)
verilog = vsio.getvalue().replace('toplevel', 'layer_d')
open('layer_d.v', 'w').write(verilog)
