class adder_test extends uvm_test;
	`uvm_component_utils(adder_test);

	adder_env env;
	adder_sequences seq; 

	function new (string name ="", uvm_component parent=null);
		super.new(name,parent);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = adder_env::type_id::create("env",this);
	endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		seq = adder_sequences::type_id::create("seq",this); 
//		assert(seq.randomize());
		seq.start(env.ag.s0);
		phase.phase_done.set_drain_time(this, 60);
		phase.drop_objection(this);

	endtask

endclass 
