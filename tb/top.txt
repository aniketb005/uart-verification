//`include "timescale.v"
`timescale 1ns/10ps

module top;

import uvm_pkg::*;
import uart_pkg::*;


bit clock1;
bit clock2;

wire a,b;

parameter CYCLE = 20;

always
#(CYCLE/2) clock1 = ~clock1;

always
#(CYCLE/4) clock2 = ~clock2;

uart_if U01(clock1);
uart_if U02(clock2);

uart_top DUT1 (.wb_clk_i(clock1),.wb_rst_i(U01.wb_rst_i),.wb_adr_i(U01.wb_addr_i),.wb_dat_i(U01.wb_dat_i),.wb_dat_o(U01.wb_dat_o),.wb_we_i(U01.wb_we_i),
		.wb_stb_i(U01.wb_stb_i),.wb_cyc_i(U01.wb_cyc_i),.wb_sel_i(U01.wb_sel_i),.wb_ack_o(U01.wb_ack_o),.int_o(U01.int_o),.stx_pad_o(a),.srx_pad_i(b));

uart_top DUT2 (.wb_clk_i(clock2),.wb_rst_i(U02.wb_rst_i),.wb_adr_i(U02.wb_addr_i),.wb_dat_i(U02.wb_dat_i),.wb_dat_o(U02.wb_dat_o),.wb_we_i(U02.wb_we_i),
		.wb_stb_i(U02.wb_stb_i),.wb_cyc_i(U02.wb_cyc_i),.wb_sel_i(U02.wb_sel_i),.wb_ack_o(U02.wb_ack_o),.int_o(U02.int_o),.srx_pad_i(a),.stx_pad_o(b));

initial 
begin

uvm_config_db #(virtual uart_if)::set(null,"*","vif_0",U01);
uvm_config_db #(virtual uart_if)::set(null,"*","vif_1",U02);

run_test();

end
endmodule





