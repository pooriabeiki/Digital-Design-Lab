module SignExtend( extend, extended );
input[31:0] extend;
output[63:0] extended;

reg[63:0] extended;

always@(extend)
begin
    if (extend[31:26] == 6'b000101) //b-type
	begin
      
        extended[25:0] = extend[25:0];
        extended[63:26] = {38{extended[25]}};
      
    end 
	else if (extend[31:24] == 8'b10110100)//cbz-type 
	begin 

        extended[19:0] = extend[23:5];
        extended[63:20] = {44{extended[19]}};
        
    end 
	else//d-type 
	begin 
        extended[9:0] = extend[20:12];
        extended[63:10] = {54{extended[9]}};
    end
end
endmodule 
