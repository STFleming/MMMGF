# Makefile for AXEL distributed application
# Application Name: <<<APPLICATION_NAME>>>
# by Brittle 2009

# ---------- Environment ---------- 
AXELSDK_ROOT=/homes/khtsoi/axelbenchmark/axel_sdk

TARGET=<<<APPLICATION_NAME>>>
SRCDIR=src
INCDIR=inc

CC=gcc
NVCC=nvcc

CFLAGS=-O3 -I$(INCDIR) -I$(AXELSDK_ROOT)/inc -D__DEBUG__
LFLAGS=-L$(AXELSDK_ROOT)/lib -lmpi -laxel -lexpat

GCFLAGS=-arch sm_13 -I/usr/local/cuda/include
GLFLAGS=-L/usr/local/cuda/lib -lcudart

FCFLAGS=-m64
FLFLAGS=-ladmxrc2

# ---------- Files ---------- 
CPU_SRCS=\
				 $(TARGET)_m0.c
CPU_OBJS=$(CPU_SRCS:%.c=%.o)
CPU_COMS=$(CPU_SRCS:%.c=%)

GPU_SRCS=\
				 $(TARGET)_m1.c
GPU_OBJS=$(GPU_SRCS:%.c=%.o)
GPU_COMS=$(GPU_SRCS:%.c=%)
GPU_KELS=\
				 $(TARGET)_m1_cuda.o

FPGA_SRCS=\
				 $(TARGET)_m2.c
FPGA_OBJS=$(FPGA_SRCS:%.c=%.o)
FPGA_COMS=$(FPGA_SRCS:%.c=%)

# ---------- Default Action ---------- 
all: $(CPU_COMS) $(GPU_COMS) $(FPGA_COMS)

# ---------- CPU ---------- 
$(CPU_COMS):%: %.o
	$(CC) $(CFLAGS) -o $@ $< $(LFLAGS)

$(CPU_OBJS):%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $<

# ---------- GPU host + device ---------- 
$(GPU_COMS):%: %.o $(GPU_KELS)
	$(CC) $(CFLAGS) -o $@ $< $(GPU_KELS) $(LFLAGS) $(GLFLAGS)

$(GPU_OBJS):%.o: $(SRCDIR)/%.c
	$(NVCC) $(CFLAGS) $(GCFLAGS) -c $<

$(GPU_KELS):%_cuda.o: $(SRCDIR)/%.cu
	$(NVCC) $(CFLAGS) $(GCFLAGS) -o $@ -c $<

# ---------- FPGA host ---------- 
$(FPGA_COMS):%: %.o
	$(CC) $(CFLAGS) $(FCFLAGS) -o $@ $< $(LFLAGS) $(FLFLAGS)

$(FPGA_OBJS):%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) $(FCFLAGS) -c $<

clean:
	rm -f $(CPU_COMS) $(GPU_COMS) $(FPGA_COMS)

realclean:
	rm -f $(CPU_COMS) $(CPU_OBJS)
	rm -f $(GPU_COMS) $(GPU_OBJS) $(GPU_KELS) *.linkinfo
	rm -f $(FPGA_COMS) $(FPGA_OBJS)
	rm -f $(TARGET).o???

# ---------- FPGA device ---------- 

FPGA_TARGET=admxrc5t2

SIM_SRC=\
				hdl/tb.vhd

SYN_SRC=\
				hdl/pe.vhd \
				hdl/user_app.vhd \
				hdl/admxrc5t2_main.vhd \
				hdl/admxrc5t2.vhd

MACRO=

sim: tb

tb: ${SIM_SRC} ${SYN_SRC}
	vhpcomp -incremental -work work -prj cfg/tb.prj
	fuse -incremental -lib unisimsr -lib unimacro -lib xilinxcorelib -o tb -top tb
	# simulation : ./tb -tclbatch cfg/tb.tcl -wavefile tb.xwv | grep -v "Warning"
	# waveform   : isimwave tb.xwv

syn: ${FPGA_TARGET}.ngc

${FPGA_TARGET}.ngc: ${SYN_SRC} cfg/${FPGA_TARGET}.scr
	xst -ifn cfg/${FPGA_TARGET}.scr

imp: ${FPGA_TARGET}.bit

${FPGA_TARGET}.bit: ${FPGA_TARGET}.ncd
	trce -v 3 -s 1 ${FPGA_TARGET}.ncd -o ${FPGA_TARGET}.twr ${FPGA_TARGET}.pcf -ucf ucf/${FPGA_TARGET}.ucf
	bitgen -f cfg/${FPGA_TARGET}.ut ${FPGA_TARGET}.ncd

${FPGA_TARGET}.ncd: ${FPGA_TARGET}_map.ncd
	par -w -ol high -xe n ${FPGA_TARGET}_map.ncd ${FPGA_TARGET}.ncd ${FPGA_TARGET}.pcf

${FPGA_TARGET}_map.ncd: ${FPGA_TARGET}.ngd
	map -p xc5vlx330t-ff1738-1 -pr b -timing -cm speed -ol high -xe n -logic_opt on -o ${FPGA_TARGET}_map.ncd ${FPGA_TARGET}.ngd ${FPGA_TARGET}.pcf

${FPGA_TARGET}.ngd: ${FPGA_TARGET}.ngc ${MACRO}
	ngdbuild -sd "../../fpga_lib" -uc "ucf/${FPGA_TARGET}.ucf" -p xc5vlx330t-ff1738-1 ${FPGA_TARGET}.ngc ${FPGA_TARGET}.ngd

fpga_clean:
	rm -f tb ${FPGA_TARGET}.bit ${FPGA_TARGET}.ngc

fpga_realclean:
	rm -f tb ${FPGA_TARGET}.bit ${FPGA_TARGET}.ngc
	rm -fr xst xlnx_auto_0_xdb isim
	rm -f ${FPGA_TARGET}.* ${FPGA_TARGET}_*.* tb.*
	rm -f xlnx_auto_0.ise smartpreview.twr netlist.lst fuse.log isim.log
	rm -f isimwavedata.xwv
