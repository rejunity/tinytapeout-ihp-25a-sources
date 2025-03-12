v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 350 -490 350 -450 {lab=Vdd}
N 350 -260 350 -250 {lab=Vss}
N 350 -250 350 -240 {lab=Vss}
N 350 -420 360 -420 {lab=Vdd}
N 350 -290 360 -290 {lab=Vss}
N 360 -290 360 -260 {lab=Vss}
N 350 -260 360 -260 {lab=Vss}
N 360 -450 360 -420 {lab=Vdd}
N 350 -450 360 -450 {lab=Vdd}
N 350 -390 350 -320 {lab=Out}
N 350 -350 390 -350 {lab=Out}
N 310 -420 310 -290 {lab=In}
N 280 -350 310 -350 {lab=In}
C {ipin.sym} -110 -340 0 0 {name=p1 lab=Vdd}
C {ipin.sym} -110 -310 0 0 {name=p2 lab=Vss}
C {opin.sym} -110 -280 0 0 {name=p4 lab=Out}
C {ipin.sym} -100 -250 0 0 {name=p3 lab=In}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 330 -420 0 0 {name=M5
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 330 -290 0 0 {name=M1
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_wire.sym} 390 -350 0 1 {name=p10 sig_type=std_logic lab=Out}
C {lab_wire.sym} 280 -350 0 0 {name=p12 sig_type=std_logic lab=In}
C {lab_wire.sym} 350 -490 0 1 {name=p9 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 350 -240 2 0 {name=p7 sig_type=std_logic lab=Vss}
