v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 570 -590 570 -570 {lab=Vdd}
N 700 -590 700 -570 {lab=Vdd}
N 610 -540 660 -540 {lab=Vpbias}
N 700 -540 710 -540 {lab=Vdd}
N 710 -570 710 -540 {lab=Vdd}
N 700 -570 710 -570 {lab=Vdd}
N 560 -540 570 -540 {lab=Vdd}
N 560 -570 560 -540 {lab=Vdd}
N 560 -570 570 -570 {lab=Vdd}
N 700 -510 700 -480 {lab=Vnbias}
N 570 -510 570 -490 {lab=Vpbias}
N 570 -490 570 -480 {lab=Vpbias}
N 570 -480 570 -460 {lab=Vpbias}
N 620 -540 620 -500 {lab=Vpbias}
N 570 -480 620 -480 {lab=Vpbias}
N 620 -500 620 -480 {lab=Vpbias}
N 610 -320 660 -320 {lab=Vnbias}
N 570 -290 570 -270 {lab=#net1}
N 700 -290 700 -270 {lab=Vss}
N 560 -320 570 -320 {lab=#net1}
N 560 -320 560 -290 {lab=#net1}
N 560 -290 570 -290 {lab=#net1}
N 700 -320 710 -320 {lab=Vss}
N 710 -320 710 -290 {lab=Vss}
N 700 -290 710 -290 {lab=Vss}
N 700 -270 700 -250 {lab=Vss}
N 640 -370 640 -320 {lab=Vnbias}
N 570 -270 570 -260 {lab=#net1}
N 570 -260 570 -250 {lab=#net1}
N 700 -390 700 -350 {lab=Vnbias}
N 640 -380 640 -370 {lab=Vnbias}
N 640 -380 700 -380 {lab=Vnbias}
N 700 -480 700 -470 {lab=Vnbias}
N 380 -540 390 -540 {lab=Vdd}
N 380 -570 380 -540 {lab=Vdd}
N 380 -570 390 -570 {lab=Vdd}
N 390 -290 400 -290 {lab=#net1}
N 400 -290 400 -260 {lab=#net1}
N 390 -260 400 -260 {lab=#net1}
N 390 -210 400 -210 {lab=Vss}
N 400 -210 400 -180 {lab=Vss}
N 390 -180 400 -180 {lab=Vss}
N 390 -180 390 -160 {lab=Vss}
N 390 -160 390 -150 {lab=Vss}
N 330 -210 350 -210 {lab=V2}
N 330 -290 350 -290 {lab=V2}
N 330 -340 390 -340 {lab=V2}
N 570 -590 700 -590 {lab=Vdd}
N 390 -590 570 -590 {lab=Vdd}
N 560 -480 570 -480 {lab=Vpbias}
N 430 -540 480 -540 {lab=Vpbias}
N 480 -540 480 -480 {lab=Vpbias}
N 480 -480 560 -480 {lab=Vpbias}
N 330 -340 330 -210 {lab=V2}
N 390 -260 390 -240 {lab=#net1}
N 390 -340 390 -320 {lab=V2}
N 390 -250 570 -250 {lab=#net1}
N 390 -450 390 -340 {lab=V2}
N 390 -590 390 -570 {lab=Vdd}
N 200 -590 330 -590 {lab=Vdd}
N 390 -510 390 -450 {lab=V2}
N 170 -590 200 -590 {lab=Vdd}
N 330 -590 390 -590 {lab=Vdd}
N 570 -400 570 -350 {lab=Vpbias}
N 570 -460 570 -400 {lab=Vpbias}
N 700 -470 700 -400 {lab=Vnbias}
N 700 -400 700 -390 {lab=Vnbias}
N 700 -380 780 -380 {lab=Vnbias}
N 620 -480 650 -480 {lab=Vpbias}
C {ipin.sym} -110 -340 0 0 {name=p1 lab=Vdd}
C {ipin.sym} -110 -310 0 0 {name=p2 lab=Vss}
C {opin.sym} -110 -280 0 0 {name=p4 lab=Vnbias}
C {sky130_fd_pr/pfet_01v8.sym} 590 -540 0 1 {name=M56
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 680 -540 0 0 {name=M57
L=0.35
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 410 -540 0 1 {name=M58
L=0.30
W=2
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 590 -320 0 1 {name=M59
L=0.2
W=1
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 680 -320 0 0 {name=M60
L=0.2
W=1
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} 650 -480 3 0 {name=p47 lab=Vpbias}
C {devices/lab_pin.sym} 780 -380 2 0 {name=p48 lab=Vnbias}
C {sky130_fd_pr/nfet_01v8.sym} 370 -290 0 0 {name=M61
L=0.2
W=1
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 370 -210 0 0 {name=M62
L=1
W=1
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 170 -590 2 1 {name=p7 sig_type=std_logic lab=Vdd}
C {opin.sym} -110 -250 0 0 {name=p3 lab=Vpbias}
C {lab_wire.sym} 390 -150 2 1 {name=p9 sig_type=std_logic lab=Vss}
C {lab_wire.sym} 700 -250 2 1 {name=p10 sig_type=std_logic lab=Vss}
