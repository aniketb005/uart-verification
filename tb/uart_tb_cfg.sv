class uart_tb_cfg extends uvm_object;

`uvm_object_utils(uart_tb_cfg)

virtual uart_if vif;

int no_of_agents = 2;
bit has_sb =1;
bit has_agent =1;
bit has_virtual_seqr=1;

uart_agt_cfg m_cfg[];

extern function new(string name="uart_tb_cfg");
endclass

function uart_tb_cfg::new(string name="uart_tb_cfg");
	super.new(name);
endfunction
