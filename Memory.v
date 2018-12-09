module memory (
input wire [63:0] adr,          // Memory Address
input wire [63:0] datain,    // Memory Address Contents
input wire w, r,
input wire clk,                  // All synchronous elements, including memories, should have a clock signal
output reg [63:0] dataout      
);

reg [63:0] MEMO[0:255];  

always @(posedge clk)
begin
	if (w == 1'b1) 
	begin
    		MEMO[adr] <= datain;
  	end

end

assign dataout = ()? MEMO[adr]:z;

endmodule 