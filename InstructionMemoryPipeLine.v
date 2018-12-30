module InstructionMemoryPipeLine  #(parameter size = 256) ( 
  input [63 : 0] adr,
  output [31 : 0] Instruction
  );
  
reg [7 : 0] Memory [0 : size-1];
integer i;
  initial 
  begin
	  	for(i = 0;i < 256; i = i + 1)
			Memory[i] <= 0;

		Memory[0] <= 8'hE5;
		Memory[1] <= 8'h03;
		Memory[2] <= 8'h1F;
		Memory[3] <= 8'h8B;
		

		Memory[16] <= 8'hA4;
		Memory[17] <= 8'h00;
		Memory[18] <= 8'h40;
		Memory[19] <= 8'hF8;
		

		Memory[32] <= 8'h86;
		Memory[33] <= 8'h00;
		Memory[34] <= 8'h04;
		Memory[35] <= 8'h8B;
	

		Memory[48] <= 8'hA6;
		Memory[49] <= 8'h10;
		Memory[50] <= 8'h00;
		Memory[51] <= 8'hF8;
		
  end

  assign Instruction[7 : 0] = Memory[adr + 0]; 
  assign Instruction[15 : 8] = Memory[adr + 1];
  assign Instruction[23 : 16] = Memory[adr + 2];
  assign Instruction[31 : 24] = Memory[adr + 3];

endmodule     
