module ULAula(
  input  [3:0] S,
  input  [4:0] A, B,
  input        R,
  output reg [4:0] O,
  output reg       Cout,
  output reg       Zero
);

  reg [5:0] tmp;

  always @(*) begin
    
    tmp  = 6'd0;
    O    = 5'd0;
    Cout = 1'b0;
    Zero = 1'b0; 

    case (S)
      4'b0000: tmp = A + B;
      4'b0001: tmp = A - B;
      4'b0010: tmp = A + ~B;
      4'b0011: tmp = A - ~B;
      4'b0100: tmp = A + 1'b1; 
      4'b0101: tmp = A - 1'b1;
      4'b0110: tmp = B + 1'b1;
      4'b0111: tmp = B - 1'b1;
      4'b1000: tmp = {1'b0, (A & B)};
      4'b1001: tmp = {1'b0, (~A)};
      4'b1010: tmp = {1'b0, (~B)};
      4'b1011: tmp = {1'b0, (A | B)};
      4'b1100: tmp = {1'b0, (A ^ B)};
      4'b1101: tmp = {1'b0, ~(A & B)};
      4'b1110: tmp = {1'b0, A};
      4'b1111: tmp = {1'b0, B};
      default: tmp = 6'd0;
    endcase
    
    
    if (R) begin
        O    = tmp[4:0];
        Cout = tmp[5];
        Zero = (O == 5'd0);
    end
    else begin
        O    = 5'b0; 
        Cout = 1'b0; 
        Zero = 1'b0; 
    end
  end
endmodule