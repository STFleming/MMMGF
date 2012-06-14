#!/bin/bash

#PBS -M khtsoi@gmail.com
#PBS -m bae
#PBS -N <<<APPLICATION_NAME>>>
#PBS -l cput=2:00:00
#PBS -j oe

if [ -n "$PBS_O_WORKDIR" ]; then
  echo "change directory to $PBS_O_WORKDIR ..."
  cd $PBS_O_WORKDIR
fi

xst -ifn cfg/admxrc5t2.scr

ngdbuild -sd "../../fpga_lib" -uc "ucf/admxrc5t2.ucf" -p xc5vlx330t-ff1738-1 admxrc5t2.ngc admxrc5t2.ngd

map -p xc5vlx330t-ff1738-1 -pr b -timing -cm speed -ol high -xe n -logic_opt on -o admxrc5t2_map.ncd admxrc5t2.ngd admxrc5t2.pcf

par -w -ol high -xe n admxrc5t2_map.ncd admxrc5t2.ncd admxrc5t2.pcf

bitgen -f cfg/admxrc5t2.ut admxrc5t2.ncd

trce -v 3 -s 1 admxrc5t2.ncd -o admxrc5t2.twr admxrc5t2.pcf -ucf ucf/admxrc5t2.ucf

echo "Subject: <<<APPLICATION_NAME>>> implemented!" | /usr/sbin/sendmail <<<EMAIL>>>
