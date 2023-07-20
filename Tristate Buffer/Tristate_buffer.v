module Tristate #(
    parameter data_width = 8
)
(
    input wire data_en ,
    input wire [data_width-1:0] data_in,
    output reg [data_width-1:0] data_out 
);
always @ (*)begin
    if(data_en)
    data_out = data_in;
    else
    data_out = 'bz;
end
endmodule