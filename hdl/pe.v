/* 
* pe.v : processing element
*
* Project   : usmif 
* Programmer: khtsoi@gmail.com 
* Date      : Oct 2010
*/

module pe (
  rst, clk,
  rd0, vld0, dout0, wr0, full0, din0,
  rd1, vld1, dout1, wr1, full1, din1);

  parameter DATA_WIDTH = 128;

  input  wire         rst;
  input  wire         clk;

  output wire         rd0;
  input  wire         vld0;
  input  wire [DATA_WIDTH-1:0] dout0;
  output wire         wr0;
  input  wire         full0;
  output wire [DATA_WIDTH-1:0] din0;

  output wire         rd1;
  input  wire         vld1;
  input  wire [DATA_WIDTH-1:0] dout1;
  output wire         wr1;
  input  wire         full1;
  output wire [DATA_WIDTH-1:0] din1;

assign rd0 = wr1;
assign wr0 = vld1 & ~full0;
assign din0 = dout1;
assign rd1 = wr0;
assign wr1 = vld0 & ~full1;
assign din1 = dout0;

endmodule
