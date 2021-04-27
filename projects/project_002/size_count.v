module size_count (
  input rst_n, clock, data_start, size_valid,
  input [31:0] size,
  output checksum_valid
);

  reg [31:0] count;
  reg [2:0] cstate;
  wire dec;

// Datapath

  always @( posedge clock ) begin
    if( !rst_n )
      count <= 0;
    else if ( size_valid )
      count <= size;
    else if ( dec )
      count <= count - 1;
    else
      count <= count;
  end

// Controller

  always @( posedge clock ) begin
    if( !rst_n )
      cstate <= 0;
    else begin
      if ( (cstate == 0) && size_valid )
        cstate <= 1;
      else if ( (cstate == 1) && data_start )
        cstate <= 3;
      else if ( (cstate == 3) && (count == 0) )
	cstate <= 0;
      else
	cstate <= cstate;
    end
  end

  assign dec = ( cstate == 3 );
  assign checksum_valid = ( (cstate == 3) && (count == 0) );

endmodule