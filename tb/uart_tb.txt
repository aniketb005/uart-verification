class uart_tb extends uvm_env;

`uvm_component_utils(uart_tb)

uart_agent magenth[];


uart_scoreboard sb;

virtual_sequencer vseqrh;

uart_tb_cfg tb_cfg;
uart_agt_cfg m_cfg[];

extern function new(string name="UART TB",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

function uart_tb::new(string name="UART TB",uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_tb::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db #(uart_tb_cfg)::get(this,"","uart_tb_cfg",tb_cfg))
		`uvm_fatal("FATAL","Cannot get tb cfg in tb")

	if(tb_cfg.has_agent)
	  begin
	    magenth = new[tb_cfg.no_of_agents];
		
	    foreach(magenth[i])
	      begin
	     	uvm_config_db #(uart_agt_cfg) ::set(this,$sformatf("magenth[%0d]*",i),"uart_agt_cfg",tb_cfg.m_cfg[i]); //check
		$display("%p",tb_cfg.m_cfg[i]);
	     	magenth[i] = uart_agent::type_id::create($sformatf($sformatf("magenth[%0d]",i)),this);
	     	//magenth2 = uart_agent::type_id::create("magenth2",this);
	      end
	  end

	if(tb_cfg.has_virtual_seqr)
	     vseqrh = virtual_sequencer::type_id::create("vseqrh",this);
		//$display("%p",vseqrh);
	if(tb_cfg.has_sb)
	     sb = uart_scoreboard::type_id::create("sb",this);

endfunction

function void uart_tb::connect_phase(uvm_phase phase);
	if(tb_cfg.has_virtual_seqr)
		if(tb_cfg.has_agent)
			vseqrh.seqrh[0] = magenth[0].seqrh; //check later
			vseqrh.seqrh[1] = magenth[1].seqrh;

	if(tb_cfg.has_sb)
		magenth[0].monh.apmon.connect(sb.wrfifo.analysis_export); //check later
		magenth[1].monh.apmon.connect(sb.rdfifo.analysis_export);
endfunction		
	
	     
	
	
	





