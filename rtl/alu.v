module alu #(
    parameter WIDTH = 8
)(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [3:0] opcode,

    output reg [WIDTH-1:0] result,

    output reg zero_flag,
    output reg negative_flag,
    output reg carry_flag,
    output reg overflow_flag
);

always @(*) begin

    result = 0;
    carry_flag = 0;
    overflow_flag = 0;

    case(opcode)

        // ADD
        4'b0000: begin
            {carry_flag, result} = A + B;

            overflow_flag =
                (~A[WIDTH-1] & ~B[WIDTH-1] & result[WIDTH-1]) |
                ( A[WIDTH-1] &  B[WIDTH-1] & ~result[WIDTH-1]);
        end

        // SUB
        4'b0001: begin
            result = A - B;

            overflow_flag =
                (~A[WIDTH-1] &  B[WIDTH-1] & result[WIDTH-1]) |
                ( A[WIDTH-1] & ~B[WIDTH-1] & ~result[WIDTH-1]);
        end

        // MUL
        4'b0010: result = A * B;

        // DIV
        4'b0011: begin
            if(B != 0)
                result = A / B;
            else
                result = 0;
        end

        // AND
        4'b0100: result = A & B;

        // OR
        4'b0101: result = A | B;

        // XOR
        4'b0110: result = A ^ B;

        // NOT
        4'b0111: result = ~A;

        // LEFT SHIFT
        4'b1000: result = A << 1;

        // RIGHT SHIFT
        4'b1001: result = A >> 1;

        // EQUAL
        4'b1010: result = (A == B);

        // GREATER THAN
        4'b1011: result = (A > B);

        // LESS THAN
        4'b1100: result = (A < B);

        // INCREMENT
        4'b1101: result = A + 1;

        // DECREMENT
        4'b1110: result = A - 1;

        // MOD
        4'b1111: begin
            if(B != 0)
                result = A % B;
            else
                result = 0;
        end

        default: result = 0;

    endcase

    zero_flag     = (result == 0);
    negative_flag = result[WIDTH-1];

end

endmodule