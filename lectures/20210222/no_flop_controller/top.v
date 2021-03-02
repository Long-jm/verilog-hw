module top (
  input rst_n, clock,
  input capture,
  input [3:0] A,
  output [7:0] F,
  output valid
);

  wire [1:0] sel;
  wire fgt127;

  datapath dp_inst (
    .rst_n ( rst_n  ),
    .clock ( clock  ),
    .A     ( A      ),
    .sel   ( sel    ),
    .fgt127( fgt127 ),
    .F     ( F      )
  );

  controller ctrl_inst (
    .capture( capture ),
    .fgt127 ( fgt127  ),
    .sel    ( sel     ),
    .valid  ( valid   )
  );

endmodule
