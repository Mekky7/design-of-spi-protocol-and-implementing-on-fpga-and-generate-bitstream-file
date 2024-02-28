quit -sim
vlib work
vlog SPI_WRAPPER.v TB.V SPI_SLAVE.v SPI_RAM.v 
vsim -voptargs=+acc work.SPI_tb
add wave *
run -all
