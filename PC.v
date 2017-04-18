module pc(
	input clk,
	input PCSrc,
	input [31:0] SignImm,
	input [25:0] jaddr,
	input Jump,

	output reg [31:0] PC,
	output [31:0] PCPlus
);

wire [31:0] PCj, PCb;

assign PCPlus = PC + 4;
assign PCj = Jump ? {PCPlus[31:28], jaddr, 2'b0} : PCb;
assign PCb = PCSrc ? PCPlus + (SignImm << 2) : PCPlus;


always @(posedge clk)
begin
	PC <= PCj;
end

initial
    PC = 0;


endmodule

