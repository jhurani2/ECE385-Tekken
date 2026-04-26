module Paul_rom (
	input logic clock,
	input logic [12:0] address,
	output logic [7:0] q
);

logic [7:0] memory [0:8191] /* synthesis ram_init_file = "./Paul/Paul.COE" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
