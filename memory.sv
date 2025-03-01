module memory (
    input clk,
    input resetn,
    input memRead,
    input memWrite,
    input [31:0] writeData,
    input [31:0] address,
    output logic [31:0] memData
);
    // instruction memory where instructions are stored in [0:55]
    reg [7:0] mem [0:1023];

    // dummy instructions
    always @ (posedge clk) begin
        if (!resetn) begin
            for (integer i = 0; i < 1024; i++) begin
                mem[i] <= 0;
            end
            // initialize 14 instructions
            // 03802083 // (Load value 0x5 into x1 from memory 56, lw x1, 56(x0)) 
            // 00108133 // (x2 = x1 + x1 = 0xA)
            // 002081B3 // (x3 = x2 + x1 = 0xF)
            // 40118233 // (x4 = x3 - x1 = 0xA)
            // 001272B3 // (x5 = x4 & x1 = 0xA & 0x5 = 0x0)
            // 0011E333 // (x6 = x3 | x1 = 0xF | 0x5 = 0xF)
            // 00602223 // (Store x6 (0xF) at addr 4)
            // 00402383 // (Load from addr 4 into x7, should get 0xF)
            // 40138433 // (x8 = x7 - x1 = 0xF - 0x5 = 0xA)
            // 0024E4B3 // (x9 = x8 | x2 = 0xA | 0xA = 0xA)
            // 00902423 // (Store x9 (0xA) at addr 8)
            // 00802503 // (Load from addr 8 into x10, should get 0xA)
            // 00950A63 // (Branch if x10 == x1 (0xA == 0x5) - False, no jump)
            // 00950C63 // (Branch if x10 == x9 (0xA == 0xA) - True, jump +12)
            mem[0] <= 8'h83;
            mem[1] <= 8'h20;
            mem[2] <= 8'h00;
            mem[3] <= 8'h00;
            mem[4] <= 8'h33;
            mem[5] <= 8'h81;
            mem[6] <= 8'h10;
            mem[7] <= 8'h00;
            mem[8] <= 8'hB3;
            mem[9] <= 8'h81;
            mem[10] <= 8'h20;
            mem[11] <= 8'h00;
            mem[12] <= 8'h33;
            mem[13] <= 8'h82;
            mem[14] <= 8'h11;
            mem[15] <= 8'h40;
            mem[16] <= 8'hB3;
            mem[17] <= 8'h72;
            mem[18] <= 8'h12;
            mem[19] <= 8'h00;
            mem[20] <= 8'h33;
            mem[21] <= 8'he3;
            mem[22] <= 8'h11;
            mem[23] <= 8'h00;
            mem[24] <= 8'h23;
            mem[25] <= 8'h22;
            mem[26] <= 8'h60;
            mem[27] <= 8'h00;
            mem[28] <= 8'h83;
            mem[29] <= 8'h23;
            mem[30] <= 8'h40;
            mem[31] <= 8'h00;
            mem[32] <= 8'h33;
            mem[33] <= 8'h84;
            mem[34] <= 8'h13;
            mem[35] <= 8'h40;
            mem[36] <= 8'hB3;
            mem[37] <= 8'h64;
            mem[38] <= 8'h24;
            mem[39] <= 8'h00;
            mem[40] <= 8'h23;
            mem[41] <= 8'h24;
            mem[42] <= 8'h90;
            mem[43] <= 8'h00;
            mem[44] <= 8'h03;
            mem[45] <= 8'h25;
            mem[46] <= 8'h80;
            mem[47] <= 8'h00;
            mem[48] <= 8'h63;
            mem[49] <= 8'h0A;
            mem[50] <= 8'h95;
            mem[51] <= 8'h00;
            mem[52] <= 8'h63;
            mem[53] <= 8'h0C;
            mem[54] <= 8'h95;
            mem[55] <= 8'h00;

            mem[56] <= 8'h05;

        end else begin
            if (memWrite) begin
                mem[address] <= writeData[7:0];
                mem[address + 1] <= writeData[15:8];
                mem[address + 2] <= writeData[23:16];
                mem[address + 3] <= writeData[31:24];
            end
            if (memRead) begin
                memData <= {mem[address + 3], mem[address + 2], mem[address + 1], mem[address]};
            end
        end
    end 
  
endmodule