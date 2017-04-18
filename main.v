module main(
	input clk,
	input rst_n
);

wire [31:0] Instr, PC, ALUResult, WriteData, ReadData, RD1, RD2, SrcA, SrcB, PCPlus, SignImm;
wire [4:0] Regfile_A3;
wire [3:0] ALUOp;
wire ALUSrc, MemtoReg, RegDst, Zero;

assign SrcA = RD1;
assign WriteData = RD2;

and branch(
    PCSrc,
    Zero,
    Branch
);

textrom text_rom(
    .a(PC),
    .spo(Instr)
);
 
dataram data_ram (
  .a(ALUResult),        // input wire [9 : 0] a
  .d(WriteData),        // input wire [31 : 0] d
  .clk(clk),    // input wire clk
  .we(MemWrite),      // input wire we
  .spo(ReadData)    // output wire [31 : 0] dpo
);

ALU mainALU (
    ALUOp,
    SrcA,
    SrcB,
    ALUResult,
    Zero
);

Ext SignExt(
    1'b1,
    Instr[15:0],
    SignImm
);

pc prog_cnt(
    clk,
	PCSrc,
	SignImm,
	Instr[25:0],
	Jump,

	PC,
	PCPlus
);
    

control ct1 (
    Instr[31:26],
    Instr[5:0],
	RegDst,
	ALUSrc,
	MemtoReg,
	RegWrite,
	MemRead,
	MemWrite,
	Branch,
	ALUOp,
	Jump
);

reg_file Reg(
    clk,
    rst_n,
    Instr[25:21],
    Instr[20:16],
    Regfile_A3,
    Result,
    RegWrite,
    RD1,
    RD2
);
    
    

mux alumux(
    ALUSrc,
    RD2,
    SigImm,
    SrcB
);

mux resmux(
    MemtoReg,
    ALUResult,
    ReadData,
    Result
);

mux regmux(
    RegDst,
    {27'd0,Instr[20:16]},
    {27'd0,Instr[15:11]},
    Regfile_A3
);


    
endmodule