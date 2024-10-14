package fifo_env_PKG;
	import seq_item::*;
	
import agent_pkg::*;
import fifo_scoreboard_pkg::*;
import cover_pkg::*;
import uvm_pkg::*; 
`include "uvm_macros.svh"
class fifo_env extends uvm_env;
`uvm_component_utils(fifo_env);

fifo_agent agt;
fifo_scoreboard sb;
fifo_coverage cov;
 uvm_analysis_port #(fifo_seq_item) agt_ap; 
function  new(string name="fifo_env",uvm_component parent=null);
	super.new(name,parent);
endfunction 

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb=fifo_scoreboard::type_id::create("sb",this);
	agt=fifo_agent::type_id::create("agt",this);
	cov=fifo_coverage::type_id::create("cov",this);
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	agt.agt_ap.connect(sb.sb_export);
	agt.agt_ap.connect(cov.cov_export);
	 
endfunction 
endclass

endpackage