`timescale 1ns / 1ps


module tb_param_rca( );
    wire [3:0]sum; wire carry_out; 
    reg [3:0]a, b; reg c; 
    parametric_RCA uut(.x(a), .y(b), .cin(c), .s_rca(sum), .cout_rca(carry_out)); 
    initial 
    begin 
    a = 4'b0000; b = 4'b0000; c = 1'b0;
    #10;         
    a = 4'b0000; b = 4'b0000; c = 1'b1;
    #10;
    a = 4'b0001; b = 4'b0001; c = 1'b0;
    #10;         
    a = 4'b0001; b = 4'b0001; c = 1'b1;
    #10;  
    a = 4'b0010; b = 4'b0010; c = 1'b0;
    #10;         
    a = 4'b0010; b = 4'b0010; c = 1'b1;
    #10;
    a = 4'b0011; b = 4'b0011; c = 1'b0;
    #10;         
    a = 4'b0011; b = 4'b0011; c = 1'b1;
    #10; 
    a = 4'b0100; b = 4'b0100; c = 1'b0;
    #10;         
    a = 4'b0100; b = 4'b0100; c = 1'b1;
    #10;
    a = 4'b0101; b = 4'b0101; c = 1'b0;
    #10;         
    a = 4'b0101; b = 4'b0101; c = 1'b1;
    #10;  
    
       
    
    end
endmodule

