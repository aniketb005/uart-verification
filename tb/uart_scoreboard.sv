class uart_scoreboard extends uvm_scoreboard;

`uvm_component_utils(uart_scoreboard)
	
uvm_tlm_analysis_fifo #(uart_xtn) wrfifo;
uvm_tlm_analysis_fifo #(uart_xtn) rdfifo;

uart_xtn xtn;
uart_xtn rxtn;
bit [7:0]local_thr0;
bit [7:0]local_rcvr_buf0;
bit [7:0]local_thr1;
bit [7:0]local_rcvr_buf1;

uart_xtn uart_coverage;
uart_xtn uart_rcoverage;

covergroup uart_cov1;
	ADDR : coverpoint uart_coverage.wb_addr_i{
			bins low_ex = {0};
			bins low = {[1:10]};
	//	bins mid = {[11:20]};
			bins high = {[11:31]};
	//		bins high_ex = {31};
			}

	DATA : coverpoint uart_coverage.wb_dat_i  {
			bins low_ex = {0};
			bins low = {[1:63]};
			bins mid1 = {[64:127]};
			bins mid2 = {[128:191]};
			bins high = {[192:255]};
		//	bins high_ex = {255};
			}
		
	WE : coverpoint uart_coverage.wb_we_i {
			bins we_bin = {1};
			bins we_bin0 = {0};}

endgroup

covergroup uart_cov2;
	ADDR : coverpoint uart_rcoverage.wb_addr_i{
			bins low_ex = {0};
			bins low = {[1:10]};
	//		bins mid = {[11:20]};
			bins high = {[11:31]};
	//		bins high_ex = {31};
			}

	DATA : coverpoint uart_rcoverage.wb_dat_i  {
			bins low_ex = {0};
			bins low = {[1:63]};
			bins mid1 = {[64:127]};
			bins mid2 = {[128:191]};
			bins high = {[192:255]};
		//	bins high_ex = {255};
			}
		
	WE : coverpoint uart_rcoverage.wb_we_i {
			bins we_bin = {1};
			bins we_bin0 = {0};}

endgroup


extern function new(string name="scoreboard",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task check_data(uart_xtn,uart_xtn);
endclass

function uart_scoreboard::new(string name="scoreboard",uvm_component parent);
	super.new(name,parent);
	uart_cov1 = new();
	uart_cov2 = new();
endfunction

function void uart_scoreboard::build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	////	local_thr = new[4];
	//	local_rcvr_buf = new[4];
	wrfifo = new("wrfifo",this);
	rdfifo = new("rdfifo",this);
	
endfunction

task uart_scoreboard::run_phase(uvm_phase phase);
	forever
	  begin
	//   xtn = uart_xtn::type_id::create("xtn");
	 //   rxtn = uart_xtn::type_id::create("rxtn");

	    fork
		  wrfifo.get(xtn);
		  rdfifo.get(rxtn);
	     join
		  check_data(xtn,rxtn);
	uart_coverage = xtn;
	uart_rcoverage = rxtn;

	uart_cov1.sample();
	uart_cov2.sample();

	  end
endtask

task uart_scoreboard::check_data(uart_xtn xtn,uart_xtn rxtn);
	if(xtn.wb_addr_i == 0 && xtn.wb_we_i == 1 && xtn.lcr[7]==0)
begin	
	local_thr0 = xtn.wb_dat_i;
$display("1wb_dat_i==%0d",xtn.wb_dat_i);
end
	if(xtn.wb_addr_i == 0 && xtn.wb_we_i == 0 && xtn.lcr[7]==0)
begin
		local_rcvr_buf0 = xtn.wb_dat_o;
$display("1wb_dat_o==%0d",xtn.wb_dat_o);
end
	if(rxtn.wb_addr_i == 0 && rxtn.wb_we_i == 1 && rxtn.lcr[7]==0)
begin
		local_thr1 = rxtn.wb_dat_i;
 $display("2wb_dat_i==%0d",rxtn.wb_dat_i);
end

	if(rxtn.wb_addr_i == 0 && rxtn.wb_we_i == 0 && rxtn.lcr[7]==0)
begin
		local_rcvr_buf1 = rxtn.wb_dat_o;
$display("2wb_dat_o==%0d",rxtn.wb_dat_o);
end
	if(local_thr0 == local_rcvr_buf1)
		begin
		`uvm_info("SCOREBOARD"," COMPARED",UVM_LOW)
		$display("thr %d \n rcvr_buf %d",local_thr0,local_rcvr_buf1);
		end
	else
		begin
		`uvm_info("SCOREBOARD"," NOT CORRECT",UVM_LOW)
		$display("wr head %d \n rd head %d",local_thr0,local_rcvr_buf1);
		end

	if(local_thr1 == local_rcvr_buf0)
		begin
		`uvm_info("SCOREBOARD"," COMPARED",UVM_LOW)
		$display("wr head %d \n rd head %d",local_thr1,local_rcvr_buf0);
		end
	else
		begin
		`uvm_info("SCOREBOARD"," NOT CORRECT",UVM_LOW)
		$display("wr head %d \n rd head %d",local_thr1,local_rcvr_buf0);
		end



endtask

