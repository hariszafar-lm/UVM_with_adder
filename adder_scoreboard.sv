class adder_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(adder_scoreboard);
	
	uvm_analysis_export #(adder_transaction_item) sb_port;
	uvm_tlm_analysis_fifo #(adder_transaction_item) sb_fifo;
	adder_transaction_item adder_tx;

	integer expected_result;

	function new (string name = "", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sb_port = new ("sb_port",this);	
		sb_fifo = new ("sb_fifo",this);	
		adder_tx = new ("adder_tx");
	endfunction

	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
		sb_port.connect(sb_fifo.analysis_export);
	endfunction

	task run();
		forever begin
		sb_fifo.get(adder_tx);
//		`uvm_info(get_type_name(),$sformatf("After getting result from MON: %s", adder_tx.sprint()),UVM_LOW)
		expected_result = adder_tx.adder_a + adder_tx.adder_b ;
   		`uvm_info(get_type_name(),$sformatf("Expected: %d", expected_result),UVM_LOW)
		if (expected_result == adder_tx.adder_out) begin
			`uvm_info("compare",{"Test: Pass"},UVM_LOW);
		end
		else begin
			`uvm_info("compare",{"Test: Fail"},UVM_LOW);
		end
		end	
	endtask
	
endclass
