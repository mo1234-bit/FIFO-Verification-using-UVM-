package fifo_scoreboard_pkg;
	import seq_item::*;
 import uvm_pkg::*; 
    `include "uvm_macros.svh" 
    class fifo_scoreboard extends uvm_scoreboard;  
    		`uvm_component_utils(fifo_scoreboard)
    		uvm_analysis_export #(fifo_seq_item)sb_export;
    		uvm_tlm_analysis_fifo #(fifo_seq_item)sb_fifo;
    		fifo_seq_item seq_item_sb;
    		localparam INPUT_PRIORITY="A";
    		localparam FULL_ADDER="ON";
    		int error_count=0,correct_count=0;
    		 function new(string name="fifo_scoreboard",uvm_component parent=null); 
        super.new(name,parent); 
    endfunction  
    function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export=new("sb_export",this);
	sb_fifo=new("sb_fifo",this);
endfunction
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	sb_export.connect(sb_fifo.analysis_export);
	
endfunction 
task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
		sb_fifo.get(seq_item_sb);

		
		if(seq_item_sb.data_out !=seq_item_sb.data_out_ref||seq_item_sb.full !=seq_item_sb.full_ref||seq_item_sb.almostfull !=seq_item_sb.almostfull_ref
		||seq_item_sb.almostempty !=seq_item_sb.almostempty_ref||seq_item_sb.empty !=seq_item_sb.empty_ref||seq_item_sb.underflow !=seq_item_sb.underflow_ref
		||seq_item_sb.wr_ack_ref !=seq_item_sb.wr_ack||seq_item_sb.overflow !=seq_item_sb.overflow_ref)begin
			`uvm_error("run_phase",$sformatf("comparsion faild by the dut: %s while the data_out reference :%0b,full_reference:%0b,empty_reference:%0b,almostfull_reference:%0b,almostempty_reference:%0b,overflow_reference:%0b,underflow_reference:%0b,ack_reference:%0b",
				seq_item_sb.convert2string(),seq_item_sb.data_out_ref,seq_item_sb.full_ref,seq_item_sb.empty_ref,seq_item_sb.almostfull_ref,
				seq_item_sb.almostempty_ref,seq_item_sb.overflow_ref,seq_item_sb.underflow_ref,seq_item_sb.wr_ack_ref));
			error_count++;
		end
		else begin
			`uvm_info("run_phase",$sformatf("correct out: %s",seq_item_sb.convert2string()),UVM_HIGH);
			correct_count++;
		end
	end
endtask : run_phase
	
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("report_phase",$sformatf("successful:%0d",correct_count),UVM_MEDIUM);
		`uvm_info("report_phase",$sformatf("faild:%0d",error_count),UVM_MEDIUM);
	endfunction 
    	endclass : fifo_scoreboard	
	
endpackage 
