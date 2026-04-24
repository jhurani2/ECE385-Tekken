module Paul_new_rom (
	input logic clock,
	input logic [13:0] address,
	output logic [7:0] q
);

logic [7:0] memory [0:12287] /* synthesis ram_init_file = "./Paul_new/Paul_new.COE" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
