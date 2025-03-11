# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

def rotar_MSB_LSB_4(inversor):        #Devuelve el valor de inversor cambiando el orden del MSB al LSB para 4 bits
    lista_MSB_LSB_4=[0,8,4,12,2,10,6,14,1,9,5,13,3,11,7,15]
    return lista_MSB_LSB_4[inversor]
    
def rotar_MSB_LSB_3(inversor):        #Devuelve el valor de inversor cambiando el orden del MSB al LSB para 4 bits
    lista_MSB_LSB_3=[0,4,2,6,1,5,3,7]
    return lista_MSB_LSB_3[inversor]

def display_7seg_mal(valor):        #Devuelve el valor para prender el display de 7 segmentos conectado por el grupo 0 (ver esquemático)
    seg7_mal=[119,65,59,107,77,110,126,67,127,111]
    return seg7_mal[valor]
    
def display_7seg_cath(valor):        #Devuelve el valor para prender el display de 7 segmentos con cátodo común
    seg7_cath_9cd=[63,6,91,79,102,109,125,7,127,111]
    return seg7_cath_9cd[valor]

def display_7seg_cath_9sd(valor):        #Devuelve el valor para prender el display de 7 segmentos con cátodo común, pero si el 9 tuviera el segmento d apagado
    seg7_cath_9sd=[63,6,91,79,102,109,125,7,127,103]
    return seg7_cath_9sd[valor]    
    
def display_7seg_cath_6sa(valor):        #Devuelve el valor para prender el display de 7 segmentos con cátodo común, pero si el 6 tuviera el segmento a apagado
    seg7_cath_9cd_6sa=[63,6,91,79,102,109,124,7,127,111]
    return seg7_cath_9cd_6sa[valor]

def display_7seg_an(valor):        #Devuelve el valor para prender el display de 7 segmentos con ánodo común
    return 127-display_7seg_cath(valor)

async def reset(dut):        #resetea los valores (FFs y la entrada)
    dut.ui_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 1)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)

async def shift_register(dut,value):        #ingresa el número value al shift register de los proyectos básicos
    for i in range(7,-1,-1): 
        bit_to_send = value&2**i
        if bit_to_send==0:
            dut.ui_in.value = 0
            await ClockCycles(dut.clk, 1)
            dut.ui_in.value = 2
            await ClockCycles(dut.clk, 1)
        else:            
            dut.ui_in.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ui_in.value = 3
            await ClockCycles(dut.clk, 1)
        
    
@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.uio_in.value = 0
   
    await reset(dut)

    dut._log.info("Test project 0 behaviour")
    for i in range(10):        #Testea que los números del 0 al 9 devuelvan el valor adecuado
        dut.ui_in.value = rotar_MSB_LSB_4(i)
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_mal(i)

    await reset(dut)
    
    dut._log.info("Test project 1 behaviour")
    for i in range(11):        #Testea que al contar hasta 9 se devuelva el valor adecuado, y además que de 9 vuelva a 0 correctamente
        dut.ui_in.value = 0x10
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_cath_9sd(i%10)     
        dut.ui_in.value = 0x11
        await ClockCycles(dut.clk, 1)

    await reset(dut)

    dut._log.info("Test project 2 behaviour")
    for i in range(8):         #Testea que los números del 0 al 7 devuelvan el valor adecuado
        dut.ui_in.value = rotar_MSB_LSB_3(i)+0x20
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_cath(i)
    
    await reset(dut)

    dut._log.info("Test project 3 behaviour")
    for i in range(8):         #Testea que los números del 0 al 7 devuelvan el valor adecuado
        dut.ui_in.value = rotar_MSB_LSB_3(i)+0x30
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_cath(i)

    await reset(dut)
    
    dut._log.info("Test project 4 behaviour")
    for i in range(8):         #Testea que los números del 0 al 7 devuelvan el valor adecuado
        dut.ui_in.value = rotar_MSB_LSB_3(i)+0x40
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_cath_6sa(i)

    await reset(dut)
    
    dut._log.info("Test project 5 behaviour")
    for i in range(9):        #Testea que al contar hasta 7 se devuelva el valor adecuado, y además que de 7 vuelva a 0 correctamente
        dut.ui_in.value = 0x50
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_cath_6sa(i%8)
        dut.ui_in.value = 0x51
        await ClockCycles(dut.clk, 1)
        
    await reset(dut)
    
    dut._log.info("Test project 6 behaviour")
    for i in range(10):        #Testea que al contar hasta 9 se devuelva el valor adecuado
        dut.ui_in.value = 0x60
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_cath(i%10)
        dut.ui_in.value = 0x61
        await ClockCycles(dut.clk, 1)

    await reset(dut)
    
    dut._log.info("Test project 7 behaviour")
    for i in range(9):         #Testea que al contar hasta 7 se devuelva el valor adecuado, y además que de 7 vuelva a 0 correctamente
        dut.ui_in.value = 0x70
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_an(i%8)
        dut.ui_in.value = 0x72        #En este proyecto en particular, el clock está dado por ui_in[1]
        await ClockCycles(dut.clk, 1)
    dut.ui_in.value = 0x71        #Testea que ui_in[0] setea los FFs del contador
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == display_7seg_an(7)

    await reset(dut)
    
    dut._log.info("Test project 8 behaviour")
    for i in range(10):        #Testea que al contar hasta 9 se devuelva el valor adecuado
        dut.ui_in.value = 0x80
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == display_7seg_cath(i%10)
        dut.ui_in.value = 0x81
        await ClockCycles(dut.clk, 1)

    await reset(dut)

    dut._log.info("Test basic projects behaviour")
    for key in range(256):         
        await shift_register(dut,key)        #Prueba todas las posibles keys
        for project in range(9,15):        
            dut.ui_in.value = 16*project        #Verifica proyecto a proyecto si es correcto o no
            await ClockCycles(dut.clk, 1)    
            if project==11:
                if key==0x80:
                    assert dut.uo_out.value == display_7seg_cath(1)        #El proyecto 11 devuelve 1 en el display de 7 segmentos si la key es correcta
                else:
                    assert dut.uo_out.value == display_7seg_cath(0)        #Y devuevle 0 sino
            else:
                if ((project==9 and key==0x11)or(project==10 and key==0xB2)or(project==12 and key==0x7F)or(project==12 and key==0xFF)or(project==13 and key==0x49)or(project==14 and key==0x55)):
                    assert dut.uo_out.value & 1 == 1        #Comprueba que uo_out[0]==1 en caso de que la key sea la indicada por proyecto
                else:
                     assert dut.uo_out.value & 1 == 0        #Y comprueba de que si no, uo_out[0]==0

    
