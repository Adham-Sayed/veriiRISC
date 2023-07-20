module controller #(
    parameter opcode_width = 3
) 
(
    input wire [opcode_width-1:0] opcode , phase,
    input wire zero,
    output reg  sel, rd, ld_ir,halt, inc_pc, ld_ac, wr, ld_pc, data_e 
);

// States for ALU
localparam hlt = 0 ;
localparam skz = 1 ;
localparam add = 2 ;
localparam andd = 3 ;
localparam xorr = 4 ;
localparam lda = 5 ;
localparam sto = 6 ;
localparam jmp = 7 ;

 
reg ALU_OP , SKZ, STO, JMP, HALT ;

always @(*) begin 
    
    
     ALU_OP = (opcode == add || opcode == andd || opcode ==  xorr || opcode == lda); 
     JMP = (opcode == jmp);
     SKZ = (opcode == skz) ;
     STO = (opcode == sto) ;
     HALT = (opcode == hlt) ;

    case (phase)
    3'd0 : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b1_1000_0000 ;
    3'd1 : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b1_1000_0000 ;
    3'd2 : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b1_1100_0000 ;
    3'd3: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b1_1100_0000 ;
    3'd4 : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {3'b000,HALT,5'b10000};
    3'd5 : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {1'b0,ALU_OP,7'b0} ;
    3'd6 : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {1'b0,ALU_OP,2'b0,(SKZ & zero),1'b0,JMP,1'b0,STO} ;
    3'd7 : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {1'b0,ALU_OP,3'b0,ALU_OP,JMP,STO,STO} ;
    endcase
end
endmodule

