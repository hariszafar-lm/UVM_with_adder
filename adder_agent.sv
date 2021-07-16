class adder_agent extends uvm_agent;
	`uvm_component_utils(adder_agent);

	uvm_analysis_port#(adder_transaction_item) agent_analysis_port;
	adder_driver d0;
	adder_monitor m0;

    uvm_sequencer#(adder_transaction_item) s0;

	function new (string name="",uvm_component parent=null);
		super.new(name,parent);	
	endfunction

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);

		d0 = adder_driver::type_id::create("d0",this);
		m0 = adder_monitor::type_id::create("m0",this);
		s0 = uvm_sequencer#(adder_transaction_item)::type_id::create("s0",this);
		agent_analysis_port = new("agent_analysis_port",this);
	endfunction

	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
		
		d0.seq_item_port.connect(s0.seq_item_export);
		m0.mon_analysis_port.connect(agent_analysis_port);
	endfunction
	
endclass
