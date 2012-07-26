#Make file used to create the testbench files for the GFMMM project
#This testbench simulates the interface with the AXEL Cluster

SIM_SRC=\
		hdl/tb.v

fresh_sim: clean tb sim

tb: ${SIM_SRC}
	fuse -incremental \
                -L unisims_ver -L unimacro_ver -L XilinxCoreLib_ver \
                tb glbl -prj cfg/tb.prj -o tb

sim: 
	./tb -tclbatch cfg/tb.tcl -wdb tb.wdb | grep -v "Warning"

wave:
	isimgui -view tb.wdb

clean:
	rm -f xlnx_auto_0.ise smartpreview.twr netlist.lst fuse.log isim.log
	rm -f tb.wdb isim.wdb usage_statistics_webtalk.html
	rm -f webtalk.log
	rm -f fuseRelaunch.cmd  fuse.xmsgs 
	rm  tb
