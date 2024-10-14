package fifo_config_pkg; 
import uvm_pkg::*; 
`include "uvm_macros.svh"    
class fifo_config_obj extends uvm_object; 
`uvm_object_utils(fifo_config_obj) 
virtual FIFO_IF fifo_config_vif; 
 uvm_active_passive_enum sel_mod; 
function new(string name="fifo_config_obj"); 
super.new(name); 
 
endfunction 
endclass 
 
endpackage