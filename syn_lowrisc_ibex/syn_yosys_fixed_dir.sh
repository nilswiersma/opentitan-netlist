#!/bin/bash
source syn_setup.sh $1
yosys -c ./tcl/yosys_run_synth.tcl | tee ./$LR_SYNTH_OUT_DIR/log/syn.log

# sta ./tcl/sta_run_reports.tcl | tee ./$LR_SYNTH_OUT_DIR/log/sta.log
# ./translate_timing_rpts.sh
