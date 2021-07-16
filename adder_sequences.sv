class adder_sequences extends uvm_sequence#(adder_transaction_item);

	`uvm_object_utils(adder_sequences);

	function new(string name="adder_sequences");
		super.new(name);
	endfunction

	task body();
	adder_transaction_item add_tx;
	repeat(2) begin
		add_tx = adder_transaction_item::type_id::create("add_tx");
 
       		start_item(add_tx);
		assert(add_tx.randomize());
        	finish_item(add_tx);

	end
	endtask
endclass

//typedef uvm_sequencer#(adder_transaction_item) adder_sequencer;
