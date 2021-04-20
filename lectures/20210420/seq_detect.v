// Decoder
//
// prefix: seqdet_
// suffix: <overlapping><coincident>
//   o: overlapping
//   n: non-overlapping
//   c: coincident
//   a: after (non-coincident)
// impl: <statemachine><shiftreg>
//   sm: state machine
//   sr: shift register
//
module seqdet_oa_sm (
  input rst_n, clock,
  input d_in,
  output reg found
);

  reg [2:0] cstate, nstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= 0;
    else
      cstate <= nstate;

  always @* begin
    found <= 0;
    case( cstate )
      0 : nstate <= d_in ? 1 : 0;
      1 : nstate <= d_in ? 1 : 2;
      2 : nstate <= d_in ? 3 : 0;
      3 : nstate <= d_in ? 4 : 2;
      4 : nstate <= d_in ? 1 : 5;
      5 : begin
        found  <= 1;
        nstate <= d_in ? 3 : 0;
      end
      default : nstate <= 0;
    endcase
  end

endmodule

module dff (
  input rst_n, clock,
  input d,
  output reg q,
  output q_n
);

  always @( posedge clock )
    if( !rst_n )
      q <= 0;
    else
      q <= d;

  assign q_n = ~q;

endmodule

module seqdet_oa_sr (
  input rst_n, clock,
  input d_in,
  output found
);

  wire [4:0] q, q_n;

  dff d0 ( rst_n, clock, d_in, q[0], q_n[0] );
  dff d1 ( rst_n, clock, q[0], q[1], q_n[1] );
  dff d2 ( rst_n, clock, q[1], q[2], q_n[2] );
  dff d3 ( rst_n, clock, q[2], q[3], q_n[3] );
  dff d4 ( rst_n, clock, q[3], q[4], q_n[4] );

  assign found = q_n[0] & q[1] & q[2] & q_n[3] & q[4];

endmodule

module seqdet_oc_sm (
  input rst_n, clock,
  input d_in,
  output reg found
);

  reg [2:0] cstate, nstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= 0;
    else
      cstate <= nstate;

  always @* begin
    found <= 0;
    case( cstate )
      0 : nstate <= d_in ? 1 : 0;
      1 : nstate <= d_in ? 1 : 2;
      2 : nstate <= d_in ? 3 : 0;
      3 : nstate <= d_in ? 4 : 2;
      4 : begin
        found  <= ~d_in;
        nstate <= d_in ? 1 : 2;
      end
      default : nstate <= 0;
    endcase
  end

endmodule

module seqdet_oc_sr (
  input rst_n, clock,
  input d_in,
  output found
);

  wire [4:0] q, q_n;

  dff d1 ( rst_n, clock, d_in, q[1], q_n[1] );
  dff d2 ( rst_n, clock, q[1], q[2], q_n[2] );
  dff d3 ( rst_n, clock, q[2], q[3], q_n[3] );
  dff d4 ( rst_n, clock, q[3], q[4], q_n[4] );

  assign found = ~d_in & q[1] & q[2] & q_n[3] & q[4];

endmodule

module seqdet_nc_sm (
  input rst_n, clock,
  input d_in,
  output reg found
);

  reg [2:0] cstate, nstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= 0;
    else
      cstate <= nstate;

  always @* begin
    found <= 0;
    case( cstate )
      0 : nstate <= d_in ? 1 : 0;
      1 : nstate <= d_in ? 1 : 2;
      2 : nstate <= d_in ? 3 : 0;
      3 : nstate <= d_in ? 4 : 2;
      4 : begin
        found  <= ~d_in;
        nstate <= d_in ? 1 : 0;
      end
      default : nstate <= 0;
    endcase
  end

endmodule

module seqdet_na_sr (
  input rst_n, clock,
  input d_in,
  output found
);

  wire [4:0] q, q_n;
  wire [4:1] clr;
  wire clear;

  assign clr[1] = clear ? 0 : q[0];
  assign clr[2] = clear ? 0 : q[1];
  assign clr[3] = clear ? 0 : q[2];
  assign clr[4] = clear ? 0 : q[3];

  dff d0 ( rst_n, clock, d_in, q[0], q_n[0] );
  dff d1 ( rst_n, clock, clr[1], q[1], q_n[1] );
  dff d2 ( rst_n, clock, clr[2], q[2], q_n[2] );
  dff d3 ( rst_n, clock, clr[3], q[3], q_n[3] );
  dff d4 ( rst_n, clock, clr[4], q[4], q_n[4] );

  assign found = q_n[0] & q[1] & q[2] & q_n[3] & q[4];
  assign clear = found;

endmodule

module seqdet_tb;

  reg rst_n, clock;
  wire d_in;
  wire found_oa_sm, found_oa_sr;
  wire found_na_sr;
  wire found_oc_sm, found_oc_sr;
  wire found_nc_sm;

  wire done;

  seqdet_oa_sm DUT_oa_sm (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .found( found_oa_sm )
  );

  seqdet_oa_sr DUT_oa_sr (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .found( found_oa_sr )
  );

  seqdet_na_sr DUT_na_sr (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .found( found_na_sr )
  );

  seqdet_oc_sm DUT_oc_sm (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .found( found_oc_sm )
  );

  seqdet_oc_sr DUT_oc_sr (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .found( found_oc_sr )
  );

  seqdet_nc_sm DUT_nc_sm (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .found( found_nc_sm )
  );

  tb_player #(
    .WIDTH( 1 ),
    .PFILE( "seqdet.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .done( done ),
    .play( d_in )
  );

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
        wait( done );
    #10 $stop();
  end

endmodule
