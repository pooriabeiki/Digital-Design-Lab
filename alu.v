module alu(
	input [63:0] A,B,  // ALU 8-bit Inputs                 
        input [3:0] ALU_Sel,// ALU Selection
        output [63:0] ALU_Out, // ALU 8-bit Output
	
        output z // Carry Out Flag
	);
    	reg [63:0] ALU_Result;
    	assign ALU_Out = ALU_Result;
	reg z_Result;
	assign z = z_Result; 
    	always @(A,B,ALU_Sel)	
    	begin
        case(ALU_Sel) 
		4'b0000: // And
        		ALU_Result = A & B ;
        	4'b0001: // Or
        		ALU_Result = A | B ;
        	4'b0010: // Add
           		ALU_Result = A + B;
         	4'b0110: // Sub
           		ALU_Result = A - B;
         	4'b0111: //Pass input b
           		ALU_Result = B;
          	4'b1100: //  Nor
           		ALU_Result = ~(A | B);
        endcase
	if(ALU_Result == 64'b0)
	begin 
		z_Result <= 1;
	end
	else
	begin
		z_Result <= 0;
	end
    end

endmodule