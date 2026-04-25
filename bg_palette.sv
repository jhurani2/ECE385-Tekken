`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2026 09:54:16 PM
// Design Name: 
// Module Name: bg_palette
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


module bg_palette (
	input logic [3:0] index,
	output logic [3:0] red, green, blue
);

localparam [0:15][11:0] palette = {
	{4'h8, 4'h8, 4'h7},
	{4'hF, 4'h0, 4'hF}, //pink
	{4'h1, 4'h1, 4'h1},
	{4'hD, 4'hF, 4'hE},
	{4'h9, 4'h2, 4'h1},
	{4'h2, 4'h4, 4'h4},
	{4'h5, 4'h2, 4'h2},
	{4'h9, 4'hB, 4'hB},
	{4'hB, 4'h1, 4'hB},
	{4'h6, 4'h5, 4'h5},
	{4'h0, 4'h0, 4'h0},
	{4'h2, 4'h2, 4'h2},
	{4'h2, 4'h5, 4'h5},
	{4'h8, 4'h3, 4'h3},
	{4'h8, 4'hA, 4'h9},
	{4'hC, 4'hD, 4'hD}
};

assign {red, green, blue} = palette[index];

endmodule