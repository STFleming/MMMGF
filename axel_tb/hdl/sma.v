/* 
* sma.v : Sequential Memory Access for ADM-XRC-5T2 board.
*
* Project   : usmif 
* Programmer: khtsoi@gmail.com 
* Date      : Oct 2010
*
* Given the start and end address and the unit will generated the
* signals for sequentially reading/writing the external memory based
* on the conditions of the embedded FIFO units. The user interface is
* purely based on FIFO I/O.
*/

module sma (
  input  wire         mclk,
  input  wire         uclk,
  input  wire         rst,
  input  wire         run,  // fetch unit starts on the rising edge of run
  input  wire [31:0]  ral,  // (low) starting read address
  input  wire [31:0]  rah,  // (high) stopping read address
  input  wire [31:0]  wal,  // (low) starting write address
  input  wire [31:0]  wah,  // (high) stopping write address

  input  wire         ready,
  input  wire         valid,
  output wire         req,
  output wire         ce,
  output wire         w,
  output wire [31:0]  a,
  output wire [127:0] d,
  input  wire [127:0] q,

  input  wire         rd,   // get data from the read FIFO
  output wire         vld,  // read FIFO data out valid
  output wire [127:0] dout, // read FIFO data out
  input  wire         wr,   // put data to the write FIFO
  output wire         full, // write FIFO full
  input  wire [127:0] din); // write FIFO data in

// ---------- ---------- ---------- ----------

wire         bzy_i, cen_i, cmd_i;
wire [31:0]  addr_i;
wire         ctl_i;

wire         bzy_o, cen_o, cmd_o;
wire [31:0]  addr_o;

// ---------- ---------- ---------- ----------

sma_cu 
  U_ictrl (mclk, rst, run, bzy_i, cen_i, ral, rah, ready, cmd_i, addr_i);
mem_fifo 
  U_ififo (
    .valid(vld),
    .rd_en(rd),
    .prog_full(ctl_i),
    .wr_en(valid),
    .full(),
    .empty(),
    .wr_clk(mclk),
    .rst(rst),
    .rd_clk(uclk),
    .dout(dout),
    .din(q));
assign cen_i = ~ctl_i & ~cen_o;

sma_cu 
  U_octrl (mclk, rst, run, bzy_o, cen_o, wal, wah, ready, cmd_o, addr_o);
mem_fifo
  U_ofifo (
    .valid(cen_o),
    .rd_en(cmd_o),
    .prog_full(),
    .wr_en(wr),
    .full(full),
    .empty(),
    .wr_clk(uclk),
    .rst(rst),
    .rd_clk(mclk),
    .dout(d),
    .din(din));
assign w = cmd_o;

assign req = bzy_i | bzy_o;
assign ce = cmd_i | cmd_o;

// arbitor : write > read
assign a = (cmd_o) ? addr_o : addr_i;

endmodule
