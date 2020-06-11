class base_test extends uvm_test;

`uvm_component_utils(base_test)

uart_tb envh;
uart_tb_cfg tb_cfg;
uart_agt_cfg m_cfg[];

int no_of_agents = 2;

extern function new(string name="base test",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function base_test::new(string name="base test",uvm_component parent);
	super.new(name,parent);
endfunction

function void base_test::build_phase(uvm_phase phase);

	tb_cfg = uart_tb_cfg::type_id::create("tb_cfg");	
	
	tb_cfg.m_cfg = new[no_of_agents];
	m_cfg = new[no_of_agents];

	foreach(m_cfg[i])
	  begin
		m_cfg[i] = uart_agt_cfg::type_id::create($sformatf("m_cfg[%0d]",i));
		$display("%p",m_cfg[i]);
		if(!uvm_config_db #(virtual uart_if)::get(this,"",$sformatf("vif_%0d",i),m_cfg[i].vif))
			`uvm_fatal("FATAL","Cannot get vif in test")

	  
 		tb_cfg.no_of_agents = no_of_agents;

		m_cfg[i].is_active = UVM_ACTIVE;

		tb_cfg.m_cfg[i] = m_cfg[i];
	
	end

	uvm_config_db #(uart_tb_cfg)::set(this,"*","uart_tb_cfg",tb_cfg);

	super.build_phase(phase);

	envh = uart_tb::type_id::create("envh",this);

endfunction

class first_test extends base_test;

	`uvm_component_utils(first_test)

	first_seqs seqh;

extern function new(string name = "first_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function first_test ::new(string name = "first_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void first_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task first_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);

	seqh = first_seqs::type_id::create("seqh");
	seqh.start(envh.vseqrh);
	#100000;	 
	phase.drop_objection(this);
endtask


class halfd_test extends base_test;

	`uvm_component_utils(halfd_test)

	halfd_seqs hd_seqh;

extern function new(string name = "halfd_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function halfd_test ::new(string name = "halfd_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void halfd_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task halfd_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	hd_seqh = halfd_seqs::type_id::create("hd_seqh");
	hd_seqh.start(envh.vseqrh);
	#100000;	 
	phase.drop_objection(this);
endtask


class loopback_test extends base_test;
	`uvm_component_utils(loopback_test)

	loopback_vseqs lb_seqh;

extern function new(string name = "loopback_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function loopback_test ::new(string name = "loopback_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void loopback_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task loopback_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	lb_seqh = loopback_vseqs::type_id::create("lb_seqh");
	lb_seqh.start(envh.vseqrh);
	#100000;	 
	phase.drop_objection(this);
endtask

//////////////////////////////////////////////////////PARITY ERROR/////////////////////////////////////////////////////////////////////////////////////////

class parity_err_test extends base_test;

	`uvm_component_utils(parity_err_test)

	parity_err_vseqs pe_seqh;

extern function new(string name = "parity_err_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function parity_err_test ::new(string name = "parity_err_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void parity_err_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task parity_err_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	pe_seqh = parity_err_vseqs::type_id::create("pe_seqh");
	pe_seqh.start(envh.vseqrh);
	#100000;	 
	phase.drop_objection(this);
endtask

/////////////////////////////////////////////////////////////////////OVERRUN ERROR////////////////////////////////////////////////////////////////////////////

class overrun_err_test extends base_test;

	`uvm_component_utils(overrun_err_test)

	overrun_err_vseqs oe_seqh;

extern function new(string name = "overrun_err_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function overrun_err_test ::new(string name = "overrun_err_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void overrun_err_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task overrun_err_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	oe_seqh = overrun_err_vseqs::type_id::create("oe_seqh");
	oe_seqh.start(envh.vseqrh);
	#10000000;	 
	phase.drop_objection(this);
endtask

///////////////////////////////////////////////////////////////////FRAME MISMATCH////////////////////////////////////////////////////////////////////////////

class frame_mismatch_test extends base_test;

	`uvm_component_utils(frame_mismatch_test)

	frame_mismatch_vseqs fm_seqh;

extern function new(string name = "frame_mismatch_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function frame_mismatch_test ::new(string name = "frame_mismatch_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void frame_mismatch_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task frame_mismatch_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	fm_seqh = frame_mismatch_vseqs::type_id::create("fm_seqh");
	fm_seqh.start(envh.vseqrh);
	#100000;	 
	phase.drop_objection(this);
endtask

//////////////////////////////////////////////////BREAK INTURRUPT////////////////////////////////////////////////////////////////////////////////////////////

class break_int_test extends base_test;

	`uvm_component_utils(break_int_test)

	break_int_vseqs bi_seqh;

extern function new(string name = "break_int_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function break_int_test ::new(string name = "break_int_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void break_int_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task break_int_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	bi_seqh = break_int_vseqs::type_id::create("bi_seqh");
	bi_seqh.start(envh.vseqrh);
	#100000;	 
	phase.drop_objection(this);
endtask

////////////////////////////////////////////////////TIMEOUT///////////////////////////////////////////////////////////////////////////////////////////////////

class timeout_test extends base_test;

	`uvm_component_utils(timeout_test)

	timeout_vseqs to_seqh;

extern function new(string name = "timeout_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function timeout_test ::new(string name = "timeout_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void timeout_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task timeout_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	to_seqh = timeout_vseqs::type_id::create("to_seqh");
	to_seqh.start(envh.vseqrh);
	#100000;	 
	phase.drop_objection(this);
endtask

//////////////////////////////////////////////////////////////THR EMPTY///////////////////////////////////////////////////////////////////////////////////////

class thr_empty_test extends base_test;

	`uvm_component_utils(thr_empty_test)

	thr_empty_vseqs te_seqh;

extern function new(string name = "thr_empty_test",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function thr_empty_test ::new(string name = "thr_empty_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void thr_empty_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task thr_empty_test:: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	te_seqh = thr_empty_vseqs::type_id::create("te_seqh");
	te_seqh.start(envh.vseqrh);
	#100000;	 
	phase.drop_objection(this);
endtask

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
