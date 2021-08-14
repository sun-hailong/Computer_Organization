module datapath(RegDst,RegWr,ALUSrc,MemWr,MemtoReg,ExtOp,ALUctr,Branch,Jump,clk,reset,instruction);
	input		RegDst,RegWr,ALUSrc,MemWr,MemtoReg,Branch,clk,reset,Jump;
	input[1:0]	ExtOp;
	input[4:0]	ALUctr;
	output[31:0]	instruction;

	wire[31:2]	PC;
	wire[31:2]	NPC;
	wire		zero;
	wire[31:0]	ALU_result;
	wire[31:0]	exout;
	wire[31:0]	r1,r2;
	wire[31:0]	data2;
	wire[31:0]	wdata;
	wire[31:0]	dout;

	PC PC_(NPC,reset,clk,PC);
	NPC NPC_(PC,NPC,Jump,Branch,zero,instruction[31:26],instruction[25:0],instruction[15:0],r1,instruction[25:21],instruction[20:16],instruction[15:11],instruction[10:6],instruction[5:0]);
	im IM_(PC[11:2],instruction);

	regFile RF_(instruction[31:26],PC,ALU_result,instruction[25:21],instruction[20:16],instruction[15:11],instruction[10:6],instruction[5:0],wdata,RegWr,RegDst,r1,r2,clk,reset);//maybe NPC
	extend EXT_(instruction[15:0],ExtOp,exout);
	mux32 mux1(r2,exout,ALUSrc,data2);
	ALU ALU_(ALUctr,r1,data2,exout,instruction[10:6],ALU_result,zero);
	dm DM_(instruction[31:26],ALU_result,r2,dout,clk,MemWr);
	mux32 mux2(ALU_result,dout,MemtoReg,wdata);
		
endmodule