package uart_pkg;

import uvm_pkg::*;

`include "uvm_macros.svh"

`include "uart_xtn.sv"
`include "uart_agt_cfg.sv"
`include "uart_tb_cfg.sv"
`include "uart_driver.sv"
`include "uart_sequencer.sv"
`include "uart_monitor.sv"
`include "uart_agent.sv"
`include "uart_sequence.sv"

`include "virtual_sequencer.sv"
`include "virtual_seqs.sv"
`include "uart_scoreboard.sv"

`include "uart_tb.sv"
`include "uart_test.sv"

endpackage 
