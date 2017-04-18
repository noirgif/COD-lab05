module control(
	input [5:0] op,
	input [5:0] funct,
	output RegDst,
	output ALUSrc,
	output MemtoReg,
	output RegWrite,
	output MemRead,
	output MemWrite,
	output Branch,
	output [3:0]ALUOp,
	output Jump
);

parameter ADD = 6'b0;
parameter ADDI = 6'b1000;
parameter AND = 6'b0;
parameter BGTZ = 6'b111;
parameter J = 6'b10;
parameter LW = 6'b100011;
parameter SW = 6'b101011;
parameter ORI = 6'b001101;


reg [11:0] pack;
assign Jump = pack[11];
assign ALUOp = pack[10:7];
assign Branch = pack[6];
assign MemWrite = pack[5];
assign MemRead = pack[4];
assign RegWrite = pack[3];
assign MemtoReg = pack[2];
assign ALUSrc = pack[1];
assign RegDst = pack[0];


always @*
begin
	case(op)
		ADD: pack = 'b0_0010_0_001_001;
		ADDI:pack = 'b0_0010_0_001_010;
		BGTZ:pack = 'b0_1000_1_000_01x;
		J:   pack = 'b1_xxxx_x_000_xxx;
		LW:  pack = 'b0010_0_011_110;
		ORI: pack = 'b0001_0_001_010;
		SW:  pack = 'b0010_0_100_x1x;
		default:
			pack = 0;
	endcase
end

endmodule
