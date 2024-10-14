module fifo_reference_model(FIFO_IF.DUT_inter fifoif);

  	int count_n;
	bit [fifoif.FIFO_WIDTH-1:0] rd_wr[$] ;
	
	always @(posedge fifoif.clk or negedge fifoif.rst_n) begin
			if (!fifoif.rst_n) begin
				fifoif.overflow_ref <= 0;
				fifoif.wr_ack_ref <= 0;
				rd_wr.delete();
			end
			else if (fifoif.wr_en && count_n < fifoif.FIFO_DEPTH) begin
				rd_wr.push_back(fifoif.data_in);
				fifoif.wr_ack_ref <= 1;
				
			end
			else begin 
				fifoif.wr_ack_ref <= 0; 
				if (fifoif.full_ref & fifoif.wr_en)
					fifoif.overflow_ref <= 1;
				else
					fifoif.overflow_ref <= 0;	
			end
	end

	always @(posedge fifoif.clk or negedge fifoif.rst_n) begin
			if (!fifoif.rst_n) begin
			  	fifoif.data_out_ref <= 0;
				fifoif.underflow_ref <= 0;
    		end
    		else if (fifoif.rd_en && count_n != 0) begin
			    fifoif.data_out_ref <= rd_wr.pop_front();
    		end
			else begin 
				if (fifoif.empty_ref & fifoif.rd_en)
					fifoif.underflow_ref <= 1;
				else
					fifoif.underflow_ref <= 0;
			end		
	end

	always @(posedge fifoif.clk or negedge fifoif.rst_n) begin
        if (!fifoif.rst_n) begin
	        count_n <= 0;
        end
    
        else begin
	        if	( ({fifoif.wr_en, fifoif.rd_en} == 2'b10) && !fifoif.full_ref) 
	    	    count_n  <= count_n + 1;
	        else if ( ({fifoif.wr_en, fifoif.rd_en} == 2'b01) && !fifoif.empty_ref)
	    	    count_n  <= count_n - 1;
            else if (({fifoif.wr_en, fifoif.rd_en} == 2'b11) && fifoif.full_ref)     
	        	count_n  <= count_n - 1;
	        else if (({fifoif.wr_en, fifoif.rd_en} == 2'b11) && fifoif.empty_ref)      
	        	count_n  <= count_n + 1;				
        end
	end

    assign fifoif.full_ref = (count_n == fifoif.FIFO_DEPTH)? 1 : 0;
    assign fifoif.empty_ref = (count_n == 0)? 1 : 0; 
    assign fifoif.almostfull_ref = (count_n == fifoif.FIFO_DEPTH-1)? 1 : 0; 
    assign fifoif.almostempty_ref = (count_n == 1)? 1 : 0;
        
endmodule