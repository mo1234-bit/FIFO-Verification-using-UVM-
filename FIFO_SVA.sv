module SVA (FIFO_IF.DUT INTER);
// Assertions to the DUT



	// Assertions for Combinational Outputs
	always_comb begin
		if (DUT.count == 0) begin
			EMPTY_assertion : assert (INTER.empty && !INTER.full && !INTER.almostempty && !INTER.almostfull) else $display("EMPTY_assertion fail");
			EMPTY_cover     : cover  (INTER.empty && !INTER.full && !INTER.almostempty && !INTER.almostfull)      ;
		end
		if (DUT.count == 1) begin
			ALMOSTEMPTY_assertion : assert (!INTER.empty && !INTER.full && INTER.almostempty && !INTER.almostfull) else $display("ALMOSTFULL_assertion fail");
			ALMOSTEMPTY_cover     : cover  (!INTER.empty && !INTER.full && INTER.almostempty && !INTER.almostfull)      ;
		end
		if (DUT.count == INTER.FIFO_DEPTH-1) begin
			ALMOSTFULL_assertion : assert (!INTER.empty && !INTER.full && !INTER.almostempty && INTER.almostfull) else $display("ALMOSTFULL_assertion fail");
			ALMOSTFULL_cover     : cover  (!INTER.empty && !INTER.full && !INTER.almostempty && INTER.almostfull)      ;
		end
		if (DUT.count == INTER.FIFO_DEPTH) begin
			FULL_assertion : assert (!INTER.empty && INTER.full && !INTER.almostempty && !INTER.almostfull) else $display("FULL_assertion fail");
			FULL_cover     : cover  (!INTER.empty && INTER.full && !INTER.almostempty && !INTER.almostfull)      ;
		end
	end

	// Assertions for Overflow and Underflow
	property OVERFLOW_FIFO;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (INTER.full & INTER.wr_en) |=> (INTER.overflow);
	endproperty

	property UNDERFLOW_FIFO;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (INTER.empty && INTER.rd_en) |=> (INTER.underflow);
	endproperty

	// Assertions for wr_ack
	property WR_ACK_HIGH;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (INTER.wr_en && (DUT.count < INTER.FIFO_DEPTH) && !INTER.full) |=> (INTER.wr_ack);
	endproperty

	property WR_ACK_LOW;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (INTER.wr_en && INTER.full) |=> (!INTER.wr_ack);
	endproperty

	// Assertions for The Counter
	property COUNT_0;
		@(posedge INTER.clk) (!INTER.rst_n) |=> (DUT.count == 0);
	endproperty

	property COUNT_INC_10;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (({INTER.wr_en, INTER.rd_en} == 2'b10) && !INTER.full) |=> (DUT.count == $past(DUT.count) + 1);
	endproperty

	property COUNT_INC_01;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (({INTER.wr_en, INTER.rd_en} == 2'b01) && !INTER.empty) |=> (DUT.count == $past(DUT.count) - 1);
	endproperty

	property COUNT_INC_11_WR;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (({INTER.wr_en, INTER.rd_en} == 2'b11) && INTER.empty) |=> (DUT.count == $past(DUT.count) + 1);
	endproperty
property COUNT_INC_11_RD;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (({INTER.wr_en, INTER.rd_en} == 2'b11) && INTER.full) |=> (DUT.count == $past(DUT.count) - 1);
	endproperty
	
	property COUNT_LAT;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) ((({INTER.wr_en, INTER.rd_en} == 2'b01) && INTER.empty) || (({INTER.wr_en, INTER.rd_en} == 2'b10) && INTER.full)) |=> (DUT.count == $past(DUT.count));
	endproperty

	// Assertions for Pointers
	property PTR_RST;
		@(posedge INTER.clk) (!INTER.rst_n) |=> (~DUT.rd_ptr && ~DUT.wr_ptr);
	endproperty

	property RD_PTR;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (INTER.rd_en && (DUT.count != 0)) |=> (DUT.rd_ptr == ($past(DUT.rd_ptr) + 1) % INTER.FIFO_DEPTH);
	endproperty

	property WR_PTR;
		@(posedge INTER.clk) disable iff (!INTER.rst_n) (INTER.wr_en && (DUT.count < INTER.FIFO_DEPTH)) |=> (DUT.wr_ptr == ($past(DUT.wr_ptr) + 1) % INTER.FIFO_DEPTH);
	endproperty

	// Assert Properties
	OVERFLOW_assertion          : assert property (OVERFLOW_FIFO)    else $display("OVERFLOW_assertion");
	UNDERFLOW_assertion         : assert property (UNDERFLOW_FIFO)   else $display("UNDERFLOW_assertion");
	WR_ACK_HIGH_assertion       : assert property (WR_ACK_HIGH)      else $display("WR_ACK_HIGH_assertion");
	WR_ACK_LOW_assertion        : assert property (WR_ACK_LOW)       else $display("WR_ACK_LOW_assertion");
	COUNTER_0_assertion         : assert property (COUNT_0)          else $display("COUNTER_0_assertion");
	COUNTER_INC_10_assertion    : assert property (COUNT_INC_10)     else $display("COUNTER_INC_WR_assertion fail");
	COUNTER_INC_01_assertion    : assert property (COUNT_INC_01)     else $display("COUNTER_INC_WR_assertion fail");
	COUNTER_INC_11_WR_assertion : assert property (COUNT_INC_11_WR)  else $display("COUNTER_INC_WR_assertion fail");
	COUNTER_INC_11_RD_assertion : assert property (COUNT_INC_11_RD)  else $display("COUNTER_INC_WR_assertion fail");
	COUNTER_LAT_assertion       : assert property (COUNT_LAT)        else $display("COUNTER_LAT_assertion fail");
	PTR_RST_assertion           : assert property (PTR_RST)          else $display("PTR_RST_asssertion fail");
	RD_PTR_assertion            : assert property (RD_PTR)           else $display("RD_PTR_asssertion fail");
	WR_PTR_assertion            : assert property (WR_PTR)           else $display("WR_PTR_asssertion fail");

	// Cover Properties
	OVERFLOW_cover          : cover property (OVERFLOW_FIFO)  ; 
	UNDERFLOW_cover         : cover property (UNDERFLOW_FIFO)  ; 
	WR_ACK_HIGH_cover       : cover property (WR_ACK_HIGH)  ;    
	WR_ACK_LOW_cover        : cover property (WR_ACK_LOW)  ;     
	COUNTER_0_cover         : cover property (COUNT_0)     ;   
	COUNTER_INC_10_cover    : cover property (COUNT_INC_10)   ; 
	COUNTER_INC_01_cover    : cover property (COUNT_INC_01) ;   
	COUNTER_INC_11_WR_cover : cover property (COUNT_INC_11_WR)  ;
	COUNTER_INC_11_RD_cover : cover property (COUNT_INC_11_RD) ;
	COUNTER_LAT_cover       : cover property (COUNT_LAT)    ;   
	PTR_RST_cover           : cover property (PTR_RST)    ;     
	RD_PTR_cover            : cover property (RD_PTR)    ;       
	WR_PTR_cover            : cover property (WR_PTR)  ;         

endmodule : SVA