`timescale 1ns / 1ns 

module tb_arithmetic_circuit ; 
    wire sum, carry; 
    reg a, b; 
    HA uut(.x(a), .y(b), .s(sum), .cout(carry)); 
    initial 
    begin 
    a = 1'b0; b = 1'b0;
    #5 
    a = 1'b0; b = 1'b1;
    #5 //3 
    a = 1'b1; b = 1'b0;
    #5 //4 
    a = 1'b1; b = 1'b1;
    end 
endmodule