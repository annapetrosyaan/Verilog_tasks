module dut #(
  parameter BITS = 4
)
(
  input clk,reset,
  input [BITS - 1:0] a,b,
  output [BITS - 1:0] out
);
  reg [BITS - 1:0] data;
  genvar i;
   generate
     for(i=0;i < BITS -1; i =i+1)
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

