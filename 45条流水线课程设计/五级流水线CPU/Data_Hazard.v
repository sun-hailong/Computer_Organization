module Data_Hazard(Mem_RegWr,Mem_Reg,EX_rs,EX_rt,EX_ALUSrc,Wr_RegWr,Wr_Reg,ALUSrcA,ALUSrcB);
	input	Mem_RegWr,Wr_RegWr,EX_ALUSrc;
	input[4:0]	Mem_Reg,Wr_Reg,EX_rs,EX_rt;
	
	wire	C1A,C1B,C2A,C2B;
	
	assign	C1A = Mem_RegWr && (Mem_Reg != 0) && (Mem_Reg == EX_rs);
	assign	C1B = Mem_RegWr && (Mem_Reg != 0) && (Mem_Reg == EX_rt);
	assign	C2A = Wr_RegWr && (Wr_Reg != 0) && ((Mem_Reg != EX_rs)||(Mem_Reg == EX_rs && Mem_RegWr == 0)) && (Wr_Reg == EX_rs);
	assign	C2B = Wr_RegWr && (Wr_Reg != 0) && ((Mem_Reg != EX_rt)||(Mem_Reg == EX_rt && Mem_RegWr == 0)) && (Wr_Reg == EX_rt);

	output reg[1:0]	ALUSrcA,ALUSrcB;

	initial
	begin
		ALUSrcA = 0;
		ALUSrcB = 0;
	end

	always@(C1A or C2A)
	begin
		if(C1A == 1)	ALUSrcA <= 2'b01;
		if(C2A == 1)	ALUSrcA <= 2'b10;
		if(C1A != 1 && C2A != 1)	ALUSrcA <= 2'b00;
	end

	always@(C1B or C2B or EX_ALUSrc)
	begin
		if(C1B == 1)	ALUSrcB <= 2'b01;
		if(C2B == 1)	ALUSrcB <= 2'b10;
		if(C1B != 1 && C2B != 1 && EX_ALUSrc == 0)	ALUSrcB <= 2'b00;
		if(C1B != 1 && C2B != 1 && EX_ALUSrc == 1)	ALUSrcB <= 2'b11;
	end
			

endmodule
