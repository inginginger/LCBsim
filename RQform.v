module RQform(
input clk80MHz,
input rst,
input val,
output reg RQ);

reg[1:0] counter;
reg [1:0] syncStrob;
reg [1:0] state;
reg [4:0] delay;

localparam IDLE = 2'd0, CNT = 2'd1, DELAY = 2'd2, WAIT = 2'd3;

always@(posedge clk80MHz)
	syncStrob <= {syncStrob[0], val};

always@(posedge clk80MHz or negedge rst)
begin
	if(~rst) begin
		RQ <= 1'b0;
		counter <= 2'd0;
		state <= 2'd0;
		delay <= 5'd0;
	end
	else begin
		case(state)
			IDLE: begin
				if(syncStrob[1])
					state <= CNT;
			end
			CNT: begin
				if(counter == 2'd3) begin
					RQ <= 1'b1;
					counter <= 2'd0;
				end
				else 
					counter <= counter + 1'b1;
				state <= DELAY;
			end
			DELAY: begin
				if(delay == 5'd31) begin
					delay <= 5'd0;
					RQ <= 1'b0;
					state <= WAIT;
				end
				else
					delay <= delay + 1'b1;
			end
			WAIT:
				if(~syncStrob[1])
					state <= IDLE;
		endcase
	end
end
endmodule