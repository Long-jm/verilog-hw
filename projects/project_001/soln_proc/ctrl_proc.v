module ctrl_proc (
  input rst_n, clock,
  input capture,
  output valid
);

  reg [2:0] cstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= 0;
    else
      if( cstate == 4 )
        cstate <= 0;
      else
        if( capture )
          cstate <= cstate + 1;
        else
          cstate <= cstate;

  assign valid = ( cstate == 4 );

endmodule
