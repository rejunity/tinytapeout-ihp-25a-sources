v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 1630 -740 2430 -340 {flags=graph


ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1

x2=10.5251612e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=0
color=4
node=in

x1=0.474839e-07
y1=1.6
y2=2}
B 2 1630 -1190 2430 -790 {flags=graph


ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.474839e-07

divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=0






sim_type=tran
autoload=1
mode=Line
legend=1
digital=0
rainbow=0

x2=10.5251612e-07
y2=-300e-6



color=7
node=i(e1)
y1=-470e-6}
N 1470 -410 1470 -390 {lab=GND}
N 1450 -440 1450 -410 {lab=GND}
N 1450 -410 1470 -410 {lab=GND}
N 880 -470 1080 -470 {lab=in}
N 880 -450 1080 -450 {lab=GND}
N 1380 -470 1470 -470 {lab=out}
C {devices/launcher.sym} 310 -300 0 0 {name=h2 
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"}
C {devices/code_shown.sym} 130 -920 0 0 {name=NGSPICE
only_toplevel=true


value="
.param Vdd = 1.8V
.param V60Hz = 0.1

*V_PS_DC in GND \{Vdd\} DC 
*V_PS_ripple in GND SIN(time*2*pi*1e6) 

.control

*op
tran 10n 1u

write tb_ptat.raw

.endc
"}
C {devices/lab_wire.sym} 880 -470 0 0 {name=l3 lab=in}
C {devices/gnd.sym} 880 -450 0 0 {name=l1 lab=GND}
C {devices/lab_wire.sym} 1440 -470 0 0 {name=l4 lab=out
}
C {devices/launcher.sym} 510 -300 0 0 {name=h5
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_ptat.raw tran"
}
C {devices/code.sym} 240 -530 0 0 {name=TT_MODELS
only_toplevel=true
corner=tt
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"
spice_ignore=false}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1470 -440 0 0 {name=R10
W=0.35
L=0.175
model=res_xhigh_po_0p35
spiceprefix=X
 mult=1}
C {devices/gnd.sym} 1470 -390 0 0 {name=l2 lab=GND}
C {vsource_arith.sym} 710 -670 0 0 {name=E1 VOL=1.8+(0.1*1.8*SIN(time*2*pi*1e6))}
C {devices/lab_wire.sym} 710 -700 0 0 {name=l5 lab=in}
C {devices/gnd.sym} 710 -640 0 0 {name=l6 lab=GND}
C {subckt/PTAT_wulff.sym} 1230 -460 0 0 {name=x1}
