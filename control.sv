module control (
    input clk,
    input resetn,
    input [6:0] opcode,
    output logic PCWriteCond,
    output logic PCWrite,
    output logic IorD,
    output logic MemRead,
    output logic MemWrite,
    output logic MemtoReg,
    output logic IRWrite,
    output logic PCSource,
    output logic ALUSrcA,
    output logic [1:0] ALUSrcB,
    output logic [1:0] ALUOp,
    output logic RegWrite
);
    reg [3:0] cur_state, next_state;

    always @(posedge clk) begin
        if (!resetn)
            cur_state <= 4'b0000;
        else
            cur_state <= next_state;
    end

    always @ (posedge clk) begin
        case (cur_state)
            4'b0000: begin
                next_state <= 4'b0001;
            end
            4'b0001: begin
                if (opcode == 7'b0110011) begin
                    next_state <= 4'b0110; // R-type
                end
                else if (opcode == 7'b0000011 || opcode == 7'b0100011) begin
                    next_state <= 4'b0010; // LW or SW
                end
                else if (opcode == 7'b1100011) begin
                    next_state <= 4'b1000; // BEQ
                end
            end
            4'b0010: begin
                if (opcode == 7'b0000011) begin
                    next_state <= 4'b0011; // LW
                end else if (opcode == 7'b0100011) begin
                    next_state <= 4'b0101; // SW
                end
            end
            4'b0011: begin
                next_state <= 4'b0100; // LW
            end
            4'b0100: begin
                next_state <= 4'b0000; // return to fetch
            end
            4'b0101: begin
                next_state <= 4'b0000; // return to fetch
            end
            4'b0110: begin
                next_state <= 4'b0111; // R-type
            end
            4'b0111: begin
                next_state <= 4'b0000; // return to fetch
            end
            4'b1000: begin
                next_state <= 4'b0000; // return to fetch
            end
            default: next_state <= 4'b0000; // default to fetch
        endcase
    end


    always @(posedge clk) begin
        case (cur_state)
            4'b0000: begin
                MemRead <= 1;
                ALUSrcA <= 0;
                IorD <= 0;
                IRWrite <= 1;
                ALUSrcB <= 2'b01;
                ALUOp <= 2'b00;
                PCWrite <= 1;
                PCWriteCond <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 0;
                PCSource <= 0;
            end
            4'b0001: begin
                MemRead <= 0;
                ALUSrcA <= 0;
                IorD <= 0;
                IRWrite <= 0;
                ALUSrcB <= 2'b10;
                ALUOp <= 2'b00;
                PCWrite <= 0;
                PCWriteCond <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 0;
                PCSource <= 0;
            end
            4'b0010: begin
                MemRead <= 0;
                ALUSrcA <= 1;
                IorD <= 0;
                IRWrite <= 0;
                ALUSrcB <= 2'b10;
                ALUOp <= 2'b00;
                PCWrite <= 0;
                PCWriteCond <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 0;
                PCSource <= 0;
            end
            4'b0011: begin
                MemRead <= 1;
                ALUSrcA <= 0;
                IorD <= 1;
                IRWrite <= 0;
                ALUSrcB <= 2'b00;
                ALUOp <= 2'b00;
                PCWrite <= 0;
                PCWriteCond <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 0;
                PCSource <= 0;
            end
            4'b0100: begin
                MemRead <= 0;
                ALUSrcA <= 0;
                IorD <= 0;
                IRWrite <= 0;
                ALUSrcB <= 2'b00;
                ALUOp <= 2'b00;
                PCWrite <= 0;
                PCWriteCond <= 0;
                MemtoReg <= 1;
                MemWrite <= 0;
                RegWrite <= 1;
                PCSource <= 0;
            end
            4'b0101: begin
                MemRead <= 0;
                ALUSrcA <= 0;
                IorD <= 1;
                IRWrite <= 0;
                ALUSrcB <= 2'b00;
                ALUOp <= 2'b00;
                PCWrite <= 0;
                PCWriteCond <= 0;
                MemtoReg <= 0;
                MemWrite <= 1;
                RegWrite <= 0;
                PCSource <= 0;
            end
            4'b0110: begin
                MemRead <= 0;
                ALUSrcA <= 1;
                IorD <= 0;
                IRWrite <= 0;
                ALUSrcB <= 2'b00;
                ALUOp <= 2'b10;
                PCWrite <= 0;
                PCWriteCond <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 0;
                PCSource <= 0;
            end
            4'b0111: begin
                MemRead <= 0;
                ALUSrcA <= 0;
                IorD <= 0;
                IRWrite <= 0;
                ALUSrcB <= 2'b00;
                ALUOp <= 2'b00;
                PCWrite <= 0;
                PCWriteCond <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 1;
                PCSource <= 0;
            end
            4'b1000: begin
                MemRead <= 0;
                ALUSrcA <= 1;
                IorD <= 0;
                IRWrite <= 0;
                ALUSrcB <= 2'b00;
                ALUOp <= 2'b01;
                PCWrite <= 0;
                PCWriteCond <= 1;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 0;
                PCSource <= 1;
            end
        endcase
    end
endmodule