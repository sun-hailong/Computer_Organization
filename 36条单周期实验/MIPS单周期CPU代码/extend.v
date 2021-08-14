module extend(imm16, op, imm32);
	input[15:0] imm16;
	input[1:0] op; //1 is sign_ext, 0 is zero_ext
	output[31:0] imm32;
	reg[31:0] imm32;
	
	always @(*) begin
		if(op == 2'b00)
			imm32 <= {16'b0, imm16};
		else if(op == 2'b01)
			imm32 <= {{16{imm16[15]}}, imm16};
		else if(op == 2'b10)
			imm32 <= {imm16, 16'b0};
	end
endmodule