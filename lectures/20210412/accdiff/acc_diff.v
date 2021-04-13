/*
 * Design a system that accumulates the difference between a pair of 4-bit
 * unsigned binary inputs, A and B, performing the operation A – B. The
 * accumulation is qualified in two (2) ways. The first is that the accumulation
 * should only occur if the capture input is also asserted. Second, the
 * accumulation should only occur if the value of A is greater than the value of
 * B. (The comparison of A to B is something that your system must do.) The system
 * will output an 8-bit unsigned binary result. When the system has accumulated a
 * result greater than 127, the system shall assert the valid output, clear the
 * result, and begin accepting values for the next accumulation. (I.e. valid will
 * assert for a clock cycle along with the accumulated value in result and the
 * process will being again.)
 */

module acc_diff (
	input clock, rst_n, capture,
	input [3:0] A, B,
	output valid,
	output [7:0] result
);

  wire acc, clear, agtb, rgt127;

  datapath dp (
    .clock( clock ),
    .rst_n( rst_n ),
    .A( A ),
    .B( B ),
    .acc( acc ),
    .clear( clear ),
    .agtb( afgtb ),
    .rgt127( rgt127 ),
    .result( result )
  );

  controller ctrl (
    .capture( capture ),
    .agtb( afgtb ),
    .rgt127( rgt127 ),
    .acc( acc ),
    .clear( clear ),
    .valid( valid )
  );

endmodule

module datapath (
  input clock, rst_n,
  input [3:0] A, B,
  input acc, clear,
  output agtb, rgt127,
  output reg [7:0] result
);

  assign agtb = A > B;
  assign rgt127 = result > 127;

  always @( posedge clock )
    if( !rst_n )
      result <= 0;
    else
      if( clear )
        result <= 0;
      else
        if( acc )
          result <= ( A - B ) + result;
        else
          result <= result;

endmodule

module controller (
  input capture,
  input agtb, rgt127,
  output acc, clear,
  output valid
);

  assign valid = rgt127;
  assign clear = rgt127;
  assign acc   = agtb & capture;

endmodule

module acc_diff_tb;

  reg rst_n, clock;
  wire [3:0] A, B;
  wire [7:0] result;
  wire capture;
  wire valid;

  wire [8:0] stim;
  wire done;

  acc_diff DUT (
    .clock( clock ),
    .rst_n( rst_n ),
    .capture( capture ),
    .A( A ),
    .B( B ),
    .valid( valid ),
    .result( result )
  );

  tb_player #(
    .WIDTH( 9 ),
    .PFILE( "acc_diff.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .done( done ),
    .play( stim )
  );

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  assign { capture, A, B } = stim;

  initial begin
        wait( done );
    #15 $stop();
  end

endmodule
