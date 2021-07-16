	import uvm_pkg::*;
	`include "adder_transaction_item.sv"
	`include "adder_sequences.sv"
	`include "adder_driver.sv"
	`include "adder_monitor.sv"
	`include "adder_agent.sv"
	`include "adder_scoreboard.sv"
	`include "adder_env.sv"
	`include "adder_test.sv"
	`include "adder_config.sv"
`include "adder_if.sv"
`include "adder_dut.v"


module adder_tb_top;

//	`include "uvm_macros.svh"

	adder_if vif();
	simpleadder dut(vif.clk, vif.en_i, vif.in_a, vif.in_b, vif.en_o, vif.out_res);

	initial begin
		uvm_config_db#(virtual adder_if)::set(null,"*","adder_vif",vif);

		run_test();
	end

	initial begin
		vif.clk <= 1'b0;
	end	

	always
		#5 vif.clk = ~vif.clk;
endmodule
