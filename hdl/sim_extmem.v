/* 
* sim_extmem.v : behavior simulation model of external memory bank
*
* Project   : usmif 
* Programmer: khtsoi@gmail.com 
* Date      : Oct 2010
*/

`timescale 1ns/1ps
`define max_name_length 1024
`define noise_period 10

module sim_extmem (clk, valid, q, qtag, ready, req, ce, w, a, tag, d, be);

parameter BANK = 0;
parameter SIM_RAM_SIZE = 1024; // 1024 words = 1024*4 = 4096 bytes
parameter DATA_WIDTH = 128;
parameter TAG_WIDTH = 2;
parameter ADDRESS_WIDTH = 32;
parameter BE_WIDTH = 16; // DATA_WIDTH/8

input  wire                     clk;
output reg                      valid;
output reg  [DATA_WIDTH-1:0]    q;
output reg  [TAG_WIDTH-1:0]     qtag;
output reg                      ready;
input  wire                     req;
input  wire                     ce;
input  wire                     w;
input  wire [ADDRESS_WIDTH-1:0] a;
input  wire [TAG_WIDTH-1:0]     tag;
input  wire [DATA_WIDTH-1:0]    d;
input  wire [BE_WIDTH-1:0]      be;

// -------- ---------- ---------- ----------

reg  mem_noise;
// variables for memory contents
reg  [DATA_WIDTH-1:0] mem_bank[SIM_RAM_SIZE/16-1:0];

event trigger_display;
integer i;

// -------- ---------- ---------- ----------

task load_mem;
  reg [8*14-1:0] file_name;
  begin
    $sformat(file_name, "bank%1d_data.hex", BANK);
    $display("Loading %d bytes from %s to memory bank %1d.",
      SIM_RAM_SIZE, file_name, BANK);
    $readmemh(file_name, mem_bank);
  end
endtask

task display_mem;
  input [31:0] size;
  integer i;
  begin
    $display("Displaying %d bytes in memory Bank %1d.", size, BANK);
    for (i=0; i<size/16; i=i+1)
        $display(" %08X  %08X  %08X  %08X ",
          mem_bank[i][4*32-1:3*32],
          mem_bank[i][3*32-1:2*32],
          mem_bank[i][2*32-1:1*32],
          mem_bank[i][1*32-1:0*32]);
  end
endtask

// -------- ---------- ---------- ----------

initial begin
  load_mem();
end

always begin  // two-cycle memory noise for every 33 cycles
  mem_noise = 0; #((`noise_period-1.5)*31);
  mem_noise = 1; #((`noise_period-1.4)*2);
end

always @ (posedge clk) begin

    ready <= #1 req & ~mem_noise; // memory grant 1 clock cycle after request
    valid <= #1 ce & ~w & ready;
    if (ce) begin
      for (i=0; i<BE_WIDTH; i=i+1)
        if (be[i])
          if (w) begin
            mem_bank[a][8*i +: 8] <= #1 d[8*i +: 8];
            q[8*i +: 8] <= #1 d[8*i +: 8];
          end else
            q[8*i +: 8] <= #1 mem_bank[a][8*i +: 8];
        else
          q[8*i +: 8] <= #1 'bz;
      qtag <= #1 tag;
    end else begin
      q <= #1 'bz;
      qtag <= #1 'bz;
    end
end

// error checking without OVL, PSL or System Verilog
always @ (posedge clk)
  if (ce && !ready)
    $display("Assert (@ %dns): Illegal operation in Bank %d. Entering command while not ready for address %d.", $stime, BANK, a);

endmodule
