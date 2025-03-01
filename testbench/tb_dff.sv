`include "../dff.sv"
module tb_dff (
);
    reg clk;
    reg resetn;
    reg write;
    reg [31:0] next;
    wire [31:0] prev;

    dff dff1 (
        .clk(clk),
        .resetn(resetn),
        .write(write),
        .next(next),
        .prev(prev)
    );
    
    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        resetn = 0;
        write = 0;
        next = 32'h1;

        #10; // wait for reset to be applied -- negedge
        if (prev != 32'h0) begin
            $display("Error: prev is not 32'h0, reset was not applied");
        end

        #5; // apply reset -- posedge
        resetn = 1;
        write = 1;
        next = 32'h12345678;

        #5; // wait for write to be applied -- negedge
        if (prev != 32'h12345678) begin
            $display("Error: prev is not 32'h12345678, write was not applied");
        end

        #5; // check again -- posedge
        if (prev != 32'h12345678) begin
            $display("Error: prev is not 32'h12345678, write was not applied");
        end

        next = 32'h87654321; // change next
        write = 0; // don't write

        #5; // check again to make sure write was not done -- negedge
        if (prev != 32'h12345678) begin
            $display("Error: prev is not 32'h12345678, write was not applied");
        end

        write = 1; // write
        #10; // check again -- negedge
        if (prev != 32'h87654321) begin
            $display("Error: prev is not 32'h87654321, write was not applied");
        end

        $display("Test is finished!");
        $finish;
    end


    initial begin
        $dumpfile("tb_dff.vcd");
        $dumpvars(0, tb_dff);
    end
endmodule