module alu_control (
    input [31:0] instruction,
    input [1:0] alu_op_sel,
    output [3:0] alu_op
);
    assign alu_op[3] = 1'b0;
    assign alu_op[2] = alu_op_sel[0] | (~alu_op_sel[0] & alu_op_sel[1] & instruction[30]);
    assign alu_op[1] = alu_op_sel[0] | ~instruction[14] | ~alu_op_sel[1];
    assign alu_op[0] = alu_op_sel[1] & instruction[13] & ~instruction[12];

    // always @ (*) begin
    //     $display("instruction: %h, instruction[14]: %b, alu_sel_op: %b", instruction, instruction[14], alu_op_sel);
    // end
endmodule