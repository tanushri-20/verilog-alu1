`timescale 1ns/1ps

module alu_tb;

parameter WIDTH = 8;

reg [WIDTH-1:0] A;
reg [WIDTH-1:0] B;
reg [3:0] opcode;

wire [WIDTH-1:0] result;
wire zero_flag;
wire negative_flag;
wire carry_flag;
wire overflow_flag;

integer pass_count = 0;
integer fail_count = 0;

alu #(WIDTH) uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .zero_flag(zero_flag),
    .negative_flag(negative_flag),
    .carry_flag(carry_flag),
    .overflow_flag(overflow_flag)
);

task check_result;
    input [WIDTH-1:0] expected;
    input [127:0] test_name;
begin
    #1;
    if(result == expected) begin
        $display("PASS : %s -> %d", test_name, result);
        pass_count = pass_count + 1;
    end
    else begin
        $display("FAIL : %s -> Expected=%d Got=%d",
                 test_name,
                 expected,
                 result);
        fail_count = fail_count + 1;
    end
end
endtask

initial begin

    A = 10;
    B = 5;

    opcode = 4'b0000;
    #10;
    check_result(15,"ADD");

    opcode = 4'b0001;
    #10;
    check_result(5,"SUB");

    opcode = 4'b0010;
    #10;
    check_result(50,"MUL");

    opcode = 4'b0011;
    #10;
    check_result(2,"DIV");

    opcode = 4'b0100;
    #10;
    check_result(0,"AND");

    opcode = 4'b0101;
    #10;
    check_result(15,"OR");

    opcode = 4'b0110;
    #10;
    check_result(15,"XOR");

    opcode = 4'b0111;
    #10;
    check_result(~8'd10,"NOT");

    opcode = 4'b1000;
    #10;
    check_result(20,"LSHIFT");

    opcode = 4'b1001;
    #10;
    check_result(5,"RSHIFT");

    opcode = 4'b1010;
    #10;
    check_result(0,"EQ");

    opcode = 4'b1011;
    #10;
    check_result(1,"GT");

    opcode = 4'b1100;
    #10;
    check_result(0,"LT");

    opcode = 4'b1101;
    #10;
    check_result(11,"INC");

    opcode = 4'b1110;
    #10;
    check_result(9,"DEC");

    opcode = 4'b1111;
    #10;
    check_result(0,"MOD");

    // Zero Flag Test
    A = 0;
    B = 0;
    opcode = 4'b0000;
    #10;

    if(zero_flag)
        $display("PASS : ZERO FLAG");
    else
        $display("FAIL : ZERO FLAG");

    // Carry Flag Test
    A = 8'd255;
    B = 8'd1;
    opcode = 4'b0000;
    #10;

    if(carry_flag)
        $display("PASS : CARRY FLAG");
    else
        $display("FAIL : CARRY FLAG");

    // Overflow Flag Test
    A = 8'd127;
    B = 8'd1;
    opcode = 4'b0000;
    #10;

    if(overflow_flag)
        $display("PASS : OVERFLOW FLAG");
    else
        $display("FAIL : OVERFLOW FLAG");

    $display("\n========================");
    $display("TOTAL PASS = %0d", pass_count);
    $display("TOTAL FAIL = %0d", fail_count);
    $display("========================\n");

    $finish;
end

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);
end

endmodule