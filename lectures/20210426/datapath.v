module datapath (
  input clk, rst_n,
  input [31:0] div, dsr,
  output reg [31:0] q, r,
  output reg err,

  input clr_q,
  input inc_q,
  input clr_r,
  input ld_r,
  input dec_r,
  input ld_div,
  input ld_dsr,
  input ld_err,
  input clr_err,
  output rltdsr
);

  reg [31:0] div_reg, dsr_reg;
  wire dsr_zero;

  // quotient
  always @( posedge clk )
    if( !rst_n )
      q <= 32'd0;
    else
      if( clr_q )
        q <= 32'd0;
      else
        if( inc_q )
          q <= q + 32'd1;
        else
          q <= q;

  // remainder
  always @( posedge clk )
    if( !rst_n )
      r <= 32'd0;
    else
      if( clr_r )
        r <= 32'd0;
      else
        if( ld_r )
          r <= div_reg;
        else
          if( dec_r )
            r <= r - dsr_reg;
          else
            r <= r;

  assign rltdsr = ( r < dsr_reg );

  // dividend
  always @( posedge clk )
    if( !rst_n )
      div_reg <= 32'd0;
    else
      if( ld_div )
        div_reg <= div;
      else
        div_reg <= div_reg;

  // divisor
  always @( posedge clk )
    if( !rst_n )
      dsr_reg <= 32'd0;
    else
      if( ld_dsr )
        dsr_reg <= dsr;
      else
        dsr_reg <= dsr_reg;

  // error register
  always @( posedge clk )
    if( !rst_n )
      err <= 0;
    else
      if( clr_err )
        err <= 0;
      else
        if( ld_err )
          err <= dsr_zero;
        else
          err <= err;

  assign dsr_zero = ( dsr == 32'd0 );

endmodule
