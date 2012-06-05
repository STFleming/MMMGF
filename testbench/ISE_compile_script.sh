#!/bin/sh
fuse -o $1 -prj highest_testbench.prj testbench_ent
./$1 -tclbatch isim.cmd
