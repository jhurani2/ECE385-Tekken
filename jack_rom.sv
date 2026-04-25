`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2026 10:57:22 PM
// Design Name: 
// Module Name: jack_rom
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


module jack_rom (
	input logic clock,
	input logic mem_clk,
	input logic [12:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:8191]; /* synthesis ram_init_file = "./Jack/Jack.COE" */;
logic [2:0] dout;

blk_mem_gen_1 jack (
        .addra(address),
        .clka(clock),
        .dina(),
        .douta(q),
        .ena(1'b1), 
        .wea(1'b0)

); 

//assign memory[address] = dout;

//always_ff @ (posedge clock) begin
//    memory[address] <= dout;
//	q <= memory[address];
//end

endmodule
