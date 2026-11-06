`timescale 1ns / 1ps

module sample_tb;

    // DUT Inputs
    reg MAX10_CLK1_50 = 0;
    reg clk_200 = 0;
    
    reg [35:0] GPIO_in = 36'b0;       // input GPIO signals
    wire [35:0] GPIO;                 // connects to DUT
    assign GPIO = GPIO_in;

    //simulation outputs
    //wire [12:0] DRAM_ADDR;
    //wire [1:0]  DRAM_BA;
    //wire        DRAM_CAS_N, DRAM_CKE, DRAM_CLK, DRAM_CS_N;
    //wire [15:0] DRAM_DQ;
    //wire        DRAM_LDQM, DRAM_RAS_N, DRAM_UDQM, DRAM_WE_N;
    //DRAM signals are not used in this simulation
    // but can be added later if needed

    wire LEDR0; //debug output 
    wire E = GPIO[0];
    wire O = GPIO[1];
    wire [14:0] input_address = GPIO[15:2];  // GPIO[2] to GPIO[15]
    wire [7:0]  input_data    = GPIO[23:16]; // GPIO[16] to GPIO[23]
    wire [14:0] output_ADDR;
    wire [7:0]  output_DATA;
    wire read_signal;
    wire [3:0] count_output;

    // Instantiate DUT
    sample dut (
        .MAX10_CLK1_50(MAX10_CLK1_50),
        .clk_200(clk_200),
        //.DRAM_ADDR(DRAM_ADDR), will use later to save the captured data into
        //.DRAM_BA(DRAM_BA),
        //.DRAM_CAS_N(DRAM_CAS_N),
        //.DRAM_CKE(DRAM_CKE),
        //.DRAM_CLK(DRAM_CLK),
        //.DRAM_CS_N(DRAM_CS_N),
        //.DRAM_DQ(DRAM_DQ),
        //.DRAM_LDQM(DRAM_LDQM),
        //.DRAM_RAS_N(DRAM_RAS_N),
        //.DRAM_UDQM(DRAM_UDQM),
        //.DRAM_WE_N(DRAM_WE_N),
        .GPIO(GPIO),
        .LEDR0(LEDR0),
        .output_DATA(output_DATA),
        .output_ADDR(output_ADDR),
        .read_signal(read_signal),
        .count_output(count_output)
    );

    // Clock generation
    always #10 MAX10_CLK1_50 = ~MAX10_CLK1_50; // 50 MHz
    always #2.5 clk_200 = ~clk_200; //the clk_200 in simulations...

    // Test procedure
    initial begin
        $display("Starting simulation...");
        $dumpfile("sample_tb.vcd");
        $dumpvars(0, clk_200);
        $dumpvars(0, dut);  

        // Set GPIO[0]=0 (E active), GPIO[1]=0 (O active)
        GPIO_in[0] = 0;
        GPIO_in[1] = 0;

        // Providing valid address and data
        GPIO_in[15:2]  = 14'b10101010101010;  // address
        GPIO_in[23:16] = 8'hAB;     // data

        #100 //hold for a couple of cycles

        // Simulating different states of E (GPIO[0]) and O(GPIO[1])

        //|E|O|
        //-----
        //|0|0|
        //|0|1|
        //|1|0|
        //|1|1|
        //-----

        GPIO_in[0] = 0;
        GPIO_in[1] = 0; #80;

        GPIO_in[0] = 0;
        GPIO_in[1] = 1; #80;

        GPIO_in[0] = 1;
        GPIO_in[1] = 0; #80;

        GPIO_in[0] = 1;
        GPIO_in[1] = 1; #80;

        // Providing new data
        GPIO_in[15:2]  = 14'd5678;
        GPIO_in[23:16] = 8'hCD;

        #20;

        // Change E/O again

        GPIO_in[0] = 0;
        GPIO_in[1] = 0; #80;

        GPIO_in[0] = 0;
        GPIO_in[1] = 1; #80;

        GPIO_in[0] = 1;
        GPIO_in[1] = 0; #80;

        GPIO_in[0] = 1;
        GPIO_in[1] = 1; #80;

        #100;
        $display("Simulation done.");
        $stop;
    end
endmodule
