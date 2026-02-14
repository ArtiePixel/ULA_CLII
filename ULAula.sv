module ULAula(
  input  logic [3:0] S,
  input  logic [5:0] A, B,
  input  logic       R,
  output logic [5:0] O,
  output logic       Cout,
  output logic       Zero
);

  logic [6:0] tmp;

  always_comb begin
    tmp  = '0;
    O    = '0;
    Cout = 1'b0;
    Zero = 1'b0;

    if (R) begin
      O    = '0;
      Cout = 1'b0;
      Zero = 1'b0;
    end 
    else begin
      case (S)
        4'b0000: tmp = {1'b0, A} + {1'b0, B};
        4'b0001: tmp = {1'b0, A} - {1'b0, B};
        4'b0010: tmp = {1'b0, A} + {1'b0, ~B};
        4'b0011: tmp = {1'b0, A} - {1'b0, ~B};
        4'b0100: tmp = {1'b0, A} + 7'd1;
        4'b0101: tmp = {1'b0, A} - 7'd1;
        4'b0110: tmp = {1'b0, B} + 7'd1;
        4'b0111: tmp = {1'b0, B} - 7'd1;
        4'b1000: tmp = {1'b0, (A & B)};
        4'b1001: tmp = {1'b0, (~A)};
        4'b1010: tmp = {1'b0, (~B)};
        4'b1011: tmp = {1'b0, (A | B)};
        4'b1100: tmp = {1'b0, (A ^ B)};
        4'b1101: tmp = {1'b0, ~(A & B)};
        4'b1110: tmp = {1'b0, A};
        4'b1111: tmp = {1'b0, B};
        default: tmp = '0;
      endcase

      O    = tmp[5:0];
      Cout = tmp[6];
      Zero = (tmp[5:0] == '0);
    end
  end

endmodule
