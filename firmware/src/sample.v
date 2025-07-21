module sample(

    //////////// CLOCK //////////
    input               ADC_CLK_10,
    input               MAX10_CLK1_50,
    input               MAX10_CLK2_50,

    //////////// SDRAM //////////
    output      [12:0]  DRAM_ADDR,
    output      [1:0]   DRAM_BA,
    output              DRAM_CAS_N,
    output              DRAM_CKE,
    output              DRAM_CLK,
    output              DRAM_CS_N,
    inout       [15:0]  DRAM_DQ,
    output              DRAM_LDQM,
    output              DRAM_RAS_N,
    output              DRAM_UDQM,
    output              DRAM_WE_N,

    //////////// GPIO //////////
    inout       [35:0]  GPIO,

    //////////// LEDR //////////
    output reg          LEDR0

);

    //=======================================================
    // 200MHz PLL Clock
    //=======================================================

    wire clk_200;
    wire locked;

    pll_200MHz pll_200MHz_inst (
        .inclk0 (MAX10_CLK1_50),
        .c0     (clk_200),
        .locked (locked)
    );

    //=======================================================
    // Timer (4-bit counter)
    //=======================================================

    reg [3:0] count = 0;
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
    assign E = GPIO[0]; // active low chip enable
    assign O = GPIO[1]; // active low output enable

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

    reg [14:0] R_address;
    reg [7:0]  R_data;

    read_data read_data_inst (
        .address    (input_address),
        .data       (input_data),
        .read       (read),
        .R_address  (R_address),
        .R_data     (R_data)
    );
	 
    //=======================================================
    // Main logic block
    //=======================================================
    always @(posedge clk_200) begin
        if (read) begin
            toggle <= ~toggle;
            LEDR0 <= toggle;
        end
    end
endmodule


