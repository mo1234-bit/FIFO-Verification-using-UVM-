package rst_seq;
	
	import seq_item::*;
	import uvm_pkg::*; 
`include "uvm_macros.svh"
class fifo_reset_sequence extends uvm_sequence #(fifo_seq_item); 
`uvm_object_utils(fifo_reset_sequence)
fifo_seq_item seq_item;
function  new(string name="alsu_reset_sequence");
		 	super.new(name);
		 endfunction
	task body;          
		seq_item=fifo_seq_item::type_id::create("seq_item");
		start_item(seq_item);
		seq_item.rst_n=0;
		seq_item.data_in=5;
	 seq_item.wr_en=0;
	  seq_item.rd_en=1;
		  finish_item(seq_item);
		endtask : body
endclass : fifo_reset_sequence
endpackage 