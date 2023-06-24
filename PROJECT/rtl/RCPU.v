`timescale 1ns / 1ps


module riscv_cpu(
    input wire clk,
    input wire reset,
    input wire [15:0] instruction,
    input wire [15:0] operand1,
    input wire [15:0] operand2,
    output reg [15:0] result,
    output reg zero_flag
);

    reg [15:0] pc;
    reg [3:0] opcode;
    reg [15:0] alu_result;

    always @(posedge clk)
    begin
        if (reset)
        begin
            pc <= 0;
            opcode <= 0;
            result <= 0;
            zero_flag <= 0;
        end
        else
        begin
            pc <= pc + 1;
            opcode <= instruction[2:0];;
            
            case (opcode)
                3'b000: // ADD
                    alu_result <= operand1 + operand2;
                3'b001: // SUB
                    alu_result <= operand1 - operand2;
                3'b100: // AND
                    alu_result <= operand1 & operand2;
                3'b110: // OR
                    alu_result <= operand1 | operand2;
                default:
                    alu_result <= -200;
            endcase


            result <= alu_result;
            zero_flag <= (alu_result == 0);
        end
    end
endmodule
