module size_count (
  input clock, rst_n,
  input size_valid,
  input [31:0] size,
  input data_start,
  output last
);

  wire ld, dec, tc;

  datapath dp (
    .clock( clock ),
    .rst_n( rst_n ),
    .size( size ),
    .dec( dec ),
    .load( ld ),
    .tc( tc )
  );

  controller ctrl (
    .clock( clock ),
    .rst_n( rst_n ),
    .size_valid( size_valid ),
    .data_start( data_start ),
    .tc( tc ),
    .ld( ld ),
    .dec( dec ),
    .last( last )
  );

endmodule

module datapath (
  input clock, rst_n,
  input [31:0] size,
  input dec, load,
  output tc
);
  reg [31:0] count;

  assign tc = ( count == 1 );

  always @( posedge clock )
    if( !rst_n )
      count <= 0;
    else
      if( load )
        count <= size;
      else
        if( dec )
          count <= count - 1;
        else
          count <= count;

endmodule

module controller (
  input clock, rst_n,
  input size_valid,
  input data_start,
  input tc,
  output reg ld, dec,
  output reg last
);

  localparam WAIT_ON_SV = 2'b00;
  localparam WAIT_ON_DS = 2'b01;
  localparam WAIT_ON_TC = 2'b11;

  reg [1:0] cstate, nstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= WAIT_ON_SV;
    else
      cstate <= nstate;

  always @*
    case( cstate )
      WAIT_ON_SV : begin
          dec  <= 0;
          ld   <= size_valid;
          last <= 0;

          nstate <= size_valid ? WAIT_ON_DS : WAIT_ON_SV;
        end

      WAIT_ON_DS : begin
          dec  <= 0;
          ld   <= 0;
          last <= 0;

          nstate <= data_start ? WAIT_ON_TC : WAIT_ON_DS;
        end

      WAIT_ON_TC : begin
          dec  <= ~tc;
          ld   <= 0;
          last <= tc;

          nstate <= tc ? WAIT_ON_SV : WAIT_ON_TC;
        end

      default : begin
          dec  <= 0;
          ld   <= 0;
          last <= 0;
          nstate <= WAIT_ON_SV;
        end
    endcase

endmodule
