module Counter #(
    parameter counter_width =5
)
(
    input wire load, rst, clk ,enab ,
    input wire [counter_width-1:0] cnt_in,
    output reg [counter_width-1:0] cnt_out
);

always @(posedge clk) begin
    if(rst)
    cnt_out <= 0;
    else begin
        if(load)
        cnt_out <= cnt_in;
        else
        if(enab)
        cnt_out <= cnt_out +1 ;
        else
        cnt_out <= cnt_out;
    end
end


endmodule   
