module InstructionMemory  #(parameter size = 256) ( 
  input [63 : 0] adr,
  output [31 : 0] Instruction
  );
  
reg [7 : 0] Memory [0 : size-1];

  initial 
  begin
		Memory[0] = 8'h8b;
		Memory[1] = 8'h1f;
		Memory[2] = 8'h03;
		Memory[3] = 8'he5;

		Memory[4] = 8'hf8;
		Memory[5] = 8'h40;
		Memory[6] = 8'h00;
		Memory[7] = 8'ha4;

		Memory[8] = 8'h8b;
		Memory[9] = 8'h04;
		Memory[10] = 8'h00;
		Memory[11] = 8'h86;

		Memory[12] = 8'hf8;
		Memory[13] = 8'h00;
		Memory[14] = 8'h10;
		Memory[15] = 8'ha6;
		
  end
 
  
  assign Instruction[7 : 0] = Memory[0]; 
  assign Instruction[15 : 8] = Memory[0 + 1];
  assign Instruction[23 : 16] = Memory[0 + 2];
  assign Instruction[31 : 24] = Memory[0 + 3];

endmodule     
