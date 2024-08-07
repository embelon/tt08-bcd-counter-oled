/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_frequency_counter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  `define clk_x       ui_in[0]

  `define oled_rstn   uo_out[0]
  `define oled_vbatn  uo_out[1]
  `define oled_vcdn   uo_out[2]
  `define oled_csn    uo_out[3]
  `define oled_dc     uo_out[4]
  `define oled_clk    uo_out[5]
  `define oled_mosi   uo_out[6]

  oled_frequency_counter counter
  (
    .clk_ref_in(clk),
    .reset_in(!rst_n),

    .clk_x_in(clk_x),

	  // Interface to controll SSD1306 OLED Display
	  .oled_rstn_out(oled_rstn),
	  .oled_vbatn_out(oled_vbatn),	
	  .oled_vcdn_out(oled_vcdn),
	  .oled_csn_out(oled_csn),
	  .oled_dc_out(oled_dc),
	  .oled_clk_out(oled_clk),
	  .oled_mosi_out(oled_mosi)
  );

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[7] = ui_in[7];
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[6:0], 1'b0};

endmodule
