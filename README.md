# opentitan-netlist

before clone:
git clone --recursive "url"

or after clone:
git submodule update --init --recursive

cell library: wget https://github.com/The-OpenROAD-Project/OpenROAD-flow/blob/master/flow/platforms/nangate45/lib/NangateOpenCellLibrary_typical.lib

## tools

sv2v: latest commit
yosys: 0.9
verilator: v4.028

### sv2v

TODO

make
stack install

### yosys

TODO

make
make install
PREFIX=$(HOME)/.local bash -c 'make install'

might need some manual messing with share directory

## yosys on just ibex core

apply ibex_syn_yosys.patch to opentitan/hw/vendor/lowrisc_ibex/syn/syn_yosys.sh
copy syn_setup.sh to opentitan/hw/vendor/lowrisc_ibex/syn/
cd opentitan/hw/vendor/lowrisc_ibex/syn/
./syn_yosys.sh
translated verilog is in syn_out/ibex_XXXX/generated/
netlist is syn_out/ibex_XXXX/generated/ibex_core_netlist.v

## yosys on opentitan

fusesoc --cores-root . run --target=sim --setup --build lowrisc:systems:top_earlgrey_verilator 
or 
fusesoc --cores-root .. run --target=sim --setup --build formal
?

cd build
find -name \*.sv -exec cp {} tmp_syn \;
