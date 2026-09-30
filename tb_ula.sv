`timescale 1ns/1ps

module tb_ula;

    localparam logic [2:0] OP_SUM = 3'b000;
    localparam logic [2:0] OP_SUB = 3'b001;
    localparam logic [2:0] OP_MUL = 3'b010;
    localparam logic [2:0] OP_COM = 3'b011;
    localparam logic [2:0] OP_AND = 3'b100;
    localparam logic [2:0] OP_OR  = 3'b101;
    localparam logic [2:0] OP_NOT = 3'b110;
    localparam logic [2:0] OP_XOR = 3'b111;

    logic [7:0]  a, b;
    logic [2:0]  op;
    logic [15:0] r;

    int erros  = 0;
    int testes = 0;

    controle dut (.a(a), .b(b), .op(op), .r(r));

    function automatic logic [15:0] modelo(input logic [7:0] x, y, input logic [2:0] o);
        case (o)
            OP_SUM:  return 16'(x) + 16'(y);     
            OP_SUB:  return 16'(x) - 16'(y);      
            OP_MUL:  return 16'(x) * 16'(y);
            OP_COM:  return -16'(x);              
            OP_AND:  return {8'b0, x & y};
            OP_OR:   return {8'b0, x | y};
            OP_NOT:  return {8'b0, ~x};
            OP_XOR:  return {8'b0, x ^ y};
            default: return 16'hxxxx;
        endcase
    endfunction

    
    task automatic check(input logic [7:0] ta, tb, input logic [2:0] top);
        logic [15:0] esperado;
        a  = ta;
        b  = tb;
        op = top;
        #1;
        esperado = modelo(ta, tb, top);
        testes++;
        if (r !== esperado) begin
            erros++;
            if (erros <= 20)
                $display("[ERRO] t=%0t op=%b a=%0d b=%0d | obtido=%0d (0x%h) esperado=%0d (0x%h)",
                         $time, top, ta, tb, r, r, esperado, esperado);
        end
    endtask

    initial begin
        $display("Teste ULA");

        
        for (int k = 0; k < 8; k++) begin
            check(8'h00, 8'h00, k[2:0]);
            check(8'hFF, 8'hFF, k[2:0]);
            check(8'hFF, 8'h00, k[2:0]);
            check(8'h00, 8'hFF, k[2:0]);
            check(8'h01, 8'hFF, k[2:0]);
            check(8'h80, 8'h7F, k[2:0]);
            check(8'h55, 8'hAA, k[2:0]);
            check(8'hAA, 8'h55, k[2:0]);
        end

        
        for (int k = 0; k < 8; k++)
            for (int i = 0; i < 256; i++)
                for (int j = 0; j < 256; j++)
                    check(i[7:0], j[7:0], k[2:0]);

      
        if (erros == 0) $display("PASSOU: %0d testes sem erros", testes);
        else            $display("FALHOU: %0d erros em %0d testes", erros, testes);
        $finish;
    end

endmodule
