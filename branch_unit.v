/*
 * Function:    resolves branches and produces the PC select control signal accordingly
 * Logic:       sequential
 */
module branch_unit #(
    `include "parameters.vh"
)(  input   clock, reset, nop,
    input   [6:0] opCode,
    input   [2:0] funct3,
    input   [31:0] operand1, operand2,
    output reg PCsrc
);

    // the default is branch not taken -> PC = PC + 4
    always @ (*) begin
        if(reset) begin PCsrc <= 0;
        else if (~nop) begin
            if ((opCode == bOp) && (funct3 == beqf3) && (operand1 == operand2) && clock) PCsrc <= 1; 
            else if ((opCode == bOp) && (funct3 == bnef3) && ~(operand1 == operand2) && clock) PCsrc <= 1;
            else if (opCode == jalOp) PCsrc <= 1;
            else if(opCode == jalrOp) PCsrc <= 1;
            else PCsrc <= 0;
        end // ~nop
        else PCsrc <= 0;
    end 

    always @ (negedge clock) PCsrc <= 0;

    end
endmodule