class base_vseqs extends uvm_sequence #(uvm_sequence_item);

`uvm_object_utils(base_vseqs)

uart_sequencer seqrh[];

virtual_sequencer vseqrh;

uart_tb_cfg tb_cfg;

extern function new(string name="virtual_seqs");
extern task body();
endclass

function base_vseqs::new(string name="virtual_seqs");
	super.new(name);
endfunction

task base_vseqs::body();
 	if(!uvm_config_db #(uart_tb_cfg)::get(null,get_full_name(),"uart_tb_cfg",tb_cfg))
		`uvm_fatal("FATAL","cannot get config in vseq")


	$display("sdnfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffgk");
	assert($cast(vseqrh,m_sequencer))
	else 
	  `uvm_error("ERROR","Casting failed")
	
	$display("sdgfkbbhhhhhhhhhhhhhm");


	seqrh = new[tb_cfg.no_of_agents];

	foreach(seqrh[i])
	seqrh[i] = vseqrh.seqrh[i];
	//seqrh[1] = vseqrh.seqrh[1];
	
endtask

class first_seqs extends base_vseqs;
	`uvm_object_utils(first_seqs)

	full_duplex_txseq fd_txseq;
	full_duplex_rxseq fd_rxseq;

extern function new (string name="first_seqs");
extern task body();
endclass

function first_seqs :: new(string name="first_seqs");
	super.new(name);
endfunction

task first_seqs::body();
	super.body();
	fd_txseq = full_duplex_txseq::type_id::create("fd_txseq");
	fd_rxseq = full_duplex_rxseq::type_id::create("fd_rxseq");
	fork
	fd_txseq.start(seqrh[0]);
	fd_rxseq.start(seqrh[1]);
	join
endtask

class halfd_seqs extends base_vseqs;
	`uvm_object_utils(halfd_seqs)

	half_duplex_txseq hd_txseq;
	half_duplex_rxseq hd_rxseq;

extern function new (string name="halfd_seqs");
extern task body();
endclass

function halfd_seqs :: new(string name="halfd_seqs");
	super.new(name);
endfunction

task halfd_seqs::body();
	super.body();
	hd_txseq = half_duplex_txseq::type_id::create("hd_txseq");
	hd_rxseq = half_duplex_rxseq::type_id::create("hd_rxseq");
	fork
	hd_txseq.start(seqrh[0]);
	hd_rxseq.start(seqrh[1]);
	join
endtask


class loopback_vseqs extends base_vseqs;
	`uvm_object_utils(loopback_vseqs)

	loopback_seq lb_trseq;

extern function new (string name="lb_seqs");
extern task body();
endclass

function loopback_vseqs :: new(string name="lb_seqs");
	super.new(name);
endfunction

task loopback_vseqs::body();
	super.body();
	lb_trseq = loopback_seq::type_id::create("lb_trseq");
	lb_trseq.start(seqrh[0]);
	//hd_rxseq.start(seqrh[1]);
endtask


class parity_err_vseqs extends base_vseqs;
	`uvm_object_utils(parity_err_vseqs)

	parity_err_txseq pe_txseq;
	parity_err_rxseq pe_rxseq;

extern function new (string name="pe_seqs");
extern task body();
endclass

function parity_err_vseqs :: new(string name="pe_seqs");
	super.new(name);
endfunction

task parity_err_vseqs::body();
	super.body();
	pe_txseq = parity_err_txseq::type_id::create("pe_txseq");
	pe_rxseq = parity_err_rxseq::type_id::create("pe_rxseq");
	fork
	pe_txseq.start(seqrh[0]);
	pe_rxseq.start(seqrh[1]);
	join
endtask

////////////////////////////////////////////////////////////////////OVERRUN ERROR?///////////////////////////////////////////////////////////////////////
class overrun_err_vseqs extends base_vseqs;
	`uvm_object_utils(overrun_err_vseqs)

	overrun_err_txseq oe_txseq;
	overrun_err_rxseq oe_rxseq;

extern function new (string name="oe_seqs");
extern task body();
endclass

function overrun_err_vseqs :: new(string name="oe_seqs");
	super.new(name);
endfunction

task overrun_err_vseqs::body();
	super.body();
	oe_txseq = overrun_err_txseq::type_id::create("oe_txseq");
	oe_rxseq = overrun_err_rxseq::type_id::create("oe_rxseq");
	fork
	oe_txseq.start(seqrh[0]);
	oe_rxseq.start(seqrh[1]);
	join
endtask

/////////////////////////////////////////////////////////////////FRAME MISMATCH///////////////////////////////////////////////////////////////////////////////

class frame_mismatch_vseqs extends base_vseqs;
	`uvm_object_utils(frame_mismatch_vseqs)

	frame_mismatch_txseq fm_txseq;
	frame_mismatch_rxseq fm_rxseq;

extern function new (string name="fm_seqs");
extern task body();
endclass

function frame_mismatch_vseqs :: new(string name="fm_seqs");
	super.new(name);
endfunction

task frame_mismatch_vseqs::body();
	super.body();
	fm_txseq = frame_mismatch_txseq::type_id::create("fm_txseq");
	fm_rxseq = frame_mismatch_rxseq::type_id::create("fm_rxseq");
	fork
	fm_txseq.start(seqrh[0]);
	fm_rxseq.start(seqrh[1]);
	join
endtask

////////////////////////////////////////////////////////////BREAK INTERRUPT////////////////////////////////////////////////////////////////////////////////////

class break_int_vseqs extends base_vseqs;
	`uvm_object_utils(break_int_vseqs)

	break_int_txseq bi_txseq;
	break_int_rxseq bi_rxseq;

extern function new (string name="bi_seqs");
extern task body();
endclass

function break_int_vseqs :: new(string name="bi_seqs");
	super.new(name);
endfunction

task break_int_vseqs::body();
	super.body();
	bi_txseq = break_int_txseq::type_id::create("bi_txseq");
	bi_rxseq = break_int_rxseq::type_id::create("bi_rxseq");
	fork
	bi_txseq.start(seqrh[0]);
	bi_rxseq.start(seqrh[1]);
	join
endtask


/////////////////////////////////////////////////////////////TIMEOUT//////////////////////////////////////////////////////////////////////////////////////////

class timeout_vseqs extends base_vseqs;
	`uvm_object_utils(timeout_vseqs)

	timeout_txseq to_txseq;
	timeout_rxseq to_rxseq;

extern function new (string name="to_seqs");
extern task body();
endclass

function timeout_vseqs :: new(string name="to_seqs");
	super.new(name);
endfunction

task timeout_vseqs::body();
	super.body();
	to_txseq = timeout_txseq::type_id::create("to_txseq");
	to_rxseq = timeout_rxseq::type_id::create("to_rxseq");
	fork
	to_txseq.start(seqrh[0]);
	to_rxseq.start(seqrh[1]);
	join
endtask


//////////////////////////////////////////////////////////THR EMPTY///////////////////////////////////////////////////////////////////////////////////////////

class thr_empty_vseqs extends base_vseqs;
	`uvm_object_utils(thr_empty_vseqs)

	thr_empty_txseq te_txseq;
	thr_empty_rxseq te_rxseq;

extern function new (string name="te_seqs");
extern task body();
endclass

function thr_empty_vseqs :: new(string name="te_seqs");
	super.new(name);
endfunction

task thr_empty_vseqs::body();
	super.body();
	te_txseq = thr_empty_txseq::type_id::create("te_txseq");
	te_rxseq = thr_empty_rxseq::type_id::create("te_rxseq");
	fork
	te_txseq.start(seqrh[0]);
	te_rxseq.start(seqrh[1]);
	join
endtask

