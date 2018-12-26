module oc(output reg clk);

initial 
begin 
	clk = 0;
end

always
begin 
	#100 clk = 1;
	#100 clk = 0;
end 
endmodule 