module SPR_ASYNC_RAM (din,clk,rst_n,rx_valid,dout,tx_valid);
    parameter MEM_DEPTH = 256;
    parameter ADDR_SIZE=8;
    input rx_valid,clk,rst_n;
    input[9:0] din;
    output reg tx_valid;
    output reg [7:0]dout;
    reg [7:0] addr;
    reg [7:0]mem[MEM_DEPTH-1:0];
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
        begin
            addr<=1;
         dout<=0;
         tx_valid<=0;   
        end
        else
        begin
            if(rx_valid)
            begin
             case (din[9:8])
                'b00: addr<=din[7:0];
                'b01: mem[addr]<=din[7:0];
                'b10: addr<=din[7:0]; 
                'b11: begin
                    dout<= mem[addr];
                    tx_valid<=1;
                end
             endcase
             if(din[9:8]!='b11)   
             tx_valid<=0;
            end
        end
    end
endmodule