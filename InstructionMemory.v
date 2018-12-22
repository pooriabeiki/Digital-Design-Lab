module InstructionMemory  #(parameter size = 256) ( 
  input [63 : 0] adr,
  output [31 : 0] Instruction
  );
  
  reg [7 : 0] Memory [0 : size-1];
  
  assign Instruction[7 : 0] = Memory[adr]; 
  assign Instruction[15 : 8] = Memory[adr + 1];
  assign Instruction[23 : 16] = Memory[adr + 2];
  assign Instruction[31 : 24] = Memory[adr + 3];

endmodule     
