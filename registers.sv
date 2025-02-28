module registers (
    input clk,
    input resetn,
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output [31:0] readData1,
    output [31:0] readData2
);

    reg [31:0] regFile [31:0];

    always @(posedge clk) begin
        if (!resetn) begin
            for (integer i = 0; i < 32; i++) begin
                regFile[i] <= 0;
            end
        end else begin
            if (regWrite) begin
                if (writeReg != 0) begin
                    regFile[writeReg] <= writeData;
                end
            end
        end
    end

    // always display first 10 registers
    // always @* begin
    //     $display("Register 0: %h, Register 1: %h, Register 2: %h, Register 3: %h, Register 4: %h, Register 5: %h, Register 6: %h, Register 7: %h, Register 8: %h, Register 9: %h", regFile[0], regFile[1], regFile[2], regFile[3], regFile[4], regFile[5], regFile[6], regFile[7], regFile[8], regFile[9]);
    // end

    assign readData1 = regFile[readReg1];
    assign readData2 = regFile[readReg2];
    
endmodule