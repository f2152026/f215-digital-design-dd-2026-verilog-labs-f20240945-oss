// tb.v

// Starter testbench template -- YOU complete this file.

module tb;

  // Inputs and outputs
  reg  [1:0] t_sel;
  wire [7:0] t_dout;

  // Instantiate DUT
  lut DUT (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Apply different input combinations
  initial begin
    t_sel = 2'b00;
    #10;

    t_sel = 2'b01;
    #10;

    t_sel = 2'b10;
    #10;

    t_sel = 2'b11;
    #10;

    $finish;
  end

  initial
    $monitor($time, " SEL=%b | DOUT=%b", t_sel, t_dout);

endmodule