`timescale 1ns / 1ps

module riscv_cpu_tb;

    reg clk;
    reg reset;
    reg [15:0] instruction;
    reg [15:0] operand1;
    reg [15:0] operand2;
    wire [15:0] result;
    wire zero_flag;

    riscv_cpu dut(
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .operand1(operand1),
        .operand2(operand2),
        .result(result),
        .zero_flag(zero_flag)
    );

    initial begin
        clk = 0;
        reset = 1;  
        #1
        reset = 0;
        #1
        operand1 = 16'b0000000000000100;    //4
        operand2 = 16'b0000000000000011;    //3
        #2 
        instruction = 16'b0000000000000000; // ADD
        #1
        operand1 = 16'b0000000000000100;    //4
        operand2 = 16'b0000000000000011;    //3
        #2
        instruction = 16'b0000000000000001; // SUB
        #1
        operand1 = 16'b0000000000000101;    //5
        operand2 = 16'b0000000000000110;    //6
        #2
        instruction = 16'b0000000000000100; // AND
        #1
        operand1 = 16'b0000000000000101;    //5
        operand2 = 16'b0000000000000110;    //6
        #2
        instruction = 16'b0000000000000110; // OR
        
        #10 $finish;
    end

    always begin
        #1 clk = ~clk;
    end

endmodule
