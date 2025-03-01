`include "../alu_ctrl.sv"
`timescale 1ns / 1ps

module tb_alu_ctrl (
);

    reg [31:0] instr;
    reg [1:0] alu_op_sel;
    wire [3:0] alu_op;

    alu_control alu_control1 (
        .instruction(instr),
        .alu_op_sel(alu_op_sel),
        .alu_op(alu_op)
    );

    initial begin
        instr = $random;
        alu_op_sel = 2'b00;
        #1;
        if (alu_op != 4'b0010) begin
            $display("Error: alu_op is not 4'b0010");
        end

        instr = $random;
        alu_op_sel = 2'b01;
        #1;
        if (alu_op != 4'b0110) begin
            $display("Error: alu_op is not 4'b0110");
        end

        alu_op_sel = 2'b10;


        instr = 32'h00000000;
        #1;
        if (alu_op != 4'b0010) begin
            $display("Error: alu_op is not 4'b0010");
        end

        instr = 32'h40000000;
        #1;
        if (alu_op != 4'b0110) begin
            $display("Error: alu_op is not 4'b0110");
        end

        instr = 32'h00007000;
        #1;
        if (alu_op != 4'b0000) begin
            $display("Error: alu_op is not 4'b0000");
        end

        instr = 32'h00116333;
        #1;
        if (alu_op != 4'b0001) begin
            $display("Error: alu_op is not 4'b0001 %b", alu_op);
        end

        $display("All tests passed");
        $finish;
    end
    
endmodule