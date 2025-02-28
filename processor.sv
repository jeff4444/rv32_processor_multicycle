module multicycle_rv32_processor (
    input clk,
    input resetn,
);
    wire PCWriteCond;
    wire PCWrite;
    wire IorD;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire IRWrite;
    wire PCSource;
    wire [1:0] ALUOp;
    wire [1:0] ALUSrcB;
    wire ALUSrcA;
    wire RegWrite;
    wire pcWriteReg;
    wire zero;

    wire [31:0] pcCurr;
    wire [31:0] pcNext;

    wire [31:0] memAddress;
    wire [31:0] memData;
    wire [31:0] prevMemData;
    wire [31:0] instruction;

    wire [31:0] regWriteData;

    wire [31:0] ALUResPrev;
    wire [31:0] ALURes;

    wire [31:0] immediate;

    wire [31:0] curReg1Data;
    wire [31:0] prevReg1Data;

    wire [31:0] curReg2Data;
    wire [31:0] prevReg2Data;

    wire [31:0] ALUIn1;
    wire [31:0] ALUIn2;


    assign pcWriteReg = (zero & PCWriteCond) | PCWrite;

    dff PC (
        .clk(clk),
        .resetn(resetn),
        .write(pcWriteReg),
        .next(pcNext),
        .prev(pcCurr)
    );

    mux_2_to_1 mux1 (
        .op1(pcCurr),
        .op2(ALUResPrev),
        .sel(IorD),
        .out(memAddress)
    );

    memory mem (
        .clk(clk),
        .resetn(resetn),
        .memRead(MemRead),
        .memWrite(MemWrite),
        .writeData(prevReg2Data),
        .address(memAddress)
        .memData(memData)
    );


    dff instructionReg (
        .clk(clk),
        .resetn(resetn),
        .write(IRWrite),
        .next(memData),
        .prev(instruction)
    );

    dff memDataReg (
        .clk(clk),
        .resetn(resetn),
        .write(1),
        .next(memData),
        .prev(prevMemData)
    );

    control ctrl (
        .clk(clk),
        .resetn(resetn),
        .opcode(instruction[6:0]),
        .PCWriteCond(PCWriteCond),
        .PCWrite(PCWrite),
        .IorD(IorD),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .IRWrite(IRWrite),
        .PCSource(PCSource),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB).
        .ALUOp(ALUOp),
        .RegWrite(RegWrite)
    );

    mux_2_to_1 mux2 (
        .op1(ALUResPrev),
        .op2(currMemData),
        .sel(MemtoReg),
        .out(regWriteData)
    );

    registers regFile (
        .clk(clk),
        .resetn(resetn),
        .readReg1(instruction[19:15]),
        .readReg2(instruction[24:20]),
        .writeReg(instruction[11:7]),
        .writeData(regWriteData),
        .regWrite(RegWrite),
        .readData1(curReg1Data),
        .readData2(curReg2Data)
    );

    dff A (
        .clk(clk),
        .resetn(resetn),
        .write(1),
        .next(curReg1Data),
        .prev(prevReg1Data)
    );

    mux_2_to_1 mux3 (
        .op1(pcCurr),
        .op2(prevReg1Data),
        .sel(ALUSrcA),
        .out(ALUIn1)
    );

    dff B (
        .clk(clk),
        .resetn(resetn),
        .write(1),
        .next(curReg2Data),
        .prev(prevReg2Data)
    );

    immediate_gen immGen (
        .instruction(instruction),
        .immediate(immediate)
    );

    mux_4_to_1 mux4 (
        .in0(prevReg2Data),
        .in1(4),
        .in2(immediate),
        .in3(0),
        .sel(ALUSrcB),
        .out(ALUIn2)
    );

    alu ALU (
        .op1(ALUIn1),
        .op2(ALUIn2),
        .alu_op(ALUOp),
        .result(ALURes),
        .zero(zero)
    );

    dff ALUOut (
        .clk(clk),
        .resetn(resetn),
        .write(1),
        .next(ALURes),
        .prev(ALUResPrev)
    );

    mux_2_to_1 mux5 (
        .op1(ALURes),
        .op2(ALUResPrev),
        .sel(PCSource),
        .out(pcNext)
    );

    
endmodule