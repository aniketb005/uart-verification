class uart_xtn extends uvm_sequence_item;

	`uvm_object_utils(uart_xtn) 	

	rand bit [4:0]wb_addr_i;
        rand bit [7:0]wb_dat_i;
	rand bit wb_we_i;

	bit [7:0]iir;
	bit [7:0]ier;
	bit [7:0]fcr;
	bit [7:0]lcr;
	bit [7:0]dl_lsb;
	bit [7:0]dl_msb;
	bit [7:0]thr[$];
	bit [7:0]rcvr_buf[$];
	bit [7:0]wb_dat_o;
//constraint 

extern function new(string name ="UART_Transaction");
extern function void do_print(uvm_printer printer);
endclass

function uart_xtn::new(string name="UART_Transaction");
	super.new(name);
endfunction

function void uart_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
    //                   srting name   		bitstream value     size       radix for printing
    printer.print_field( "wb_addr_i", 		this.wb_addr_i,      5,		 UVM_DEC		);
    printer.print_field( "wb_dat_i", 		this.wb_dat_i, 	     32,	 UVM_DEC		);
    printer.print_field( "wb_we_i", 		this.wb_we_i, 	     1,		 UVM_DEC		);
    foreach(thr[i])
    printer.print_field("thr",    this.thr[i],     8,		 UVM_DEC		);
    foreach(rcvr_buf[i])
    printer.print_field("rcvr_buf", this.rcvr_buf[i], 8,	 UVM_DEC		);
 /*  printer.print_field( "",                     this.thr,	    8,		 UVM_DEC		);
    printer.print_field( "thr",                 this.thr,	    8,		 UVM_DEC		);
    printer.print_field( "thr",                 this.thr,	    8,		 UVM_DEC		);
*/

endfunction

