class base_uart_sequence extends uvm_sequence #(uart_xtn);

`uvm_object_utils(base_uart_sequence)

extern function new(string name = "base uart seq");
endclass

function base_uart_sequence::new(string name = "base uart seq");
	super.new(name);
endfunction

//////////////////////////////////////////////////////////////FULLL DUPLEXXXX/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class full_duplex_txseq extends base_uart_sequence;

  `uvm_object_utils(full_duplex_txseq)

extern function new (string name = "FD_seq");
extern task body();
endclass

function full_duplex_txseq::new(string name = "FD_seq");
 	super.new(name);
endfunction

task full_duplex_txseq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");
		
	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)

	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b00011011 ;}) // Calculate DL Value
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		

	  //lcr msb 0
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0000_0011;})
	  	`uvm_info("FD_SEQ2",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	 finish_item(xtn);

         //IER
	 start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0001;})
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	//THR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1010 ;}) 
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	//IIR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
	  	`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	  get_response(xtn);

	  if(xtn.iir[3:1]==3'b010)
		begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 0 ; wb_dat_i ==0;wb_we_i == 0;})	
			`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end

	  if(xtn.iir[3:1] ==3'b011)
	        begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end
	end
endtask


class full_duplex_rxseq extends base_uart_sequence;

	`uvm_object_utils(full_duplex_rxseq)

extern function new (string name ="FD_rseq");
extern task body();
endclass

function full_duplex_rxseq::new(string name ="FD_rseq");
	super.new(name);
endfunction

task full_duplex_rxseq::body();
    begin
	uart_xtn rxtn;
	rxtn = uart_xtn::type_id::create("rxtn");


	  //LCR msb 1;
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("FD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	  //DL MSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("FD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
 
	  //DL LSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0011_0110 ;}) // Calculate DL Value
		`uvm_info("FD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
		

	  //lcr msb 0
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0000_0011;})
	  	`uvm_info("FD_SEQ2",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	 finish_item(rxtn);

         //IER
	 start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0001;}) 
		`uvm_info("FD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);


	/////FCR
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
		`uvm_info("FD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	//THR of rcvr
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1110 ;}) 
		`uvm_info("FD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	//IIR
	  start_item(rxtn);
	 	assert(rxtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("FD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	  get_response(rxtn);
	 
	  if(rxtn.iir[3:1]==3'b010)
		begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0;wb_we_i == 0;})		
			`uvm_info("FD_RXSEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end

	  if(rxtn.iir[3:1] ==3'b011)
	        begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("FD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end
	end
endtask


//////////////////////////////////////////////////////////////HALF DUPLEXXXX/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class half_duplex_txseq extends base_uart_sequence;

  `uvm_object_utils(half_duplex_txseq)

extern function new (string name = "HD_txseq");
extern task body();
endclass

function half_duplex_txseq::new(string name = "HD_txseq");
 	super.new(name);
endfunction

task half_duplex_txseq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");
		
	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("HD_SEQ",$sformatf("printing from Half Duplex sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("HD_SEQ",$sformatf("printing from  Half Duplex sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b00011011 ;}) // Calculate DL Value
	  	`uvm_info("DD_SEQ",$sformatf("printing from  Half Duplex  sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		
	  //lcr msb 0
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;})
	   	`uvm_info("HD_SEQ2",$sformatf("printing from  Half Duplex sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

         //IER
	 start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0001;})
	 	`uvm_info("HD_SEQ",$sformatf("printing from  Half Duplex sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);


	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
	  	`uvm_info("HD_SEQ",$sformatf("printing from  Half Duplex  sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	//THR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1010 ;}) 
		`uvm_info("HD_SEQ",$sformatf("printing from Half Duplex THHHHHHHHRRR sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	end
endtask

class half_duplex_rxseq extends base_uart_sequence;

  `uvm_object_utils(half_duplex_rxseq)

extern function new (string name = "HD_rxseq");
extern task body();
endclass

function half_duplex_rxseq::new(string name = "HD_rxseq");
 	super.new(name);
endfunction

task half_duplex_rxseq::body();
    begin
	uart_xtn rxtn;
	rxtn = uart_xtn::type_id::create("rxtn");


	  //LCR msb 1;
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("HD_SEQ",$sformatf("U2 printing from sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	  //DL MSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("HD_SEQ",$sformatf("U2 printing from Half_duplex sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
 
	  //DL LSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0011_0110 ;}) // Calculate DL Value
		`uvm_info("HD_SEQ",$sformatf("U2 printing from Half_duplex  sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
		
	  //lcr msb 0
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0000_0011;})
	  	`uvm_info("HD_SEQ",$sformatf("U2 printing Half_duplex  from sequence \n %s", rxtn.sprint()),UVM_LOW)
	 finish_item(rxtn);

         //IER
	 start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0001;}) 
		`uvm_info("HD_SEQ",$sformatf("U2 printing from Half_duplex sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	/////FCR
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
		`uvm_info("HD_SEQ",$sformatf("U2 printing from Half_duplex  sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	//IIR
	  start_item(rxtn);
	 	assert(rxtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("HD_SEQ",$sformatf("U2 printing from Half_duplex  sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	  get_response(rxtn);
	 
	  if(rxtn.iir[3:1]==3'b010)
		begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0;	 wb_we_i == 0;})	
			`uvm_info("HD_RXSEQ",$sformatf("U2 printing from Half RCVRRRR BUFFF Duplex sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end

	  if(rxtn.iir[3:1] ==3'b011)
	        begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("HD_SEQ",$sformatf("U2 printing from half duplex sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end
	end
endtask

///////////////////////////////////////////////////////////////LOOOP BACKKKKKKKK//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class loopback_seq extends base_uart_sequence;

  `uvm_object_utils(loopback_seq)

extern function new (string name = "lb_seq");
extern task body();
endclass

function loopback_seq::new(string name = "lb_seq");
 	super.new(name);
endfunction

task loopback_seq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");
		
	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b00011011 ;}) // Calculate DL Value
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		
	  //lcr msb 0
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0000_0011;})
	  	`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	 finish_item(xtn);

         //IER
	 start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0001;})
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	////MCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 4;wb_we_i == 1;wb_dat_i ==  8'd16;}) 
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);	  
	
	//THR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1010 ;}) 
		`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	 	$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ %b",xtn.iir);

	//IIR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 0;}) //check 
	  	`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	  get_response(xtn);

	  if(xtn.iir[3:1]==3'b010)
		begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 0 ; wb_dat_i ==0;wb_we_i == 0;})	
			`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end

	  if(xtn.iir[3:1] ==3'b011)
	        begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("FD_SEQ",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end
	end
endtask	  

//////////////////////////////////////////////////////////////PARITYY ERRORRRRRRRR////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class parity_err_txseq extends base_uart_sequence;
  `uvm_object_utils(parity_err_txseq)
extern function new (string name = "parity_err_txseq");
extern task body();
endclass

function parity_err_txseq::new(string name = "parity_err_txseq");
 	super.new(name);
endfunction

task parity_err_txseq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");

	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("PE_SEQ",$sformatf("printing from  parity error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0001_1011 ;}) // Calculate DL Value
	  	`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		
	  //lcr msb 0


	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_1011;})
	   	`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

         //IER
	 start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0100;})
	 	`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0110;}) 
	  	`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

/*	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
	  	`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn); */
	
	//THR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1110 ;}) 
		`uvm_info("PE_SEQ",$sformatf("printing from parity error THHHHHHHHRRR sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	//IIR
	  start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	 	$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ %b",xtn.iir);

	  get_response(xtn);
	 	$display("rsdtgmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
	  if(xtn.iir[3:1]==3'b010)
		begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end

	  if(xtn.iir[3:1] ==3'b011)
	        begin
			$display("akbk gdtbjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("PE_SEQ",$sformatf("printing from parity error sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end

	end
endtask

class parity_err_rxseq extends base_uart_sequence;

  `uvm_object_utils(parity_err_rxseq)

extern function new (string name = "pe_rxseq");
extern task body();
endclass

function parity_err_rxseq::new(string name = "pe_rxseq");
 	super.new(name);
endfunction

task parity_err_rxseq::body();
    begin
	uart_xtn rxtn;
	rxtn = uart_xtn::type_id::create("rxtn");

	  //LCR msb 1;
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("PE_SEQ",$sformatf("U2 printing from parity error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	  //DL MSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("PE_SEQ",$sformatf("U2 printing from parity error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
 
	  //DL LSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0011_0110 ;}) // Calculate DL Value
		`uvm_info("PE_SEQ",$sformatf("U2 printing from parity error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
		
	  //lcr msb 0
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0001_1011;})
	  	`uvm_info("PE_SEQ",$sformatf("U2 printing parity error from sequence \n %s", rxtn.sprint()),UVM_LOW)
	 finish_item(rxtn);

         //IER
	 start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0100;}) 
		`uvm_info("PE_SEQ",$sformatf("U2 printing from parity error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);


	/////FCR
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0110;}) 
		`uvm_info("PE_SEQ",$sformatf("U2 printing from parity errror sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	//THR of rcvr
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1010 ;}) 
		`uvm_info("PE_SEQ",$sformatf("U2 printing from parity error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	//IIR
	  start_item(rxtn);
	 	assert(rxtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("PE_SEQ",$sformatf("U2 printing from parity error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	 	$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ %b",rxtn.iir);

	  get_response(rxtn);
	 

	  if(rxtn.iir[3:1]==3'b010)
		begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("PE_SEQ",$sformatf("U2 printing from parity error sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end

	  if(rxtn.iir[3:1] ==3'b011)
	        begin
		  start_item(rxtn);
			$display("akbk gdtbjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");

			assert(rxtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("PE_SEQ",$sformatf("U2 printing from parity error sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end
	end
endtask

//////////////////////////////////////////////////////////////OVERRUN ERROR///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class overrun_err_txseq extends base_uart_sequence;
  `uvm_object_utils(overrun_err_txseq)
extern function new (string name = "overrun_err_txseq");
extern task body();
endclass

function overrun_err_txseq::new(string name = "overrun_err_txseq");
 	super.new(name);
endfunction

task overrun_err_txseq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");

	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("OE_SEQ",$sformatf("printing from overrun error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("OE_SEQ",$sformatf("printing from  overrun error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0001_1011 ;}) // Calculate DL Value
	  	`uvm_info("OE_SEQ",$sformatf("printing from overrun error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		
	  //lcr msb 0
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;})
	   	`uvm_info("OE_SEQ",$sformatf("printing from overrun error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

         //IER
	 start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0001;})
	 	`uvm_info("OE_SEQ",$sformatf("printing from overrun error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b1100_0110;}) 
	  	`uvm_info("OE_SEQ",$sformatf("printing from overrun error sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	//THR
	  repeat(14) //////CHECK THIS
	   begin 
	    start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1110 ;}) 
		`uvm_info("OE_SEQ",$sformatf("printing from overrun error THHHHHHHHRRR sequence \n %s", xtn.sprint()),UVM_LOW)
	    finish_item(xtn);
	   end
	 	 
	  repeat(3) //////CHECK THIS
	   begin 
	    start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1110 ;}) 
		`uvm_info("OE_SEQ",$sformatf("printing from overrun error THHHHHHHHRRR sequence \n %s", xtn.sprint()),UVM_LOW)
	    finish_item(xtn);
	   end
	end
endtask

class overrun_err_rxseq extends base_uart_sequence;

  `uvm_object_utils(overrun_err_rxseq)

extern function new (string name = "oe_rxseq");
extern task body();
endclass

function overrun_err_rxseq::new(string name = "oe_rxseq");
 	super.new(name);
endfunction

task overrun_err_rxseq::body();
    begin
	uart_xtn rxtn;
	rxtn = uart_xtn::type_id::create("rxtn");

	  //LCR msb 1;
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("OE_SEQ",$sformatf("U2 printing from overrun error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	  //DL MSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("OE_SEQ",$sformatf("U2 printing from overrun error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
 
	  //DL LSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0011_0110 ;}) // Calculate DL Value
		`uvm_info("OE_SEQ",$sformatf("U2 printing from overrun error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
		
	  //lcr msb 0
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0000_0011;})
	  	`uvm_info("OE_SEQ",$sformatf("U2 printing overrun error from sequence \n %s", rxtn.sprint()),UVM_LOW)
	 finish_item(rxtn);

         //IER
	 start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0100;}) 
		`uvm_info("OE_SEQ",$sformatf("U2 printing from overrun error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);


	/////FCR
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
		`uvm_info("OE_SEQ",$sformatf("U2 printing from overrun errror sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	//IIR
	  start_item(rxtn);
	 	assert(rxtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("OE_SEQ",$sformatf("U2 printing from overrun error sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	  get_response(rxtn);
		 	$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ %b",rxtn.iir);

	  if(rxtn.iir[3:1]==3'b010)
		begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("OE_SEQ",$sformatf("U2 printing from overrun error sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end

	  if(rxtn.iir[3:1] ==3'b011)
	        begin
		  start_item(rxtn);
		 	$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ %b",rxtn.iir);

			assert(rxtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("OE_SEQ",$sformatf("U2 printing from overrun error sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end
	end
endtask

//////////////////////////////////////////////////////////////FRAME MISMATCH////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class frame_mismatch_txseq extends base_uart_sequence;
  `uvm_object_utils(frame_mismatch_txseq)
extern function new (string name = "frame_mismatch_txseq");
extern task body();
endclass

function frame_mismatch_txseq::new(string name = "frame_mismatch_txseq");
 	super.new(name);
endfunction

task frame_mismatch_txseq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");

	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("FM_SEQ",$sformatf("printing from  frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0001_1011 ;}) // Calculate DL Value
	  	`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		
	  //lcr msb 0
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0100;})
	   	`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

         //IER
	 start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0101;})
	 	`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0110;}) 
	  	`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	//THR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 5'b1_0101 ;}) 
		`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch THHHHHHHHRRR sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	//IIR
	  start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	  get_response(xtn);
	 

	 	$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ %b",xtn.iir);

	  if(xtn.iir[3:1]==3'b010)
		begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end

	  if(xtn.iir[3:1] ==3'b011)
	        begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("FM_SEQ",$sformatf("printing from frame mismatch sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end
	end
endtask

class frame_mismatch_rxseq extends base_uart_sequence;

  `uvm_object_utils(frame_mismatch_rxseq)

extern function new (string name = "fm_rxseq");
extern task body();
endclass

function frame_mismatch_rxseq::new(string name = "fm_rxseq");
 	super.new(name);
endfunction

task frame_mismatch_rxseq::body();
    begin
	uart_xtn rxtn;
	rxtn = uart_xtn::type_id::create("rxtn");

	  //LCR msb 1;
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	  //DL MSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
 
	  //DL LSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0011_0110 ;}) // Calculate DL Value
		`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
		
	  //lcr msb 0
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0000_0111;})
	  	`uvm_info("FM_SEQ",$sformatf("U2 printing frame mismatch from sequence \n %s", rxtn.sprint()),UVM_LOW)
	 finish_item(rxtn);

         //IER
	 start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0101;}) 
		`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);


	/////FCR
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0110;}) 
		`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	//THR of rcvr
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1110 ;}) 
		`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	//IIR
	  start_item(rxtn);
	 	assert(rxtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	  get_response(rxtn);
	 	$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ %b",rxtn.iir);
	  if(rxtn.iir[3:1]==3'b010)
		begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end

	  if(rxtn.iir[3:1] ==3'b011)
	        begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("FM_SEQ",$sformatf("U2 printing from frame mismatch sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end
	end
endtask


///////////////////////////////////////////////////BREAK INTERUPTTTTTTTTTTTTTTTTTTTT/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class break_int_txseq extends base_uart_sequence;
  `uvm_object_utils(break_int_txseq)
extern function new (string name = "break_int_txseq");
extern task body();
endclass

function break_int_txseq::new(string name = "break_int_txseq");
 	super.new(name);
endfunction

task break_int_txseq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");

	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("BI_SEQ",$sformatf("printing from  Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0001_1011 ;}) // Calculate DL Value
	  	`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		
	  //lcr msb 0
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;})
	   	`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

         //IER
	 start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0100;})
	 	`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
	  	`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	//THR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1010 ;}) 
		`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt THHHHHHHHRRR sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	//IIR
	  start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	  get_response(xtn);
	 
	  if(xtn.iir[3:1]==3'b010)
		begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end

	  if(xtn.iir[3:1] ==3'b011)
	        begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("BI_SEQ",$sformatf("printing from Break interrupt sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end
	end
endtask

class break_int_rxseq extends base_uart_sequence;

  `uvm_object_utils(break_int_rxseq)

extern function new (string name = "break_int_rxseq");
extern task body();
endclass

function break_int_rxseq::new(string name = "break_int_rxseq");
 	super.new(name);
endfunction

task break_int_rxseq::body();
    begin
	uart_xtn rxtn;
	rxtn = uart_xtn::type_id::create("rxtn");

	  //LCR msb 1;
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	  //DL MSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
 
	  //DL LSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0011_0110 ;}) // Calculate DL Value
		`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
		
	  //lcr msb 0
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0100_0011;})
	  	`uvm_info("BI_SEQ",$sformatf("U2 printing Break interrupt from sequence \n %s", rxtn.sprint()),UVM_LOW)
	 finish_item(rxtn);

         //IER
	 start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0001;}) 
		`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);


	/////FCR
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0000;}) 
		`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	//THR of rcvr
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1110 ;}) 
		`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	//IIR
	  start_item(rxtn);
	 	assert(rxtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	  get_response(rxtn);
	 
	  if(rxtn.iir[3:1]==3'b010)
		begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end

	  if(rxtn.iir[3:1] ==3'b011)
	        begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("BI_SEQ",$sformatf("U2 printing from Break interrupt sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end
	end
endtask



///////////////////////////////////////////////////TIMEOUTTTTTTTTTTTTTTTT/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class timeout_txseq extends base_uart_sequence;
  `uvm_object_utils(timeout_txseq)
extern function new (string name = "timeout_txseq");
extern task body();
endclass

function timeout_txseq::new(string name = "timeout_txseq");
 	super.new(name);
endfunction

task timeout_txseq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");

	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("TO_SEQ",$sformatf("printing from timeout sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("TO_SEQ",$sformatf("printing from  timeout sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0001_1011 ;}) // Calculate DL Value
	  	`uvm_info("TO_SEQ",$sformatf("printing from timeout sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		
	  //lcr msb 0
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;})
	   	`uvm_info("TO_SEQ",$sformatf("printing from timeout sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

         //IER
	 start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0101;})
	 	`uvm_info("TO_SEQ",$sformatf("printing from timeout sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b1100_0000;}) 
	  	`uvm_info("TO_SEQ",$sformatf("printing from timeout sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	//THR
	repeat(14)
	  begin
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1110 ;}) 
		`uvm_info("TO_SEQ",$sformatf("printing from timeout THHHHHHHHRRR sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	  end

/*	//IIR
	  start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("TO_SEQ",$sformatf("printing from timeout sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	  get_response(xtn);
	 
	  if(xtn.iir[3:1]==3'b010)
		begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("TO_SEQ",$sformatf("printing from timeout sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end

	  if(xtn.iir[3:1] ==3'b011)
	        begin
		  start_item(xtn);
			assert(xtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("TO_SEQ",$sformatf("printing from timeout sequence \n %s", xtn.sprint()),UVM_LOW)
		  finish_item(xtn);
		end */
	end
endtask

class timeout_rxseq extends base_uart_sequence;

  `uvm_object_utils(timeout_rxseq)

extern function new (string name = "timeout_rxseq");
extern task body();
endclass

function timeout_rxseq::new(string name = "timeout_rxseq");
 	super.new(name);
endfunction

task timeout_rxseq::body();
    begin
	uart_xtn rxtn;
	rxtn = uart_xtn::type_id::create("rxtn");

	  //LCR msb 1;
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	  //DL MSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
 
	  //DL LSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0011_0110 ;}) // Calculate DL Value
		`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
		
	  //lcr msb 0
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0100_0011;})
	  	`uvm_info("TO_SEQ",$sformatf("U2 printing timeout from sequence \n %s", rxtn.sprint()),UVM_LOW)
	 finish_item(rxtn);

         //IER
	 start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0101;}) 
		`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);


	/////FCR
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b1000_0000;}) 
		`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	/*//THR of rcvr
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0000_1110 ;}) 
		`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);*/

	//IIR
	  start_item(rxtn);
	 	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 0;}) //check 
		`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	  get_response(rxtn);
	 
	  if(rxtn.iir[3:1]==3'b010)
		begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end

	  if(rxtn.iir[3:1] ==3'b011)
	        begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("TO_SEQ",$sformatf("U2 printing from timeout sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end
	end
endtask





///////////////////////////////////////////////////////////////////////////THR EMPTY//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class thr_empty_txseq extends base_uart_sequence;
  `uvm_object_utils(thr_empty_txseq)
extern function new (string name = "thr_empty_txseq");
extern task body();
endclass

function thr_empty_txseq::new(string name = "thr_empty_txseq");
 	super.new(name);
endfunction

task thr_empty_txseq::body();
	begin
	  uart_xtn xtn;
	  xtn = uart_xtn::type_id::create("xtn");

	  //LCR msb 1;
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 5'd3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("TE_SEQ",$sformatf("printing from thr_empty sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
	
	  //DL MSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("TE_SEQ",$sformatf("printing from  thr_empty sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
 
	  //DL LSB
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0001_1011 ;}) // Calculate DL Value
	  	`uvm_info("TE_SEQ",$sformatf("printing from thr_empty sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);
		
	  //lcr msb 0
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;})
	   	`uvm_info("TE_SEQ",$sformatf("printing from thr_empty sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

         //IER
	 start_item(xtn);
	 	assert(xtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0010;})
	 	`uvm_info("TE_SEQ",$sformatf("printing from thr_empty sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	/////FCR
	  start_item(xtn);
	  	assert(xtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0110;}) 
	  	`uvm_info("TE_SEQ",$sformatf("printing from thr_empty sequence \n %s", xtn.sprint()),UVM_LOW)
	  finish_item(xtn);

	end
endtask



class thr_empty_rxseq extends base_uart_sequence;

  `uvm_object_utils(thr_empty_rxseq)

extern function new (string name = "thr_empty_rxseq");
extern task body();
endclass

function thr_empty_rxseq::new(string name = "thr_empty_rxseq");
 	super.new(name);
endfunction

task thr_empty_rxseq::body();
    begin
	uart_xtn rxtn;
	rxtn = uart_xtn::type_id::create("rxtn");

	  //LCR msb 1;
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;})
	  	`uvm_info("TO_SEQ",$sformatf("U2 printing from thr_empty sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	  //DL MSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0000 ;}) //Calculate DL value
		`uvm_info("TO_SEQ",$sformatf("U2 printing from thr_empty sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
 
	  //DL LSB
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 0;wb_we_i == 1;wb_dat_i == 8'b0011_0110 ;}) // Calculate DL Value
		`uvm_info("TO_SEQ",$sformatf("U2 printing from thr_empty sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
		
	  //lcr msb 0
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 3;wb_we_i == 1;wb_dat_i == 8'b0000_0011;})
	  	`uvm_info("TO_SEQ",$sformatf("U2 printing thr_empty from sequence \n %s", rxtn.sprint()),UVM_LOW)
	 finish_item(rxtn);

         //IER
	 start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 1;wb_we_i == 1;wb_dat_i == 8'b0000_0010;}) 
		`uvm_info("TO_SEQ",$sformatf("U2 printing from thr_empty sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	/////FCR
	  start_item(rxtn);
	  	assert(rxtn.randomize() with {wb_addr_i == 2;wb_we_i == 1;wb_dat_i ==  8'b0000_0110;}) 
		`uvm_info("TO_SEQ",$sformatf("U2 printing from thr_empty sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);
	
	//IIR
	  start_item(rxtn);
	 	assert(rxtn.randomize() with {wb_addr_i == 2;wb_dat_i ==0;wb_we_i == 0;}) //check 
		`uvm_info("TO_SEQ",$sformatf("U2 printing from thr_empty sequence \n %s", rxtn.sprint()),UVM_LOW)
	  finish_item(rxtn);

	  get_response(rxtn);
	 
	  if(rxtn.iir[3:1]==3'b010)
		begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 0 ;wb_dat_i ==0; wb_we_i == 0;})	
			`uvm_info("TO_SEQ",$sformatf("U2 printing from thr_empty sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end

	  if(rxtn.iir[3:1] ==3'b011)
	        begin
		  start_item(rxtn);
			assert(rxtn.randomize() with {wb_addr_i == 5;wb_dat_i ==0;wb_we_i == 0;})
			`uvm_info("TO_SEQ",$sformatf("U2 printing from thr_empty sequence \n %s", rxtn.sprint()),UVM_LOW)
		  finish_item(rxtn);
		end
	end
endtask










