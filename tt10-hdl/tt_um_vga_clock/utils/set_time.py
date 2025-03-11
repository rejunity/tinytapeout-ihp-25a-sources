from machine import Pin
from ttboard.mode import RPMode
from ttboard.demoboard import DemoBoard
import time
import gc
gc.threshold(10000)

button_on_time= 0.02
button_off_time= 0.06

# get a handle to the board
tt = DemoBoard()
tt.shuttle.tt_um_vga_clock.enable()
tt.reset_project(True)
tt.reset_project(False)
tt.mode = RPMode.ASIC_RP_CONTROL
tt.clock_project_PWM(31.5e6)

# make sure buttons aren't pressed
tt.ui_in[0] = 0
tt.ui_in[1] = 0
tt.ui_in[2] = 0

def press(button, number):
    print(f"pressing {button} x {number}")
    for i in range(number):
        tt.ui_in[button] = 1
        time.sleep(button_on_time)
        tt.ui_in[button] = 0
        time.sleep(button_off_time)

# set the time
press(2, time.localtime()[5])
press(1, time.localtime()[4])
press(0, time.localtime()[3])
