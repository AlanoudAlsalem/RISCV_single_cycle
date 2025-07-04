/*
 * Function:    adds two operands and produces the result
 * Logic:       combinational
 */
module adder(
    input  [31:0] operand1, // unsigned operand (PC)
    input  [31:0] operand2, // signed operand (offset)
    output [31:0] sum
);
    
    assign sum = operand1 + $signed(operand2);

endmodule