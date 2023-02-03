`timescale 1ns / 1ps


module tb_fa( );
    wire sum, carry_out; 
    reg a, b, c; 
    FA uut(.x(a), .y(b), .ci(c), .s_fa(sum), .cout_fa(carry_out)); 
    initial 
    begin 
    a = 1'b0; b = 1'b0; c = 1'b0;
    #10;
    a = 1'b0; b = 1'b0; c = 1'b1;
    #10;
    a = 1'b0; b = 1'b1; c = 1'b0;
    #10;
    a = 1'b0; b = 1'b1; c = 1'b1;
    #10;
    a = 1'b1; b = 1'b0; c = 1'b0;
    #10;
    a = 1'b1; b = 1'b0; c = 1'b1;
    #10;
    a = 1'b1; b = 1'b1; c = 1'b0;
    #10; 
    a = 1'b1; b = 1'b1; c = 1'b1;
    end
endmodule
