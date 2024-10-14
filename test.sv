package fifo_test_pkg;
	import rst_seq::*;
	import myseq::*;
	import fifo_config_pkg::*;
	import uvm_pkg::*; 
`include "uvm_macros.svh"
import fifo_env_PKG::*; 
	class fifo_test extends uvm_test;
	`uvm_component_utils(fifo_test);
	fifo_env env;
	 mysequence_wr write_only_seq;
    mysequence_rd read_only_seq;
    mysequence_rd_wr write_read_seq;
     mysequence_rn random;
    virtual FIFO_IF fifo_test_vif;
    fifo_config_obj fifo_config_obj_test;
    fifo_reset_sequence rst_seq; 
  
	function  new(string name="fifo_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env=fifo_env::type_id::create("env",this);
	fifo_config_obj_test=fifo_config_obj::type_id::create("fifo_config_obj_test",this); 
        write_only_seq = mysequence_wr::type_id::create("write_only_seq",this);
        read_only_seq= mysequence_rd::type_id::create("read_only_seq",this);
        write_read_seq =mysequence_rd_wr::type_id::create("write_read_seq",this);
         random=mysequence_rn::type_id::create("random",this);
        rst_seq=fifo_reset_sequence::type_id::create("rst_seq",this);
       
 if (!uvm_config_db #(virtual FIFO_IF)::get(this,"","FIFO_IF",fifo_config_obj_test.fifo_config_vif)) begin
        `uvm_fatal("build_phase", "Virtual interface1 not found for fifo_test")end

    uvm_config_db#(fifo_config_obj)::set(this,"*","FIFO_IF",fifo_config_obj_test); 
endfunction 
	
	 task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		`uvm_info("run_phase","Reset Asserted",UVM_LOW);
		rst_seq.start(env.agt.sqr);
		`uvm_info("run_phase","Reset Dasserted",UVM_LOW);

		 `uvm_info("run_phase" , "Stimulus Generated Stareted" , UVM_LOW)
              write_only_seq.start(env.agt.sqr);
        `uvm_info("run_phase" , "Stimulus Generated Ended" , UVM_LOW)

        `uvm_info("run_phase" , "Stimulus Generated Stareted" , UVM_LOW)
        read_only_seq.start(env.agt.sqr);
        `uvm_info("run_phase" , "Stimulus Generated Ended" , UVM_LOW)
        `uvm_info("run_phase" , "Stimulus Generated Stareted" , UVM_LOW)
        write_read_seq.start(env.agt.sqr);
        `uvm_info("run_phase" , "Stimulus Generated Ended" , UVM_LOW)
        `uvm_info("run_phase" , "Stimulus Generated Stareted" , UVM_LOW)
         random.start(env.agt.sqr);
         `uvm_info("run_phase" , "Stimulus Generated Ended" , UVM_LOW)
       
		phase.drop_objection(this);
	endtask : run_phase
endclass 
endpackage : fifo_test_pkg