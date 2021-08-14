module dm_4k(op,addr,din,dout,clk,we);
// data_memeory
	input[5:0]	op;
	input[31:0]	addr;
	input[31:0]	din;
	input		clk;
	input		we;
	output[31:0]	dout;

	reg[31:0]	dm[1023:0];
	integer		i;
//definition

	initial
	begin
		for(i = 0;i<1024;i = i+1)
			dm[i] <= 32'b0;
	end
//initial assignment --- 0
	always@(negedge clk)
		begin
			if(we == 1)
				begin
					if(op == 6'b101000)
						begin
							if(addr[1:0] == 2'b00)
								dm[addr[11:2]][7:0]<=din[7:0];
							if(addr[1:0] == 2'b01)
								dm[addr[11:2]][15:8]<=din[7:0];
							if(addr[1:0] == 2'b10)
								dm[addr[11:2]][23:16]<=din[7:0];
							if(addr[1:0] == 2'b11)
								dm[addr[11:2]][31:24]<=din[7:0];
						end
//this is for instruction 'sb' - save byte

					else	dm[addr[11:2]] <= din;
//normal data write into dm
				end
		end
	assign dout = dm[addr[11:2]];
//normal data acquire into dout
endmodule