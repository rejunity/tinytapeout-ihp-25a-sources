from myhdl import Signal, intbv, block, always_comb, concat, instances

pix_x = Signal(intbv(0)[10:])
pix_y = Signal(intbv(0)[10:])
counter = Signal(intbv(0)[10:])
switches = Signal(intbv(0)[8:])
below = Signal(intbv(0)[6:])
above = Signal(intbv(0)[6:])

@block
def layer_b(pix_x, pix_y, counter, switches, below, above):

    layer_x = Signal(intbv(0)[10:])
    layer_y = Signal(intbv(0)[10:])
    layer_sel = Signal(bool(0))
    layer_color = Signal(intbv(0)[6:])

    @always_comb
    def func():
        layer_x.next = pix_x + counter*7
        layer_y.next = pix_y + counter + counter//2;
        layer_sel.next = (layer_x[7] ^ layer_y[7]) & (~pix_y[0] ^ pix_x[1])
        layer_color.next = concat(switches[5], not switches[2], switches[4], not switches[1], switches[3], not switches[0])
        if layer_sel:
            above.next = layer_color
        else:
            above.next = below

    return instances()

inst = layer_b(pix_x, pix_y, counter, switches, below, above)
inst.convert(hdl='Verilog')
