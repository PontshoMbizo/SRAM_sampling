`timescale 1ns / 1ps

module sample(

    //////////// CLOCK //////////
    input               MAX10_CLK1_50,
    input               clk_200, // used for simulations only, comment out when flashing onto the device

    //////////// SDRAM ////////// don't need it at the moment.
    //output      [12:0]  DRAM_ADDR,
    //output      [1:0]   DRAM_BA,
    //output              DRAM_CAS_N,
    //output              DRAM_CKE,
    //output              DRAM_CLK,
    //output              DRAM_CS_N,
    //inout       [15:0]  DRAM_DQ,
    //output              DRAM_LDQM,
    //output              DRAM_RAS_N,
    //output              DRAM_UDQM,
    //output              DRAM_WE_N,

    //////////// GPIO //////////
    inout       [35:0]  GPIO,

    //////////// LEDR //////////
    output reg          LEDR0,

    /////////// output data ////// for simulation purposes at this point
    output reg  [7:0]   output_DATA,
    output reg  [14:0]  output_ADDR,
    output reg          read_signal,
    output reg  [3:0]   count_output
);

    //=======================================================
    // 200MHz PLL Clock
    //=======================================================

    //for simulations, instantiate this module with clk_200
    //comment the pll instantiation above and uncomment the declaration below when simulating
    //do the opposite when flashing onto the device.

    //wire clk_200;
    //wire locked;

    //pll_200MHz pll_200MHz_inst (
    //    .inclk0 (MAX10_CLK1_50),
    //    .c0     (clk_200),
    //    .locked (locked)
    //);

    //=======================================================
    // Timer (4-bit counter)
    //=======================================================

    wire [3:0] count;
    reg toggle = 1'b0;
    reg reset = 1'b0;

    timer_5ns timer_5ns_inst (
        .clk    (clk_200),
        .reset  (reset),
        .count  (count)
    );

    //=======================================================
    // READ MODE logic
    //=======================================================

	wire read; // OUTPUT from read module
    wire E, O;
    assign E = GPIO[0]; //chip enable
    assign O = GPIO[1]; //output enable

    read read_inst (
        .E       (E),
        .O       (O),
        .counter (count),
        .read    (read)
    );
	 
    //=======================================================
    // MUXing Address and Data
    //=======================================================

    wire [14:0] input_address = GPIO[15:2];  // GPIO[2] to GPIO[15]
    wire [7:0]  input_data    = GPIO[23:16]; // GPIO[16] to GPIO[23]

    wire [14:0] R_address;
    wire [7:0]  R_data;

    read_data read_data_inst (
        .read       (read),
        .clk        (clk_200),
        .address    (input_address),
        .data       (input_data),
        .R_address  (R_address),
        .R_data     (R_data)
    );
    //=======================================================
    // simulation startup
    //=======================================================
        initial begin
            reset = 1;
            #1 reset = 0;
        end

    //=======================================================
    // Main logic block
    //=======================================================
    always @(posedge clk_200) begin
        toggle <= ~toggle; // toggle LEDR0 for debugging
		LEDR0 <= toggle; //debug output
        count_output <= count; //simulation output
        read_signal <= read; //simulation output
        output_DATA <= R_data; //simulation output
        output_ADDR <= R_address; //simulation output
    end
endmodule


