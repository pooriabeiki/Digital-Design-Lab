`default_nettype none

module arm_tb_pipeline;

reg pc_reset;
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

wire zero_alu;
wire [3  : 0] alu_opcode;
wire [63 : 0] output_pc_adder, output_data_memory, output_alu, reg_data_1, reg_data_2, output_alu_multiplexer, input_data_register, output_sign_extend, output_shift_unit, output_shift_unit_adder;

wire [63:0] Fpc , Spc;
wire [31:0] Fins, Sins;

wire [63:0] Tpc , Sread1 , Sread2,Tread1,Tread2,Ssign,Tsign;
wire [10:0] Sins11 , Tins11;
wire [4:0] Sins5 , Tins5;
wire Salu_src , Talu_src , Smem_to_reg , Tmem_to_reg , Sreg_write , Treg_write , Smem_read , Tmem_read;
wire Smem_write, Tmem_write, Sbranch,Tbranch;
wire [1:0] Salu_op,Talu_op;
//Spc,Sread1,Sread2,Ssign,Sins11,Sins5,Salu_src,Smem_to_reg,Sreg_write,Smem_read,Smem_write,Sbranch,Salu_op
//Tpc,Tread1,Tread2,Tsign,Tins11,Tins5,Talu_src,Tmem_to_reg,Treg_write,Tmem_read,Tmem_write,Tbranch,Talu_op

wire [4:0] Foins5;
wire [63:0] Foread2;
wire [63:0] Talu_result,Foalu_result , Tadd_result,Foadd_result;
wire Tzero,Fozero,Fomem_to_reg,Foreg_write,Fomem_read,Fomem_write,Fobranch;
//Foins5,Foread2,Foalu_result,Foadd_result,Fozero,Foreg_write,Fomem_read,Fomem_write,Fobranch
//Tins5,Tread2,Talu_result,Tadd_result,Tzero,Treg_write,Tmem_read,Tmem_write,Tbranch

wire [63:0] Fialu_result ,Fomem_out,Fimem_out;
wire [4:0] Fiins5;
wire Fimem_to_reg,Fireg_write;
//Fialu_result,Fimem_out,Fiins5,Fimem_to_reg,Fireg_write
//Foalu_result,Fomem_out,Foins5,Fomem_to_reg,Foreg_write

initial 
begin
	
	pc_reset=1;
	
	#250 pc_reset =0;
end


oc os0(clk);
multiplexer shift_unit_multiplexer (output_pc_adder,output_shift_unit_adder,Fobranch & Fozero,newpc);
pc pc0(clk,pc_reset,newpc,Fpc);
adder adder0(Fpc,64'b100,output_pc_adder);
InstructionMemoryPipeLine instruction_memory (Fpc,Fins);

pc #(.size(96)) Register1(clk,pc_reset,{Fpc,Fins},{Spc,Sins});

ControlUnit control_unit (Sins[31 : 21],reg_to_loc,Sbranch,Smem_read,Smem_to_reg,Salu_op,Smem_write,Salu_src,Sreg_write);
multiplexer #(.size(5)) RB_multiplexer(Sins[20 : 16],Sins[4 : 0],reg_to_loc,output_register_bank_multiplexer);//,size(5)
registerBank register_bank (Sins[9 : 5],output_register_bank_multiplexer,Fiins5,input_data_register,clk,Fireg_write,Sread1,Sread2);
SignExtend sign_extend (Sins,Ssign);

pc #(.size(280)) Register2(clk,pc_reset,{Spc,Sread1,Sread2,Ssign,Sins[31 : 21],Sins[4 : 0],Salu_src,Smem_to_reg,Sreg_write,Smem_read,Smem_write,Sbranch,Salu_op},{Tpc,Tread1,Tread2,Tsign,Tins11,Tins5,Talu_src,Tmem_to_reg,Treg_write,Tmem_read,Tmem_write,Tbranch,Talu_op});

multiplexer alu_multiplexer(Tread2,Tsign,Talu_src,output_alu_multiplexer);
alu alu1 (Tread1,output_alu_multiplexer,alu_opcode,Talu_result,Tzero);
ALUControl alu_control_unit (Talu_op,Tins11,alu_opcode);
ShiftUnit shift_unit (Tsign,output_shift_unit);
adder shift_unit_adder(Tpc,output_shift_unit,Tadd_result);

pc #(.size(203)) Register3(clk,pc_reset,{Tins5,Tread2,Talu_result,Tadd_result,Tzero,Treg_write,Tmem_read,Tmem_write,Tbranch,Tmem_to_reg},{Foins5,Foread2,Foalu_result,Foadd_result,Fozero,Foreg_write,Fomem_read,Fomem_write,Fobranch,Fomem_to_reg});

Datamemory data_memory (Foalu_result,Foread2,Fomem_write,Fomem_read,clk,Fomem_out);

pc #(.size(135)) Register4(clk,pc_reset,{Foalu_result,Fomem_out,Foins5,Fomem_to_reg,Foreg_write},{Fialu_result,Fimem_out,Fiins5,Fimem_to_reg,Fireg_write});

multiplexer data_memory_multiplexer (Fialu_result,Fimem_out,Fimem_to_reg,input_data_register);

endmodule 