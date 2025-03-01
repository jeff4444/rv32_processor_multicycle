module tb_alu (
);
    reg [31:0] op1, op2;
    reg [3:0] alu_op;
    wire [31:0] result;
    wire zero;

    alu alu1 (
        .op1(op1),
        .op2(op2),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );

    initial begin
        for (int i = 0; i < 100; i = i + 1) begin
            op1 = $random;
            op2 = $random;
            alu_op = 4'b0000;
            #1;
            if (result != (op1 & op2)) begin
                $display("Error: result is not op1 & op2");
            end
        end

        for (int i = 0; i < 100; i = i + 1) begin
            op1 = $random;
            op2 = $random;
            alu_op = 4'b0001;
            #1;
            if (result != (op1 | op2)) begin
                $display("Error: result is not op1 | op2");
            end
        end

        for (int i = 0; i < 100; i = i + 1) begin
            op1 = $random;
            op2 = $random;
            alu_op = 4'b0010;
            #1;
            if (result != (op1 + op2)) begin
                $display("Error: result is not op1 + op2");
            end
        end

        for (int i = 0; i < 100; i = i + 1) begin
            op1 = $random;
            op2 = $random;
            alu_op = 4'b0110;
            #1;
            if (result != (op1 - op2)) begin
                $display("Error: result is not op1 - op2");
            end
        end

        for (int i = 0; i < 100; i = i + 1) begin
            op1 = $random;
            op2 = $random;
            alu_op = 4'b0111;
            #1;
            if (result != (op1 < op2)) begin
                $display("Error: result is not op1 < op2");
            end
        end

        for (int i = 0; i < 100; i = i + 1) begin
            op1 = $random;
            op2 = $random;
            alu_op = 4'b1100;
            #1;
            if (result != (op1 << op2)) begin
                $display("Error: result is not op1 << op2");
            end
        end

        for (int i = 0; i < 100; i = i + 1) begin
            op1 = $random;
            op2 = $random;
            alu_op = 4'b1101;
            #1;
            if (result != (op1 >> op2)) begin
                $display("Error: result is not op1 >> op2");
            end
        end

        for (int i = 0; i < 100; i = i + 1) begin
            op1 = $random;
            op2 = $random;
            alu_op = 4'b1110;
            #1;
            if (result != (op1 >>> op2)) begin
                $display("Error: result is not op1 >>> op2");
            end
        end

        
        $display("All tests passed");
        $finish
    end
endmodule