module datapath (
  input rst_n, clock,
  input [3:0] A,
  input [1:0] sel,
  output fgt127,
  output [7:0] F
);

  wire [7:0] next_f;
  wire [8:0] apf;
  wire [7:0] wide_a;

  dff8bit U1 (
    .rst_n( rst_n ),
    .clock( clock ),
    .D( next_f ),
    .Q( F )
  );

  assign wide_a = { 4'b0000, A };

  fa8bit U2 (
    .A( wide_a ),
    .B( F ),
    .F( apf )
  );

  assign next_f = sel[1] ?
    ( sel[0] ? F : apf[7:0] ) :
    ( sel[0] ? wide_a : 8'h00 );

  assign fgt127 = F[7];

endmodule
