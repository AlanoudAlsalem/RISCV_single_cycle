/*
 * Function:    2 to 1 mux
 * Logic:       combinational
 */
 module mux_2to1(
  input [31:0] i0, i1, 
  input select,
  output reg [31:0] out
);
  
  always @ (*)
    case (select)
      1'b0: out <= i0;
      1'b1: out <= i1;
    endcase
  
endmodule