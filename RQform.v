module RQform(
input clk80MHz,
input rst,
input val,
output reg RQ);

reg[2:0] counter;
reg [1:0] syncStrob;
reg [1:0] state;

localparam IDLE = 2'd0, CNT = 2'd1, WAIT = 2'd2;

always@(posedge clk80MHz)
	syncStrob <= {syncStrob[0], val};

always@(posedge clk80MHz or negedge rst)
begin
	if(~rst) begin
		RQ <= 1'b0;
		counter <= 3'd0;
		state <= 2'd0;
	end
	else begin
		case(state)
			IDLE: begin
				RQ <= 1'b0;
				if(syncStrob[1])
					state <= CNT;
			end
			CNT: begin
				counter <= counter + 1;
				if(counter == 3'd7)
					RQ <= 1'b1;
				state <= WAIT;
			end
			WAIT:
				if(~syncStrob[1])
					state <= WAIT;
		endcase
	end
end
endmodule