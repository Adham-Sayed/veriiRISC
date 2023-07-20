module ALU #(
    parameter data_width =8,
    parameter opcode_width =3
)
(
    input wire [data_width-1:0] in_a,in_b,
    input wire [opcode_width-1:0] opcode ,
    output reg [data_width-1:0] alu_out ,
    output reg zero   
);



always @(*) begin
    
    case (opcode)
    3'b000 : {alu_out,zero} = in_a ? {in_a,1'b0} : {in_a,1'b1};
    3'b001 : {alu_out,zero} = in_a ? {in_a,1'b0} : {in_a,1'b1};
    3'b010 : {alu_out,zero} = (in_a + in_b) ? {(in_a + in_b) ,1'b0} : {(in_a + in_b) ,1'b1};
    3'b011 : {alu_out,zero} = (in_a & in_b) ? {(in_a & in_b) ,1'b0} : {(in_a & in_b),1'b1};
    3'b100 : {alu_out,zero} = (in_a ^ in_b) ? {(in_a ^ in_b) ,1'b0} : {(in_a ^ in_b),1'b1};
    3'b101 : {alu_out,zero} = in_b ? {in_b,1'b0} : {in_b,1'b1};
    3'b110 : {alu_out,zero} = in_a ? {in_a,1'b0} : {in_a,1'b1};
    3'b111 : {alu_out,zero} = in_a  ? {in_a ,1'b0} : {in_a,1'b1};
    endcase
end
endmodule