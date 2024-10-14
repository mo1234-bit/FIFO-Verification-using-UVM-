package myseq;
	import seq_item::*;
	import uvm_pkg::*; 
`include "uvm_macros.svh"
class mysequence_wr extends uvm_sequence #(fifo_seq_item); /* base class*/;
`uvm_object_utils(mysequence_wr)
function  new(string name="mysequence_wr");
		 	super.new(name);
		 endfunction
		 task body();
		 	repeat(70)begin
		 		fifo_seq_item item;
		 		item=fifo_seq_item::type_id::create("item");
		 		start_item(item);
		 		
		 		
		 		item.constraint_mode(0);
                item.wr.constraint_mode(1);
                
		 		assert(item.randomize());
		 		finish_item(item);
		 	end
		 endtask : body
endclass : mysequence_wr
class mysequence_rd extends uvm_sequence #(fifo_seq_item); /* base class*/;
`uvm_object_utils(mysequence_rd)
function  new(string name="mysequence_rd");
		 	super.new(name);
		 endfunction
		 task body();
		 	repeat(50)begin
		 		fifo_seq_item item;
		 		item=fifo_seq_item::type_id::create("item");
		 		start_item(item);
		 		
		 		
		 		item.constraint_mode(0);
		 		item.data_in.rand_mode(0);
                item.rd.constraint_mode(1);
		 		assert(item.randomize());
		 	
		 		finish_item(item);
		 	end
		 endtask : body
endclass : mysequence_rd
class mysequence_rd_wr extends uvm_sequence #(fifo_seq_item); /* base class*/;
`uvm_object_utils(mysequence_rd_wr)
function  new(string name="mysequence_rd_wr");
		 	super.new(name);
		 endfunction
		  task body();
		 	repeat(1000)begin
		 		fifo_seq_item item;
		 		item=fifo_seq_item::type_id::create("item");
		 		start_item(item);
		 		
		 		item.constraint_mode(0);
                item.rd_wr.constraint_mode(1);
               
		 		assert(item.randomize());
		 		finish_item(item);
		 	end
		 endtask : body
endclass : mysequence_rd_wr

class mysequence_rn extends uvm_sequence #(fifo_seq_item);  
`uvm_object_utils(mysequence_rn)
function  new(string name="mysequence_rn");
		 	super.new(name);
		 endfunction
		task body();
		 	repeat(10000)begin
		 		fifo_seq_item item;
		 		item=fifo_seq_item::type_id::create("item");
		 		start_item(item);
		 		
		 		//item.constraint_mode(0);
                item.rd_wr.constraint_mode(0);
                  item.rd.constraint_mode(0);
                  item.wr.constraint_mode(0);
		 		assert(item.randomize());
		 		finish_item(item);
		 	end
		 endtask
endclass : mysequence_rn

endpackage : myseq
