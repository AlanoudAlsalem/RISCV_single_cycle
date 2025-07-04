/*
 * Function:    interfaces CPU modules for single cycle operation
 * Logic:       sequential & combinational
 *              === First cycle ===
 *              instruction memory read: positive edge (fetch)
 *              decode & execute stages: combinational
 *              === Second cycle ===
 *              data memory read/ write: positive edge
 *              write-back: combinational                   
 */

`include "includes.v"
module dual_cycle_cpu(
    input   clock, reset,
    output  [31:0] program_counter,

);
    wire [31:0] pc; // PC output
    PC pc1(

    );

    wire [31:0] sum; // adder output
    adder adder1(

    );

    wire [31:0] chosen_pc; // pc mux output
    mux2_1 mux1(

    );

    wire [31:0] instruction; // instruction_memory output
    instruction_memory im1(

    );

    // ***************************** add control signals
    control_unit c1(

    );

    wire [31:0] register; // register_file output
    register_file rf1( 

    );

    wire [31:0] immediate; // imm_gen output
    imm_gen imgen1(

    );

    wire [31:0] chosen_operand; // alu mux output
    mux2_1 mux2(

    );

    wire [31:0] alu_result; // alu output
    ALU alu1(

    );

    wire [31:0] data; // data memory output
    data_memory dm1(

    );

    wire [31:0] sign_extended_data; // sign extender output
    sign_extender se1(

    );
endmodule