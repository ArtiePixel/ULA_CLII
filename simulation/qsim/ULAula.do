onerror {quit -f}
vlib work
vlog -work work ULAula.vo
vlog -work work ULAula.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ULAula_vlg_vec_tst
vcd file -direction ULAula.msim.vcd
vcd add -internal ULAula_vlg_vec_tst/*
vcd add -internal ULAula_vlg_vec_tst/i1/*
add wave /*
run -all
