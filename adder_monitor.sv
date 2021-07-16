class adder_monitor extends uvm_monitor#(adder_transaction_item);
	`uvm_component_utils(adder_monitor);
	
	virtual adder_if vif;

	uvm_analysis_port#(adder_transaction_item) mon_analysis_port;

	function new (string name = "adder_monitor", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual adder_if)::get(this,"","adder_vif",vif))
			`uvm_fatal("MON","Could not get interface")
		mon_analysis_port = new ("mon_analysis_port",this);
	endfunction

	task run_phase (uvm_phase phase);
		super.run_phase(phase);
		sample_port();
	endtask

	virtual task sample_port();
		adder_transaction_item add_tx;
//		add_tx = adder_transaction_item::type_id::create("add_tx");
		forever begin
		add_tx = adder_transaction_item::type_id::create("add_tx");
			@(posedge vif.clk);
			if (vif.en_o) begin
				add_tx.adder_out <= vif.out_res;
				add_tx.adder_a <= vif.in_a;
				add_tx.adder_b <= vif.in_b;
				repeat(5)@(posedge vif.clk);
			`uvm_info(get_type_name(),$sformatf("Contents: %s", add_tx.sprint()),UVM_LOW)
				mon_analysis_port.write(add_tx);
			$display("After write");
			end
		end
	endtask

endclass
