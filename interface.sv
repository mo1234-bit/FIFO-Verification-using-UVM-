interface FIFO_IF (clk);
input bit clk;
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
logic [FIFO_WIDTH-1:0] data_in;
logic rst_n, wr_en, rd_en,full, empty, almostfull, almostempty, underflow, full_ref, 
empty_ref, almostfull_ref, almostempty_ref, underflow_ref,  wr_ack_ref, overflow_ref;
logic [FIFO_WIDTH-1:0] data_out_ref,data_out;
logic wr_ack, overflow;


modport DUT (input clk, data_in, rst_n, wr_en, rd_en,
	output full, empty, almostfull, almostempty, underflow, data_out, wr_ack, overflow);

modport DUT_inter (input clk, data_in, rst_n, wr_en, rd_en,
	output full_ref, empty_ref, almostfull_ref, almostempty_ref, underflow_ref, data_out_ref, wr_ack_ref, overflow_ref);


endinterface : FIFO_IF