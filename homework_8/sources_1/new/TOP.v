`timescale 1ns / 1ps

module TOP (
  input clk,
  input reset,
  input conv_run,
  input [71:0] kernel,
  output conv_done,
  output [1023:0] data_out
  
);
  wire [7:0] ram_address;
  wire [23:0] weight;
  wire [1023:0] data;
  wire  result_conv128;
  wire [7:0] address_ram_2;
  wire [1023:0] data_2;
  wire enable_ram;
  control_input control_input_unit (
    .clk(clk),.reset(reset),.conv_run(conv_run),.kernel(kernel),.enable_ram(enable_ram),.address_ram(ram_address),.weight(weight));
  blk_mem_gen_0_0 design1
       (.addra_0(ram_address),
        .clka_0(clk),
        .dina_0(kernel),
        .douta_0(data),
        .ena_0(enable_ram),
        .wea_0(conv_done));
  CONV128 conv128_unit (
    .clk(clk), .reset(reset), .data(data), .weight(weight), .result(result_conv128));
  output_control output_control_unit (
    .clk(clk),  .reset(reset),  .data(result_conv128),  .conv_done(conv_done),  .ram_address(address_ram_2), .data_out(data_2) );
  blk_mem_gen_1_1 design_
       ( .addra_1(address_ram_2),
        .clka_1(clk),
        .dina_1(data_2),
        .douta_1(data_out),
        .ena_1(enable_ram),
        .wea_1(conv_done));
endmodule


