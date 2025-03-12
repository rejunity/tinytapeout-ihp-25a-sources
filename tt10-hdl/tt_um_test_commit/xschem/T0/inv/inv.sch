v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 320 -360 320 -320 {lab=Out}
N 320 -400 320 -360 {lab=Out}
N 320 -430 330 -430 {lab=pBulk}
N 280 -360 280 -290 {lab=In}
N 240 -360 280 -360 {lab=In}
N 280 -430 280 -360 {lab=In}
N 320 -480 320 -460 {lab=Vdd}
N 320 -290 330 -290 {lab=nBulk}
N 320 -260 320 -240 {lab=Vss}
N 320 -360 360 -360 {lab=Out}
C {ipin.sym} -120 -340 0 0 {name=p1 lab=Vdd}
C {ipin.sym} -120 -320 0 0 {name=p2 lab=Vss}
C {opin.sym} -117.5 -222.5 0 0 {name=p4 lab=Out}
C {ipin.sym} -120 -300 0 0 {name=p3 lab=In}
C {lab_wire.sym} 360 -360 0 1 {name=p10 sig_type=std_logic lab=Out}
C {lab_wire.sym} 240 -360 0 0 {name=p12 sig_type=std_logic lab=In}
C {lab_wire.sym} 320 -480 0 1 {name=p9 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 320 -240 2 0 {name=p7 sig_type=std_logic lab=Vss}
C {sky130_fd_pr/nfet_01v8.sym} 300 -290 0 0 {name=M1
L=0.15
W=1  
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 300 -430 0 0 {name=M2
L=0.15
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 330 -290 0 1 {name=p5 sig_type=std_logic lab=nBulk}
C {lab_wire.sym} 330 -430 0 1 {name=p6 sig_type=std_logic lab=pBulk}
C {ipin.sym} -120 -277.5 0 0 {name=p8 lab=nBulk}
C {ipin.sym} -117.5 -257.5 0 0 {name=p11 lab=pBulk}
