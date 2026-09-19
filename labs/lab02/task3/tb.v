// tb.v
// Self-checking testbench for comp2

module tb;

  reg  [1:0] A;
  reg  [1:0] B;
  wire       GT;
  wire       LT;
  wire       EQ;

  // Instantiate DUT
  comp2 DUT (
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
  );

  integer i, j;
  integer errors;

  initial begin
    errors = 0;

    // Test all 16 possible combinations
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin

        A = i;
        B = j;

        #1;

        // Self-check expected outputs
        if ((GT !== (A > B)) ||
            (LT !== (A < B)) ||
            (EQ !== (A == B))) begin

          $display("FAIL: A=%b B=%b | Expected GT=%b LT=%b EQ=%b | Got GT=%b LT=%b EQ=%b",
                   A, B,
                   (A > B), (A < B), (A == B),
                   GT, LT, EQ);

          errors = errors + 1;
        end
        else begin
          $display("PASS: A=%b B=%b | GT=%b LT=%b EQ=%b",
                   A, B, GT, LT, EQ);
        end

      end
    end

    // Final result
    if (errors == 0)
      $display("ALL TESTS PASSED");
    else
      $display("TEST FAILED: %0d error(s) found", errors);

    $finish;
  end

endmodule