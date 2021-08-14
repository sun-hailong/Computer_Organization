module mux32(a, b, c, dout);//ok
	input[31:0] a;
	input[31:0] b;
	input c;
	output[31:0] dout;

	assign dout = c ? b : a;

endmodule