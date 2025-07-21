`timescale 1ns/1ps

module sample_tb;

    // Testbench signals
    reg MAX10_CLK1_50 = 0;
    wire LEDR0;

    // Other unused inputs
    wire [12:0] DRAM_ADDR;
    wire [1:0] DRAM_BA;
    wire DRAM_CAS_N, DRAM_CKE, DRAM_CLK, DRAM_CS_N;
    wire [15:0] DRAM_DQ;
    wire DRAM_LDQM, DRAM_RAS_N, DRAM_UDQM, DRAM_WE_N;
    wire [35:0] GPIO;

    // Clock generation (50 MHz -> 20 ns period)
    always #10 MAX10_CLK1_50 = ~MAX10_CLK1_50;

    // DUT instantiation
    sample dut (
        .ADC_CLK_10       (1'b0),  // Not used
        .MAX10_CLK1_50    (MAX10_CLK1_50),
        .MAX10_CLK2_50    (1'b0),  // Not used
        .DRAM_ADDR        (DRAM_ADDR),
        .DRAM_BA          (DRAM_BA),
        .DRAM_CAS_N       (DRAM_CAS_N),
        .DRAM_CKE         (DRAM_CKE),
        .DRAM_CLK         (DRAM_CLK),
        .DRAM_CS_N        (DRAM_CS_N),
        .DRAM_DQ          (DRAM_DQ),
        .DRAM_LDQM        (DRAM_LDQM),
        .DRAM_RAS_N       (DRAM_RAS_N),
        .DRAM_UDQM        (DRAM_UDQM),
        .DRAM_WE_N        (DRAM_WE_N),
        .GPIO             (GPIO),
        .LEDR0            (LEDR0)
    );

    initial begin
        $display("Starting simulation...");
        $dumpfile("sample_tb.vcd");
        $dumpvars(0, sample_tb);

        // Run long enough to see at least one toggle (simulate > 2s)
        #2_200_000_000; // 2.2 seconds of simulation time
        $display("Simulation finished.");
        $finish;
    end

endmodule
