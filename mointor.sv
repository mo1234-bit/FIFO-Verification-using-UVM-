package mointor_pkg;
	import seq_item::*;
	import uvm_pkg::*; 
`include "uvm_macros.svh"
class fifo_monitor extends uvm_monitor;  
	`uvm_component_utils(fifo_monitor)
	virtual FIFO_IF fifo_vif;
	fifo_seq_item stim_seq_item;
	uvm_analysis_port #(fifo_seq_item)mon_ap;
	function  new(string name="alsu_monitor",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		mon_ap=new("mon_ap",this);
	endfunction 
	task run_phase(uvm_phase phase);
    super.run_phase(phase);
     forever begin
         stim_seq_item=fifo_seq_item::type_id::create("stim_seq_item"); 
          @(negedge fifo_vif.clk);  
         stim_seq_item.data_in=fifo_vif.data_in ;
         stim_seq_item.rst_n=fifo_vif.rst_n;
         stim_seq_item.wr_en=fifo_vif.wr_en;
         stim_seq_item.rd_en=fifo_vif.rd_en;
         stim_seq_item.data_out=fifo_vif.data_out;
         stim_seq_item.full=fifo_vif.full;
         stim_seq_item.almostfull=fifo_vif.almostfull;
         stim_seq_item.almostempty=fifo_vif.almostempty;
         stim_seq_item.empty=fifo_vif.empty;
         stim_seq_item.underflow=fifo_vif.underflow;
         stim_seq_item.overflow=fifo_vif.overflow;
         stim_seq_item.wr_ack=fifo_vif.wr_ack;
         mon_ap.write(stim_seq_item);
         `uvm_info("run_phase",stim_seq_item.convert2string(),UVM_HIGH)
        end 

    
endtask : run_phase
endclass 
endpackage : mointor_pkg