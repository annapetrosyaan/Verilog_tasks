`timescale 1ns/1ps

module dut_tb();
  parameter SIZE = 8;
  reg clk,reset;
  reg [SIZE -1 : 0] a,b;
  wire[SIZE -1:0] out;
  reg [SIZE -1:0] test;
  integer pass = 0;
  integer fail = 0;
  dut #(.BITS(SIZE))
      uut (.clk(clk),
        .reset(reset),
        .a(a),.b(b),
        .out(out));
  initial begin
    clk <= 0;
    forever #10 clk = ~clk;
   end
  integer i =0;
  initial begin
    reset <= 0;
    @(posedge clk);
    @(posedge clk);
     reset <= 1;
    repeat(1000) begin
      a = $random;
      b = $random;
      @(posedge clk);
       for(i=0 ; i < 8; i =i+1) begin
          test[i] = !(a[i] & b[i]);
        end;
      @(posedge clk);
        if (test === out ) begin
             pass +=1;
        end
        else begin
           fail +=1;
        end
     @(posedge clk);
     end
    $display ("Passed:", pass);
    $display("Failed:", fail);
    $finish;
    end
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(1,dut);
    end;
endmodule
