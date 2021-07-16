interface adder_if;
	logic clk;

	logic en_i;
	logic [1:0] in_a;
	logic [1:0] in_b;

	logic en_o;
	logic [2:0] out_res;

endinterface
