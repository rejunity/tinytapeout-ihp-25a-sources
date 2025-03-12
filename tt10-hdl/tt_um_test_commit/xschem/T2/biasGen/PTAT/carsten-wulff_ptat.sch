v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 260 -350 260 -200 {lab=Vss}
N 260 -140 260 -100 {lab=Vss}
N 480 -140 480 -100 {lab=Vss}
N 480 -240 480 -200 {lab=Vss}
N 480 -350 480 -300 {lab=#net1}
N 300 -380 440 -380 {lab=Vss}
N 260 -300 330 -300 {lab=Vss}
N 330 -380 330 -300 {lab=Vss}
N 260 -510 260 -410 {lab=#net2}
N 480 -510 480 -410 {lab=Iptat}
N 300 -540 440 -540 {lab=Iptat}
N 260 -610 260 -570 {lab=Vdd}
N 480 -610 480 -570 {lab=Vdd}
N 400 -540 400 -480 {lab=Iptat}
N 400 -480 480 -480 {lab=Iptat}
N 440 -540 440 -530 {lab=Iptat}
N 440 -530 600 -530 {lab=Iptat}
N 260 -200 260 -140 {lab=Vss}
N 480 -200 480 -140 {lab=Vss}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 460 -540 0 0 {name=M10
L=0.35
W=4
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 280 -380 2 0 {name=M1
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 480 -270 0 0 {name=R10
W=0.35
L=0.35
model=res_xhigh_po_0p35
spiceprefix=X
 mult=1}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 280 -540 2 0 {name=M2
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 460 -380 0 0 {name=M3
L=0.15
W=4
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {ipin.sym} -140 -430 0 0 {name=p1 lab=Vdd}
C {ipin.sym} -140 -400 0 0 {name=p2 lab=Vss}
C {lab_wire.sym} 260 -540 2 1 {name=p3 sig_type=std_logic lab=Vdd}
C {opin.sym} -140 -370 0 0 {name=p4 lab=Iptat}
C {lab_wire.sym} 260 -380 2 1 {name=p5 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 480 -380 0 1 {name=p7 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 260 -100 2 1 {name=p8 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 480 -100 2 1 {name=p9 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 260 -610 0 1 {name=p10 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 480 -610 0 1 {name=p11 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 600 -530 0 1 {name=p12 sig_type=std_logic lab=Iptat}
C {lab_wire.sym} 460 -270 2 1 {name=p13 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 480 -540 0 1 {name=p6 sig_type=std_logic lab=Vdd}
