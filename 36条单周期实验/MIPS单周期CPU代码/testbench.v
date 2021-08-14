module testbench();

	reg clk;
	reg rst;

	mips MIPS(clk,rst);

	initial
		begin
			clk <= 1;
			rst <= 0;
			#4 rst <= 1;
			#1 rst <= 0;
		end

	always
		#4 clk = ~clk;

endmodule 

