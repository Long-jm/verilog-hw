module toggle_counter (
  input clock, rst_n,
  input toggle,
  output [3:0] count
);

  wire enable;

  datapath dp (
    .clock( clock ),
    .rst_n( rst_n ),
    .enable( enable ),
    .count( count )
  );

  controller ctrl (
    .clock( clock ),
    .rst_n( rst_n ),
    .toggle( toggle ),
    .enable( enable )
  );

endmodule

module datapath (
  input clock, rst_n,
  input enable,
  output reg [3:0] count
);

  always @( posedge clock )
    if( !rst_n )
      count <= 0;
    else
      if( enable )
        count <= count + 1;
      else
        count <= count;

endmodule

module controller (
  input clock, rst_n,
  input toggle,
  output reg enable
);

  reg cstate, nstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= 0;
    else
      cstate <= nstate;

  // This is how you create a Mealy type output that is dependent, not
  // only on the state but, on the currect inputs.  Anything on the LHS
  // in the case statement will be dependent on cstate.  If you make it
  // dependent on another signal within the case then you're creating a
  // Mealy output.
  //
  // An interesting thing to note is that the next state value will
  // always be a Mealy type output.  It's dependent on both the current
  // state and inputs.
  always @*
    case( cstate )
      0 : begin
        // Here, enable is dependent on cstate and toggle; Mealy
        enable <= toggle ? 1 : 0;
        nstate <= toggle ? 1 : 0;
      end

      1 : begin
        // Here, enable is dependent on cstate and toggle; Mealy
        enable <= toggle ? 0 : 1;
        nstate <= toggle ? 0 : 1;
      end

      default : begin
        // Here, enable is only dependent on the state; Moore
        enable <= 0;
        nstate <= 0;
      end
    endcase

endmodule

module toggle_counter_tb;

  reg clock, rst_n;
  wire toggle;
  wire [3:0] count;

  wire done;
  wire stim;

  toggle_counter DUT (
    .clock( clock ),
    .rst_n( rst_n ),
    .toggle( toggle ),
    .count( count )
  );

  tb_player #(
    .WIDTH( 1 ),
    .PFILE( "toggle_counter.dat" ),
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

  assign toggle = stim;

  initial begin
        wait( done );
    #15 $stop;
  end

endmodule
