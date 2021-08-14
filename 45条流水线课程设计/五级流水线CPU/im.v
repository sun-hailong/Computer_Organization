module im_4k(addr,dout);
	input[11:2]	addr;
	output[31:0]	dout;

	reg[31:0]	im[1023:0];
	integer		i;
	initial
		begin
			$readmemh("code1.txt",im);
			for(i = 0;i<9;i = i+1)
				$display("%b",im[i]);
		end
//read data in code1.txt
	assign	dout = im[addr];
endmodule	