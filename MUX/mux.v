module MUX 
#( 
    parameter MUX_Width = 5
    ) 
    (
    input [MUX_Width-1:0] in0, in1 ,
    input sel,
    output reg [MUX_Width-1:0] mux_out
    );

always @ (*) begin

    if(sel)
    mux_out = in1;
    else
    mux_out = in0;
    end

endmodule

