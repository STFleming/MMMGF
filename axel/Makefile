# Makefile for AXEL distributed application
# Application Name: myapp
# by Brittle 2010

# ---------- Environment ---------- 
AXELSDK_ROOT=../axel_sdk
#AXELSDK_ROOT=.



CC=gcc

#CFLAGS=-fast -xSSE4.1 -opt-mem-bandwidth2 -Iinc -I${AXELSDK_ROOT}/inc #-D__DEBUG__
#CFLAGS=-xSSE4.2 -O3 -ipo -no-prec-div -opt-mem-bandwidth2 -Iinc -I${AXELSDK_ROOT}/inc -I${ADMXRC2}/include #-D__DEBUG__
CFLAGS=-O3  -Iinc -I${AXELSDK_ROOT}/inc -I${ADMXRC2}/include #-D__DEBUG__
LFLAGS= -L[ADMXRC2}/lib -ladmxrc2

SW_TARGET=myapp
SW_SRCS=\
				fpga_util.c \
			  ${SW_TARGET}.c
SW_OBJS=${SW_SRCS:%.c=%.o}

FPGA_TARGET=admxrc5t2

#SIM_SRC=\
				hdl/tb.v

SYN_SRC=\
				../hdl/axel_interface.vhd \
				../hdl/user_app_v.v

all: syn imp sw

#sim: tb

#tb: ${SIM_SRC} ${SYN_SRC}
#	fuse -incremental \
		-L unisims_ver -L unimacro_ver -L XilinxCoreLib_ver \
		tb glbl -prj cfg/tb.prj -o tb
	# simulation : ./tb -tclbatch cfg/tb.tcl -wdb tb.wdb | grep -v "Warning"
	# waveform   : isimgui -view tb.wdb

syn: ${FPGA_TARGET}.ngc

${FPGA_TARGET}.ngc: ${SYN_SRC} cfg/${FPGA_TARGET}.scr
	xst -ifn cfg/${FPGA_TARGET}.scr

imp: ${FPGA_TARGET}.bit

${FPGA_TARGET}.bit: ${FPGA_TARGET}.ncd
	bitgen -f cfg/${FPGA_TARGET}.ut ${FPGA_TARGET}.ncd
	trce -v 3 -s 1 ${FPGA_TARGET}.ncd -o ${FPGA_TARGET}.twr ${FPGA_TARGET}.pcf -ucf ucf/${FPGA_TARGET}.ucf

${FPGA_TARGET}.ncd: ${FPGA_TARGET}_map.ncd
	par -w -ol high -xe n ${FPGA_TARGET}_map.ncd ${FPGA_TARGET}.ncd ${FPGA_TARGET}.pcf

${FPGA_TARGET}_map.ncd: ${FPGA_TARGET}.ngd
	map -w -p xc5vlx330t-ff1738-1 -pr b -timing -cm speed -ol high -xe n -logic_opt on -o ${FPGA_TARGET}_map.ncd ${FPGA_TARGET}.ngd ${FPGA_TARGET}.pcf

${FPGA_TARGET}.ngd: ${FPGA_TARGET}.ngc ${MACRO}
	ngdbuild -sd "../../axel_sdk/fpga_lib" -sd "edf" -uc "ucf/${FPGA_TARGET}.ucf" -p xc5vlx330t-ff1738-1 ${FPGA_TARGET}.ngc ${FPGA_TARGET}.ngd

sw: ${SW_TARGET}

${SW_TARGET}: ${SW_OBJS}
	${CC} ${CFLAGS} -o ${SW_TARGET} ${SW_OBJS} ${LFLAGS}

${SW_OBJS}:%.o: ../src/%.c inc/%.h
	${CC} ${CFLAGS} -c $<

clean:
	rm -f tb ${FPGA_TARGET}.bit ${FPGA_TARGET}.ngc ${SW_TARGET}

realclean:
	rm -f tb ${FPGA_TARGET}.bit ${FPGA_TARGET}.ngc ${SW_TARGET}
	rm -fr xst xlnx_auto_0_xdb isim _xmsgs ${SW_OBJS}
	rm -f ${FPGA_TARGET}.* ${FPGA_TARGET}_*.* tb.*
	rm -f xlnx_auto_0.ise smartpreview.twr netlist.lst fuse.log isim.log
	rm -f tb.wdb isim.wdb usage_statistics_webtalk.html
	rm -f webtalk.log
