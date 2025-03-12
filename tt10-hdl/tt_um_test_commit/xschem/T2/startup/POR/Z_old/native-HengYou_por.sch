v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 280 -100 970 -100 {lab=Vss}
N 850 -270 850 -160 {lab=Vout}
N 310 -330 960 -330 {lab=Vdd}
N 240 -330 310 -330 {lab=Vdd}
N 370 -210 370 -160 {lab=#net1}
N 240 -190 370 -190 {lab=#net1}
N 240 -270 240 -250 {lab=#net2}
N 180 -220 200 -220 {lab=Vss}
N 180 -220 180 -100 {lab=Vss}
N 180 -100 260 -100 {lab=Vss}
N 260 -100 280 -100 {lab=Vss}
N 180 -260 330 -260 {lab=Vss}
N 180 -260 180 -220 {lab=Vss}
N 370 -230 370 -210 {lab=#net1}
N 370 -330 370 -290 {lab=Vdd}
N 140 -300 200 -300 {lab=Vout}
N 850 -200 960 -200 {lab=Vout}
N 410 -130 440 -130 {lab=#net3}
N 480 -270 480 -160 {lab=#net4}
N 520 -300 530 -300 {lab=#net5}
N 530 -300 550 -300 {lab=#net5}
N 590 -170 590 -100 {lab=Vss}
N 590 -270 590 -230 {lab=#net6}
N 630 -200 700 -200 {lab=Vdd}
N 700 -330 700 -200 {lab=Vdd}
N 810 -300 810 -130 {lab=#net6}
N 590 -250 810 -250 {lab=#net6}
N 350 -130 370 -130 {lab=Vss}
N 350 -130 350 -100 {lab=Vss}
N 480 -130 510 -130 {lab=Vss}
N 510 -130 510 -100 {lab=Vss}
N 570 -200 590 -200 {lab=Vss}
N 570 -200 570 -160 {lab=Vss}
N 570 -160 590 -160 {lab=Vss}
N 240 -300 260 -300 {lab=Vdd}
N 260 -330 260 -300 {lab=Vdd}
N 850 -130 870 -130 {lab=Vss}
N 870 -130 870 -100 {lab=Vss}
N 850 -300 870 -300 {lab=Vdd}
N 870 -330 870 -300 {lab=Vdd}
N 590 -300 610 -300 {lab=Vdd}
N 610 -330 610 -300 {lab=Vdd}
N 450 -300 480 -300 {lab=Vdd}
N 450 -330 450 -300 {lab=Vdd}
C {ipin.sym} 80 -470 0 0 {name=p1 lab=Vdd}
C {ipin.sym} 75 -440 0 0 {name=p2 lab=Vss}
C {opin.sym} 55 -410 0 0 {name=p3 lab=Vout}
C {sky130_fd_pr/nfet_01v8_esd.sym} 610 -200 2 0 {name=M30
L=0.165
W=20.35
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=esd_nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 830 -130 0 0 {name=M2
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 830 -300 0 0 {name=M3
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 570 -300 0 0 {name=M5
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 500 -300 2 0 {name=M6
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 460 -130 0 0 {name=M7
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 390 -130 2 0 {name=M8
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 220 -300 0 0 {name=M9
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_05v0_nvt.sym} 350 -260 0 0 {name=M11
L=0.9
W=1
nf=1 mult=1
model=nfet_05v0_nvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_05v0_nvt.sym} 220 -220 0 0 {name=M12
L=0.9
W=1
nf=1 mult=1
model=nfet_05v0_nvt
spiceprefix=X
}
C {lab_wire.sym} 960 -330 2 0 {name=p4 sig_type=std_logic lab=Vdd}
C {lab_wire.sym} 960 -200 2 0 {name=p5 sig_type=std_logic lab=Vout}
C {lab_wire.sym} 970 -100 2 0 {name=p6 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 140 -300 0 0 {name=p7 sig_type=std_logic lab=Vout}
C {lab_wire.sym} 240 -220 2 0 {name=p8 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 370 -260 2 0 {name=p9 sig_type=std_logic lab=Vss}
