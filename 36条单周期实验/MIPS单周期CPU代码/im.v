module im(addr, dout);//ok
    input[11:2]     addr;
    output[31:0]    dout;

    reg[31:0]   im_4k[1023:0];
    assign      dout = im_4k[addr];
    integer i;
    initial 
        begin
            $readmemh("code.txt", im_4k);
        end
endmodule