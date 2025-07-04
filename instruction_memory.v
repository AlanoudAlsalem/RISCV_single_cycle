/*
 * Function:    instruction memory - stores the program instructions
 * Logic:       combinational
 */
module instruction_memory(
    input [31:0] instructionAddress, // 32-bit instruction address (PC)
    output [31:0] instruction // 32-bit instruction
);
    reg [7:0] memory [65535:0]; // 64K memory locations with 8 bits in each location
    
    // instruction initialization
    initial begin 
        memory[0]       <= 8'h00;
        memory[1]       <= 8'h00;
        memory[2]       <= 8'h00;
        memory[3]       <= 8'h00;
    end

    // outputs the instruction from memory (in little endian order)
    assign instruction = {
        memory[instructionAddress + 3], 
        memory[instructionAddress + 2], 
        memory[instructionAddress + 1], 
        memory[instructionAddress]
    };

endmodule