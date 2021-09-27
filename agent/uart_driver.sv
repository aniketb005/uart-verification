class uart_driver extends uvm_driver #(uart_xtn);

`uvm_component_utils(uart_driver)
	
virtual uart_if.UDRV vif;

uart_agt_cfg agt_cfg;

extern function new(string name="UART Driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive(uart_xtn xtn);
extern function void report_phase(uvm_phase phase);
endclass

function uart_driver::new(string name = "UART Driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db #(uart_agt_cfg)::get(this,"","uart_agt_cfg",agt_cfg))
		`uvm_fatal("FATAL","Cannnot get agent config in driver");

endfunction 

function void uart_driver::connect_phase(uvm_phase phase);
	vif = agt_cfg.vif;
endfunction


task uart_driver::run_phase(uvm_phase phase);
	
	@(vif.u_drv);
	  vif.u_drv.wb_rst_i <= 1'b1; //check
	  vif.u_drv.wb_stb_i <= 1'b0;
	  vif.u_drv.wb_cyc_i <= 1'b0;

	@(vif.u_drv);
	  vif.u_drv.wb_rst_i <= 1'b0;

	forever 
	  begin
	   req = uart_xtn::type_id::create("req");
	   seq_item_port.get_next_item(req);
	   drive(req);
	   seq_item_port.item_done();
	 end
endtask

task uart_driver::drive(uart_xtn xtn);
	begin
	@(vif.u_drv);

	vif.u_drv.wb_we_i <= xtn.wb_we_i;
	vif.u_drv.wb_addr_i <= xtn.wb_addr_i;
	vif.u_drv.wb_dat_i <= xtn.wb_dat_i;
	vif.u_drv.wb_sel_i <= 4'b0001;
	vif.u_drv.wb_stb_i <= 1'b1;
	vif.u_drv.wb_cyc_i <= 1'b1;
	
	wait(vif.u_drv.wb_ack_o);
		vif.u_drv.wb_stb_i <= 1'b0;
		vif.u_drv.wb_cyc_i <= 1'b0;
	  

		
	if(xtn.wb_addr_i == 2 && xtn.wb_we_i == 0)
	  begin
	    wait(vif.u_drv.int_o);
	     
		@(vif.u_drv);
		@(vif.u_drv);

	      xtn.iir = vif.u_drv.wb_dat_o;
	      seq_item_port.put_response(xtn);
	     
	  end
	
agt_cfg.drv_data_sent_cnt++;


	//  `uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	end
endtask

function void uart_driver::report_phase(uvm_phase phase);
	`uvm_info(get_type_name(),$sformatf("Report: UART Driver sent %0d no. of transactions",agt_cfg.drv_data_sent_cnt),UVM_LOW)
endfunction
