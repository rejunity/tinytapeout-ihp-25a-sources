# Makefile for GHDL VHDL simulation

# Variables

#Package for pnr
PACKAGE = qn84


WORKDIR = bld
SRC_DIR = vhdlsrc
TB_WAVE = tb.ghw
TOP_MODULE = tt_um_tobimckellar_top
TB_MODULE = tb_tt_um_tobimckellar_top

# Create build directory if it doesn't exist
$(WORKDIR):
	mkdir -p $(WORKDIR)

# Analyze VHDL source files
analyze: $(WORKDIR)
	ghdl -a --workdir=$(WORKDIR) $(SRC_DIR)/$(TOP_MODULE).vhd
	ghdl -a --workdir=$(WORKDIR) $(SRC_DIR)/$(TOP_MODULE)_tb.vhd

# Elaborate the testbench
elaborate: analyze
	ghdl -e --workdir=$(WORKDIR) $(TB_MODULE)

# Run simulation and generate waveform file
run: elaborate
	ghdl -r --workdir=$(WORKDIR) $(TB_MODULE) --wave=$(TB_WAVE)

# Run simulation and generate waveform file
view:
	gtkwave $(TB_WAVE)

transpile:
	ghdl --synth --out=verilog --workdir=bld $(TOP_MODULE) > bld/$(TOP_MODULE).v;\

synthesise:
	cd bld;\
	yosys -p "synth_ice40 -top tt_um_tobimckellar_top; write_json ../bld/tt_um_tobimckellar_top.json" ../src/tt_um_tobimckellar_top.v;\
	nextpnr-ice40 --lp1k --package $(PACKAGE) --json ../bld/tt_um_tobimckellar_top.json --pcf ../fpga/pinmap.pcf --pcf-allow-unconstrained --asc tt_um_tobimckellar_top.asc;\
	icepack -v tt_um_tobimckellar_top.asc tt_um_tobimckellar_top.bin;\
	iceburn -e -v -w tt_um_tobimckellar_top.bin;\

# Clean up generated files
clean:
	rm -rf $(WORKDIR) *.ghw *.o *.cf

# Default target
all: run
