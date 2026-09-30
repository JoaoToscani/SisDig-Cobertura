module ha (
    input  logic in_a, in_b,
    output logic ha_soma, carry_out
);
    assign ha_soma = in_a ^ in_b;
    assign carry_out = in_a & in_b;
endmodule


module fa (
    input  logic fa_a, fa_b, carry_in,
    output logic fa_soma, carry_out
);
    logic soma_1, carry_1, carry_2;
    ha ha1 (
        .in_a(fa_a),
        .in_b(fa_b),
        .ha_soma(soma_1),
        .carry_out(carry_1)
    );
    ha ha2 (
        .in_a(soma_1),
        .in_b(carry_in),
        .ha_soma(fa_soma),
        .carry_out(carry_2)
    );
    assign carry_out = carry_1 | carry_2;
endmodule


module mul (
    input logic [7:0] x, y,
    output logic [14:0] prod_ext0, prod_ext1, prod_ext2, prod_ext3, prod_ext4, prod_ext5, prod_ext6, prod_ext7
);
    logic [7:0] produto0, produto1, produto2, produto3, produto4, produto5, produto6, produto7;
    assign produto0 = {8{x[0]}} & y[7:0];
    assign produto1 = {8{x[1]}} & y[7:0];
    assign produto2 = {8{x[2]}} & y[7:0];
    assign produto3 = {8{x[3]}} & y[7:0];
    assign produto4 = {8{x[4]}} & y[7:0];
    assign produto5 = {8{x[5]}} & y[7:0];
    assign produto6 = {8{x[6]}} & y[7:0];
    assign produto7 = {8{x[7]}} & y[7:0];
    assign prod_ext0 = {7'b0, produto0};
    assign prod_ext1 = {6'b0, produto1, 1'b0};
    assign prod_ext2 = {5'b0, produto2, 2'b0};
    assign prod_ext3 = {4'b0, produto3, 3'b0};
    assign prod_ext4 = {3'b0, produto4, 4'b0};
    assign prod_ext5 = {2'b0, produto5, 5'b0};
    assign prod_ext6 = {1'b0, produto6, 6'b0};
    assign prod_ext7 = {produto7, 7'b0};
endmodule


module somador_mul (
    input logic [14:0] x, y,
    output logic [14:0] soma,
    output logic out
);
    logic [14:0] carry;
    ha mul_ha (
        .in_a(x[0]),
        .in_b(y[0]),
        .ha_soma(soma[0]),
        .carry_out(carry[0])
    );
    fa mul_fa0 (
        .fa_a(x[1]),
        .fa_b(y[1]),
        .carry_in(carry[0]),
        .fa_soma(soma[1]),
        .carry_out(carry[1])
    );
    fa mul_fa1 (
        .fa_a(x[2]),
        .fa_b(y[2]),
        .carry_in(carry[1]),
        .fa_soma(soma[2]),
        .carry_out(carry[2])
    );
    fa mul_fa2 (
        .fa_a(x[3]),
        .fa_b(y[3]),
        .carry_in(carry[2]),
        .fa_soma(soma[3]),
        .carry_out(carry[3])
    );
    fa mul_fa3 (
        .fa_a(x[4]),
        .fa_b(y[4]),
        .carry_in(carry[3]),
        .fa_soma(soma[4]),
        .carry_out(carry[4])
    );
    fa mul_fa4 (
        .fa_a(x[5]),
        .fa_b(y[5]),
        .carry_in(carry[4]),
        .fa_soma(soma[5]),
        .carry_out(carry[5])
    );
    fa mul_fa5 (
        .fa_a(x[6]),
        .fa_b(y[6]),
        .carry_in(carry[5]),
        .fa_soma(soma[6]),
        .carry_out(carry[6])
    );
    fa mul_fa6 (
        .fa_a(x[7]),
        .fa_b(y[7]),
        .carry_in(carry[6]),
        .fa_soma(soma[7]),
        .carry_out(carry[7])
    );
    fa mul_fa7 (
        .fa_a(x[8]),
        .fa_b(y[8]),
        .carry_in(carry[7]),
        .fa_soma(soma[8]),
        .carry_out(carry[8])
    );
    fa mul_fa8 (
        .fa_a(x[9]),
        .fa_b(y[9]),
        .carry_in(carry[8]),
        .fa_soma(soma[9]),
        .carry_out(carry[9])
    );
    fa mul_fa9 (
        .fa_a(x[10]),
        .fa_b(y[10]),
        .carry_in(carry[9]),
        .fa_soma(soma[10]),
        .carry_out(carry[10])
    );
    fa mul_fa10 (
        .fa_a(x[11]),
        .fa_b(y[11]),
        .carry_in(carry[10]),
        .fa_soma(soma[11]),
        .carry_out(carry[11])
    );
    fa mul_fa11 (
        .fa_a(x[12]),
        .fa_b(y[12]),
        .carry_in(carry[11]),
        .fa_soma(soma[12]),
        .carry_out(carry[12])
    );
    fa mul_fa12 (
        .fa_a(x[13]),
        .fa_b(y[13]),
        .carry_in(carry[12]),
        .fa_soma(soma[13]),
        .carry_out(carry[13])
    );
    fa mul_fa13 (
        .fa_a(x[14]),
        .fa_b(y[14]),
        .carry_in(carry[13]),
        .fa_soma(soma[14]),
        .carry_out(carry[14])
    );
    assign out = carry[14];
endmodule


module mul_total (
    input  logic [7:0]  x, y,
    output logic [15:0] r_mul
);
    logic [14:0] p0, p1, p2, p3, p4, p5, p6, p7;
    logic [14:0] s1, s2, s3, s4, s5, s6, s7;
    logic c;

    mul m (
        .x(x), .y(y),
        .prod_ext0(p0),
        .prod_ext1(p1),
        .prod_ext2(p2),
        .prod_ext3(p3),
        .prod_ext4(p4),
        .prod_ext5(p5),
        .prod_ext6(p6),
        .prod_ext7(p7)
    );

    somador_mul som1 (.x(p0), .y(p1), .soma(s1), .out());
    somador_mul som2 (.x(s1), .y(p2), .soma(s2), .out());
    somador_mul som3 (.x(s2), .y(p3), .soma(s3), .out());
    somador_mul som4 (.x(s3), .y(p4), .soma(s4), .out());
    somador_mul som5 (.x(s4), .y(p5), .soma(s5), .out());
    somador_mul som6 (.x(s5), .y(p6), .soma(s6), .out());
    somador_mul som7 (.x(s6), .y(p7), .soma(s7), .out(c));
    assign r_mul = {c, s7};
endmodule


module controle
(
	input logic [7:0] a, b,
	input logic [2:0] op,
	output logic [15:0] r
);
localparam OP_SUM = 3'b000;
localparam OP_SUB = 3'b001;
localparam OP_MUL = 3'b010;
localparam OP_COM = 3'b011;
localparam OP_AND = 3'b100;
localparam OP_OR  = 3'b101;
localparam OP_NOT = 3'b110;
localparam OP_XOR = 3'b111;

logic [15:0] r_mul;
logic [7:0] soma;
logic [7:0] carry;
logic [7:0] x;
logic [7:0] y;
logic z;

mul_total u_mul (.x(a), .y(b), .r_mul(r_mul));

fa fa0 (
    .fa_a(x[0]),
    .fa_b(y[0]),
    .carry_in(z),
    .fa_soma(soma[0]),
    .carry_out(carry[0])
);
fa fa1 (
    .fa_a(x[1]),
    .fa_b(y[1]),
    .carry_in(carry[0]),
    .fa_soma(soma[1]),
    .carry_out(carry[1])
);
fa fa2 (
    .fa_a(x[2]),
    .fa_b(y[2]),
    .carry_in(carry[1]),
    .fa_soma(soma[2]),
    .carry_out(carry[2])
);
fa fa3 (
    .fa_a(x[3]),
    .fa_b(y[3]),
    .carry_in(carry[2]),
    .fa_soma(soma[3]),
    .carry_out(carry[3])
);
fa fa4 (
    .fa_a(x[4]),
    .fa_b(y[4]),
    .carry_in(carry[3]),
    .fa_soma(soma[4]),
    .carry_out(carry[4])
);
fa fa5 (
    .fa_a(x[5]),
    .fa_b(y[5]),
    .carry_in(carry[4]),
    .fa_soma(soma[5]),
    .carry_out(carry[5])
);
fa fa6 (
    .fa_a(x[6]),
    .fa_b(y[6]),
    .carry_in(carry[5]),
    .fa_soma(soma[6]),
    .carry_out(carry[6])
);
fa fa7 (
    .fa_a(x[7]),
    .fa_b(y[7]),
    .carry_in(carry[6]),
    .fa_soma(soma[7]),
    .carry_out(carry[7])
);

always_comb begin
    x = a;
    y = b;
    z = 0;
    r = 16'h0000;
    case (op)
        OP_SUM: r = {7'b0, carry[7], soma};
        OP_SUB: begin
            x = a;
            y = ~b;
            z = 1;
            r = {{8{~carry[7]}}, soma};
        end
        OP_MUL: r = r_mul;
		OP_COM: begin
            x = ~a;
            y = 8'b0;
            z = 1;
            r = {{8{~carry[7]}}, soma};
        end
		OP_AND: r = a & b;
		OP_OR: r = a | b;
		OP_NOT: r = {8'b0, ~a};
		OP_XOR: r = a ^ b;
    endcase
end

endmodule