#!/bin/bash

# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

# This script drives the experimental Ibex synthesis flow. More details can be
# found in README.md

if [ ! -f syn_setup.sh ]; then
  echo "Must provide syn_setup.sh file"
  echo "See example in syn_setup.example.sh and README.md for instructions"
  exit 1
fi

#-------------------------------------------------------------------------
# setup flow variables
#-------------------------------------------------------------------------
source syn_setup.sh

#-------------------------------------------------------------------------
# use sv2v to convert all SystemVerilog files to Verilog
#-------------------------------------------------------------------------

mkdir -p "$LR_SYNTH_OUT_DIR/generated"
mkdir -p "$LR_SYNTH_OUT_DIR/log"
mkdir -p "$LR_SYNTH_OUT_DIR/reports/timing"

for file in $LR_SYNTH_IBEX_OPENTITAN/*.sv; do
  module=`basename -s .sv $file`
  echo "sv2v --define=SYNTHESIS $LR_SYNTH_IBEX_OPENTITAN/*_pkg.sv $file > $LR_SYNTH_OUT_DIR/generated/${module}.v | tee -a ./$LR_SYNTH_OUT_DIR/log/sv2v.log" | tee -a ./$LR_SYNTH_OUT_DIR/log/sv2v.log

  sv2v --define=SYNTHESIS $LR_SYNTH_IBEX_OPENTITAN/*_pkg.sv $file > $LR_SYNTH_OUT_DIR/generated/${module}.v 2>&1 | tee -a ./$LR_SYNTH_OUT_DIR/log/sv2v.log

  # TODO: eventually remove below hack. It removes "unsigned" from params
  # because Yosys doesn't support unsigned parameters
  sed -i 's/parameter unsigned/parameter/g'   $LR_SYNTH_OUT_DIR/generated/${module}.v
  sed -i 's/localparam unsigned/localparam/g' $LR_SYNTH_OUT_DIR/generated/${module}.v
  sed -i 's/reg unsigned/reg/g'   $LR_SYNTH_OUT_DIR/generated/${module}.v
done

# # remove prim_assert
# rm -v $LR_SYNTH_IBEX_CORE/rtl/prim_assert.sv
# rm -v $LR_SYNTH_OUT_DIR/generated/prim_assert.v

# # remove generated *pkg.v files (they are empty files and not needed)
# rm -f $LR_SYNTH_OUT_DIR/generated/*_pkg.v

# # remove tracer (not needed for synthesis)
# rm -f $LR_SYNTH_OUT_DIR/generated/ibex_tracer.v

# # remove the FPGA & latch-based register file (because we will use the
# # flop-based one instead)
# rm -f $LR_SYNTH_OUT_DIR/generated/ibex_register_file_latch.v
# rm -f $LR_SYNTH_OUT_DIR/generated/ibex_register_file_fpga.v

# yosys -c ./tcl/yosys_run_synth.tcl 2>&1 | tee ./$LR_SYNTH_OUT_DIR/log/syn.log

# # sta ./tcl/sta_run_reports.tcl | tee ./$LR_SYNTH_OUT_DIR/log/sta.log

# # ./translate_timing_rpts.sh
