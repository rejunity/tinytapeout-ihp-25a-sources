v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 230 -190 230 -150 {lab=Vss}
N 230 -150 380 -150 {lab=Vss}
N 380 -150 610 -150 {lab=Vss}
N 380 -240 380 -210 {lab=#net1}
N 610 -240 610 -210 {lab=#net2}
N 420 -180 440 -180 {lab=#net1}
N 440 -220 440 -180 {lab=#net1}
N 380 -220 440 -220 {lab=#net1}
N 440 -220 520 -220 {lab=#net1}
N 520 -220 520 -180 {lab=#net1}
N 520 -180 570 -180 {lab=#net1}
N 550 -270 570 -270 {lab=Vout}
N 550 -300 550 -270 {lab=Vout}
N 550 -300 610 -300 {lab=Vout}
N 610 -340 610 -300 {lab=Vout}
N 610 -440 610 -400 {lab=Vdd}
N 380 -440 380 -300 {lab=Vdd}
N 380 -440 610 -440 {lab=Vdd}
N 420 -320 420 -270 {lab=Vdd}
N 380 -320 420 -320 {lab=Vdd}
N 230 -300 380 -300 {lab=Vdd}
N 230 -300 230 -250 {lab=Vdd}
N 610 -150 740 -150 {lab=Vss}
N 610 -300 730 -300 {lab=Vout}
N 610 -440 720 -440 {lab=Vdd}
N 350 -270 380 -270 {lab=Vss}
N 350 -270 350 -150 {lab=Vss}
N 350 -180 380 -180 {lab=Vss}
N 610 -180 640 -180 {lab=Vss}
N 640 -180 640 -150 {lab=Vss}
N 610 -270 640 -270 {lab=Vss}
N 640 -270 640 -180 {lab=Vss}
C {ipin.sym} 70 -280 0 0 {name=p1 lab=Vdd}
C {ipin.sym} 65 -250 0 0 {name=p2 lab=Vss}
C {opin.sym} 45 -220 0 0 {name=p3 lab=Vout}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 400 -270 2 0 {name=M1
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 400 -180 2 0 {name=M2
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 590 -180 0 0 {name=M3
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 590 -270 0 0 {name=M4
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/cap_mim_m3_1.sym} 610 -370 0 0 {name=C1 model=cap_mim_m3_1 W=1 L=1 MF=1 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 230 -220 0 0 {name=C2 model=cap_mim_m3_1 W=1 L=1 MF=1 spiceprefix=X}
C {lab_wire.sym} 720 -440 2 0 {name=p8 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 730 -300 2 0 {name=p4 sig_type=std_logic lab=Vout}
C {lab_wire.sym} 740 -150 2 0 {name=p5 sig_type=std_logic lab=Vss}
