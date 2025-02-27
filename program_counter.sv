module program_counter (
    input clk,
    input resetn,
    input [31:0] pc_next,
    output logic [31:0] pc_prev
);

    dff dff_pc (
        .clk(clk),
        .resetn(resetn),
        .next(pc_next),
        .prev(pc_prev)
    );
    
endmodule