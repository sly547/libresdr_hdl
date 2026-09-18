module app_logic
#(
    parameter CLOCK_FREQ = 100e6,
    parameter N_CLOCKS = 4
) (
    input logic clk,
    input logic rstn,
    input logic [N_CLOCKS-1:0] board_clocks,
    output logic video_clk,
    output logic video_rstn,

    output logic s_axil_awready,
    input wire s_axil_awvalid,
    input wire [4:0] s_axil_awaddr,
    input wire [2:0] s_axil_awprot,
    output logic s_axil_wready,
    input wire s_axil_wvalid,
    input wire [31:0] s_axil_wdata,
    input wire [3:0]s_axil_wstrb,
    input wire s_axil_bready,
    output logic s_axil_bvalid,
    output logic [1:0] s_axil_bresp,
    output logic s_axil_arready,
    input wire s_axil_arvalid,
    input wire [4:0] s_axil_araddr,
    input wire [2:0] s_axil_arprot,
    input wire s_axil_rready,
    output logic s_axil_rvalid,
    output logic [31:0] s_axil_rdata,
    output logic [1:0] s_axil_rresp
);

    logic [N_CLOCKS-1:0][31:0] freqs;
    logic video_clk_bufr;
    logic rst;

    assign rst = !rstn;

    // This is in library 'desy', but the tool follows a library search order
    // and finds it anyway.
    clock_freq #(
        .G_CLOCK_FREQ   (CLOCK_FREQ),
        .G_CLOCK_COUNT  (N_CLOCKS)
    ) i_clock_freq (
        .pi_clock (clk),
        .pi_reset (rst),
        .pi_clock_vect (board_clocks),
        .po_clock_freq (freqs)
    );

    app_logic_reg_pkg::app_logic_reg__in_t hwif_in;
    app_logic_reg_pkg::app_logic_reg__out_t hwif_out;

    // TODO use a for loop or so
    assign hwif_in.clock_freq[0].data.next = freqs[0];
    assign hwif_in.clock_freq[1].data.next = freqs[1];
    assign hwif_in.clock_freq[2].data.next = freqs[2];
    assign hwif_in.clock_freq[3].data.next = freqs[3];

    assign video_rstn = !hwif_out.video.rst.value;

    // freqs[2] is the AD9361 BB PLL clock - divide it by 4 to get the actual
    // sample rate.
    // FIXME this is a suboptimal solution. Due to long distances between
    // BUFG -> BUFR -> BUFG -> logic, there will be a significant phase shift
    // between the original clock and the divided clock, as well as jitter due
    // to noise along the way. This might cause trouble once I feed video data
    // back into the AD9361. Then again, there are FIFOs..
    // Better: use an MMCM with some phase alignment method?
    //BUFR #(
    //    .BUFR_DIVIDE("4"),
    //    .SIM_DEVICE("7SERIES")
    //) i_bufr (
    //    .CE(1'b1),
    //    .CLR(1'b0),
    //    .I(board_clocks[2]),
    //    .O(video_clk_bufr)
    //);
    //BUFG i_bufg (
    //    .O(video_clk),
    //    .I(video_clk_bufr)
    //);
    assign video_clk = 1'b0;

    // 2.4.4 The dot-star inferred named port connection shortcut
    app_logic_reg i_reg (.*);

endmodule
