/* 
* sma_cu.vhd : Sequential Memory Access (Control Unit) for ADM-XRC-5T2 board.
*
* Project   : usmif 
* Programmer: khtsoi@gmail.com 
* Date      : Oct 2010
*
* Given the start and end address and the unit will generated the
* signals for sequentially reading/writing the external memory based
* on the conditions of an FIFO units.
*/

module sma_cu (
  input  wire         clk,
  input  wire         rst,
  input  wire         run,  // control unit starts on the rising edge of run
  output wire         bzy,  // control unit asserts to high level when busy
  input  wire         cen,  // control unit enable
  input  wire [31:0]  adl,  // (low) starting address counter value
  input  wire [31:0]  adh,  // (high) stopping address counter value
  input  wire         rdy,  // ready for accepting read/write command
  output wire         cmd,  // read/write command
  output wire [31:0]  add   // read/write address
);

// ---------- ---------- ---------- ----------

localparam [1:0] ST_IDLE = 2'b00;
localparam [1:0] ST_MREQ = 2'b01;
localparam [1:0] ST_MCMD = 2'b10;
localparam [1:0] ST_WAIT = 2'b11;

reg  [1:0]   fsm_state;
reg  [31:0]  addr_cnt;
wire         cnt_end;
wire         cmd_q;

// ---------- ---------- ---------- ----------

assign bzy = (fsm_state == ST_IDLE) ? 1'b0 : 1'b1;
assign cmd = cmd_q;
assign add = addr_cnt;

assign cmd_q = (fsm_state == ST_MCMD) ? rdy & cen : 1'b0;
assign cnt_end = (addr_cnt == adh) ? 1'b1 :  1'b0;

always @ (posedge clk)
  if (run)
    addr_cnt <= #1 adl;
  else if (cmd_q)
    addr_cnt <= #1 addr_cnt + 1'b1;

always @ (posedge clk)
  if (rst)
    fsm_state <= #1 ST_IDLE;
  else
    case (fsm_state)

      ST_IDLE :
        if (run && (adh > adl) )
          fsm_state <= #1 ST_MREQ;

      ST_MREQ :
        if (rdy) begin
          if (cen)
            fsm_state <= #1 ST_MCMD;
          else
            fsm_state <= #1 ST_WAIT;
        end // if (rdy)

      ST_MCMD :
        if (cnt_end)
          fsm_state <= #1 ST_IDLE;
        else if (!rdy || !cen)
          fsm_state <= #1 ST_WAIT;

      ST_WAIT :
        if (cen) begin
          if (rdy)
            fsm_state <= #1 ST_MCMD;
          else
            fsm_state <= #1 ST_MREQ;
        end // if (cen)

    endcase

endmodule
