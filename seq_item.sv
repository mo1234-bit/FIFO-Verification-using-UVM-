package seq_item;
	
import uvm_pkg::*; 
`include "uvm_macros.svh"
	class fifo_seq_item extends uvm_sequence_item;

		`uvm_object_utils(fifo_seq_item);
parameter FIFO_WIDTH = 16;
		rand bit [FIFO_WIDTH-1:0] data_in;
        rand bit rst_n, wr_en, rd_en;
		 logic full, empty, almostfull, almostempty, underflow;
logic [FIFO_WIDTH-1:0]data_out_ref, data_out;
logic wr_ack, overflow;
logic full_ref, empty_ref, almostfull_ref, almostempty_ref, underflow_ref,  wr_ack_ref, overflow_ref;
int RD_EN_ON_DIST = 30;
  int WR_EN_ON_DIST = 70;
		 function  new(string name="fifo_seq_item");
		 	super.new(name);
		 endfunction

		 function string convert2string();
		 	return $sformatf("%s reset=%0b, data_in=%0b,write_enable=%0b,read_enable=%0b,data_out=%0b,full=%0b, empty=%0b, almostfull=%0b, almostempty=%0b, underflow=%0b,wr_ack=%0b, overflow=%0b",super.convert2string(),
		 		rst_n,data_in,wr_en,rd_en,data_out,full,empty,almostfull,almostempty,underflow,wr_ack,overflow);
	endfunction 

	constraint rstn {
rst_n dist{0:=10,1:=90};}

constraint wr_en_c {
wr_en dist{1:=WR_EN_ON_DIST,0:=100-WR_EN_ON_DIST};}

constraint rd_en_c {
rd_en dist{1:=RD_EN_ON_DIST,0:=100-RD_EN_ON_DIST};}

 constraint wr { rst_n == 1;  wr_en == 1;  rd_en == 0; } 

constraint rd { rst_n == 1;  wr_en == 0;  rd_en == 1; } 
constraint rd_wr { rst_n == 1;  wr_en == 1;  rd_en == 1; }
      
  endclass
endpackage : seq_item