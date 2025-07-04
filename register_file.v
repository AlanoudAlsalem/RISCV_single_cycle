/*
 * Function:    32 register file with 32-bit registers
 * Logic:       combinational
 */
module registerFile(
    input           reset,  
    input   [4:0]   readReg,    // 5-bit address of register to be read
    input   [4:0]   writeReg,   // 5-bit address of write reg
    input   [31:0]  writeData,  // 32-bit write data
    input           regWrite,   // write control signal
    output  [31:0]  readData1,  // 32-bit read data
);

    reg [31:0] registers [31:0];  // 32 register file with 32-bit registers
    assign readData1 = registers[readReg];  // reading the data

    always @ (posedge regWrite or writeReg or writeData or reset) begin
        if(reset)
            for(integer i = 0; i < 32; i = i+1)
                registers[i] <= 32'b0; // assigns zero to entire register file
        else if(regWrite && writeReg != 5'b0) // ensures that x0 value remains 0
            registers[writeReg] <= writeData; // writing to register file
    end
endmodule