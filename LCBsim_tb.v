`timescale 1 ns/1 ns

module LCBsim_tb();

	// Wires and variables to connect to UUT (unit under test)
	reg clk80MHz;
	wire ValRX;
	
	reg clk4_8MHz;
	//reg [8:0] LCB_rq_addr;
	wire TX;          // serial transmitted data
	reg RX;
	wire dirTX;        // rs485 TX dir controller 
	wire dirRX;        // rs485 RX dir controller
	//reg [7:0] LCB_rq_data;
	//reg  [5:0] cycle;
	//reg  [4:0] switch;
	//local variables
	reg [7:0] data [0:19];
	reg [7:0] cntmas [0:255];
	reg [2:0] i = 0;
	reg [4:0] j = 0;
	reg [7:0] q = 0;
	reg [4:0] k = 0;
	reg [7:0] nowdata = 0;

	
	LCBsim simulatorLCB(.clk80MHz(clk80MHz), .UART_RX(RX), .dataFromLCB(dataFromLCB),.ValRX(ValRX),.UART_TX(TX), .UART_dTX(dirTX), .UART_dRX(dirRX));
	
	
initial begin
	clk80MHz = 0;
	forever #12.5 clk80MHz = ~clk80MHz;
 end
 initial begin
	clk4_8MHz = 0;
	forever #210 clk4_8MHz = ~clk4_8MHz;
end
initial begin
	cntmas[ 0 ] =  42 ;
	cntmas[ 1 ] =  33 ;
	cntmas[ 2 ] =  80 ;
	cntmas[ 3 ] =  186 ;
	cntmas[ 4 ] =  42 ;
	cntmas[ 4 ] =  32 ;
	cntmas[ 6 ] =  80 ;
	cntmas[ 7 ] =  78 ;
	cntmas[ 8 ] =  42 ;
	cntmas[ 9 ] =  31 ;
	cntmas[ 10 ] =  80 ;
	cntmas[ 11 ] =  101 ;
	cntmas[ 12 ] =  42 ;
	cntmas[ 13 ] =  30 ;
	cntmas[ 14 ] =  80 ;
	cntmas[ 15 ] =  145 ;
	cntmas[ 16 ] =  42 ;
	cntmas[ 17 ] =  37 ;
	cntmas[ 18 ] =  80 ;
	cntmas[ 19 ] =  57 ;
	cntmas[ 20 ] =  42 ;
	cntmas[ 21 ] =  36 ;
	cntmas[ 22 ] =  80 ;
	cntmas[ 23 ] =  205 ;
	cntmas[ 24 ] =  42 ;
	cntmas[ 25 ] =  35 ;
	cntmas[ 26 ] =  80 ;
	cntmas[ 27 ] =  99 ;
	cntmas[ 28 ] =  42 ;
	cntmas[ 29 ] =  34 ;
	cntmas[ 30 ] =  80 ;
	cntmas[ 31 ] =  151 ;
	cntmas[ 32 ] =  42 ;
	cntmas[ 33 ] =  3 ;
	cntmas[ 34 ] =  80 ;
	cntmas[ 35 ] =  191 ;
	cntmas[ 36 ] =  42 ;
	cntmas[ 37 ] =  2 ;
	cntmas[ 38 ] =  80 ;
	cntmas[ 39 ] =  75 ;
	cntmas[ 40 ] =  42 ;
	cntmas[ 41 ] =  1 ;
	cntmas[ 42 ] =  80 ;
	cntmas[ 43 ] =  102 ;
	cntmas[ 44 ] =  42 ;
	cntmas[ 45 ] =  0 ;
	cntmas[ 46 ] =  80 ;
	cntmas[ 47 ] =  146 ;
	cntmas[ 48 ] =  42 ;
	cntmas[ 49 ] =  7 ;
	cntmas[ 50 ] =  80 ;
	cntmas[ 51 ] =  60 ;
	cntmas[ 52 ] =  42 ;
	cntmas[ 53 ] =  6 ;
	cntmas[ 54 ] =  80 ;
	cntmas[ 55 ] =  200 ;
	cntmas[ 56 ] =  42 ;
	cntmas[ 57 ] =  5 ;
	cntmas[ 58 ] =  80 ;
	cntmas[ 59 ] =  229 ;
	cntmas[ 60 ] =  42 ;
	cntmas[ 61 ] =  15 ;
	cntmas[ 62 ] =  80 ;
	cntmas[ 63 ] =  11 ;
	cntmas[ 64 ] =  42 ;
	cntmas[ 65 ] =  33 ;
	cntmas[ 66 ] =  80 ;
	cntmas[ 67 ] =  186 ;
	cntmas[ 68 ] =  42 ;
	cntmas[ 69 ] =  32 ;
	cntmas[ 70 ] =  80 ;
	cntmas[ 71 ] =  78 ;
	cntmas[ 72 ] =  42 ;
	cntmas[ 73 ] =  31 ;
	cntmas[ 74 ] =  80 ;
	cntmas[ 75 ] =  101 ;
	cntmas[ 76 ] =  42 ;
	cntmas[ 77 ] =  30 ;
	cntmas[ 78 ] =  80 ;
	cntmas[ 79 ] =  145 ;
	cntmas[ 80 ] =  42 ;
	cntmas[ 81 ] =  37 ;
	cntmas[ 82 ] =  80 ;
	cntmas[ 83 ] =  57 ;
	cntmas[ 84 ] =  42 ;
	cntmas[ 85 ] =  36 ;
	cntmas[ 86 ] =  80 ;
	cntmas[ 87 ] =  205 ;
	cntmas[ 88 ] =  42 ;
	cntmas[ 89 ] =  35 ;
	cntmas[ 90 ] =  80 ;
	cntmas[ 91 ] =  99 ;
	cntmas[ 92 ] =  42 ;
	cntmas[ 93 ] =  34 ;
	cntmas[ 94 ] =  80 ;
	cntmas[ 95 ] =  151 ;
	cntmas[ 96 ] =  42 ;
	cntmas[ 97 ] =  14 ;
	cntmas[ 98 ] =  80 ;
	cntmas[ 99 ] =  255 ;
	cntmas[ 100 ] =  42 ;
	cntmas[ 101 ] =  13 ;
	cntmas[ 102 ] =  80 ;
	cntmas[ 103 ] =  210 ;
	cntmas[ 104 ] =  42 ;
	cntmas[ 105 ] =  12 ;
	cntmas[ 106 ] =  80 ;
	cntmas[ 107 ] =  38 ;
	cntmas[ 108 ] =  42 ;
	cntmas[ 109 ] =  11 ;
	cntmas[ 110 ] =  80 ;
	cntmas[ 111 ] =  136 ;
	cntmas[ 112 ] =  42 ;
	cntmas[ 113 ] =  10 ;
	cntmas[ 114 ] =  80 ;
	cntmas[ 115 ] =  124 ;
	cntmas[ 116 ] =  42 ;
	cntmas[ 117 ] =  9 ;
	cntmas[ 118 ] =  80 ;
	cntmas[ 119 ] =  81 ;
	cntmas[ 120 ] =  42 ;
	cntmas[ 121 ] =  8 ;
	cntmas[ 122 ] =  80 ;
	cntmas[ 123 ] =  165 ;
	cntmas[ 124 ] =  42 ;
	cntmas[ 125 ] =  54 ;
	cntmas[ 126 ] =  80 ;
	cntmas[ 127 ] =  122 ;
	cntmas[ 128 ] =  42 ;
	cntmas[ 129 ] =  33 ;
	cntmas[ 130 ] =  80 ;
	cntmas[ 131 ] =  186 ;
	cntmas[ 132 ] =  42 ;
	cntmas[ 133 ] =  32 ;
	cntmas[ 134 ] =  80 ;
	cntmas[ 135 ] =  78 ;
	cntmas[ 136 ] =  42 ;
	cntmas[ 137 ] =  31 ;
	cntmas[ 138 ] =  80 ;
	cntmas[ 139 ] =  101 ;
	cntmas[ 140 ] =  42 ;
	cntmas[ 141 ] =  30 ;
	cntmas[ 142 ] =  80 ;
	cntmas[ 143 ] =  145 ;
	cntmas[ 144 ] =  42 ;
	cntmas[ 145 ] =  37 ;
	cntmas[ 146 ] =  80 ;
	cntmas[ 147 ] =  57 ;
	cntmas[ 148 ] =  42 ;
	cntmas[ 149 ] =  36 ;
	cntmas[ 150 ] =  80 ;
	cntmas[ 151 ] =  205 ;
	cntmas[ 152 ] =  42 ;
	cntmas[ 153 ] =  35 ;
	cntmas[ 154 ] =  80 ;
	cntmas[ 155 ] =  99 ;
	cntmas[ 156 ] =  42 ;
	cntmas[ 157 ] =  34 ;
	cntmas[ 158 ] =  80 ;
	cntmas[ 159 ] =  151 ;
	cntmas[ 160 ] =  42 ;
	cntmas[ 161 ] =  55 ;
	cntmas[ 162 ] =  80 ;
	cntmas[ 163 ] =  142 ;
	cntmas[ 164 ] =  42 ;
	cntmas[ 165 ] =  56 ;
	cntmas[ 166 ] =  80 ;
	cntmas[ 167 ] =  23 ;
	cntmas[ 168 ] =  42 ;
	cntmas[ 169 ] =  80 ;
	cntmas[ 170 ] =  80 ;
	cntmas[ 171 ] =  117 ;
	cntmas[ 172 ] =  42 ;
	cntmas[ 173 ] =  80 ;
	cntmas[ 174 ] =  80 ;
	cntmas[ 175 ] =  117 ;
	cntmas[ 176 ] =  42 ;
	cntmas[ 177 ] =  80 ;
	cntmas[ 178 ] =  80 ;
	cntmas[ 179 ] =  117 ;
	cntmas[ 180 ] =  42 ;
	cntmas[ 181 ] =  80 ;
	cntmas[ 182 ] =  80 ;
	cntmas[ 183 ] =  117 ;
	cntmas[ 184 ] =  42 ;
	cntmas[ 185 ] =  80 ;
	cntmas[ 186 ] =  80 ;
	cntmas[ 187 ] =  117 ;
	cntmas[ 188 ] =  42 ;
	cntmas[ 189 ] =  80 ;
	cntmas[ 190 ] =  80 ;
	cntmas[ 191 ] =  117 ;
	cntmas[ 192 ] =  42 ;
	cntmas[ 193 ] =  33 ;
	cntmas[ 194 ] =  80 ;
	cntmas[ 195 ] =  186 ;
	cntmas[ 196 ] =  42 ;
	cntmas[ 197 ] =  32 ;
	cntmas[ 198 ] =  80 ;
	cntmas[ 199 ] =  78 ;
	cntmas[ 200 ] =  42 ;
	cntmas[ 201 ] =  31 ;
	cntmas[ 202 ] =  80 ;
	cntmas[ 203 ] =  101 ;
	cntmas[ 204 ] =  42 ;
	cntmas[ 205 ] =  30 ;
	cntmas[ 206 ] =  80 ;
	cntmas[ 207 ] =  145 ;
	cntmas[ 208 ] =  42 ;
	cntmas[ 209 ] =  37 ;
	cntmas[ 210 ] =  80 ;
	cntmas[ 211 ] =  57 ;
	cntmas[ 212 ] =  42 ;
	cntmas[ 213 ] =  36 ;
	cntmas[ 214 ] =  80 ;
	cntmas[ 215 ] =  205 ;
	cntmas[ 216 ] =  42 ;
	cntmas[ 217 ] =  35 ;
	cntmas[ 218 ] =  80 ;
	cntmas[ 219 ] =  99 ;
	cntmas[ 220 ] =  42 ;
	cntmas[ 221 ] =  34 ;
	cntmas[ 222 ] =  80 ;
	cntmas[ 223 ] =  151 ;
	cntmas[ 224 ] =  42 ;
	cntmas[ 225 ] =  80 ;
	cntmas[ 226 ] =  80 ;
	cntmas[ 227 ] =  142 ;
	cntmas[ 228 ] =  42 ;
	cntmas[ 229 ] =  80 ;
	cntmas[ 230 ] =  80 ;
	cntmas[ 231 ] =  117 ;
	cntmas[ 232 ] =  42 ;
	cntmas[ 233 ] =  80 ;
	cntmas[ 234 ] =  80 ;
	cntmas[ 235 ] =  117 ;
	cntmas[ 236 ] =  42 ;
	cntmas[ 237 ] =  80 ;
	cntmas[ 238 ] =  80 ;
	cntmas[ 239 ] =  117 ;
	cntmas[ 240 ] =  42 ;
	cntmas[ 241 ] =  80 ;
	cntmas[ 242 ] =  80 ;
	cntmas[ 243 ] =  117 ;
	cntmas[ 244 ] =  42 ;
	cntmas[ 245] =  80 ;
	cntmas[ 246 ] =  80 ;
	cntmas[ 247 ] =  117 ;
	cntmas[ 248 ] =  42 ;
	cntmas[ 249 ] =  80 ;
	cntmas[ 250 ] =  80 ;
	cntmas[ 251 ] =  117 ;
	cntmas[ 252 ] =  42 ;
	cntmas[ 253 ] =  80 ;
	cntmas[ 254 ] =  80 ;
	cntmas[ 255 ] =  117 ;
end


initial begin						// Main
		repeat (30)@(posedge clk80MHz);
		RX = 1;
		repeat (300) begin					// 5 times
			j=0;
			wait(dirRX == 1);
			wait(dirRX == 0);

			repeat (30)@(posedge clk4_8MHz);
			repeat (8) begin				// 8 bytes
				repeat(10)@(posedge clk4_8MHz);
				RX = 0;
				repeat (8)					// 8 bit
				begin
					nowdata = cntmas[q];
					@(posedge clk4_8MHz)
					if(j == 0)
						RX = cntmas[q][i];
					else
						RX=data[j][i];
					i=i+1;
				end
				@(posedge clk4_8MHz);
				RX = 1;
				
				j=j+1;
			end
			q = q+1;
		end
		$stop;
	end
endmodule