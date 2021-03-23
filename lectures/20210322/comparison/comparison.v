module structural (
  input A, B, C, D,
  output F
);

  wire w0, w1;

  and U0 ( w0, A, B );
  and U1 ( w1, C, D );
  or U2 ( F, w0, w1 );

endmodule

module dataflow (
  input A, B, C, D,
  output F
);

  assign F = ( A & B ) | ( C & D );

endmodule

module procedural (
  input A, B, C, D,
  output reg F
);

  reg ab, cd;

  always @( A, B, C, D ) begin
    ab = A & B;
    cd = C & D;
    F = ab | cd;
  end

endmodule

module proc_err (
  input A, B, C, D,
  output reg F
);

  reg ab, cd;

  always @( A, C, D ) begin
    ab = A & B;
    cd = C & D;
    F = ab | cd;
  end

endmodule

module comparison_tb;

  integer i;
  wire f_str, f_dfl, f_proc, f_err;
  reg a, b, c, d;

  structural dut_str ( a, b, c, d, f_str );
  dataflow dut_dfl ( a, b, c, d, f_dfl );
  procedural dut_proc ( a, b, c, d, f_proc );
  proc_err dut_err ( a, b, c, d, f_err );

  initial begin
        { a, b, c, d } = 4'b0001;
    #10 { a, b, c, d } = 4'b0011;
    #10 { a, b, c, d } = 4'b1011;
    #10 { a, b, c, d } = 4'b1001;
    #10 { a, b, c, d } = 4'b1101;
    #10 { a, b, c, d } = 4'b0101;
    #10 { a, b, c, d } = 4'b0100;
    #10 { a, b, c, d } = 4'b0110;
    #10 { a, b, c, d } = 4'b0100;
    #10 { a, b, c, d } = 4'b0101;
    #10 { a, b, c, d } = 4'b1101;
    #10 { a, b, c, d } = 4'b1001;
    #10 { a, b, c, d } = 4'b1010;
    #10 { a, b, c, d } = 4'b0010;
    #10 { a, b, c, d } = 4'b0001;
    #10 $stop();
  end

endmodule
