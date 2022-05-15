module majority3(
	// Clock Input (50 MHz)
	input CLOCK_50,
	// Push Buttons
	input [3:0] KEY,
	// DPDT Switches
	input [17:0] SW,
	// 7-SEG Displays
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
	// LEDs
	output [8:0] LEDG, // LED Green[8:0]
	output [17:0] LEDR, // LED Red[17:0]
	output [3:0] result1,result2,result3,
	output f1,f2,f3,
	// GPIO Connections
	inout [35:0] GPIO_0, GPIO_1
);
	// set all inout ports to tri-state
	assign GPIO_0 = 36'hzzzzzzzzz;
	assign GPIO_1 = 36'hzzzzzzzzz;
	// Connect dip switches to red LEDs
	assign LEDR[17:0] = SW[17:0];
	assign LEDR[17]= SW[17];
	assign LEDR[16] = SW[16];
	// turn off green LEDs
	assign LEDG[8:0] = 0;
	wire [15:0] A;
	// map to 7-segment displays
	main_code(A[3],A[2],A[1],A[0],f1,f2,f3);
	assign result1[0] = f1; //Send f1 to result1
	assign result2[0] = f2; // Send f2 to result2
	assign result3[0]= f3; // Send f3 to result3
	hex_7seg(result1,HEX0); // We are calling a module called hex_7seg
	hex_7seg(result2,HEX1);
	hex_7seg(result3,HEX2);
	wire [6:0] blank = ~7'h00;
	// blank remaining digits
	assign HEX3 = blank;
	assign HEX4 = blank;
	assign HEX5 = blank;
	assign HEX6 = blank;
	assign HEX7 = blank;
	assign A = SW[15:0];
endmodule


//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑         卡諾圖圈對
//               compile          一次過
//               板子             不要壞掉
//