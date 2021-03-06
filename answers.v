module answers(
input clk,
input rst,
input ValRX,
input [7:0] iUART,
input [4:0] addr,
output reg[7:0] data);

reg [7:0] cnt;
reg once;
reg [1:0] syncVal;

reg [1:0] cntVal, st;
reg [9:0] cntbits;
reg [9:0] outdata;
always@(posedge clk)
	syncVal <= {syncVal[0], ValRX};

always@(posedge clk or negedge rst)
begin
	if(~rst) begin
		data <= 8'd0;
		cnt <= 8'd0;
		once <= 1'b0;
		cntVal <= 2'd0;
		cntbits <= 10'd0;
		outdata <= 10'd0;
		st <= 2'd0;
	end
	else begin
		case(st)
			0:if(syncVal[1])begin
				st <= 1;
			end
			1:begin
				cntVal <= cntVal + 1'b1;
				if(cntVal == 2'd1) begin
					/*if(iUART == 8'd82)begin
						cntbits <= cntbits + 1'b1;
						outdata <= cntbits;
					end 
					else*/
						outdata <= iUART;
				end
				st <= 2;
			end
			2: if(~syncVal[1])
				st <= 0;
		endcase
		case(addr)
			0 : begin
				data <= cnt;
				once <= 1'b0;
			end
			1 : data <= 10;
			2 : data <= 8'd20;
			3 : data <= 8'd30;
			4 : data <= 8'd40;
			5 : data <= 8'd50;
			6 : data <= 8'd60;
			7 : data <= 8'd70;
			8 : data <= 8'd80;
			9 : data <= 8'd90;
			10 : data <= 8'd100;
			11 : data <= 8'd110;
			12 : data <= 8'd120;
			13 : data <= 8'd130;
			14 : data <= 8'd140;
			15 : data <= 8'd150;
			16 : data <= outdata[7:0];
			17 : begin
				data <= outdata[9:8];
				if(once == 1'b0) begin
					cnt <= cnt + 1'b1;
					once <= 1'b1;
				end
				/*if(cnt == 8'd255)
				cnt <= 8'd0;*/
			end
		endcase
	end
end
endmodule