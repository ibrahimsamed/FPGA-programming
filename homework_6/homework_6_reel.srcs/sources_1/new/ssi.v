`timescale 1ns / 1ps

module NOT(
    input x,
    output y);
    assign y=!x;
endmodule
module AND(
    input x,y,
    output z);
    assign z=x&y;
endmodule
module OR(
    input x,y,
    output z);
    assign z=x|y;
endmodule