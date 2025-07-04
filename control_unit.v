/*
 * Function:    decodes the instruction and outputs the correspoinding control signals
 *              FSM with two states: fetch - decode - execute (first cycle), memory - write-back (second cycle)
 *              FSM state is triggered by the clock's positive edge
 * Logic:       combinational
 */
module control_unit #(
    `include "parameters.vh"
)(  input [6:0] opCode,      // 7-bit opCode
    input [2:0] funct3,      // 3-bit funct3
    input [6:0] funct7,      // 7-bit funct7
    input nop,               // no operation
    output reg regWrite,     // register file write signal (1 = enable)
    output reg memtoReg,     // WB stage MUX selecion signal (0 = data, 1 = ALUresult)
    output reg memWrite,     // memory write signal = (memory read)'
    output reg [1:0] ALUsrc, // ALU operand 2 MUX selection signal (0 = Rs2, 1 = imm, 2 = PC)
    output reg [3:0] ALUop,  // ALU operation
    output reg sb,           // sb instruction
    output reg lh,           // lh instruction
    output reg ld,           // lw or lh instruction
    output reg jalr,
    output halt             // halts the CPU operation 
);

    reg state;  // 0 -> fetch - decode - execute
                // 1 -> memory - write-back
            
    assign halt = (opCode == 7'b1111111) ? 1 : 0;

    always @ (*) begin
        // initializing the signals
        regWrite    <= 1'b0; 
        memtoReg    <= 1'b0; 
        memWrite    <= 1'b0; 
        ALUsrc      <= 2'b0; 
        ALUop       <= 4'b0;
        sb          <= 1'b0;
        lh          <= 1'b0;
        ld          <= 1'b0;
        jalr        <= 1'b0;

        if(~nop) begin
            if(opCode == Rtype) begin
                regWrite    <= 1'b1; 
                memtoReg    <= 1'b1; 
                memWrite    <= 1'b0; 
                ALUsrc      <= 2'b0; 
            
                // assigns the ALUop signal
                case({funct3, funct7})
                    {addwf3, addwf7}: ALUop <= add_;
                    {andf3, andf7}  : ALUop <= and_;
                    {xorf3, xorf7}  : ALUop <= xor_;
                    {orf3, orf7}    : ALUop <= or_;
                    {sltf3, sltf7}  : ALUop <= slt_;
                    {sllf3, sllf7}  : ALUop <= sll_;
                    {srlf3, srlf7}  : ALUop <= srl_;
                    {subf3, subf7}  : ALUop <= sub_; 
                    default         : regWrite <= 1'b0; // for invalid funct3 and funct 7
                endcase
            end
            else if(opCode == addiwOp && funct3 == addiwf3) begin
                regWrite    <= 1'b1; 
                memtoReg    <= 1'b1; 
                memWrite    <= 1'b0; 
                ALUop       <= addop;
                ALUsrc      <= 2'b1; 
            end
            else if(opCode == andiOp && funct3 == andif3) begin
                regWrite    <= 1'b1; 
                memtoReg    <= 1'b1; 
                memWrite    <= 1'b0; 
                ALUop       <= andop;
                ALUsrc      <= 2'b1; 
            end
            else if(opCode == jalrOp) begin
                regWrite    <= 1'b1; 
                memtoReg    <= 1'b1; 
                memWrite    <= 1'b0; 
                ALUop       <= jalop;
                ALUsrc      <= 2'b10; 
                jalr        <= 1'b1;
            end
            else if(opCode == lhOp) begin
                regWrite    <= 1'b1; 
                memtoReg    <= 1'b0; 
                memWrite    <= 1'b0; 
                ALUop       <= addop;
                ALUsrc      <= 2'b1; 
                ld          <= 1'b1;
                lh          <= (funct3 == lhf3) ? 1 : 0;
            end
            else if(opCode == oriOp && funct3 == orif3) begin
                regWrite    <= 1'b1; 
                memtoReg    <= 1'b1; 
                memWrite    <= 1'b0; 
                ALUop       <= orop;
                ALUsrc      <= 2'b1;
            end
            else if(opCode == beqOp) begin
                regWrite    <= 1'b0; 
                memWrite    <= 1'b0;  
                ALUop       <= subop;
                ALUsrc      <= 2'b0;
            end
            else if(opCode == jalOp) begin
                regWrite    <= 1'b1; 
                memtoReg    <= 1'b1; 
                memWrite    <= 1'b0; 
                ALUop       <= jalop;
                ALUsrc      <= 2'b10;
            end
            else if(opCode == luiOp) begin
                regWrite    <= 1'b1; 
                memtoReg    <= 1'b1; 
                memWrite    <= 1'b0; 
                ALUop       <= luiop;
                ALUsrc      <= 2'b1;
            end
            else if(opCode == sbOp) begin
                regWrite    <= 1'b0; 
                memWrite    <= 1'b1; 
                ALUop       <= addop;
                ALUsrc      <= 2'b1;
                sb          <= (funct3 == 0) ? 1 : 0;
            end
        end 
    end      
endmodule 