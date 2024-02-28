create_project project_2 "C:/Users/TECH SHOP/Desktop/SPI PROJECT" -part xc7a35ticpg236-1L -force

add_files SPI_WRAPPER.v SPI_SLAVE.v SPI_RAM.v  basys_master.xdc

synth_design -rtl -top SPI_WRAPPER > elab.log

write_schematic elaborated_schematic.pdf -format pdf -force 

launch_runs synth_1 > synth.log

wait_on_run synth_1
open_run synth_1

write_schematic synthesized_schematic.pdf -format pdf -force 

write_verilog -force switch_LEDs_netlist.v

launch_runs impl_1 -to_step write_bitstream 

wait_on_run impl_1
open_run impl_1
