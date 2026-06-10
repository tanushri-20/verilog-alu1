module alu (
    input [7:0] A,
    input [7:0] B,
    input [3:0] opcode,
    output reg [7:0] result,
    output reg zero_flag,
    output reg negative_flag
);

always @(*) begin
    case(opcode)

        // Arithmetic Operations
        4'b0000: result = A + B;      // ADD
        4'b0001: result = A - B;      // SUB
        4'b0010: result = A * B;      // MUL

        4'b0011: begin                // DIV
            if(B != 0)
                result = A / B;
            else
                result = 8'b0;
        end

        // Logical Operations
        4'b0100: result = A & B;      // AND
        4'b0101: result = A | B;      // OR
        4'b0110: result = A ^ B;      // XOR
        4'b0111: result = ~A;         // NOT

        // Shift Operations
        4'b1000: result = A << 1;     // LEFT SHIFT
        4'b1001: result = A >> 1;     // RIGHT SHIFT

        // Comparison Operations
        4'b1010: result = (A == B);   // EQUAL
        4'b1011: result = (A > B);    // GREATER THAN
        4'b1100: result = (A < B);    // LESS THAN

        // Increment / Decrement
        4'b1101: result = A + 1;      // INC
        4'b1110: result = A - 1;      // DEC

        // Modulus
        4'b1111: begin
            if(B != 0)
                result = A % B;
            else
                result = 8'b0;
        end

        default: result = 8'b0;

    endcase
    zero_flag = (result == 0);
    negative_flag = result[7];
end

endmodule