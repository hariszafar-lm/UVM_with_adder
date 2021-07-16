//import uvm_pkg::*;
//`include "uvm_macros.svh"
class adder_transaction_item extends uvm_sequence_item;

	rand bit [1:0] adder_a;
	rand bit [1:0] adder_b;
   	 bit [2:0] adder_out;

    `uvm_object_utils_begin(adder_transaction_item)
		`uvm_field_int(adder_a,UVM_DEFAULT)
		`uvm_field_int(adder_b,UVM_DEFAULT)
		`uvm_field_int(adder_out,UVM_DEFAULT)
	`uvm_object_utils_end

    function new (string name ="");
	    super.new(name);
    endfunction

endclass: adder_transaction_item
