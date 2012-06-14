#!/bin/bash

#PBS -M khtsoi@gmail.com
#PBS -m bae
#PBS -N usmif
#PBS -l cput=2:00:00
#PBS -j oe

if [ -n "$PBS_O_WORKDIR" ]; then
  echo "change directory to $PBS_O_WORKDIR ..."
  cd $PBS_O_WORKDIR
fi

FPGA_TARGET=admxrc5t2
FPGA_PART=xc5vlx330t-ff1738-1

xst -ifn cfg/${FPGA_TARGET}.scr

ngdbuild \
  -p ${FPGA_PART} \
  -sd "../../axel_sdk/fpga_lib" -sd "edf" \
  -uc "ucf/${FPGA_TARGET}.ucf" \
  ${FPGA_TARGET}.ngc ${FPGA_TARGET}.ngd

map \
  -p ${FPGA_PART} \
  -w -pr b -timing -cm speed -ol high -xe n -logic_opt on \
  -o ${FPGA_TARGET}_map.ncd ${FPGA_TARGET}.ngd ${FPGA_TARGET}.pcf

par \
  -w -ol high -xe n \
  ${FPGA_TARGET}_map.ncd ${FPGA_TARGET}.ncd ${FPGA_TARGET}.pcf

bitgen -f cfg/${FPGA_TARGET}.ut ${FPGA_TARGET}.ncd

trce \
  -v 3 -s 1 \
  -ucf ucf/${FPGA_TARGET}.ucf \
  ${FPGA_TARGET}.ncd -o ${FPGA_TARGET}.twr ${FPGA_TARGET}.pcf 

#echo "Subject: usmif implemented!" | /usr/sbin/sendmail khtsoi@gmail.com
