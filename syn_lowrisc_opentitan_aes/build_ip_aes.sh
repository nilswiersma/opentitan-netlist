#!/bin/bash

cd ../submodules/opentitan

fusesoc --cores-root . run --target=syn --tool=icarus --setup lowrisc:ip:aes

cd build/lowrisc_ip_aes_0.6

mkdir -p ./../../../../syn_lowrisc_opentitan_aes/sv

find -name \*.sv -exec cp {} ./../../../../syn_lowrisc_opentitan_aes/sv/ \;

echo "remove #() from prim_clock_mux2.sv"
