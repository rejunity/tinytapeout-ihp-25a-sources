v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 460 -390 460 -360 {lab=#net1}
N 460 -360 640 -360 {lab=#net1}
N 460 -360 460 -330 {lab=#net1}
N 440 -300 440 -270 {lab=Vss}
N 440 -270 460 -270 {lab=Vss}
N 300 -420 420 -420 {lab=#net2}
N 260 -390 260 -260 {lab=#net2}
N 260 -360 320 -360 {lab=#net2}
N 320 -420 320 -360 {lab=#net2}
N 300 -230 680 -230 {lab=Vout}
N 680 -330 680 -230 {lab=Vout}
N 680 -230 730 -230 {lab=Vout}
N 260 -200 260 -180 {lab=Vss}
N 460 -270 460 -250 {lab=Vss}
N 260 -470 260 -450 {lab=Vdd}
N 460 -470 460 -450 {lab=Vdd}
N 680 -410 680 -390 {lab=Vdd}
N 460 -250 460 -180 {lab=Vss}
N 260 -180 460 -180 {lab=Vss}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 280 -420 2 0 {name=M10
L=0.7
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 440 -420 0 0 {name=M1
L=0.7
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 660 -360 0 0 {name=M2
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 280 -230 2 0 {name=M3
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 460 -300 0 0 {name=R10
W=.35
L=17.5
model=res_xhigh_po_0p35
spiceprefix=X
 mult=1}
C {ipin.sym} 60 -400 0 0 {name=p1 lab=Vdd}
C {ipin.sym} 55 -370 0 0 {name=p2 lab=Vss}
C {opin.sym} 35 -340 0 0 {name=p3 lab=Vout}
C {lab_wire.sym} 730 -230 0 0 {name=p4 sig_type=std_logic lab=Vout}
C {lab_wire.sym} 680 -410 0 0 {name=p5 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 260 -180 0 0 {name=p7 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 460 -470 0 0 {name=p9 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 260 -470 0 0 {name=p10 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 260 -420 0 0 {name=p8 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 460 -420 2 0 {name=p11 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 680 -360 2 0 {name=p12 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 260 -230 0 0 {name=p13 sig_type=std_logic lab=Vss}
