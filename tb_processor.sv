`include "processor.sv"
`include "alu.sv"
`include "alu_ctrl.sv"
`include "imm_gen.sv"
`include "dff.sv"
`include "mux_2_to_1.sv"
`include "mux_4_to_1.sv"
`include "registers.sv"
`include "control.sv"
`include "memory.sv"
`timescale 1ns / 1ps

module tb_processor (
);
    reg clk;
    reg resetn;

    always begin
        #5 clk = ~clk;
    end

    multicycle_rv32_processor processor (
        .clk(clk),
        .resetn(resetn)
    );

    initial begin
        clk = 0;
        resetn = 0;
        #10 resetn = 1;
        #250 $finish;
    end

    initial begin
        $dumpfile("tb_processor.vcd");
        $dumpvars(0, tb_processor);
    end
    
endmodule