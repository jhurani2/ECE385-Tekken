`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 05:22:58 PM
// Design Name: 
// Module Name: jack_m
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


module jack_m (
	input logic [9:0] DrawX, DrawY,
	input logic [12:0] addr,
	input logic blank,
	input logic pix_clk,
	output logic [3:0] red, green, blue
);

//logic [12:0] rom_address;
logic [2:0] rom_q;
logic [9:0] drawx,drawy;

logic [3:0] palette_red, palette_green, palette_blue;

logic negedge_pix_clk;

// read from ROM on negedge, set pixel on posedge
assign negedge_pix_clk = ~pix_clk;

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen
//always_ff @ (posedge pix_clk) begin
//    drawx <= DrawX;
//    drawy <= DrawY;
//   end

//assign rom_address = ((drawx * 64) / 640) + (((drawy * 128) / 480) * 64);

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

jack_rom Jack_rom (
	.clock   (negedge_pix_clk),
	.mem_clk (pix_clk),
	.address (addr),
	.q       (rom_q)
);

palette_jack Jack_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
