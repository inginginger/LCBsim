module answers(
input clk,
input rst,
input [4:0] addr,
input strob,
input [7:0] slowData,
output reg[7:0] data);

reg [7:0] cnt;
reg only;
reg [1:0] syncStr;
reg [7:0] cntSlow;
reg [7:0] oSlowData;
reg [1:0] cntStr;

always@(posedge clk)
	syncStr <= {syncStr[0], strob};

always@(posedge clk or negedge rst)
begin
	if(~rst) begin
		data <= 8'd0;
		cnt <= 8'd0;
		only <= 1'b0;
		cntSlow <= 8'd0;
		oSlowData <= 8'd0;
		cntStr <= 2'd0;
	end
	else begin
		if(syncStr[1])begin//если приняли байт запроса
			cntStr <= cntStr + 1'b1;//считаем
			if(cntStr == 2'd1) begin//второй байт=медленный параметр
				oSlowData <= slowData;//кладем его в 17 байт ответа
				if(slowData == 8'd1) begin//если медленный параметр = 1
					cntSlow <= cntSlow + 1'b1;
					oSlowData <= cntSlow;
				end//на выходную шину ставим счетчик
			end
		end
		case(addr)
			0 : begin
				data <= cnt;
				only <= 1'b0;
			end
			1 : data <= 8'd10;
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
			16 : data <= oSlowData;
			17 : begin
				data <= 8'd0;
				if(only == 1'b0) begin
					cnt <= cnt + 1'b1;
					only <= 1'b1;
				end
				/*if(cnt == 8'd255)
				cnt <= 8'd0;*/
			end
		endcase
	end
end
endmodule