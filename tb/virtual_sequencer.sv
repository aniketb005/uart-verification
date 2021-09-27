class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
	
`uvm_component_utils(virtual_sequencer)

uart_sequencer seqrh[];
uart_tb_cfg m_cfg;
//seqrh = new[2];

extern function new(string name="virtual seqr",uvm_component parent);
endclass

function virtual_sequencer::new(string name="virtual seqr",uvm_component parent);
	super.new(name,parent);

	if(!uvm_config_db #(uart_tb_cfg)::get(this,"","uart_tb_cfg",m_cfg))
		`uvm_fatal("FATAL","cannot get in virtual sequencer")

	seqrh = new[m_cfg.no_of_agents];

endfunction 
 
