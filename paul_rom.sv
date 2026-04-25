`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2026 09:47:21 PM
// Design Name: 
// Module Name: paul_rom
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


module paul_rom (
	input logic clock,
	input logic mem_clk,
	input logic [12:0] address,
	output logic [2:0] q
);

blk_mem_gen_2 paul (
        .addra(address),
        .clka(clock),
        .dina(),
        .douta(q),
        .ena(1'b1), 
        .wea(1'b0)

); 

endmodule

