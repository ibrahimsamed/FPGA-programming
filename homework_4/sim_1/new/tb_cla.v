`timescale 1ns / 1ps


module tb_cla();
    reg [3:0]x,y;
    reg c0;
    wire [3:0]s_cla;
    wire cout_cla;
    CLA uut(.x(x),.y(y),.c0(c0),.cout_cla(cout_cla),.s_cla(s_cla));
    initial begin
    
    x= 4'd0; y=4'd0; c0=0;
    #10
    x= 4'd1; y=4'd1; c0=0;
    #10
    x= 4'd2; y=4'd2; c0=0;
    #10
    x= 4'd4; y=4'd3; c0=0;
    #10
    x= 4'd2; y=4'd3; c0=0;
    end
endmodule
