module immediate_gen (
    input [31:0] instruction,
    output [31:0] immediate
);

    reg [11:0] temp_imm;

    always @ (*) begin
        case (instruction[6:0])
            7'b0000011: temp_imm = instruction[31:20]; // I-type ld
            7'b0010011: temp_imm = instruction[31:20]; // I-type alu
            7'b1100111: temp_imm = instruction[31:20]; // I-type jalr
            7'b0100011: temp_imm = {instruction[31:25], instruction[11:7]}; // S-type st
            7'b1100111: temp_imm = {instruction[7], instruction[30:25], instruction[11:8]}; // SB-type branch
            default: temp_imm = 12'h0;
            
        endcase
    end

    assign immediate = (instruction[6:0] == 7'b1100111) ? {{19{instruction[31]}}, temp_imm, 1'b0} : {{20{temp_imm[11]}} , temp_imm};
endmodule