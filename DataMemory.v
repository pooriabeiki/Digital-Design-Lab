module Datamemory (
input wire [63:0] adr,          // Memory Address
input wire [63:0] datain,    // Memory Address Contents
input wire w, r,
input wire clk,                  // All synchronous elements, including memories, should have a clock signal
output [63:0] dataout      
);

reg [63:0] MEMO[0:255];

integer i;
initial
begin
	for( i = 0; i < 255; i = i + 1) 
		MEMO[i] = 1;
end  

always @(posedge clk)
begin
	if (w == 1'b1) 
	begin
    		MEMO[adr] <= datain;
  	end

end

assign dataout = (r == 1'b1)? MEMO[adr]:{(64){1'bz}};

endmodule 
