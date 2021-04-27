module divider (
  input clk, rst_n,
  input start,
  input [31:0] div, dsr,
  output [31:0] q, r,
  output err,
  output done
);

  wire clr_q, inc_q;
  wire clr_r, ld_r, dec_r;
  wire ld_div, ld_dsr;
  wire ld_err, clr_err;
  wire rltdsr;

  datapath dp (
    clk, rst_n,
    div, dsr,
    q, r,
    err,
    clr_q,
    inc_q,
    clr_r,
    ld_r,
    dec_r,
    ld_div,
    ld_dsr,
    ld_err,
    clr_err,
    rltdsr
  );

  controller ct (
    clk, rst_n,
    start,
    done,
    clr_q,
    inc_q,
    clr_r,
    ld_r,
    dec_r,
    ld_div,
    ld_dsr,
    ld_err,
    clr_err,
    err,
    rltdsr
  );

endmodule
