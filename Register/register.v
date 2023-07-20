module generic_register #(
    parameter data_width = 8
)
(
    input wire load, clk, rst ,
    input wire [data_width-1:0] data_in,
    output reg [data_width-1:0] data_out 
);

always@(posedge clk) begin
if(rst)
data_out <= 0;
else begin
    if(load)
    data_out <= data_in;
    else
    data_out <= data_out;
end
end
endmodule