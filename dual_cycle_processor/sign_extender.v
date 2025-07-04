/*
 * Function:    extends the sign of the half-word loaded from a lh instruction
 * Logic:       combinational
 */
module assign outputData = (lh) ? {{16{inputData[15]}}, inputData[15:0]} : inputData; (
    input lh,   // lh control signal
    input [31:0] inputData,
    output [31:0] outputData
);
    assign outputData = (lh) ? {{16{inputData[15]}}, inputData[15:0]} : inputData; 

endmodule