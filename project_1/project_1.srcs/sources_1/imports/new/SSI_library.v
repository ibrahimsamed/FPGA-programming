`timescale 1ns / 1ps

module AND( output O,
            input I1,I2);
            
            assign O = I1&I2;
            endmodule

module OR (output O,
           input I1,I2);
           
           assign O = I1|I2;
           endmodule

module NOT( output O,
            input I);
            
            assign O = ~I;
            endmodule

module NAND(output reg O,
            input I1,I2);

            always @(I1,I2) begin
            O = ~(I1&I2);
            end
            endmodule

module NOR(output reg O,
            input I1,I2);
            
            always @(I1,I2) begin
                O = ~(I1|I2);
            end
            endmodule

module EXOR(output O,
            input I1,I2);
            LUT2 #(
                .INIT ( 4'b0110 ) 
            ) EXOR
            (
    .I0( I1 ),
    .I1( I2 ),
    .O ( O )
 );
 endmodule

module EXNOR(output O,
            input I1,I2);
            LUT2 #(
                .INIT ( 4'b1001 )
            ) EXNOR
            (
    .I0( I1 ),
    .I1( I2 ),
    .O ( O )
 );
 endmodule

module TRI(input I,E,
            output O);
            assign O = (E==1) ? (I) : (1'bz);
endmodule