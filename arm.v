module arm_tb;

reg pc_reset;
wire [63:0]oldpc;
wire [63:0]newpc;
wire clk ;

wire [31 : 0] instruction;

wire reg_to_loc;
wire branch;
wire mem_read;
wire mem_to_reg;
wire [1:0]Alu_Op;
wire mem_write;
wire alu_src;
wire reg_write;

wire [4  : 0] output_register_bank_multiplexer;

wire [63:0] datain;
wire [63:0] dataout;
wire zero_alu;



    wire [5  : 0] alu_opcode;
    
    wire [63 : 0] output_pc_adder, output_data_memory, output_alu, reg_data_1, reg_data_2, output_alu_multiplexer, input_data_register, output_sign_extend, output_shift_unit, output_shift_unit_adder;


initial 
begin
	
	pc_reset=1;
	
	#100 pc_reset =0;
end


oc os0(clk);
pc pc0(clk,pc_reset,1,newpc,oldpc);
adder adder0(oldpc,64'b100,newpc);
InstructionMemory instruction_memory (oldpc,instruction);
ControlUnit control_unit (instruction[31 : 21],reg_to_loc,branch,mem_read,mem_to_reg,Alu_Op,mem_write,alu_src,reg_write);
multiplexer RB_multiplexer(instruction[20 : 16],instruction[4 : 0],reg_to_loc,output_register_bank_multiplexer);//,size(5)
registerBank register_bank (instruction[9 : 5],instruction[4 : 0],output_register_bank_multiplexer,input_data_register,clk,reg_write,reg_data_1,reg_data_2);
multiplexer alu_multiplexer(reg_data_2,output_sign_extend,alu_src,output_alu_multiplexer);
alu alu1 (reg_data_1,output_alu_multiplexer,alu_opcode,output_alu,zero_alu);
ShiftUnit shift_unit (output_sign_extend,output_shift_unit);
SignExtend sign_extend (instruction,output_sign_extend);
adder shift_unit_adder(oldpc,output_shift_unit,output_shift_unit_adder);
multiplexer shift_unit_multiplexer (output_pc_adder,output_shift_unit_adder,branch & zero_alu,new_pc);
Datamemory data_memory (output_alu,reg_data_2,mem_write,mem_read,clk,output_data_memory);
multiplexer data_memory_multiplexer (output_data_memory,output_alu,mem_to_reg,input_data_register);
ALUControl alu_control_unit (Alu_Op,instruction[31 : 21],alu_opcode);
endmodule 