module IUnit(PC,IF_PC,instruction);
	input[31:2]	PC;
	output[31:2]	IF_PC;
	output[31:0]	instruction;

	im_4k imD(PC[11:2],instruction);
	assign	IF_PC = PC + 1;
endmodule 
