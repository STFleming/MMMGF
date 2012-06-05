#!/bin/sh
fuse -o testbench -prj highest_testbench.prj testbench_ent
./testbench -tclbatch isim.cmd
