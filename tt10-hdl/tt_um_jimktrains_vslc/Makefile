PROJ=tt_um_jimktrains_vslc
SUBDIRPROJ=build/icebreaker/$(PROJ)
SRC_DIR=src

IBTOP=tt_um_jimktrains_vslc_icebreaker

COMPILE_ARGS 		+= -I$(SRC_DIR)

PCF=src/icebreaker.pcf

PROJECT_SOURCES = $(SRC_DIR)/tt_um_jimktrains_vslc_icebreaker.v \
                  $(SRC_DIR)/tt_um_jimktrains_vslc_core.v \
									$(SRC_DIR)/tt_um_jimktrains_vslc_eeprom_reader.v \
									$(SRC_DIR)/tt_um_jimktrains_vslc_executor.v \
									$(SRC_DIR)/tt_um_jimktrains_vslc_timer.v \
									$(SRC_DIR)/tt_um_jimktrains_vslc_servo.v \
									$(SRC_DIR)/tt_um_jimktrains_vslc.v


runs/wokwi/final/pnl/tt_um_jimktrains_vslc.pnl.v: $(PROJECT_SOURCES)
	tt/tt_tool.py --create-user-config
	tt/tt_tool.py --harden --openlane2
	tt/tt_tool.py --create-png --create-svg
	rm *_preview*
	./summary.sh

harden: runs/wokwi/final/pnl/tt_um_jimktrains_vslc.pnl.v

test-gates: runs/wokwi/final/pnl/tt_um_jimktrains_vslc.pnl.v
	cp runs/wokwi/final/pnl/tt_um_jimktrains_vslc.pnl.v test/gate_level_netlist.v
	cd test; make -B GATES=yes

test:
	cd test; make -B

summary: runs/wokwi/final/pnl/tt_um_jimktrains_vslc.pnl.v
	./summary.sh


icebreaker: $(SUBDIRPROJ).rpt $(SUBDIRPROJ).bin

icebreaker-prog: $(SUBDIRPROJ).bin
	iceprog $<

ib: icebreaker
ibp: icebreaker-prog

$(SUBDIRPROJ).json: $(PROJECT_SOURCES)
	yosys -ql $(SUBDIRPROJ).yslog -p 'synth_ice40 -top $(IBTOP) -json $@' $^

$(SUBDIRPROJ).asc: $(SUBDIRPROJ).json
	nextpnr-ice40 -ql $(SUBDIRPROJ).nplog --up5k --package sg48 --freq 12 --asc $@ --pcf $(PCF) --json $^

$(SUBDIRPROJ).bin: $(SUBDIRPROJ).asc
	icepack $< $@

$(SUBDIRPROJ).rpt: $(SUBDIRPROJ).asc
	icetime -d up5k -c 12 -mtr $@ $^

$(SUBDIRPROJ)_tb: $(SUBDIRPROJ)_tb.v $(SUBDIRPROJ).v
	iverilog -o $@ $^

$(SUBDIRPROJ)_tb.vcd: $(SUBDIRPROJ)_tb
	vvp -N $< +vcd=$@

$(SUBDIRPROJ)_syn.v: $(SUBDIRPROJ).json
	yosys -p 'read_json $^; write_verilog $@'

$(SUBDIRPROJ)_syntb: $(SUBDIRPROJ)_tb.v $(SUBDIRPROJ)_syn.v
	iverilog -o $@ $^ `yosys-config --datdir/ice40/cells_sim.v`

$(SUBDIRPROJ)_syntb.vcd: $(SUBDIRPROJ)_syntb
	vvp -N $< +vcd=$@


clean:
	rm -f $(SUBDIRPROJ)*

write-eeprom:
	minipro -p 25LC080D -w examples/prog1.eeprom.bin

.PHONY: test harden clean

artwork: art/my_logo_49.png macros/my_logo.gds macros/my_logo.lef

macros/my_logo.gds: art/my_logo_49.png
	./art/make_gds.py

macros/my_logo.lef: macros/my_logo.gds
	cd macros && cat ../art/make_lef.tcl | magic -rcfile /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc -noconsole
