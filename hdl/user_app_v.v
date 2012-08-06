/* 
* user_app.vhd : user application code 
*
* Project   : usmif 
* Programmer: khtsoi@gmail.com 
* Date      : Oct 2010
*/

module user_app_v (
  rst, clk, clk2x,
  reg_in, reg_wr, reg_out,
  gtp_clk, gtp_rdy, gtp_txd, gtp_txk, gtp_rxd, gtp_rxk, gtp_aligned,
  valid, q, qtag, ready, req, ce, w, a, tag, d, be);

  parameter NUM_GTP = 4;
  parameter NUM_BANK = 6;
  parameter DATA_WIDTH = 128;
  parameter TAG_WIDTH = 2;
  parameter ADDRESS_WIDTH = 32;
  parameter BE_WIDTH = 16; // DATA_WIDTH/8

  input  wire         rst;   // Reset from memory clock domain
  input  wire         clk;   // Clock from memory clock domain
  input  wire         clk2x; // Clock from memory clock domain

  // To/from local bus interface (32 x 64-bit register)
  input  wire [63:0]  reg_in;
  input  wire [255:0] reg_wr; // 256 bwe
  output wire [2047:0]reg_out;// 256 bytes

  // GTP interface
  input  wire                   gtp_clk;
  input  wire                   gtp_rdy;
  output wire [16*NUM_GTP-1:0]  gtp_txd;
  output wire [2*NUM_GTP-1:0]   gtp_txk;
  input  wire [16*NUM_GTP-1:0]  gtp_rxd;
  input  wire [2*NUM_GTP-1:0]   gtp_rxk;
  input  wire [NUM_GTP-1:0]     gtp_aligned;

  // To/from memory banks
  input  wire [NUM_BANK-1:0]               valid;
  input  wire [DATA_WIDTH*NUM_BANK-1:0]    q;
  input  wire [TAG_WIDTH*NUM_BANK-1:0]     qtag;
  input  wire [NUM_BANK-1:0]               ready;
  output wire [NUM_BANK-1:0]               req;
  output wire [NUM_BANK-1:0]               ce;
  output wire [NUM_BANK-1:0]               w;
  output wire [ADDRESS_WIDTH*NUM_BANK-1:0] a;
  output wire [TAG_WIDTH*NUM_BANK-1:0]     tag;
  output wire [DATA_WIDTH*NUM_BANK-1:0]    d;
  output wire [BE_WIDTH*NUM_BANK-1:0]      be;

// ---------- ---------- ---------- ----------

wire mclk;
wire uclk;

wire run0, rd0, vld0, wr0, full0;
reg  [ADDRESS_WIDTH-1:0] ral0, rah0, wal0, wah0;
wire [DATA_WIDTH-1:0] din0, dout0;

wire run1, rd1, vld1, wr1, full1;
reg  [ADDRESS_WIDTH-1:0] ral1, rah1, wal1, wah1;
wire [DATA_WIDTH-1:0] din1, dout1;

reg  busy, done;

// ---------- ---------- ---------- ----------

// -------- Clock Interface ----------
assign mclk = clk;
assign uclk = clk;

// -------- Memory Interface ----------
genvar i;
generate
  for (i=2; i<NUM_BANK; i=i+1) begin : unused_ram
    assign req[i] = 0;
    assign ce[i]  = 0;
    assign w[i]   = 0;
    assign a[i*ADDRESS_WIDTH +: ADDRESS_WIDTH] = 0;
    assign tag[i*TAG_WIDTH +: TAG_WIDTH]       = 0;
    assign d[i*DATA_WIDTH +: DATA_WIDTH]       = 0;
    assign be[i*BE_WIDTH +: BE_WIDTH]          = 0;
  end // for
endgenerate
assign be[BE_WIDTH*0 +: BE_WIDTH] = {BE_WIDTH{1'b1}};
assign tag[TAG_WIDTH*0 +: TAG_WIDTH] = 0;
assign be[BE_WIDTH*1 +: BE_WIDTH] = {BE_WIDTH{1'b1}};
assign tag[TAG_WIDTH*1 +: TAG_WIDTH] = 0;

sma U_SMA0 (
    mclk, uclk, rst,
    run0, ral0, rah0, wal0, wah0,

    ready[0], valid[0], req[0], ce[0], w[0], 
    a[ADDRESS_WIDTH*0 +: ADDRESS_WIDTH],
    d[DATA_WIDTH*0 +: DATA_WIDTH],
    q[DATA_WIDTH*0 +: DATA_WIDTH],

    rd0, vld0, dout0, wr0, full0, din0);

sma U_SMA1 (
    mclk, uclk, rst,
    run1, ral1, rah1, wal1, wah1,

    ready[1], valid[1], req[1], ce[1], w[1], 
    a[ADDRESS_WIDTH*1 +: ADDRESS_WIDTH],
    d[DATA_WIDTH*1 +: DATA_WIDTH],
    q[DATA_WIDTH*1 +: DATA_WIDTH],

    rd1, vld1, dout1, wr1, full1, din1);

//-------- Processing Element ----------
//pe U_PE (
//  rst, uclk,
//  rd0, vld0, dout0, wr0, full0, din0,
//  rd1, vld1, dout1, wr1, full1, din1);

 //-------- DEVICE UNDER TEST ----------
axel_interface_ent U_PE (
  .clk (uclk), 
  .reset (rst),
  .full0 (full0),  
  .wr0 (wr0),
  .data_out0 (din0),
  .data_in0 (dout0),
  .vld0 (vld0),
  .rd0 (rd0),

  .full1 (full1),
  .wr1	 (wr1),
  .data_out1 (din1),
  .data_in1 (dout1),
  .vld1 (vld1),
  .rd1 (rd1)
  ); 

//-----Printing Processes------------
always @ (posedge clk)
begin
	$display("Data out bank0: %d", din0);
//	$display("Data out bank1: %d", din1); 
end

//-------- User Registers ----------

reg run0_reg, run1_reg;
always @ (posedge clk)
  if (rst) begin
    run0_reg <= 0;
    run1_reg <= 0;
  end else begin
    run0_reg <= reg_in[2] & reg_wr[0];
    run1_reg <= reg_in[3] & reg_wr[0];
  end
assign run0 = reg_in[2] & reg_wr[0] & ~run0_reg;
assign run1 = reg_in[3] & reg_wr[0] & ~run1_reg;

always @ (posedge clk)
  if (rst) begin
    ral0 <= 0;
    rah0 <= 0;
    wal0 <= 0;
    wah0 <= 0;
    ral1 <= 0;
    rah1 <= 0;
    wal1 <= 0;
    wah1 <= 0;
  end else begin
    if (reg_wr[2*4]) ral0 <= #1 reg_in[31: 0];
    if (reg_wr[3*4]) rah0 <= #1 reg_in[63:32];
    if (reg_wr[4*4]) wal0 <= #1 reg_in[31: 0];
    if (reg_wr[5*4]) wah0 <= #1 reg_in[63:32];
    if (reg_wr[6*4]) ral1 <= #1 reg_in[31: 0];
    if (reg_wr[7*4]) rah1 <= #1 reg_in[63:32];
    if (reg_wr[8*4]) wal1 <= #1 reg_in[31: 0];
    if (reg_wr[9*4]) wah1 <= #1 reg_in[63:32];
  end

assign reg_out[3   :  0] = {req[1], req[0], busy, done};
assign reg_out[31  :  4] = 0;
assign reg_out[2047: 32] = 0;

always @ (posedge clk)
  if (rst || done)
    busy <= #1 1'b0;
  else
    busy <= #1 req[0] | req[1];

always @ (posedge clk)
  if (rst || run0 || run1)
    done <= #1 1'b0;
  else
    done <= #1 busy & ~req[0] & ~req[1];

endmodule
