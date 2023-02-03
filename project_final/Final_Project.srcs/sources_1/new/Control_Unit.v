`timescale 1ns / 1ps

module CU(
    input start,clk,reset,CO,Z,
    output reg [1:0] InsSel,
    output reg WE,busy,
    output reg [2:0] InMuxAdd,
    output reg [7:0] CUconst,
    output reg [3:0] OutMuxAdd,RegAdd
);
    reg [3:0] state;
    reg [7:0] counter;
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 4'b0000;
        end
        else if(start) begin
            case (state)
                4'b0000: begin // CUcount -> Reg1
                    busy <= 1'b1;
                    state <= 4'b0001;
                    CUconst <= 8'b11111111;
                    InMuxAdd <= 3'b010;
                    RegAdd <= 4'b0001;
                    WE <= 1'b1;
                    counter <= 8'b00000000;
                end
                4'b0001: begin // Inb -> reg2
                    state <= 4'b0010;
                    InMuxAdd <= 3'b001;
                    RegAdd <= 4'b0010;
                end
                4'b0010: begin // reg2 xor reg1
                    state <= 4'b0011;
                    InsSel <= 2'b01;
                    RegAdd <= 4'b1111;
                end
                4'b0011: begin // ALUout -> reg2
                    state <= 4'b0100;
                    InMuxAdd <= 3'b011;
                    RegAdd <= 4'b0010;
                end
                4'b0100: begin // CUcount -> reg1
                    state <= 4'b0101;
                    CUconst <= 8'b00000001;
                    RegAdd <= 4'b0001;
                    InMuxAdd <= 3'b010;
                end
                4'b0101: begin // reg2 + reg1
                    state <= 4'b0110;
                    InsSel <= 2'b10;
                    RegAdd <= 4'b1111;
                end
                4'b0110: begin // ALUout -> Reg2
                    state <= 4'b0111;
                    RegAdd <= 4'b0010;
                    InMuxAdd <= 3'b011;
                end
                4'b0111: begin // InA -> Reg1
                    state <= 4'b1000;
                    InMuxAdd <= 3'b000;
                    RegAdd <= 4'b0001;
                end
                4'b1000: begin //reg1 + reg2
                    state <= 4'b1001;
                    InsSel <= 2'b10;
                    counter <= counter + 1'b1;
                end
                4'b1001: begin // if CO = 1 ALUout -> reg1 and counter = counter +1 else counter -> reg0 (quotient) and reg1 is reminder
                    if(CO) begin
                        state <= 4'b1000;
                        InMuxAdd <= 3'b011;
                        RegAdd <= 4'b0001;
                        InsSel <= 2'b00;
                        
                    end
                    else if(!CO) begin
                        state <= 4'b1010;
                    end
                end
                4'b1010: begin // counter -> reg0 
                    RegAdd <= 4'b0000;
                    CUconst <= counter -1'b1;
                    InMuxAdd <= 3'b010;
                    busy <= 1'b0;
                end
                default: begin
                    state <= 4'b0000;
                end 
            endcase
        end
    end


endmodule