module SPI  (MOSI,MISO,SS_n,rx_data,rx_valid,tx_data,tx_valid,clk,rst_n);
input MOSI, tx_valid, SS_n, clk, rst_n;
    input [7:0] tx_data;
    output reg rx_valid, MISO;
    output reg [9:0] rx_data;
parameter IDLE=0;
parameter CHK_CMD=1;
parameter WRITE=2;
parameter READ_ADD=3;
parameter READ_DATA=4;
(* fsm_encoding = "gray" *)
    reg [3:0] cs, ns;
    integer i;
    reg u,rd_address;

    always @(posedge clk or negedge rst_n ) begin
        if (!rst_n) begin
              cs <= IDLE;
           
        end else begin
            cs <= ns;
            
    end
end

    always @(cs,SS_n,rd_address,rx_valid) begin
      
            case (cs)
                IDLE: begin
                    if (SS_n)
                        ns = IDLE;
                    else
                        ns = CHK_CMD;
                end
                CHK_CMD: begin
                    if (SS_n)
                        ns = IDLE;
                    else begin
                        if (!MOSI)
                            ns = WRITE;
                        else
                            if ((!rd_address))  ns=READ_ADD;
                            else  ns=READ_DATA;
            
                          end
                          end
                WRITE: begin
                    if ((!SS_n) && (!rx_valid))
                        ns = WRITE;
                    else
                        ns = IDLE;
                end
                   READ_ADD: begin
        if(SS_n)
        ns=IDLE;
      else
      if((!rx_valid))
      begin
      ns=READ_ADD;
      end
      else ns= IDLE;
       end
       READ_DATA: begin
        if(SS_n)
        ns=IDLE;
      else
      if((rd_address))
      begin
      ns=READ_DATA;
      end
      else ns= IDLE;
       end 
            endcase
         
        end
        always@(posedge clk)
        begin
            if(!rst_n)
            begin
                MISO<=0;
                u<=0;
            rd_address<=0;
            i <= 0;
            rx_valid <= 0;
            end
            else
        if (cs == WRITE) begin
                if (i <= 10) begin
                    i <= i + 1;
                    if (i <= 9)
                        rx_data[9 - i] <= MOSI;
                    else
                        rx_valid <= 1;
                end else begin
                    i <= 0;
                end
            end else
            if (cs == READ_ADD) begin
    
                if (i <= 10) begin
                    i <= i + 1;
                    if (i <= 9)
                        rx_data[9 - i] <= MOSI;
                    else
                        rx_valid <= 1;
                     
                end else begin
                    i <= 0;
                end
            end
        else if (cs == READ_DATA) begin
 
                if (i <= 18) begin
                i <= i + 1;
                if(rx_valid)
                begin
                u<=1;
            if (u) begin
rx_valid<=0;
            end end
                    if(i==10) rx_valid<=1;
                   
                    if (i <= 9)
                        rx_data[9 - i] <= MOSI;
                    else
                    begin
                        if(i<=17)
                        begin
                           if(tx_valid)
                        MISO<=tx_data[17-i];
                        end
                        end
                end else begin i<=0;
                               MISO<=0;
                                 rd_address<=0;  
                end
        end else begin
           rx_valid<=0; 

        end

    if(cs==IDLE) begin rx_valid<=0; i<=0; end
   if((cs==READ_DATA)&&(ns==IDLE))rd_address<=0;
       if((cs==READ_ADD)&&(ns==IDLE))rd_address<=1;    
        end
        
   
endmodule
