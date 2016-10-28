module UART_RX
	(
		input clk, 
		input reset,
		input RX,
		output reg [7:0]oData,
		output oValid, 
		output reg RQ
	);

	reg rx_act;
	reg Valid;
	reg [3:0]place;
	reg [7:0]data;
	reg [3:0]strtcnt;
	reg [4:0]stepcnt;
	reg [3:0]delay;
	reg [1:0]cntVal;
	
	assign oValid = Valid;
	
	reg [1:0] sync;
	wire iRX;
	assign iRX = sync[1];

	always @ (posedge clk)
	sync <= { sync[0], RX };
	
	
	always@(posedge clk or negedge reset)
	begin
	if (~reset) begin
		place <= 4'd0;
		data <= 8'd0;
		strtcnt <= 4'd0;
		stepcnt <= 5'd0;
		delay <= 4'd0;
		rx_act <= 1'b0;
		oData <= 8'd0;
		Valid <= 1'b0;
		cntVal <= 2'd0;
	end else begin
		if (Valid) begin
			if (delay == 4'd15) begin 
				delay <= 4'd0; 
				Valid <= 1'b0;
				cntVal <= cntVal + 1;
				if(cntVal == 2'd3)
					RQ <= 1'b1;
			end 
			else begin 
				delay <= delay + 1'b1; 
			end
		end
		else RQ <= 1'b0;
			 
		

		
		if (rx_act) begin
			if (stepcnt == 5'd15) begin
				if (place == 4'd8) begin
					if (iRX) begin
						Valid <= 1'b1;
						oData <= data;
					end else begin
						data <= 8'b0;
					end
					place <= 4'd0;
					rx_act <= 1'b0;
				end else begin
					data[place] <= iRX;
					place <= place + 1'b1;
				end
					stepcnt <= 5'd0;
			end else begin
				stepcnt <= stepcnt + 1'b1;
			end
		end else begin
			if ((~rx_act)&&(~iRX)) begin
				if (strtcnt == 5'd7) begin
					rx_act <= 1'b1;
					strtcnt <= 4'd0;
				end else begin
					strtcnt <= strtcnt + 1'b1;
				end
			end
		end
		
	end
	end

endmodule
