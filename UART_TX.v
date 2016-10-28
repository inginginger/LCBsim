module UART_TX
#(
  parameter BYTES = 5'd4
)
(
  input reset,          // global reset and enable signal
  input clk,            // actual needed baudrate (tested on 4,8 MHz)
  input RQ,            // start transfer signal
  //input [4:0]cycle,
  
  output [8:0]addr,
  output reg tx,          // serial transmitted data
  output reg dirTX,        // rs485 TX dir controller 
  output reg dirRX,        // rs485 RX dir controller
  output reg [4:0]switch  // memory switcher
);

//  wire [7:0]data;        // 8bits data 
//  wire [8:0]addr;
  //reg unsigned [4:0]cycle;
reg [7:0]data;
reg [7:0] cnt;
  assign addr = switch;
  
//dROM innerMEM(
//  .aclr(!reset),
//  .address(addr),
//  .clock(clk),
//  .q(data));

localparam WAIT=0, MEGAWAIT=1, DIRON=2, TX=3, DIROFF=4;

reg [2:0] state;
reg [3:0] serialize;
reg [4:0] delay;
reg [1:0] rqsync;

always@(posedge clk) begin      // double d-flipflop to avoid metastability
  rqsync <= { rqsync[0],  RQ };  // start signal from other clock domain
end

always@(posedge clk or negedge reset)
begin
if (~reset) begin          // global asyncronous reset, initial values
  state <= 1'b0;
  serialize <= 4'd0;
  delay <= 5'b0;
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
      if (delay == 5'd0) begin dirRX <= 1'd1; end
      if (delay == 5'd15) begin dirTX <= 1'd1; end
      if (delay == 5'd30) begin state <= TX; end  // proceed to next state
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
          if (switch == 5'd20) begin 
            switch <= 5'd0; 
            state <= DIROFF; 
          end  // if completed transfer proceed to next state 
        end  
      endcase
    end
    DIROFF: begin        // set the DIR pins to low level with a tiny delay
      delay <= delay + 1'b1;  // count while in this state
      if (delay == 5'd15) begin dirTX <= 1'd0; end
      if (delay == 5'd30) begin dirRX <= 1'd0; state <= MEGAWAIT; end  // proceed to next state
    end
    MEGAWAIT: begin      // checking the low level of request signal
      delay <= 5'd0;        // reset previous counter
      if (~rqsync[1]) state <= WAIT; // just move on
    end
  endcase 
end
end
always@(posedge clk or negedge reset)
begin
	if(~reset) begin
		data <= 7'd0;
		cnt <= 8'd0;
	end
	else begin
		case(addr)
			0 : data <= cnt ;
			1 : data <= 7'd10;
			2 : data <= 7'd20;
			3 : data <= 7'd30;
			4 : data <= 7'd40;
			5 : data <= 7'd50;
			6 : data <= 7'd60;
			7 : data <= 7'd70;
			8 : data <= 7'd80;
			9 : data <= 7'd90;
			10 : data <= 7'd100;
			11 : data <= 7'd110;
			12 : data <= 7'd120;
			13 : data <= 7'd130;
			14 : data <= 7'd140;
			15 : data <= 7'd150;
			16 : data <= 7'd160;
			17 : data <= 7'd170;
			18 : data <= 7'd180;
			19 : begin
				data <= 7'd190;
				cnt <= cnt + 1;
				/*if(cnt == 8'd255)
					cnt <= 8'd0;*/
			end
		endcase
	end
end

endmodule