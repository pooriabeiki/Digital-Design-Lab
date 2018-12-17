module multiplexer(a,b,select,result);
    input [63:0] a;
    input [63:0] b;
    input select;
    output reg [63:0] result;
     
    always @(a,b,select) must be removed
    begin
    if(select)
        result=b;
    else
        result=a;
    end    
endmodule 