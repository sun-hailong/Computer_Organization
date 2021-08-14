module PC (NPC, rst, clk, PC);//ok
    input[31:2] NPC;
    input       rst;
    input       clk;
    output reg[31:2] PC;

    always @(negedge clk or posedge rst) begin
        if(rst == 1)    
            PC <= 30'h0c00;
        else            
            PC <= NPC;
    end
    
endmodule