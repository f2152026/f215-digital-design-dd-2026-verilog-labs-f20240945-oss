// tb.v

module tb;

    reg  [3:0] a;
    reg  [3:0] b;
    reg        op;
    wire [3:0] result;

    // Instantiate DUT
    alu DUT (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    // Waveform dump
    string vcd_file;

    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);
            $dumpvars(0, DUT);
        end
    end

    // Test cases
    initial begin
        $display("Starting ALU tests...");
        $display(" time |  a |  b | op | result");
        $display("--------------------------------");

        // ADD: 3 + 2 = 5
        a = 4'd3;
        b = 4'd2;
        op = 1'b0;
        #10;
        $display("%5t | %2d | %2d | %2d | %2d",
                 $time, a, b, op, result);

        // SUB: 3 - 2 = 1
        a = 4'd3;
        b = 4'd2;
        op = 1'b1;
        #10;
        $display("%5t | %2d | %2d | %2d | %2d",
                 $time, a, b, op, result);

        // Change OP only: 3 + 2 -> 3 - 2
        // This specifically tests the sensitivity-list bug.
        a = 4'd7;
        b = 4'd3;
        op = 1'b0;
        #10;

        op = 1'b1;
        #10;
        $display("%5t | %2d | %2d | %2d | %2d",
                 $time, a, b, op, result);

        // More subtraction tests
        a = 4'd9;
        b = 4'd4;
        op = 1'b1;
        #10;
        $display("%5t | %2d | %2d | %2d | %2d",
                 $time, a, b, op, result);

        // More addition tests
        a = 4'd10;
        b = 4'd5;
        op = 1'b0;
        #10;
        $display("%5t | %2d | %2d | %2d | %2d",
                 $time, a, b, op, result);

        // Subtraction where result wraps around 4 bits
        // 2 - 5 = -3 = 13 (4'b1101)
        a = 4'd2;
        b = 4'd5;
        op = 1'b1;
        #10;
        $display("%5t | %2d | %2d | %2d | %2d",
                 $time, a, b, op, result);

        $display("--------------------------------");
        $display("Tests complete.");

        $finish;
    end

endmodule