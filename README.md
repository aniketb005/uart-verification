## UART Verification in System Verilog Using UVM Methodology

This project was completed in 2019. This projects used QuestaSim for Verification and Rivera Aldec Pro for testing Assertions.

Designed the verification plan and created a class based environmment. Architecutre of the testbench included Universal Verification Components(UVC's), Scoreboard, and Virtual Sequencers.

Testbench Architecture:
![Alt text](./test/tb_arch.png?raw=true)

Following Test Case scenarios were verified the operations of UART in three modes i.e Half duplex, Full Duplex, and Loop Back Mode.
This also covered
This also verified different error situations like Parity Error, Frame error, Time Out Error,Overrun Error,Break Interrupt Error,Transmitter Hold Register Empty Error

Following Functional coverage was acheived:
![Alt text](./test/coverage.png?raw=true "Coverage")