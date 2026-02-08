module ULAula(
  // --- Entradas ---
  input  [3:0] S,     // Seletor de operação (Opcode). 4 bits permitem até 16 operações.
  input  [5:0] A, B,  // Operandos de dados. São números de 6 bits.
  input        R,     // Entrada declarada, mas NÃO utilizada no código (pode ser um Reset ou Carry-In esquecido).
  
  // --- Saídas ---
  // "output reg" indica que essas variáveis terão valores atribuídos dentro de um bloco "always"
  output reg [5:0] O,    // O resultado principal da operação (6 bits).
  output reg       Cout, // Flag de "Carry Out" (estouro da soma ou "vai-um").
  output reg       Zero  // Flag "Zero": fica em 1 se o resultado for igual a 0.
);

  // --- Variável Temporária ---
  // Criou-se um registrador de 7 bits (1 bit maior que A e B).
  // Motivo: Ao somar dois números de 6 bits, o resultado pode ter 7 bits (ex: estouro/overflow).
  // O 7º bit (índice 6) será usado como o Cout.
  reg [6:0] tmp;

  // --- Bloco de Lógica Combinacional ---
  // "always @(*)" significa: execute este bloco sempre que QUALQUER entrada (A, B ou S) mudar.
  always @(*) begin
    // Inicialização padrão para evitar "latches" (memória indesejada) e estados desconhecidos.
    tmp  = 7'd0;
    O    = 6'd0;
    Cout = 1'b0;

    // --- Seleção da Operação ---
    // O comando "case" verifica o valor de S e decide qual cálculo fazer.
    case (S)
      // OPERAÇÕES ARITMÉTICAS
      // O Verilog lida automaticamente com o bit extra no 'tmp' para somas/subtrações.
      4'b0000: tmp = A + B;       // Soma simples
      4'b0001: tmp = A - B;       // Subtração simples
      4'b0010: tmp = A + ~B;      // Soma A com o inverso de B (parte do cálculo de complemento de 2)
      4'b0011: tmp = A - ~B;      // Subtração de A com o inverso de B
      4'b0100: tmp = A + 1;       // Incrementa A (A++)
      4'b0101: tmp = A - 1;       // Decrementa A (A--)
      4'b0110: tmp = B + 1;       // Incrementa B (B++)
      4'b0111: tmp = B - 1;       // Decrementa B (B--)

      // OPERAÇÕES LÓGICAS
      // Note a sintaxe {1'b0, ...}. Isso é uma concatenação.
      // Como operações lógicas (AND, OR, XOR) não geram "Carry" matemático,
      // forçamos o 7º bit (bit mais significativo) a ser 0.
      4'b1000: tmp = {1'b0, (A & B)};  // E lógico (AND)
      4'b1001: tmp = {1'b0, (~A)};     // NÃO lógico (NOT A)
      4'b1010: tmp = {1'b0, (~B)};     // NÃO lógico (NOT B)
      4'b1011: tmp = {1'b0, (A | B)};  // OU lógico (OR)
      4'b1100: tmp = {1'b0, (A ^ B)};  // OU Exclusivo (XOR)
      4'b1101: tmp = {1'b0, ~(A & B)}; // NÃO-E (NAND)
      4'b1110: tmp = {1'b0, A};        // Pass-through A (copia A para a saída)
      4'b1111: tmp = {1'b0, B};        // Pass-through B (copia B para a saída)
      
      default: tmp = 7'd0;             // Segurança: se S for inválido, zera tudo.
    endcase

    // --- Atribuição das Saídas ---
    O    = tmp[5:0];      // Os 6 bits menos significativos vão para a saída O.
    Cout = tmp[6];        // O 7º bit (mais significativo) vira o flag de Carry Out.
    
    // Verifica se O é zero. Se for, a saída Zero recebe 1 (True), senão 0 (False).
    Zero = (O == 6'd0);
  end
endmodule
