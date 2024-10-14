package cover_pkg;
	import seq_item::*;
	import uvm_pkg::*; 
    `include "uvm_macros.svh"
	class fifo_coverage extends uvm_component;
        `uvm_component_utils(fifo_coverage)
        uvm_analysis_export #(fifo_seq_item)cov_export;
        uvm_tlm_analysis_fifo #(fifo_seq_item)cov_fifo;
        fifo_seq_item seq_item_cov;
	 
        
        // coverage group here
        covergroup group;
            rd:coverpoint seq_item_cov.rd_en;

            wr:coverpoint seq_item_cov.wr_en;

            wrack:coverpoint seq_item_cov.wr_ack;

            full_cover:coverpoint seq_item_cov.full;

            empty_cover:coverpoint seq_item_cov.empty;

            almostfull_cover:coverpoint seq_item_cov.almostfull;

            almostempty_cover:coverpoint seq_item_cov.almostempty;

            overflow_cover:coverpoint seq_item_cov.overflow;

            underflow_cover:coverpoint seq_item_cov.underflow;


wr_ack_crross : cross wr, rd, wrack {
   
    ignore_bins a = binsof(wr) intersect {0} && binsof(wrack) intersect {1};
    ignore_bins b = binsof(wr) intersect {0} && binsof(rd) intersect {1} && binsof(wrack) intersect {1};
   
}


full_cross : cross wr, rd, full_cover {
    
    ignore_bins a = binsof(rd) intersect {1} && binsof(full_cover) intersect {1};
  
}


empty_cross : cross wr, rd, empty_cover ;
 


overflow_cross : cross wr, rd, overflow_cover {
    ignore_bins a = binsof(wr) intersect {0} && binsof(overflow_cover) intersect {1};
   }
  


underflow_cross : cross wr, rd, underflow_cover {
   ignore_bins a = binsof(rd) intersect {0} && binsof(underflow_cover) intersect {1};
}


almostfull_cross : cross wr, rd, almostfull_cover;


almostempty_cross : cross wr, rd, almostempty_cover;
  
endgroup 


		function new(string name="fifo_coverage",uvm_component parent=null); 
        super.new(name,parent); 
        group=new();
    endfunction  
    function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	cov_export=new("cov_export",this);
	cov_fifo=new("cov_fifo",this);
endfunction
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	cov_export.connect(cov_fifo.analysis_export);
endfunction
task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
		cov_fifo.get(seq_item_cov);
		group.sample();
	end
endtask
	endclass : fifo_coverage
endpackage : cover_pkg