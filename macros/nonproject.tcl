create_project -in_memory -part xck26-sfvc784-2LV-c
set_property source_mgmt_mode All [current_project]
#set_property IP_REPO_PATHS ../src/ip [current_project] 

#read_vhdl ../src/hdl/Dahua_To_Fifo.vhd
#read_vhdl ../src/hdl/Econ_To_Fifo.vhd
#read_vhdl ../src/hdl/IO_Sync.vhd
#read_vhdl ../src/hdl/IO_Sync_2.vhd
#read_vhdl ../src/hdl/Video_Debug.vhd
#read_vhdl ../src/hdl/gmii_ps_pl_mux.vhd
#read_vhdl ../src/hdl/top.vhd
#
#read_xdc ../src/xdc/io.xdc
#read_xdc ../src/xdc/pl_phy.xdc
#read_xdc ../src/xdc/debug.xdc

read_bd ../src/bd/design_1/design_1.bd 
read_verilog ../src/bd/design_1/hdl/design_1_wrapper.v

synth_design -top design_1_wrapper
write_checkpoint -force post_synth
report_timing_summary -file post_synth_timing.rpt
report_methodology -file post_synth_method.rpt
report_cdc -file post_synth_cdc.rpt

opt_design
place_design
phys_opt_design
write_checkpoint -force post_place
report_timing_summary -file post_place_timing.rpt
report_methodology -file post_place_method.rpt
report_cdc -file post_place_cdc.rpt

route_design
write_checkpoint -force post_route
report_timing_summary -file post_rout_timing.rpt
report_methodology -file post_rout_method.rpt
report_cdc -file post_route_cdc.rpt
report_route_status -file post_route_status.rpt
report_io -file post_route_io.rpt
report_drc -file post_route_drc.rpt

write_bitstream -force design_1_wrapper.bit
write_debug_probes -force design_1_wrapper.ltx
write_hw_platform -fixed -include_bit -force design_1_wrapper.xsa
