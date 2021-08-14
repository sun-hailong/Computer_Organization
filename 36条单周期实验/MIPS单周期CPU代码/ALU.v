module ALU (ALUctr, busA, busB, imm32, shamt, result, zero);
    input[4:0]	ALUctr;
	input[31:0]	busA, busB;
	input[31:0]	imm32;
	input[4:0]	shamt;
	output reg[31:0]	result;
	output		zero;
    
    assign   zero = (result == 32'b0);

    always @(*)
        begin
            case(ALUctr)
                //R-type
                5'b00000:result <= busA + busB;//addu
                5'b00001:result <= busA - busB;//subu
                5'b00010://slt
                    begin
                        if(busA[31] ^ busB[31])	result <= (busA[31] == 1) ? 1 : 0;
                        else	result <= (busA < busB) ? 1 : 0;
                    end
                5'b00011:result <= busA & busB;//and
                5'b00100:result <= ~(busA | busB);//nor
                5'b00101:result <= busA | busB;//or
                5'b00110:result <= busA ^ busB;//xor
                5'b00111:result <= busB << shamt;//sll
                5'b01000:result <= busB >> shamt;//srl
                5'b01001:result <= (busA < busB) ? 1 : 0;//sltu
                //5'b01010:jalr;
                //5'b01011:jr;
                5'b01100:result <= busB << busA;//sllv
                5'b01101:result <= $signed(busB) >>> shamt ;//sra
                5'b01110:result <= $signed(busB) >>> busA ;//srav
                5'b01111:result <= busB >> busA;//srlv

                //I-type
                5'b10000:result <= busA + imm32;//addiu
                5'b10001://slti
                    begin
                        if(busA[31] ^ imm32[31]) result <= (busA[31] == 1);
                        else result <= (busA < imm32);
                    end
                5'b10010:result <= (busA < imm32);//sltiu
                5'b10011:result <= busA & imm32;//andi
                5'b10100:result <= busA | imm32;//ori
                5'b10101:result <= busA ^ imm32;//xori

            endcase
        end
endmodule