`timescale 1ns/1ps

module alu_tb;

reg [7:0] A;
reg [7:0] B;
reg [3:0] opcode;
wire [7:0] result;
wire zero_flag;
wire negative_flag;

alu uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .zero_flag(zero_flag),
    .negative_flag(negative_flag)
);

initial begin

    A = 10;
    B = 5;

    // ADD
    opcode = 4'b0000;
    #10;
    $display("ADD : %d", result);

    // SUB
    opcode = 4'b0001;
    #10;
    $display("SUB : %d", result);

    // MUL
    opcode = 4'b0010;
    #10;
    $display("MUL : %d", result);

    // DIV
    opcode = 4'b0011;
    #10;
    $display("DIV : %d", result);

    // AND
    opcode = 4'b0100;
    #10;
    $display("AND : %d", result);

    // OR
    opcode = 4'b0101;
    #10;
    $display("OR  : %d", result);

    // XOR
    opcode = 4'b0110;
    #10;
    $display("XOR : %d", result);

    // NOT
    opcode = 4'b0111;
    #10;
    $display("NOT : %d", result);

    // LEFT SHIFT
    opcode = 4'b1000;
    #10;
    $display("LSHIFT : %d", result);

    // RIGHT SHIFT
    opcode = 4'b1001;
    #10;
    $display("RSHIFT : %d", result);

    // EQUAL
    opcode = 4'b1010;
    #10;
    $display("EQ : %d", result);

    // GREATER THAN
    opcode = 4'b1011;
    #10;
    $display("GT : %d", result);

    // LESS THAN
    opcode = 4'b1100;
    #10;
    $display("LT : %d", result);

    // INCREMENT
    opcode = 4'b1101;
    #10;
    $display("INC : %d", result);

    // DECREMENT
    opcode = 4'b1110;
    #10;
    $display("DEC : %d", result);

    // MODULUS
    opcode = 4'b1111;
    #10;
    $display("MOD : %d", result);
    $display("ADD : %d Z=%b N=%b",
          result,
          zero_flag,
          negative_flag);

    $finish;

end

endmodule