module pc(clk, rst, w, oldpc,newpc);
input clk;
input rst;
input w;
input [63:0] oldpc;
output reg [63:0] newpc;

always@(posedge clk)
begin
	if(rst)
	begin
		newpc<=0;
	end
	esle if(w)
	begin
		newpc <= oldpc;
	end 
		
end
endmodule
