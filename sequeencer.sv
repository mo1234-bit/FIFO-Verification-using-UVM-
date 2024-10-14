package seqer;
	import seq_item::*;
	import uvm_pkg::*; 
`include "uvm_macros.svh"
class mysequencer extends uvm_sequencer #(fifo_seq_item);
`uvm_component_utils(mysequencer) 
 

function new(string name="mysequencer",uvm_component parent=null);
	super.new(name,parent);
endfunction : new
endclass : mysequencer
endpackage : seqer