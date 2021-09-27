class uart_monitor extends uvm_monitor;

`uvm_component_utils(uart_monitor)

virtual uart_if.UMON vif;

uart_agt_cfg m_cfg;

uvm_analysis_port #(uart_xtn) apmon;

extern function new(string name="UART Monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern function void report_phase(uvm_phase phase);
endclass

function uart_monitor::new(string name="UART Monitor",uvm_component parent);
	super.new(name,parent);
	apmon = new("AnalysisPort",this);
endfunction

function void uart_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(uart_agt_cfg)::get(this,"","uart_agt_cfg",m_cfg))
		`uvm_fatal("FATAL","Cannot get config for UART Monitor");
endfunction

function void uart_monitor::connect_phase(uvm_phase phase);
	vif = m_cfg.vif;

endfunction


task uart_monitor::run_phase(uvm_phase phase);
	forever
	begin
	collect_data();
	end
endtask

task uart_monitor::collect_data();
	uart_xtn xtn;
	xtn = uart_xtn::type_id::create("xtn");
	
	@(vif.u_mon);
	wait(vif.u_mon.wb_ack_o)

	xtn.wb_we_i = vif.u_mon.wb_we_i;
	xtn.wb_addr_i = vif.u_mon.wb_addr_i;
	xtn.wb_dat_i = vif.u_mon.wb_dat_i;

//	wait(vif.u_mon.wb_ack_o)
	xtn.wb_dat_o = vif.u_mon.wb_dat_o;

	  if(vif.u_mon.wb_addr_i == 3 && vif.u_mon.wb_we_i == 1)
		xtn.lcr = vif.u_mon.wb_dat_i ;
		
	  //if(vif.u_mon.wb_addr_i == 1 && vif.u_mon.wb_we_i == 1)
		
	
	  if(vif.u_mon.wb_addr_i == 0 && vif.u_mon.wb_we_i == 1 && xtn.lcr[7] == 0)
		begin
		$display("$$$$$$$$$$$$$$$$$$$$$$llloololololololololololo$$$$$$$$$$$$$$$$");
		xtn.thr.push_back(vif.u_mon.wb_dat_i);
		end

	  if(vif.u_mon.wb_addr_i == 0 && vif.u_mon.wb_we_i == 0 && xtn.lcr[7]==0)
		xtn.rcvr_buf.push_back(vif.u_mon.wb_dat_o);
	
	 $display("-------------------------------MONITOR-------------------------------------------------");
	`uvm_info("MON",$sformatf("printing from MONITOR \n %s", xtn.sprint()),UVM_LOW)
	 $display("---------------------------------------------------------------------------------------");
	
	apmon.write(xtn);
	m_cfg.mon_data_rcvd_cnt++;
endtask

function void uart_monitor::report_phase(uvm_phase phase);
	`uvm_info(get_type_name(),$sformatf("Report: UART monitor received %0d no. of transaction",m_cfg.mon_data_rcvd_cnt),UVM_LOW)
endfunction

