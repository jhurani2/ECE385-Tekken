module Kyoto bg_rom (
	input logic clock,
	input logic [14:0] address,
	output logic [3:0] q
);

logic [3:0] memory [0:32767] /* synthesis ram_init_file = "./Kyoto bg/Kyoto bg.COE" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
