module reg_file(
	input	clk,
	input	rst_n,
	input[4:0]	r1_addr,
	input[4:0]	r2_addr,
	input[4:0]	r3_addr,
	input[31:0]	r3_din,
	input		r3_wr,
	output	[31:0]	r1_dout,
	output	[31:0]	r2_dout
);

reg	[31:0] reg_file[31:0];
integer i;
always @(posedge clk, negedge rst_n)
begin
	if(~rst_n)
	begin
		for(i = 0;i <= 31;i = i + 1)
			reg_file[i] <= 0;
	end
	else
	begin
		if(r3_wr)
			reg_file[r3_addr] <= r3_din;
	end
end

assign r1_dout = reg_file[r1_addr];
assign r2_dout = reg_file[r2_addr];
endmodule
