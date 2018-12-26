module pc(clk, rst, w, oldpc,newpc);
input clk;
input rst;
input w;
input [63:0] oldpc;
output reg [63:0] newpc;

always @(clk)
begin
	if(rst)
	begin
		newpc<=0;
	end
		
end
always @(posedge clk)
begin
	newpc <= oldpc;
end
endmodule
