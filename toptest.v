`timescale 1ns / 1ps

module toptest;

	reg clk;
	reg rst_n;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
        rst_n = 0;
		// Wait 100 ns for global reset to finish
		#100;
		rst_n = 1;
		forever #5 clk <= ~clk;
		// Add stimulus here

	end
endmodule

