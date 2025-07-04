/*
 * Function:    immediate generator - sign extends an inputs of varying sizes to 32 bits
 * Logic:       combinational
 */
module imm_gen #(
    `include "parameters.vh"
)(  input [31:0] instruction,
    output reg [31:0] out
);

    always @ (*) begin
        case (instruction[6:0])
            addiwOp:    out <= {{20{instruction[31]}}, instruction[31:20]};
            andiOp:     out <= {{20{instruction[31]}}, instruction[31:20]};
            jalrOp:     out <= {{20{instruction[31]}}, instruction[31:20]};
            lwOp:       out <= {{20{instruction[31]}}, instruction[31:20]}; 
            beqOp:      out <= {{19{instruction[31]}}, instruction[31:25], instruction[11:7], 1'b0}; 
            jalOp:      out <= {{12{instruction[31]}}, instruction[31:12], 1'b0};
            luiOp:      out <= {instruction[31:12], 12'b0};
            swOp:       out <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        endcase 
    end
endmodule