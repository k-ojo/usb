`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: Department of COmputer Engineering, KNUST
// Engineer:	Maruf Usman
//
// Create Date:   11:29:21 07/09/2025
// Design Name:   usb_line_decoder
// Module Name:   C:/Users/HP/Desktop/Xilinx/usb-main/usb_line_decoder_testbench.v
// Project Name:  usb-main
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: usb_line_decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module usb_line_decoder_testbench;

	// Inputs
	reg usb_dp;
	reg usb_dn;

	// Outputs
	wire [1:0] usb_line_state;

	// Instantiate the Unit Under Test (UUT)
	usb_line_decoder uut (
		.usb_dp(usb_dp), 
		.usb_dn(usb_dn), 
		.usb_line_state(usb_line_state)
	);

	initial begin
		// Initialize Inputs
		#100;
		usb_dp = 0;
		usb_dn = 0;

		// Wait 100 ns for global reset to finish
		#100;
      usb_dp = 1;
		usb_dn = 0;

		#100;
		usb_dp = 0;
		usb_dn = 1;
		// Add stimulus here

	end
      
endmodule

