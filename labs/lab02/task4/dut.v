// dut.v

// Dataflow implementation
module and_df (
    input  a,
    input  b,
    output y
);
    assign #5 y = a & b;
endmodule


// Behavioral implementation:
// Delay occurs BEFORE the assignment/execution.
module and_beh_before (
    input  a,
    input  b,
    output reg y
);
    always @(*) begin
        #5;
        y = a & b;
    end
endmodule


// Behavioral implementation:
// Intra-assignment delay.
// The expression a & b is evaluated immediately,
// then the result is assigned after 5 time units.
module and_beh_intra (
    input  a,
    input  b,
    output reg y
);
    always @(*) begin
        y = #5 (a & b);
    end
endmodule