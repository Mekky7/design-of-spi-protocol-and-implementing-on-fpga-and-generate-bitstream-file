

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module SPI_WRAPPER (MOSI,MISO,SS_n,clk,rst_n);
 input clk,rst_n,SS_n,MOSI;
output MISO;
wire [9:0]rx_data,din;
wire [7:0] tx_data;
wire rx_valid,in1;
wire tx_valid,in2;
assign in1= rx_valid;
assign tx_valid=in2;
assign din= rx_data;
 SPI   dut1 (MOSI,MISO,SS_n,rx_data,rx_valid,tx_data,tx_valid,clk,rst_n);
 SPR_ASYNC_RAM  dut2 (din,clk,rst_n,in1,tx_data,in2);
endmodule