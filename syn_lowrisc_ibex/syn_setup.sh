#!/bin/bash

# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

if [ $# -eq 1 ]; then
  export LR_SYNTH_OUT_DIR=$1
elif [ $# -eq 0 ]; then
  export LR_SYNTH_OUT_DIR_PREFIX="syn_out/ibex"
  export LR_SYNTH_OUT_DIR=$(date +"${LR_SYNTH_OUT_DIR_PREFIX}_%d_%m_%Y_%H_%M_%S")
else
  echo "Usage $0 [synth_out_dir]"
  exit 1
fi

export LR_SYNTH_TIMING_RUN=1
export LR_SYNTH_FLATTEN=1

# SETUP CELL LIBRARY PATH
# Uncomment the lines below and set the path to an appropriate .lib file
export LR_SYNTH_CELL_LIBRARY_PATH=../submodules/NangateOpenCellLibrary_typical.lib
export LR_SYNTH_CELL_LIBRARY_NAME=nangate

# location of prim_assert.sv, excluded in opentitan
export LR_SYNTH_PRIM_ASSERT=../submodules/opentitan/hw/ip/prim/rtl/prim_assert.sv

# location of ibex_core
export LR_SYNTH_IBEX_CORE=../submodules/opentitan/hw/vendor/lowrisc_ibex
