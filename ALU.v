module ALU(
	input [3:0] ALUop,
	input signed [31:0] alu_a,
	input signed [31:0] alu_b,
	output reg signed [31:0] Result,
	output Zero
); 


wire carry, Inv_a, Inv_b;
wire [31:0] a,b;
assign Zero = ~|Result;
assign a = alu_a;
assign b = alu_b;

always @(*)
begin
	case(ALUop)
		4'h0 : Result = a & b;
		4'h1 : Result = a | b;
		4'h2 : Result = a + b;
		4'h7 : Result = a < b;
		4'h8 : Result = a <= b;//
		4'hc : Result = ~(a | b);
	endcase
end

assign overflow = (ALUop == 4'd2) && (Result[31] ^ alu_a[31]) & (Result[31] ^ alu_b[31]);

endmodule