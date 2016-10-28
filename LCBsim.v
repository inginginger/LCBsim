module LCBsim(
input clk80MHz,
output dirRX,//dirTX от яфк
output dirTX,//dirRX от яфк
input RX,//TX от яфк
output [7:0] DataFromCFM,
output ValRX,
output LCBreq,
output test1,
output test2,
output test3,
output TX//RX для яфк
//output rst
);
wire [4:0] ans_addr;
wire [7:0] ans_data;
wire rst;
wire clk4_8MHz;
//wire LCBreq;
//wire ValRX;
//wire [7:0] DataFromCFM;
//assign test = ans_addr[4];
assign test1 = LCBreq;
assign test2 = ValRX;
assign test3 = TX;
globalReset inst1(
	.clk(clk80MHz),	// 40 MHz
	.rst(rst)			// global enable
);

pll mypll(
	.inclk0(clk80MHz),
	.c0(clk4_8MHz)
	);

UART_RX inst2(
	.clk(clk80MHz),
	.reset(rst),
	.RX(RX),
	.oValid(ValRX),
	.oData(DataFromCFM),
	//.RQ(LCBreq)
);

RQform inst3(
	.clk80MHz(clk80MHz),
	.rst(rst),
	.val(ValRX),
	.RQ(LCBreq));

/*answers inst4(
	.clk80MHz(clk80MHz),
	.rst(rst),
	.addr(ans_addr),
	.data(ans_data)
);*/

UART_TX inst5(
	.reset(rst),          // global reset and enable signal
	.clk(clk4_8MHz),            // actual needed baudrate
	.RQ(LCBreq),
	//.cycle(cycle + 1'b1),  // number of the request (from m8) + shift, to give LCB time to respond
	//.data(ans_data),      // data to transmit (from ROM)
	.addr(ans_addr),      // address to read (to ROM)
	.tx(TX),          // serial transmitted data
	.dirTX(dirTX),        // rs485 TX dir controller 
	.dirRX(dirRX),        // rs485 RX dir controller
	.switch(switch)
);

endmodule
