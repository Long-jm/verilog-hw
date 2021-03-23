module blocking (
  input clock,
  input [3:0] B, D,
  output reg [3:0] A, C, G
);

  always @( posedge clock ) begin
    A = B;
    C = D;
    G = A;
  end

endmodule

module nonblocking (
  input clock,
  input [3:0] B, D,
  output reg [3:0] A, C, G
);

  always @( posedge clock ) begin
    A <= B;
    C <= D;
    G <= A;
  end

endmodule

module bvnb_tb;

  reg [3:0] b, d;
  wire [3:0] bA, bC, bG;
  wire [3:0] nbA, nbC, nbG;
  reg clock;

  blocking dut_b ( clock, b, d, bA, bC, bG );
  nonblocking dut_nb ( clock, b, d, nbA, nbC, nbG );

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
        { b, d } = 8'h0_8;
    #10 { b, d } = 8'h1_9;
    #10 { b, d } = 8'h2_a;
    #10 { b, d } = 8'h3_b;
    #10 { b, d } = 8'h4_c;
    #10 { b, d } = 8'h5_d;
    #10 { b, d } = 8'h6_e;
    #10 $stop();
  end

endmodule
