class uart_agent extends uvm_agent;

`uvm_component_utils(uart_agent)

uart_agt_cfg m_cfg;

uart_monitor monh;
uart_driver drvh;
uart_sequencer seqrh;

extern function new(string name = "Agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function uart_agent::new(string name = "Agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(uart_agt_cfg)::get(this,"","uart_agt_cfg",m_cfg))
		`uvm_fatal("FATAL","Cannot get agent cfg in Agent")
	monh = uart_monitor::type_id::create("monh",this);

	$display("%p",m_cfg);
	if(m_cfg.is_active == UVM_ACTIVE)
	begin
	$display("asdnglkjnd g");


	drvh = uart_driver::type_id::create("drvh",this);
	seqrh = uart_sequencer::type_id::create("seqrh",this);	
	end
endfunction

function void uart_agent::connect_phase(uvm_phase phase);
	if(m_cfg.is_active == UVM_ACTIVE)
		drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction 

task uart_agent::run_phase(uvm_phase phase);
	uvm_top.print_topology();
endtask	
