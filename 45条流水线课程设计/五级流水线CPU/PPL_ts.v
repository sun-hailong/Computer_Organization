module PPL_ts();

	reg clk;
	reg rst;

	datapath_PPL dPP(clk,rst);

	initial
		begin
			clk <= 1;
			rst <= 0;
			#40 rst <= 1;
			#10 rst <= 0;
		end

	always
		#40 clk = ~clk;

endmodule 
