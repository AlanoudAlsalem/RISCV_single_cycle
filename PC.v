module pc(
    input   clock, reset,
    input   [31:0] pc_in,
    output  [31:0] pc_out
);

    always @ (posedge clock or posedge reset) begin
        if(reset)
            pc_out <= 32'b0;
        else 
            pc_out <= pc_in;
    end
endmodule