module UART_TX
#(
  parameter BYTES = 5'd4
)
(
  input reset,          // global reset and enable signal
  input clk,            // actual needed baudrate (tested on 4,8 MHz)
  input RQ,            // start transfer signal
  input [4:0]cycle,
  input [7:0]data,
  output [4:0]addr,
  output reg tx,          // serial transmitted data
  output reg dirTX,        // rs485 TX dir controller 
  output reg dirRX        // rs485 RX dir controller
);

  
reg [7:0] cnt;
reg [4:0]switch;

assign addr = switch;

localparam WAIT=0, MEGAWAIT=1, DIRON=2, TX=3, DIROFF=4;

reg [2:0] state;
reg [3:0] serialize;
reg [5:0] delay;
reg [1:0] rqsync;

always@(posedge clk) begin      // double d-flipflop to avoid metastability
  rqsync <= { rqsync[0],  RQ };  // start signal from other clock domain
end

always@(posedge clk or negedge reset)
begin
if (~reset) begin          // global asyncronous reset, initial values
  state <= 1'b0;
  serialize <= 4'd0;
  delay <= 6'b0;
  tx <= 1'b1;
  switch <= 5'd0;
  dirTX <= 1'd0;
  dirRX <= 1'd0;
end else begin            // main circuit
  case (state)          // state machine
    WAIT: begin          // waiting for transfer request
      if (rqsync[1]) state <= DIRON;    // just move on
    end
    DIRON: begin         // set the DIR pins to high level with a tiny delay
      delay <= delay + 1'b1;  // count while in this state
      if (delay == 6'd15) begin dirRX <= 1'd1; end
      if (delay == 6'd30) begin dirTX <= 1'd1; end
      if (delay == 6'd45) begin state <= TX; end  // proceed to next state
    end
    TX: begin          // the transfer
      serialize <= serialize + 1'b1;    // count while in this state
      case (serialize)          // make a sequence while here
        0: begin 
          tx <= 1'd0;      // startbit
          delay <= 5'd0;    // reset previous counter
        end
        1,2,3,4,5,6,7,8: tx <= data[(serialize - 1'b1)];  // transmit every bit of data
        9: begin 
          tx <= 1'd1;    // stopbit
          switch <= switch + 1'b1;  // switch memory
        end
        10: begin
          serialize <= 4'd0; // reset sequencer
          if (switch == 5'd18) begin 
            switch <= 5'd0; 
            state <= DIROFF; 
          end  // if completed transfer proceed to next state 
        end  
      endcase
    end
    DIROFF: begin        // set the DIR pins to low level with a tiny delay
      delay <= delay + 1'b1;  // count while in this state
      if (delay == 6'd15) begin dirTX <= 1'd0; end
      if (delay == 6'd30) begin dirRX <= 1'd0; state <= MEGAWAIT; end  // proceed to next state
    end
    MEGAWAIT: begin      // checking the low level of request signal
      delay <= 6'd0;        // reset previous counter
      if (~rqsync[1]) state <= WAIT; // just move on
    end
  endcase 
end
end

endmodule