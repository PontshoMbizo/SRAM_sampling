`timescale 1ns / 1ps
// Phase sweep: asserts E/O at 16 different offsets against the 80 ns timer
// period and checks that the data valid 70-80 ns after assertion is latched.
module phase_sweep_tb;
    reg clk_200 = 0;
    reg MAX10_CLK1_50 = 0;
    reg [35:0] g = 36'h3;
    wire [35:0] GPIO = g;
    wire LEDR0;
    wire [7:0] output_DATA;
    wire [14:0] output_ADDR;
    wire read_signal;
    wire [3:0] count_output;

    sample dut (.MAX10_CLK1_50(MAX10_CLK1_50), .clk_200(clk_200), .GPIO(GPIO),
                .LEDR0(LEDR0), .output_DATA(output_DATA), .output_ADDR(output_ADDR),
                .read_signal(read_signal), .count_output(count_output));

    always #10  MAX10_CLK1_50 = ~MAX10_CLK1_50;
    always #2.5 clk_200       = ~clk_200;

    integer k, fails;
    initial begin
        $dumpfile("phase_sweep.vcd"); $dumpvars(0, phase_sweep_tb);
        fails = 0;
        g[15:2]  = 14'h1234;
        g[23:16] = 8'hFF;
        #403;
        for (k = 0; k < 16; k = k + 1) begin
            g[1:0] = 2'b00;                 // access starts
            #70 g[23:16] = 8'hA0 + k;       // data valid 70-80 ns after assertion
            #10 g[23:16] = 8'hFF;
            #30 g[1:0] = 2'b11;             // access ends at 110 ns
            #5  if (dut.R_data !== 8'hA0 + k) begin
                    fails = fails + 1;
                    $display("FAIL offset %0d ns: latched %h, expected %h", 5*k, dut.R_data, 8'hA0 + k);
                end
            #130;                           // iteration = 245 ns, which is 5 ns more than 3 timer periods
        end
        $display("%0d of 16 phases latched the correct data (%0d failed)", 16 - fails, fails);
        $finish;
    end
endmodule
