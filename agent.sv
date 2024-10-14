package agent_pkg;
	import seq_item::*;
	import seqer::*;
	import mointor_pkg::*;
	import fifo_driver_pkg::*;
	import fifo_config_pkg::*;
	`include "uvm_macros.svh"
import uvm_pkg::*;  
class fifo_agent extends uvm_agent; 
	`uvm_component_utils(fifo_agent);

	fifo_driver driver;
    mysequencer sqr;
    fifo_monitor mon;
    fifo_config_obj fifo_config_obj_driver;
    uvm_analysis_port #(fifo_seq_item)agt_ap;

function  new(string name="fifo_agent",uvm_component parent=null);
		super.new(name,parent);
	endfunction	

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (!uvm_config_db #(fifo_config_obj)::get(this, "", "FIFO_IF", fifo_config_obj_driver)) begin
        `uvm_fatal("build_phase", "Virtual interface2 not found for fifo_driver")end
       
        sqr=mysequencer::type_id::create("sqr",this);
        driver=fifo_driver::type_id::create("fifo_driver",this);
   
	mon=fifo_monitor::type_id::create("mon",this);
	agt_ap=new("agt_ap",this);
endfunction 
function void connect_phase(uvm_phase phase);
	   mon.fifo_vif= fifo_config_obj_driver.fifo_config_vif ;
	mon.mon_ap.connect(agt_ap);
	 driver.fifo_vif=fifo_config_obj_driver.fifo_config_vif ;
	driver.seq_item_port.connect(sqr.seq_item_export);
	
endfunction 
	endclass : fifo_agent	
endpackage : agent_pkg