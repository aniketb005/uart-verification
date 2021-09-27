interface uart_if(input bit clock);

	//inputs
	bit 		wb_rst_i;
	bit [3:0] 	wb_addr_i;
	bit [3:0] 	wb_sel_i;
	bit [7:0] 	wb_dat_i;
	bit 		wb_we_i;
	bit 		wb_stb_i;
	bit 		wb_cyc_i;

	//outputs
	bit [7:0]	wb_dat_o;
	bit 		wb_ack_o;

	//other internal signals
	bit 		int_o;
	bit 		baud_o;

clocking U_DRV @(posedge clock);
	default input #1 output #1;

	output 		wb_rst_i;
	output  	wb_addr_i;
	output  	wb_sel_i;
	output		wb_dat_i;
	output 		wb_we_i;
	output 		wb_stb_i;
	output 		wb_cyc_i;
	input 		wb_dat_o;
	input 		wb_ack_o;
	input 		int_o;

endclocking

clocking U_MON @(posedge clock);
	default input #1 output #1;

	input 		wb_rst_i;
	input	  	wb_addr_i;
	input  		wb_sel_i;
	input		wb_dat_i;
	input 		wb_we_i;
	input 		wb_stb_i;
	input 		wb_cyc_i;
	input 		wb_dat_o;
	input 		wb_ack_o;
	input 		int_o;

endclocking

modport U_DRV_MP(clocking U_DRV);
modport U_MON_MP(clocking U_MON);

endinterface



	
