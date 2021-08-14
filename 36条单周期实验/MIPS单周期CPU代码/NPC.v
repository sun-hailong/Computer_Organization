module NPC(PC,NPC,jump,branch,zero,op,target,imm16,busA,rs,rt,rd,shamt,func);//ok
    input[31:2]	PC;
	output reg[31:2]    NPC;
	input		jump,branch,zero;
	input[5:0]	op;
	input[25:0]	target;
	input[15:0]	imm16;
	input[31:0]	busA;
	input[4:0]	rs,rt,rd,shamt;
	input[5:0]	func;
    
    wire[31:2] jump_npc = {PC[31:28], target};
    wire[31:2] branch_npc = {{14{imm16[15]}}, imm16[15:0]} + PC;
    wire[31:2] normal_npc = PC + 1;

    always @(*) begin
        case(op)
                //R-type
				6'b000000:
					begin
						if(rt == 5'b00000 && imm16 == 16'b1111100000001001)
							NPC = busA[31:2];//jalr
						else if(rt == 5'b00000 && imm16 == 16'b0000000000001000)
							NPC = busA[31:2];//jr
						else NPC = normal_npc;
					end
					
				//I-type
				6'b000100: NPC = (zero == 1 && branch == 1) ? branch_npc : normal_npc;//beq
				6'b000101: NPC = (zero == 0 && branch == 1) ? branch_npc : normal_npc;//bne
				6'b000001:
					begin
						if(rt == 1 && branch == 1 && (busA == 0 || busA[31] == 0))//bgez
							NPC = branch_npc;
						else if(rt == 0 && branch == 1 && busA[31] == 1 && busA != 0)//bltz
							NPC = branch_npc;
						else
							NPC = normal_npc;
					end
				6'b000111: NPC = (branch == 1 && busA[31] == 0 && busA != 0) ? branch_npc : normal_npc; //bgtz
				6'b000110: NPC = (branch == 0 && (busA[31] == 1 || busA == 0)) ? branch_npc : normal_npc;//blez					

				//J-type
				6'b000010: NPC = (jump == 1) ? jump_npc : normal_npc;//j
				6'b000011: NPC = (jump == 1) ? jump_npc : normal_npc;//jal 

				default: NPC = normal_npc;
			endcase
    end
endmodule