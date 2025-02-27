module mux_32 (
    input [31:0] op1,
    input [31:0] op2,
    input sel,
    output [31:0] out
);
    assign out = sel ? op2 : op1;
endmodule