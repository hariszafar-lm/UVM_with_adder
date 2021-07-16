class adder_env extends uvm_env;
	`uvm_component_utils(adder_env);

	adder_scoreboard sb;
	adder_agent ag;

	function new (string name="", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sb = adder_scoreboard::type_id::create("sb",this);
		ag = adder_agent::type_id::create("ag",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		ag.agent_analysis_port.connect(sb.sb_port);
	endfunction

endclass
