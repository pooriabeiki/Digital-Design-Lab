module arm_tb;
wire [63:0]oldpc;
wire [63:0]newpc;
wire [63:0] datain;
wire [63:0] dataout;
reg pc_reset;
initial 
begin
	pc_reset=1;
	#100 pc_reset =0;
end
wire clk;
pc pc0(clk,pc_reset,0,newpc,oldpc);
os os0(clk);
adder adder0(oldpc,64'b100,newpc);
memory memory0(oldpc,datain,1'b0,1'b1,clk,dataout);
endmodule 