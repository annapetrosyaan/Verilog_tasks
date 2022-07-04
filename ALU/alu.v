module ALU #(
  parameter BITS = 8, OP = 4
)
(
  input reset,
  input [OP - 1:0] op,
  input [BITS - 1:0] inp1,inp2,
  output [BITS - 1:0] out
);
  wire [BITS -1:0] Reg1,Reg2;
  reg[BITS - 1:0] result;
  assign Reg1 = inp1;
  assign Reg2 = inp2;
  assign out = result;

  always @(*)
    begin
      if(!reset)
         result = 0;
      else begin
         case (op)
            0 : result = Reg1 + Reg2;
            1 : result = Reg1 - Reg2;
            2: result = Reg1 * Reg2;
            3: result = Reg1 / Reg2;
            4: result = Reg1 % Reg2;
            5: result = Reg1 ^ Reg2;
            6: result = ~(Reg1 | Reg2); //nor
            7: result = ~(Reg1 ^ Reg2); //xnor
            default:
               result = 'x;
         endcase
      end
    end
endmodule


module ROM #(
  parameter BITS = 8,
  SIZE = 4
)
(
  input clk,
  input [SIZE -1: 0] addr,
  input en,
  output reg [BITS -1:0] data
);
  reg [BITS -1:0] ROM [BITS -1:0];
always @(posedge clk)
  begin
    if(en)
      data <= ROM[addr];
    else
      data <= 4'bxxxx;
  end
initial
    begin
        ROM[0] = 4'b10110;
        ROM[1] = 4'b10010;
        ROM[2] = 4'b101000;
        ROM[3] = 4'b01010;
        ROM[4] = 4'b0000;
        ROM[5] = 4'b01001;
        ROM[6] = 4'b01001;
        ROM[7] = 4'b01001;
    end
endmodule
