/* 
* sim_host.v : behavior simulation model of host register interface
*
* Project   : usmif 
* Programmer: khtsoi@gmail.com 
* Date      : Oct 2010
*/

`timescale 1ns/1ps

`define clk_period 10
`define rst_period 111

module sim_host (clk, reg_in, reg_wr, reg_out);

parameter [8*128-1:0] file_name = "sim_host.cmd";

input  wire          clk;
output reg  [63:0]   reg_in;
output reg  [255:0]  reg_wr;
input  wire [2047:0] reg_out;

// -------- ---------- ---------- ----------

integer cmd_file;
reg [16*8-1:0] cmd;
reg [31:0] addr, data;
integer i;

// -------- ---------- ---------- ----------

initial begin : host_block
  reg_wr <= {256{1'b0}};
  reg_in <= {64{1'bz}};
  #(`rst_period+3);

  @ (posedge clk);
  cmd_file = $fopen(file_name, "r");
  if (cmd_file == 0)
    disable host_block;

  while (!$feof(cmd_file)) begin
    #`clk_period;
    i=$fscanf(cmd_file, "%s", cmd);

    case (cmd)
      "read":
        i=$fscanf(cmd_file, "%h", addr);

      "write": begin
        i=$fscanf(cmd_file, "%h %h", addr, data);
        reg_wr[4*addr +: 4] <= #1 4'b1111;
        if (addr & 1)
          reg_in <= #1 {data, {32{1'b0}}};
        else
          reg_in <= #1 {{32{1'b0}}, data};
        #`clk_period; reg_wr <= #1 0; reg_in <= #1 'bz;
      end // write

      "wait": begin
        i=$fscanf(cmd_file, "%h", data);
        repeat (data) #`clk_period;
      end

      default:
        $display("unknown command %s", cmd);
    endcase
  end // while not EOF

  $fclose(cmd_file);
end // initial

endmodule
