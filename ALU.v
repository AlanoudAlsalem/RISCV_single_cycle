/*
 * Function:    processes the inputs and produces the result based on the opration
 * Logic:       combinational
 */
module alu #(
    `include "parameters.vh"
)(
    input [31:0]    operand1, operand2,
    input [3:0]     operation,
    output reg [31:0]   result
);

    always @ (*) begin
        case(operation)
            add_:  result <= $signed(operand1) + $signed(operand2);
            sub_:  result <= $signed(operand1) - $signed(operand2);
            and_:  result <= operand1 & operand2;
            or_:   result <= operand1 | operand2;
            sll_:  result <= operand1 << operand2;
            srl_:  result <= operand1 >> operand2;
            xor_:  result <= operand1 ^ operand2;
            slt_:  result <= ($signed(operand1) < $signed(operand2)) ? 1 : 0;
            jal_:  result <= operand2 + 4;
            lui_:  result <= operand2;
        endcase
    end

endmodule