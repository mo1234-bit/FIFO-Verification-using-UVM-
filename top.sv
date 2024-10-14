import fifo_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top();
	bit clk;

	initial begin
        forever begin
            #1 clk = ~clk;
        end
    end   

	FIFO_IF fifoif(clk);

	FIFO DUT (fifoif);
 fifo_reference_model DUT_gold (fifoif);
    bind FIFO SVA fifo_assert_dut(fifoif);
	
	 initial begin
        uvm_config_db #(virtual FIFO_IF)::set(null , "uvm_test_top" , "FIFO_IF",fifoif);
        run_test("fifo_test");
    end

endmodule