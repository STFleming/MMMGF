#!/bin/bash

#PBS -M <<<EMAIL>>>
#PBS -m bae
#PBS -N <<<APPLICATION_NAME>>>
#PBS -l cput=2:00:00
#PBS -j oe

if [ -n "$PBS_O_WORKDIR" ]; then
  echo "change directory to $PBS_O_WORKDIR ..."
  cd $PBS_O_WORKDIR
fi

mpirun -bynode \
  -host axel05 -np 1 ./<<<APPLICATION_NAME>>>_m0 cfg/axel_app.xml : \
  -host axel06 -np 1 ./<<<APPLICATION_NAME>>>_m0 cfg/axel_app.xml : \
  -host axel07 -np 1 ./<<<APPLICATION_NAME>>>_m0 cfg/axel_app.xml : \
  -host axel08 -np 1 ./<<<APPLICATION_NAME>>>_m0 cfg/axel_app.xml
