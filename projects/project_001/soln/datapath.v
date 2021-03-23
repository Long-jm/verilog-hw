module datapath (
  input rst_n, clock,
  input [3:0] d_in,
  input [3:0] en,
  input clear,
  output full,
  output [4:0] result
);

  wire [3:0] next_A, next_B, next_C, next_D;
  wire [3:0] A, B, C, D;
  wire [4:0] apb, cpd, cpd_inv;
  wire STA, STB, STC, STD;
  wire next_STA, next_STB, next_STC, next_STD;
  wire set_STA, set_STB, set_STC, set_STD;
  wire [3:0] q_n;

  wire msb; /* gets discarded as a result of the subtration */

  /* capture structure for A */
  dff4bit DFF_A ( rst_n, clock, next_A, A );
  mux21_4bit MUX_A ( en[0], A, d_in, next_A );

  /* capture structure for B */
  dff4bit DFF_B ( rst_n, clock, next_B, B );
  mux21_4bit MUX_B ( en[1], B, d_in, next_B );

  /* capture structure for C */
  dff4bit DFF_C ( rst_n, clock, next_C, C );
  mux21_4bit MUX_C ( en[2], C, d_in, next_C );

  /* capture structure for D */
  dff4bit DFF_D ( rst_n, clock, next_D, D );
  mux21_4bit MUX_D ( en[3], D, d_in, next_D );

  /* A+B */
  fa4bit AplusB ( 1'b0, A, B, apb );

  /* C+D */
  fa4bit CplusD ( 1'b0, C, D, cpd );
  assign cpd_inv = ~cpd;

  /* (A+B)-(C+D) */
  fa5bit Func ( 1'b1, apb, cpd_inv, { msb, result } );

  /* tracking when operand A is stored */
  mux21 MUX_STA ( en[0], STA, 1'b1, set_STA );
  mux21 MUX_STA_CLR ( clear, set_STA, 1'b0, next_STA );
  dff DFF_STA ( rst_n, clock, next_STA, STA, q_n[0] );

  /* tracking when operand B is stored */
  mux21 MUX_STB ( en[1], STB, 1'b1, set_STB );
  mux21 MUX_STB_CLR ( clear, set_STB, 1'b0, next_STB );
  dff DFF_STB ( rst_n, clock, next_STB, STB, q_n[1] );

  /* tracking when operand C is stored */
  mux21 MUX_STC ( en[2], STC, 1'b1, set_STC );
  mux21 MUX_STC_CLR ( clear, set_STC, 1'b0, next_STC );
  dff DFF_STC ( rst_n, clock, next_STC, STC, q_n[2] );

  /* tracking when operand D is stored */
  mux21 MUX_STD ( en[3], STD, 1'b1, set_STD );
  mux21 MUX_STD_CLR ( clear, set_STD, 1'b0, next_STD );
  dff DFF_STD ( rst_n, clock, next_STD, STD, q_n[3] );

  /* we're full when all stores are 1 */
  and track ( full, STA, STB, STC, STD );

endmodule
