class uart_agt_cfg extends uvm_object;

`uvm_object_utils(uart_agt_cfg)

virtual uart_if vif;

uvm_active_passive_enum is_active = UVM_ACTIVE;
static int drv_data_sent_cnt=0;
static int mon_data_rcvd_cnt=0;


extern function new(string name="Agent Config");
endclass

function uart_agt_cfg::new(string name="Agent Config");
	super.new(name);
endfunction


