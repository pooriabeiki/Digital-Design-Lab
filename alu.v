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
        	4'b0001: // Subtraction
        		ALU_Result = A - B ;
        	4'b0010: // Multiplication
           		ALU_Result = A * B;
        	4'b0011: // Division
           		ALU_Result = A/B;
        	4'b0100: // Logical shift left
           		ALU_Result = A<<1;
         	4'b0101: // Logical shift right
           		ALU_Result = A>>1;
         	4'b0110: // Rotate left
           		ALU_Result = {A[6:0],A[7]};
         	4'b0111: // Rotate right
           		ALU_Result = {A[0],A[7:1]};
          	4'b1000: //  Logical and 
           		ALU_Result = A & B;
          	4'b1001: //  Logical or
           		ALU_Result = A | B;
          	4'b1010: //  Logical xor 
           		ALU_Result = A ^ B;
          	4'b1011: //  Logical nor
           		ALU_Result = ~(A | B);
          	4'b1100: // Logical nand 
           		ALU_Result = ~(A & B);
          	4'b1101: // Logical xnor
           		ALU_Result = ~(A ^ B);
          	4'b1110: // Greater comparison
           		ALU_Result = (A>B)?8'd1:8'd0 ;
          	4'b1111: // Equal comparison   
            		ALU_Result = (A==B)?8'd1:8'd0 ;
          	default: ALU_Result = A + B ; 
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