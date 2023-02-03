`timescale 1ns / 1ps

module MULTB(
    input signed [7:0]A,
    input signed [7:0]B,
    output reg signed [15:0]result
);
    always @(*) begin
        result=A*B;
    end
endmodule

module MAC(
    input clk,
    input reset,
    input signed [23:0]data,weight,
    output reg signed [19:0]result
);
    initial
    begin
    result = 20'b00000000000000000000;
    end
    wire signed [15:0]product0,product1,product2;
    wire signed [15:0] sum0,sum1;
    reg [1:0]count=2'b00;
        MULTB u1(.A(data[7:0]),.B(weight[7:0]),.result(product0));
        MULTB u2(.A(data[15:8]),.B(weight[15:8]),.result(product1));
        MULTB u3(.A(data[23:16]),.B(weight[23:16]),.result(product2));
        BA u4(.A(product0),.B(product1),.result(sum0));
        BA u5(.A(product2),.B(sum0),.result(sum1));
        always @(posedge clk )begin
            if (reset == 1'b1)begin
                result <= 20'b00000000000000000000;
                count <= 2'b00;
            end
            else if(count == 2'b11)begin
                count <=2'b00;
                result <= 20'b00000000000000000000;
            end 
            else begin
                result <= result + sum1;
                count <= count +1'b1;
            end
        end


endmodule

module BA(
    input signed [15:0]A,
    input signed [15:0]B,
    output reg signed [15:0]result
);
    always @(*)begin
    result = A+B;
    end
endmodule


module MAC_Normalize (
  input [19:0] data,
  output reg [7:0] result
);
  always @(*) begin
    if (data > 1023) begin
      result = 8'd255;
    end else if (data < 0) begin
      result = 8'd0;
    end else begin
      result = data;
    end
  end
endmodule

module CONV (
  input clk,
  input reset,
  input [23:0] data,
  input [23:0] weight,
  output [7:0] result
);
  wire [19:0] mac_result;

  MAC mac_unit (.data(data),.weight(weight),.result(mac_result));
  MAC_Normalize mac_normalize_unit (.data(mac_result),.result(result));

endmodule

module CONV128 (
  input clk,
  input reset,
  input [1039:0] data,
  input [23:0] weight,
  output [1023:0] result
);
  genvar i;
  generate
    for (i = 0; i < 128; i=i+1) 
    begin 
      wire [7:0] conv_result;
      CONV conv_unit (.clk(clk),.reset(reset),.data(data[(i+1)*8-1:i*8]),.weight(weight),.result(conv_result));
      assign result[(i+1)*8-1:i*8] = conv_result;
    end
  endgenerate
endmodule


module control_input (
  input clk,
  input reset,
  input conv_run,
  input   [71:0] kernel,
  output enable_ram,
  output reg [7:0] address_ram,
  output reg[23:0] weight
);
  reg [1:0] counter;
  reg [71:0] kernela;
  
  assign kernel= kernela;
  always @(posedge clk) begin
    if (reset) begin
      counter <= 0;
      address_ram <= 8'h00;
    end
  end
  always @(posedge clk) begin
    if (conv_run) begin
      counter <= counter + 1'b1;
      address_ram <= address_ram + 1;
      weight <= kernela[47:24];
      kernela <= kernela[71:48];
    end
  end
  always @(posedge clk) begin
    if (counter == 3) begin
      counter <= 0;
    end
  end
  assign enable_ram = conv_run;
  
endmodule

module output_control (
  input clk,
  input reset,
  input [1023:0] data,
  output reg conv_done,
  output [6:0] ram_address,
  output [1023:0] data_out
);
  reg [1:0] counter;
  reg [6:0] current_address;

  always @(posedge clk) begin
    if (reset) begin
      counter <= 0;
      current_address <= 0;
    end
    else begin
      counter <= counter + 1'b1;
    end
    if (counter == 2'd3) begin
        counter <= 0;
        current_address <= current_address + 1;
    end
    if (current_address ==130)begin
        conv_done = 1'b1;
    end
  end

  assign ram_address = current_address;
  
endmodule








