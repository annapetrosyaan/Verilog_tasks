`timescale 1ns / 1ps

module tb_alu;
parameter BITS = 8, OP = 4,SIZE = 6;
reg reset;
reg [OP -1:0] op;
reg [BITS -1:0] inp1,inp2;
wire [BITS -1:0] out;

ALU #(
       .BITS(BITS),.OP(OP))
        uut( .reset(reset),
          .op(op), .inp1(inp1),
           .inp2(inp2), .out(out)
);

reg clk,en;
reg [SIZE -1:0] addr;
wire [BITS -1:0] data;

ROM #(
    .BITS(BITS),.SIZE(SIZE))
      unit(.clk(clk),.addr(addr),
          .en(en), .data(data));

initial
    begin
       $dumpfile("dump.vcd");
       $dumpvars(1,tb_alu);
   end
initial
   begin
      clk = 1'b1;
      forever #5 clk = ~clk;
   end
initial
   begin
      en = 1'b0;
      addr = 0;
      op = 0;
      inp1 = 4'b10100;
      inp2 = 4'b0010;
      reset = 0;
      @(posedge clk)
      addr = 4'b0000;
      en = 1'b1;
      op = 0;
      reset = 1;
       repeat(BITS - 1) begin
          @(posedge clk)
          @(posedge clk)
            if(out === data)
               $display ("Passed");
             else
                $display ("failed:");
      op = op + 1;
      addr += 4'b0001;
   end    
end
initial
    begin
       #300 $stop;
    end
endmodule
