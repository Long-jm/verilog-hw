module size_count (
  input rst_n, clock, size_valid, data_start,
  input [31:0] size,
  output last
);

  reg [31:0] data;
  reg [2:0] cstate;
  wire dec/*, tc*/;

// Datapath

  always @( posedge clock ) begin
    if( !rst_n )
      data <= 0;
    else if ( size_valid )
      data <= size;
    else if ( dec )
      data <= data - 1;
    else
      data <= data;
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
      else if ( (cstate == 3) && (data == 0) )
	cstate <= 0;
      else
	cstate <= cstate;
    end
  end

  assign dec = ( cstate == 3 );
  assign last = ( (cstate == 3) && (data == 0) );

/*
// Datapath

  always @( posedge clock ) begin
    if( !rst_n )
      data <= 32'h00000000;
    else if ( size_valid )
      data <= size - 1;
    else if ( dec )
      data <= data - 1;
    else
      data <= data;
  end

// Controller

  always @( posedge clock ) begin
    if( !rst_n )
      cstate <= 0;
    else begin
      if ( cstate == 0 ) begin
        dec <= 0;
        tc <= 0;
        if (size_valid) begin
          cstate <= 1;
        end
      end
      else if ( cstate == 1 ) begin
	dec <= 0;
	tc <= 0;
        if ( data_start )
          cstate <= 3;
      end
      else if ( cstate == 3 ) begin
        if ( data == 1 ) begin
	  dec <= 0;
	  tc <= 1;
	  cstate <= 0;
	end
	else begin
	  dec <= 1;
	  tc <= 0;
	end
      end
      else
	cstate <= cstate;
    end
  end

  assign last = ( tc ); */

endmodule