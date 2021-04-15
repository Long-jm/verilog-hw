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

  always @*
    case( cstate )
      0 : begin
        enable <= 0;
        nstate <= toggle ? 1 : 0;
      end

      1 : begin
        enable <= 1;
        nstate <= toggle ? 0 : 1;
      end

      default : begin
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
