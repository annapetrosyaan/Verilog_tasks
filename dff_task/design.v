module dut(input clk,reset,input [7:0] a,b,output [7:0] out);
 reg [7:0] data;
 genvar i;
  generate
    for(i=0;i < 8;i =i+1)
      begin
        always @ (posedge clk)
          begin
            if(!reset)
                data[i] <= 0;
            else
                data[i] <= !(a[i] & b[i]);
            end
         end
    endgenerate
  assign out = data;
 endmodule
