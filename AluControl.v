module ALUControl (ALUOp, ALUOp, instruction, code);

    input ALUOp;
    input [31:0] instruction;
    output reg [3:0] code;

    always @ (ALUOp, instruction) begin

        casex(ALUOp)
        
            2'b00: code = 4'b0010;
            2'bx1: code = 4'b0111;
            2'b1x: 
                casex(instruction)

                    11'b10001011000: code = 0010;
                    11'b11001011000: code = 0110;
                    11'b10001010000: code = 0000;
                    11'b10101010000: code = 0001;
                
                endcase

        endcase

    end

endmodule 