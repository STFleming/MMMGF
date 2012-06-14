# always check new update from Alpha-Data
# ftp://ftp.alpha-data.com/pub/admxrc/linux

TARGET=admxrc5t2

CXX=g++
CC=gcc
LD=ld

DEBUG=-D__DEBUG__
CFLAGS=-Wall -O3 -m64 -Iinc -I../../fpga_inc ${DEBUG}
LDFLAGS=

APP_SRC=\
				fpga_util.c \
				userapp.c
APP_OBJ=$(APP_SRC:%.c=%.o)

SIM_SRC=\
				hdl/tb.vhd

SYN_SRC=\
				hdl/pe.vhd \
				hdl/user_app.vhd \
				hdl/admxrc5t2_main.vhd \
				hdl/admxrc5t2.vhd

MACRO=

all: sim syn imp <<<APPLICATION_NAME>>>_fpga

sim: tb

tb: ${SIM_SRC} ${SYN_SRC}
	vhpcomp -incremental -work work -prj cfg/tb.prj
	fuse -incremental -lib unisimsr -lib unimacro -lib xilinxcorelib -o tb -top tb
	# simulation : ./tb -tclbatch cfg/tb.tcl -wavefile tb.xwv | grep -v "Warning"
	# waveform   : isimwave tb.xwv


syn: ${TARGET}.ngc

${TARGET}.ngc: ${SYN_SRC} cfg/${TARGET}.scr
	xst -ifn cfg/${TARGET}.scr

imp: ${TARGET}.bit

${TARGET}.bit: ${TARGET}.ncd
	trce -v 3 -s 1 ${TARGET}.ncd -o ${TARGET}.twr ${TARGET}.pcf -ucf ucf/${TARGET}.ucf
	bitgen -f cfg/${TARGET}.ut ${TARGET}.ncd

${TARGET}.ncd: ${TARGET}_map.ncd
	par -w -ol high -xe n ${TARGET}_map.ncd ${TARGET}.ncd ${TARGET}.pcf

${TARGET}_map.ncd: ${TARGET}.ngd
	map -p xc5vlx330t-ff1738-1 -pr b -timing -cm speed -ol high -xe n -logic_opt on -o ${TARGET}_map.ncd ${TARGET}.ngd ${TARGET}.pcf

${TARGET}.ngd: ${TARGET}.ngc ${MACRO}
	ngdbuild -sd "../../fpga_lib" -uc "ucf/${TARGET}.ucf" -p xc5vlx330t-ff1738-1 ${TARGET}.ngc ${TARGET}.ngd

<<<APPLICATION_NAME>>>_fpga: ${APP_OBJ}
	gcc -o <<<APPLICATION_NAME>>>_fpga ${APP_OBJ} ${LDFLAGS} -ladmxrc2

$(APP_OBJ):%.o: src/%.c inc/%.h
	  $(CC) $(CFLAGS) -c $<

clean:
	rm -f tb ${TARGET}.bit ${TARGET}.ngc <<<APPLICATION_NAME>>>_fpga

realclean:
	rm -f tb ${TARGET}.bit ${TARGET}.ngc
	rm -fr xst xlnx_auto_0_xdb isim
	rm -f ${TARGET}.* ${TARGET}_*.* tb.*
	rm -f xlnx_auto_0.ise smartpreview.twr netlist.lst fuse.log isim.log
	rm -f isimwavedata.xwv
	rm -f ${APP_OBJ} <<<APPLICATION_NAME>>>_fpga
	rm -f <<<APPLICATION_NAME>>>.o*
