/*
 * Function:    data memory - stores and loads data
 * Logic:       sequential (positive edge)
 */
module data_memory(
    input   clock,
    input   [31:0] dataAddress, // 32-bit data address
    input   [31:0] writeData,   // 32-bit data to be stored
    input   memWrite, sb,       // write control signal & store byte (sb) instruction control signal
    output  [31:0] data         // output data
);

    reg [7:0] memory [8191:0]; // 8K memory locations with 1 byte in each location

    // reading data
    assign data = {
            memory[dataAddress + 3], 
            memory[dataAddress + 2], 
            memory[dataAddress + 1], 
            memory[dataAddress]
            };

    // initializing data
    initial begin 
        memory[0]   <= 8'h0;
        memory[1]   <= 8'h0;
        memory[2]   <= 8'h0;
        memory[3]   <= 8'h0;
    end

    always @ (posedge clock) begin
        if(memWrite) begin
            if(sb)
                memory[dataAddress] <= writeData[7:0];
            else begin // stores the data in little endian format
                memory[dataAddress]     <= writeData[7:0];
                memory[dataAddress + 1] <= writeData[15:8];
                memory[dataAddress + 2] <= writeData[23:16];
                memory[dataAddress + 3] <= writeData[31:24];
            end
        end     
    end
endmodule