v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 360 -370 360 -220 {lab=Vss}
N 360 -160 360 -120 {lab=Vss}
N 580 -120 580 -80 {lab=Vss}
N 580 -220 580 -180 {lab=Vss}
N 580 -330 580 -280 {lab=#net1}
N 400 -400 540 -400 {lab=Vss}
N 360 -320 430 -320 {lab=Vss}
N 430 -400 430 -320 {lab=Vss}
N 360 -530 360 -430 {lab=#net2}
N 580 -530 580 -430 {lab=Vbiasp}
N 400 -560 540 -560 {lab=Vbiasp}
N 360 -630 360 -590 {lab=Vdd}
N 580 -630 580 -590 {lab=Vdd}
N 500 -560 500 -500 {lab=Vbiasp}
N 500 -500 580 -500 {lab=Vbiasp}
N 360 -220 360 -160 {lab=Vss}
N 580 -180 580 -120 {lab=Vss}
N 350 -400 360 -400 {lab=Vss}
N 350 -400 350 -370 {lab=Vss}
N 350 -370 360 -370 {lab=Vss}
N 580 -400 590 -400 {lab=#net1}
N 590 -400 590 -370 {lab=#net1}
N 580 -370 590 -370 {lab=#net1}
N 560 -250 560 -220 {lab=Vss}
N 560 -220 580 -220 {lab=Vss}
N 580 -560 590 -560 {lab=Vdd}
N 590 -590 590 -560 {lab=Vdd}
N 580 -590 590 -590 {lab=Vdd}
N 580 -370 580 -330 {lab=#net1}
N 430 -320 820 -320 {lab=Vss}
N 580 -500 820 -500 {lab=Vbiasp}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 560 -560 0 0 {name=M10
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 380 -400 2 0 {name=M1
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 580 -250 0 0 {name=R10
W=0.35
L=1
model=res_xhigh_po_0p35
spiceprefix=X
 mult=1}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 380 -560 2 0 {name=M2
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 560 -400 0 0 {name=M3
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {ipin.sym} -140 -430 0 0 {name=p1 lab=Vdd}
C {ipin.sym} -140 -400 0 0 {name=p2 lab=Vss}
C {lab_wire.sym} 360 -560 2 1 {name=p3 sig_type=std_logic lab=Vdd}
C {opin.sym} -140 -370 0 0 {name=p4 lab=Vbiasp}
C {lab_wire.sym} 360 -120 2 1 {name=p8 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 580 -80 2 1 {name=p9 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 360 -630 0 1 {name=p10 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 580 -630 0 1 {name=p11 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 820 -500 0 1 {name=p12 sig_type=std_logic lab=Vbiasp}
C {lab_wire.sym} 560 -250 2 1 {name=p13 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 820 -320 0 1 {name=p5 sig_type=std_logic lab=Vbiasn}
C {opin.sym} -140 -340 0 0 {name=p6 lab=Vbiasn}
