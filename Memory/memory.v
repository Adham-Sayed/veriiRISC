module memory #(
    parameter data_width =8,
    parameter addr_width =5
) (
    input wire [addr_width-1:0]addr,
    input wire clk,
    input wire wr,
    input wire rd,
    inout wire [data_width-1:0]data
);

reg [data_width-1:0] array[2**addr_width-1:0]; 
// Continous assigning output 
assign data=rd ? array[addr]:'bz;
always @(posedge clk) begin
    if (wr) 
        array[addr]=data;
end



endmodule