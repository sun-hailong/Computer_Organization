module dm(op, addr, din, dout, clk, we);
    input[5:0]	op;
	input[31:0]	addr;
	input[31:0]	din;
	input		clk;
	input		we;
	output[31:0]	dout;
    
    reg[31:0]	dm_4k[1023:0];
    assign dout = dm_4k[addr[11:2]];
    
    always @(negedge clk) 
        begin
            if(we == 1)
                begin
					if(op == 6'b101000)//sb
						begin
							if(addr[1:0] == 2'b00)
								dm_4k[addr[11:2]][7:0] <= din[7:0];
							if(addr[1:0] == 2'b01)
								dm_4k[addr[11:2]][15:8] <= din[7:0];
							if(addr[1:0] == 2'b10)
								dm_4k[addr[11:2]][23:16] <= din[7:0];
							if(addr[1:0] == 2'b11)
								dm_4k[addr[11:2]][31:24] <= din[7:0];
						end
					else	dm_4k[addr[11:2]] <= din;
				end
        end
endmodule