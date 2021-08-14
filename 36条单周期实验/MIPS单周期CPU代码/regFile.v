module regFile (op,PC,ALU_re,rs,rt,rd,shamt,func,data,RegWr,RegDst,ra,rb,clk,rst);
    input[5:0]	op;
	input[31:2]	PC;
	input[31:0]	ALU_re;//result
	input[4:0]	rs,rt,rd,shamt;
	input[5:0]	func;
	input[31:0]	data;
	input		RegWr;
	input		RegDst;
	input 		clk;
	input		rst;
	output[31:0]	ra,rb;

    reg[31:0]	rf[31:0];
    assign	ra = (rs != 0) ? rf[rs] : 0;
	assign	rb = (rt != 0) ? rf[rt] : 0;
    integer i;

    always @(negedge clk or posedge rst) begin
        if(rst == 1) begin
            for(i = 0; i < 32; i = i + 1)
                rf[i] <= 32'b0;
        end

        if(RegWr == 1) 
            case(op)
                6'b100000://lb
                    begin
                        if(ALU_re[1:0] == 2'b00)		rf[rt]<={{24{data[7]}}, data[7:0]};
                        if(ALU_re[1:0] == 2'b01)		rf[rt]<={{24{data[15]}}, data[15:8]};
                        if(ALU_re[1:0] == 2'b10)		rf[rt]<={{24{data[23]}}, data[23:16]};					
                        if(ALU_re[1:0] == 2'b11)		rf[rt]<={{24{data[31]}}, data[31:24]};
                    end
                6'b100100://lbu
                    begin
                        if(ALU_re[1:0] == 2'b00)		rf[rt]<={{24'b0}, data[7:0]};
                        if(ALU_re[1:0] == 2'b01)		rf[rt]<={{24'b0}, data[15:8]};
                        if(ALU_re[1:0] == 2'b10)		rf[rt]<={{24'b0}, data[23:16]};					
                        if(ALU_re[1:0] == 2'b11)		rf[rt]<={{24'b0}, data[31:24]};
                    end	
                6'b001111: rf[rt] <= {rd, shamt, func, 16'b0};//lui
                6'b000011: rf[31] <= {(PC + 1), 2'b00};//jal
                default:    
                    begin
                        if(func == 6'b001001)
                            rf[31] <= {(PC + 1), 2'b00};//jalr
                        else if(RegDst == 1)	rf[rd] <= data;
                        else rf[rt] <= data;
                    end 
				endcase
    end
endmodule