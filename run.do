quit -sim
vlib work
vlog -sv +cover=bcesf ULA.sv tb_ula.sv
vsim -c -coverage -voptargs="+acc" work.tb_ula
coverage save -onexit cov.ucdb
run -all
coverage report -details -code bcesf
quit -f
