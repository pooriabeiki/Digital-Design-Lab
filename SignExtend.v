module SignExtend( extend, extended );
input[31:0] extend;
output[63:0] extended;

reg[63:0] extended;
wire[31:0] extend;

base on cb-type (b-type , ..) immediate part 
always@(extend)
begin
    extended[31:0] = extend[31:0];
    extended[63:32] = {32{extend[31]}};
end
endmodule 
