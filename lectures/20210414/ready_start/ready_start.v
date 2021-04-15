module ready_start (
  input clock, rst_n,
  input ready, start,
  output reg f
);

  localparam WAIT_ON_READY = 2'b00;
  localparam WAIT_ON_START = 2'b01;
  localparam MACHINE_DONE  = 2'b11;

  reg [1:0] cstate, nstate;

  // state vector
  always @( posedge clock )
    if( !rst_n )
      cstate <= WAIT_ON_READY;
    else
      cstate <= nstate;

  always @*
    case( cstate )
      WAIT_ON_READY : begin
        f      <= 0;
        nstate <= ready ? WAIT_ON_START : WAIT_ON_READY;
      end

      WAIT_ON_START : begin
        f      <= 0;
        nstate <= start ? MACHINE_DONE : WAIT_ON_START;
      end

      MACHINE_DONE : begin
        f      <= 1;
        nstate <= WAIT_ON_READY;
      end

      default : begin
        f      <= 0;
        nstate <= WAIT_ON_READY;
      end
    endcase

endmodule

module ready_start_tb;

  reg clock, rst_n;
  wire ready, start;
  wire f;

  wire done;
  wire [1:0] stim;

  ready_start DUT (
    .clock( clock ),
    .rst_n( rst_n ),
    .ready( ready ),
    .start( start ),
    .f( f )
  );

  tb_player #(
    .WIDTH( 2 ),
    .PFILE( "ready_start.dat" ),
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

  assign { ready, start } = stim;

  initial begin
        wait( done );
    #15 $stop;
  end

endmodule
