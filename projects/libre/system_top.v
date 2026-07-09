// ***************************************************************************
// ***************************************************************************
// Copyright (C) 2014-2023 Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/main/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  inout   [14:0]  ddr_addr,
  inout   [ 2:0]  ddr_ba,
  inout           ddr_cas_n,
  inout           ddr_ck_n,
  inout           ddr_ck_p,
  inout           ddr_cke,
  inout           ddr_cs_n,
  inout   [ 3:0]  ddr_dm,
  inout   [31:0]  ddr_dq,
  inout   [ 3:0]  ddr_dqs_n,
  inout   [ 3:0]  ddr_dqs_p,
  inout           ddr_odt,
  inout           ddr_ras_n,
  inout           ddr_reset_n,
  inout           ddr_we_n,

  inout           fixed_io_ddr_vrn,
  inout           fixed_io_ddr_vrp,
  inout   [53:0]  fixed_io_mio,
  inout           fixed_io_ps_clk,
  inout           fixed_io_ps_porb,
  inout           fixed_io_ps_srstb,

  input           rx_clk_in_p,
  input           rx_clk_in_n,
  input           rx_frame_in_p,
  input           rx_frame_in_n,
  input   [ 5:0]  rx_data_in_p,
  input   [ 5:0]  rx_data_in_n,
  output          tx_clk_out_p,
  output          tx_clk_out_n,
  output          tx_frame_out_p,
  output          tx_frame_out_n,
  output  [ 5:0]  tx_data_out_p,
  output  [ 5:0]  tx_data_out_n,

  output          enable,
  output          txnrx,
  // the AD936x CLK_OUT pin J6 is unconnected on the LibreSDR
  //input           clk_out,

  inout           gpio_resetb,
  inout           gpio_en_agc,
  inout   [ 3:0]  gpio_ctl,
  inout   [ 7:0]  gpio_status,

  output          spi_csn,
  output          spi_clk,
  output          spi_mosi,
  input           spi_miso,

  output  [ 1:0]  pl_led,

  // EXT_GPIO
  inout   [ 3:0]  ext_gpio,

  inout           clk_dac_spi_csn,
  inout           clk_dac_spi_clk,
  inout           clk_dac_spi_mosi,

  inout           exp_iic_scl,
  inout           exp_iic_sda

);

  // internal signals

  wire    [19:0]  gpio_i;
  wire    [19:0]  gpio_o;
  wire    [19:0]  gpio_t;

  wire            clk_dac_spi_io0_i;
  wire            clk_dac_spi_io0_o;
  wire            clk_dac_spi_io0_t;
  wire            clk_dac_spi_sck_i;
  wire            clk_dac_spi_sck_o;
  wire            clk_dac_spi_sck_t;
  wire            clk_dac_spi_ss_i;
  wire            clk_dac_spi_ss_o;
  wire            clk_dac_spi_ss_t;

  // instantiations

  ad_iobuf #(
    .DATA_WIDTH(14)
  ) i_iobuf (
    .dio_t (gpio_t[13:0]),
    .dio_i (gpio_o[13:0]),
    .dio_o (gpio_i[13:0]),
    .dio_p ({ gpio_resetb,        // 13:13
              gpio_en_agc,        // 12:12
              gpio_ctl,           // 11: 8
              gpio_status}));     //  7: 0

  assign gpio_i[16:14] = gpio_o[16:14];
  //assign gpio_i[17] = pl_muxout;
  //assign phaser_enable = gpio_o[14];

  // FIXME
  //assign pl_led = gpio_o[24:23];
  ad_iobuf #(
    .DATA_WIDTH(2)
  ) i_iobuf_pl_led (
    .dio_t (gpio_t[19:18]),
    .dio_i (gpio_o[19:18]),
    .dio_o (gpio_i[19:18]),
    .dio_p (pl_led));

  IOBUF i_iobuf_clk_dac_spi_mosi (
    .T(clk_dac_spi_io0_t),
    .I(clk_dac_spi_io0_o),
    .O(clk_dac_spi_io0_i),
    .IO(clk_dac_spi_mosi));
  ad_iobuf #(
    .DATA_WIDTH(1)
  ) i_iobuf_clk_dac_spi_clk (
    .dio_t (clk_dac_spi_sck_t),
    .dio_i (clk_dac_spi_sck_o),
    .dio_o (clk_dac_spi_sck_i),
    .dio_p (clk_dac_spi_clk));
  ad_iobuf #(
    .DATA_WIDTH(1)
  ) i_iobuf_clk_dac_spi_csn (
    .dio_t (clk_dac_spi_ss_t),
    .dio_i (clk_dac_spi_ss_o),
    .dio_o (clk_dac_spi_ss_i),
    .dio_p (clk_dac_spi_csn));

  system_wrapper i_system_wrapper (
    //.CLKIN_10MHz (),
    //.CLK_40M_FPGA (),
    //.PPS_IN (),
    //.clk_dac_spi_io0_io (clk_dac_spi_mosi),
    //.clk_dac_spi_io1_io (),
    //.clk_dac_spi_sck_io (clk_dac_spi_clk),
    //.clk_dac_spi_ss_io (clk_dac_spi_csn),
    .ddr_addr (ddr_addr),
    .ddr_ba (ddr_ba),
    .ddr_cas_n (ddr_cas_n),
    .ddr_ck_n (ddr_ck_n),
    .ddr_ck_p (ddr_ck_p),
    .ddr_cke (ddr_cke),
    .ddr_cs_n (ddr_cs_n),
    .ddr_dm (ddr_dm),
    .ddr_dq (ddr_dq),
    .ddr_dqs_n (ddr_dqs_n),
    .ddr_dqs_p (ddr_dqs_p),
    .ddr_odt (ddr_odt),
    .ddr_ras_n (ddr_ras_n),
    .ddr_reset_n (ddr_reset_n),
    .ddr_we_n (ddr_we_n),
    .enable (enable),
    .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
    .fixed_io_mio (fixed_io_mio),
    .fixed_io_ps_clk (fixed_io_ps_clk),
    .fixed_io_ps_porb (fixed_io_ps_porb),
    .fixed_io_ps_srstb (fixed_io_ps_srstb),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .exp_iic_scl_io (exp_iic_scl),
    .exp_iic_sda_io (exp_iic_sda),
    .rx_clk_in_p (rx_clk_in_p),
    .rx_clk_in_n (rx_clk_in_n),
    .rx_data_in_p (rx_data_in_p),
    .rx_data_in_n (rx_data_in_n),
    .rx_frame_in_p (rx_frame_in_p),
    .rx_frame_in_n (rx_frame_in_n),

    .spi0_clk_i (1'b0),
    .spi0_clk_o (spi_clk),
    .spi0_csn_0_o (spi_csn),
    .spi0_csn_1_o (),
    .spi0_csn_2_o (),
    .spi0_csn_i (1'b1),
    .spi0_sdi_i (spi_miso),
    .spi0_sdo_i (1'b0),
    .spi0_sdo_o (spi_mosi),

    .clk_dac_spi_io0_i (clk_dac_spi_io0_i),
    .clk_dac_spi_io0_o (clk_dac_spi_io0_o),
    .clk_dac_spi_io0_t (clk_dac_spi_io0_t),
    .clk_dac_spi_sck_i (clk_dac_spi_sck_i),
    .clk_dac_spi_sck_o (clk_dac_spi_sck_o),
    .clk_dac_spi_sck_t (clk_dac_spi_sck_t),
    .clk_dac_spi_ss_i (clk_dac_spi_ss_i),
    .clk_dac_spi_ss_o (clk_dac_spi_ss_o),
    .clk_dac_spi_ss_t (clk_dac_spi_ss_t),

    .tx_clk_out_p (tx_clk_out_p),
    .tx_clk_out_n (tx_clk_out_n),
    .tx_data_out_p (tx_data_out_p),
    .tx_data_out_n (tx_data_out_n),
    .tx_frame_out_p (tx_frame_out_p),
    .tx_frame_out_n (tx_frame_out_n),
    .txnrx (txnrx),
    .up_enable (gpio_o[15]),
    .up_txnrx (gpio_o[16]));

endmodule
