module ControlUnit(

  input [10 : 0] OpCode,
  output Reg2Loc,
  output Branch,
  output MemRead,
  output MemtoReg,
  output [1:0]Aluop,
  output MemWrite,
  output AluSrc,
  output RegWrite
);
reg [8:0] outcome;
assign  {Reg2Loc ,AluSrc ,MemtoReg ,RegWrite ,MemRead ,Memwrite ,Branch } = outcome[8:2];
assign Aluop = outcome[1:0];
always @( OpCode )
casex(OpCode)
	11'b1xx0101x000: outcome = 9'b000100010;
        11'b11111000010: outcome = 9'bx11110000;
        11'b11111000000: outcome = 9'b11x001000;
        11'b10110100xxx: outcome = 9'b10x000101;
endcase
    
endmodule
