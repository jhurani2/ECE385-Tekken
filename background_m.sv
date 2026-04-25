`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2026 09:51:42 PM
// Design Name: 
// Module Name: background_m
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module background_m (
	input logic [9:0] DrawX, DrawY,
	input logic [12:0] addr,
	input logic blank,
	input logic pix_clk,
	output logic [3:0] red, green, blue
);

//logic [14:0] rom_address;
logic [3:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

logic negedge_pix_clk;

// read from ROM on negedge, set pixel on posedge
assign negedge_pix_clk = ~pix_clk;


always_ff @ (posedge pix_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
	end
end

bg_rom bg_rom (
	.clock   (negedge_pix_clk),
	.mem_clk (pix_clk),
	.address (addr),
	.q       (rom_q)
);

bg_palette bg_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
