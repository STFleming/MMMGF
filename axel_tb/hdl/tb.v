/* tb.v : Simulation Test Bench
*
* Project   : usmif 
* Programmer: khtsoi@gmail.com 
* Date      : Oct 2010
*
*/

`timescale 1ns/1ps

module tb ();

`define clk_period 10
`define rst_period 111
`define sim_period 15000

parameter NUM_GTP = 4;
parameter NUM_BANK = 6;
parameter DATA_WIDTH = 128;
parameter TAG_WIDTH = 2;
parameter ADDRESS_WIDTH = 32;
parameter BE_WIDTH = 16; // DATA_WIDTH/8

// -------- ---------- ---------- ----------

reg  tb_clk   = 0;
reg  tb_clk2x = 0;
reg  tb_rst   = 1;
reg  tb_start = 0;
reg  tb_noise = 0;

// To/from local bus interface (32 x 64-bit register)
wire [63:0]  reg_in;
wire [255:0] reg_wr;
wire [2047:0]reg_out;// 256 bytes

// GTP interface
wire                   gtp_clk;
reg                    gtp_rdy = 0;
wire [16*NUM_GTP-1:0]  gtp_txd;
wire [2*NUM_GTP-1:0]   gtp_txk;
reg  [16*NUM_GTP-1:0]  gtp_rxd = 0;
reg  [2*NUM_GTP-1:0]   gtp_rxk = 0;
reg  [NUM_GTP-1:0]     gtp_aligned = 0;

// To/from memory banks
wire [NUM_BANK-1:0]               valid;
wire [DATA_WIDTH*NUM_BANK-1:0]    q;
wire [TAG_WIDTH*NUM_BANK-1:0]     qtag;
wire [NUM_BANK-1:0]               ready;
wire [NUM_BANK-1:0]               req;
wire [NUM_BANK-1:0]               ce;
wire [NUM_BANK-1:0]               w;
wire [ADDRESS_WIDTH*NUM_BANK-1:0] a;
wire [TAG_WIDTH*NUM_BANK-1:0]     tag;
wire [DATA_WIDTH*NUM_BANK-1:0]    d;
wire [BE_WIDTH*NUM_BANK-1:0]      be;

// -------- ---------- ---------- ----------

user_app_v DUT (
    tb_rst, tb_clk, tb_clk2x,
    reg_in, reg_wr, reg_out,
    gtp_clk, gtp_rdy, gtp_txd, gtp_txk, gtp_rxd, gtp_rxk, gtp_aligned,
    valid, q, qtag, ready, req, ce, w, a, tag, d, be);

sim_extmem #(.BANK(0), .SIM_RAM_SIZE(144)) BANK0 (
    tb_clk,
    valid[0],
    q[DATA_WIDTH*0 +: DATA_WIDTH],
    qtag[TAG_WIDTH*0 +: TAG_WIDTH],
    ready[0],
    req[0],
    ce[0],
    w[0],
    a[ADDRESS_WIDTH*0 +: ADDRESS_WIDTH],
    tag[TAG_WIDTH*0 +: TAG_WIDTH],
    d[DATA_WIDTH*0 +: DATA_WIDTH],
    be[BE_WIDTH*0 +: BE_WIDTH]);

sim_extmem #(.BANK(1), .SIM_RAM_SIZE(144)) BANK1 (
    tb_clk,
    valid[1],
    q[DATA_WIDTH*1 +: DATA_WIDTH],
    qtag[TAG_WIDTH*1 +: TAG_WIDTH],
    ready[1],
    req[1],
    ce[1],
    w[1],
    a[ADDRESS_WIDTH*1 +: ADDRESS_WIDTH],
    tag[TAG_WIDTH*1 +: TAG_WIDTH],
    d[DATA_WIDTH*1 +: DATA_WIDTH],
    be[BE_WIDTH*1 +: BE_WIDTH]);

sim_host #(.filename("sim_host.cmd")) HOST (tb_clk, reg_in, reg_wr, reg_out);

//-------- CLK/RST ----------
always
  #(`clk_period/2) tb_clk = !tb_clk;

always
  #(`clk_period/4) tb_clk2x = !tb_clk2x;

initial
  #`rst_period tb_rst = 0;


// -------- GTP ----------
assign gtp_clk = tb_clk;
initial begin
  #(`rst_period+33) gtp_rdy = 1; 
  #33 gtp_aligned = 4'b1001; 
end

always @ (posedge gtp_clk)
begin
  gtp_rxd[15:0] <= #1 gtp_txd[3*16 +: 16];
  gtp_rxk[1:0] <= #1 gtp_txk[7:6];
  gtp_rxd[3*16 +: 16] <= #1 gtp_txd[15:0];
  gtp_rxk[7:6] <= #1 gtp_txk[1:0];
end

//-------- Termination ----------
//initial begin
//  $dumpfile("tb.vcd");
//  $dumpvars(1, HOST);
//end

initial begin
  wait (reg_out[0]);
  @ (posedge tb_clk);
  BANK0.display_mem(1024);
  BANK1.display_mem(1024);
  $display("Simulation terminate normally.");
  $finish;
end

initial begin
  #`sim_period $display("Simulation time out!!");
  $finish;
end

endmodule
