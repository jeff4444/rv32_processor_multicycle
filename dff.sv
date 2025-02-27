module dff (
    input clk,
    input resetn,
    input write,
    input [31:0] next,
    output logic [31:0] prev
);

    always @(posedge clk) begin
        if (!resetn) begin
            prev <= 32'h0;
        end else begin
            if (write)
                prev <= next;
            else
        end
    end
    
endmodule