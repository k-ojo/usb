`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: Department of Computer Engineering, KNUST
// Engineer: Maruf Usman
//
// Testbench for: usb_line_decoder
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
		$dumpfile("build/wave.vcd");
		$dumpvars(0, usb_line_decoder_testbench);

		// Initialize Inputs
		usb_dp = 0;
		usb_dn = 0;
		#100;

		usb_dp = 1;
		usb_dn = 0;
		#100;

		usb_dp = 0;
		usb_dn = 1;
		#100;

		$finish;
	end

endmodule
