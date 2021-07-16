class adder_driver extends uvm_driver#(adder_transaction_item);
	`uvm_component_utils(adder_driver);

	function new (string name="adder_driver", uvm_component parent=null);
		super.new(name,parent);
	endfunction

   	virtual adder_if vif;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual adder_if)::get(this,"","adder_vif",vif))
			`uvm_fatal("DRV","Could not get interface")
	endfunction

	virtual	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			adder_transaction_item add_tx;
			seq_item_port.get_next_item(add_tx);
			drive_item(add_tx);
			`uvm_info(get_type_name(),$sformatf("Contents: %s", add_tx.sprint()),UVM_LOW)
			seq_item_port.item_done();	
		end
	endtask

	virtual task drive_item (adder_transaction_item add_tx);
		vif.en_i <= 0;
		vif.in_a <= 0;
		vif.in_b <= 0;
		@(posedge vif.clk);
		vif.en_i <= 1;
		vif.in_a <= add_tx.adder_a;
		vif.in_b <= add_tx.adder_b;
		@(posedge vif.clk);
		vif.en_i <= 0;
		repeat(4) @(posedge vif.clk);
		vif.in_a <= 0;
		vif.in_b <= 0;
	endtask

endclass
