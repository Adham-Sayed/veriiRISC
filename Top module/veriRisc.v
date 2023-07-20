`include "Tristate_buffer.v"
`include "ALU.v"
`include "controller.v"
`include "Counter.v"
`include "memory.v"
`include "MUX.v"
`include "register.v"

module veri_Risc (
    input wire clk, rst,
    output wire halt
);

localparam data_width = 8;
localparam addr_width = 5; 

// Wires of Counter
wire [2:0] phase;

// Wires of Controller 
wire rd, wr, ld_ie, ld_ac, ld_pc, inc_pc, data_e, sel ;

//Wires of ALU 

wire [data_width-1:0] alu_out ;
wire zero;

// Wires of accumulator register

wire [data_width-1 : 0] ac_out ;


// Wires of Tistate buffer

wire [data_width-1: 0] data ;

//Wires of instruction register 

wire [2:0] opcode;
wire [addr_width-1:0] ir_addr ;

// Wires of Program Counter

wire [addr_width-1:0] pc_addr ;

// Wires of address Mux

wire [addr_width-1:0] addr;




///////////////////////////////////////////////////////////////////////////

// phase generator institation

Counter #(
    .counter_width(3)
)
phase_genrator
(
    .load(1'b0),
    .rst(rst),
    .clk(clk),
    .enab(!halt),
    .cnt_in(3'b0),
    .cnt_out(phase)
);

// Controller insitiation

controller #(
    .opcode_width (3) 
)  
controller_inst
(
    .opcode(opcode),
    .phase(phase),
    .zero(zero),
    .sel(sel),
    .rd(rd),
    .ld_ir(ld_ir),
    .inc_pc(inc_pc),
    .halt(halt),
    .ld_pc(ld_pc),
    .data_e(data_e),
    .ld_ac(ld_ac),
    .wr(wr)
);


// ALU insitiation
ALU #(
    .data_width(data_width),
    .opcode_width(3)
)
ALU_Inst
(
    .in_a(ac_out),
    .in_b(data),
    .opcode(opcode),
    .alu_out(alu_out),
    .zero(zero)
);

// Acummulator register

generic_register #(
    .data_width(data_width)
)
 Acummulator_register_Inst
(
    .load(ld_ac),
    .clk(clk),
    .rst(rst),
    .data_in(alu_out),
    .data_out(ac_out)
);


// Tristate buffer insitation

Tristate #(
    .data_width(data_width)
)
Tristate_inst
(
    .data_en(data_e),
    .data_in(alu_out),
    .data_out(data)
);

// Instruction register instiation

generic_register #(
    .data_width(data_width)
)
Instruction_register_inst
(
    .clk(clk),
    .rst(rst),
    .load(ld_ir),
    .data_in(data),
    .data_out({opcode,ir_addr})

);

// Program Counter Instiation

Counter #(
    .counter_width(addr_width)
)
Program_Counter_inst
(
    .load(ld_pc),
    .rst(rst),
    .clk(clk),
    .enab(inc_pc),
    .cnt_in(ir_addr),
    .cnt_out(pc_addr)
);

// Adrress Mux instiation
MUX #(
    .MUX_Width(addr_width)
)

Adress_MUX_Inst
(
    .in0(ir_addr),
    .in1(pc_addr),
    .mux_out(addr),
    .sel(sel)
);

// Memory instiation

memory #(
    .addr_width(addr_width),
    .data_width(data_width)
)
memory_inst
(
    .clk(clk),
    .wr(wr),
    .rd(rd),
    .addr(addr),
    .data(data)

); 
endmodule







