module SPI_tb();
reg MOSI,SS_n,rst_n,clk;
wire MISO;
SPI_WRAPPER dut (MOSI,MISO,SS_n,clk,rst_n);
initial begin
    clk=0;
    forever #1 clk=!clk;
end
initial
begin
rst_n=0;
#2
rst_n=1;
SS_n=1;
#2;
SS_n=0;
MOSI=0;
#34;
MOSI=1;
#28;
MOSI=0;
#22;
MOSI=1;
#44;
MOSI=0;
SS_n=1;
#24;
$stop;
end
endmodule