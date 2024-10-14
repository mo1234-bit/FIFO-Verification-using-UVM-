vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave -position insertpoint  \
sim:/top/fifoif/FIFO_WIDTH \
sim:/top/fifoif/FIFO_DEPTH \
sim:/top/fifoif/clk \
sim:/top/fifoif/data_in \
sim:/top/fifoif/rst_n \
sim:/top/fifoif/wr_en \
sim:/top/fifoif/rd_en \
sim:/top/fifoif/full \
sim:/top/fifoif/empty \
sim:/top/fifoif/almostfull \
sim:/top/fifoif/almostempty \
sim:/top/fifoif/underflow \
sim:/top/fifoif/full_ref \
sim:/top/fifoif/empty_ref \
sim:/top/fifoif/almostfull_ref \
sim:/top/fifoif/almostempty_ref \
sim:/top/fifoif/underflow_ref \
sim:/top/fifoif/wr_ack_ref \
sim:/top/fifoif/overflow_ref \
sim:/top/fifoif/data_out_ref \
sim:/top/fifoif/data_out \
sim:/top/fifoif/wr_ack \
sim:/top/fifoif/overflow
coverage save FIFO.ucdb -onexit 
run -all
# quit -sim
# vcover report FIFO.ucdb -details -annotate -all -output Coverage_rpt.txt