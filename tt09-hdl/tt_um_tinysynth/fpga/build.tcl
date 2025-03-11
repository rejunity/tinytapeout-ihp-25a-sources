# read design sources (add one line for each file)
read_verilog -v "../src/ChiselTop.v"

# read constraints
read_xdc "arty-s7.xdc"

# synth
synth_design -top "ChiselTop" -part "xc7s25csga324-1"

# place and route
opt_design
place_design
route_design

# write bitstream
write_bitstream -force "hello.bit"