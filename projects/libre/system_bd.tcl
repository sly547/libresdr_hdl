###############################################################################
## Copyright (C) 2014-2024 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# set LibreSDR-specific things
set libre "libre"

# Calling 'update_ip_catalog' fails when the BD is already opened,
# which seems to happen implicitly with 'create_bd_design'.
set bd_design_obj [current_bd_design]
set bd_design_name [get_property NAME $bd_design_obj]
close_bd_design $bd_design_name
set lib_dirs [get_property ip_repo_paths [current_fileset]]
lappend lib_dirs ../../ip_repo
set_property ip_repo_paths $lib_dirs [current_fileset]
update_ip_catalog
open_bd_design "libre.srcs/sources_1/bd/${bd_design_name}/${bd_design_name}.bd"

# create board design
source $ad_hdl_dir/projects/common/xilinx/adi_fir_filter_bd.tcl
source $ad_hdl_dir/library/axi_tdd/scripts/axi_tdd.tcl
source bd_cell_hier_microblaze.tcl
source bd_cell_hier_video.tcl


# Start of Vivado-generated code (with some customizations where ADI's code is called).
# The indentation from `write_bd_tcl` is kept for easier comparison (diff).

  # Create interface ports
  set ddr [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr ]

  set fixed_io [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 fixed_io ]

  set exp_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 exp_iic ]


  # Create ports
  set spi0_csn_2_o [ create_bd_port -dir O spi0_csn_2_o ]
  set spi0_csn_1_o [ create_bd_port -dir O spi0_csn_1_o ]
  set spi0_csn_0_o [ create_bd_port -dir O spi0_csn_0_o ]
  set spi0_csn_i [ create_bd_port -dir I spi0_csn_i ]
  set spi0_clk_i [ create_bd_port -dir I spi0_clk_i ]
  set spi0_clk_o [ create_bd_port -dir O spi0_clk_o ]
  set spi0_sdo_i [ create_bd_port -dir I spi0_sdo_i ]
  set spi0_sdo_o [ create_bd_port -dir O spi0_sdo_o ]
  set spi0_sdi_i [ create_bd_port -dir I spi0_sdi_i ]
  set gpio_i [ create_bd_port -dir I -from 19 -to 0 gpio_i ]
  set gpio_o [ create_bd_port -dir O -from 19 -to 0 gpio_o ]
  set gpio_t [ create_bd_port -dir O -from 19 -to 0 gpio_t ]
  set clk_dac_spi_io0_i [ create_bd_port -dir I clk_dac_spi_io0_i ]
  set clk_dac_spi_sck_i [ create_bd_port -dir I clk_dac_spi_sck_i ]
  set clk_dac_spi_ss_i [ create_bd_port -dir I clk_dac_spi_ss_i ]
  set clk_dac_spi_ss_o [ create_bd_port -dir O -from 0 -to 0 clk_dac_spi_ss_o ]
  set clk_dac_spi_ss_t [ create_bd_port -dir O clk_dac_spi_ss_t ]
  set clk_dac_spi_sck_t [ create_bd_port -dir O clk_dac_spi_sck_t ]
  set clk_dac_spi_sck_o [ create_bd_port -dir O clk_dac_spi_sck_o ]
  set clk_dac_spi_io0_o [ create_bd_port -dir O clk_dac_spi_io0_o ]
  set clk_dac_spi_io0_t [ create_bd_port -dir O clk_dac_spi_io0_t ]
  set txdata_o [ create_bd_port -dir O -from 0 -to 0 txdata_o ]
  set tdd_ext_sync [ create_bd_port -dir I tdd_ext_sync ]
  set clkin_10mhz [ create_bd_port -dir I clkin_10mhz ]
  set clk_40m_fpga [ create_bd_port -dir I clk_40m_fpga ]
  set pps_in [ create_bd_port -dir I pps_in ]
  set rx_clk_in_p [ create_bd_port -dir I rx_clk_in_p ]
  set rx_clk_in_n [ create_bd_port -dir I rx_clk_in_n ]
  set rx_frame_in_p [ create_bd_port -dir I rx_frame_in_p ]
  set rx_frame_in_n [ create_bd_port -dir I rx_frame_in_n ]
  set rx_data_in_p [ create_bd_port -dir I -from 5 -to 0 rx_data_in_p ]
  set rx_data_in_n [ create_bd_port -dir I -from 5 -to 0 rx_data_in_n ]
  set tx_clk_out_p [ create_bd_port -dir O tx_clk_out_p ]
  set tx_clk_out_n [ create_bd_port -dir O tx_clk_out_n ]
  set tx_frame_out_p [ create_bd_port -dir O tx_frame_out_p ]
  set tx_frame_out_n [ create_bd_port -dir O tx_frame_out_n ]
  set tx_data_out_p [ create_bd_port -dir O -from 5 -to 0 tx_data_out_p ]
  set tx_data_out_n [ create_bd_port -dir O -from 5 -to 0 tx_data_out_n ]
  set enable [ create_bd_port -dir O enable ]
  set txnrx [ create_bd_port -dir O txnrx ]
  set up_enable [ create_bd_port -dir I up_enable ]
  set up_txnrx [ create_bd_port -dir I up_txnrx ]

  # Create instance: sys_ps7, and set properties
  set sys_ps7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.* sys_ps7 ]
  set_property -dict [list \
    CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {750.000000} \
    CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.096154} \
    CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
    CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {200.000000} \
    CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
    CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
    CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
    CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {166.666672} \
    CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
    CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {100.000000} \
    CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {750} \
    CONFIG.PCW_CLK0_FREQ {100000000} \
    CONFIG.PCW_CLK1_FREQ {200000000} \
    CONFIG.PCW_CLK2_FREQ {10000000} \
    CONFIG.PCW_CLK3_FREQ {10000000} \
    CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {50} \
    CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
    CONFIG.PCW_DM_WIDTH {4} \
    CONFIG.PCW_DQS_WIDTH {4} \
    CONFIG.PCW_DQ_WIDTH {32} \
    CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
    CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
    CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
    CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
    CONFIG.PCW_ENET0_RESET_ENABLE {1} \
    CONFIG.PCW_ENET0_RESET_IO {MIO 9} \
    CONFIG.PCW_ENET_RESET_ENABLE {1} \
    CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
    CONFIG.PCW_EN_CLK1_PORT {1} \
    CONFIG.PCW_EN_EMIO_ENET0 {0} \
    CONFIG.PCW_EN_EMIO_GPIO {1} \
    CONFIG.PCW_EN_EMIO_SPI0 {1} \
    CONFIG.PCW_EN_EMIO_UART0 {0} \
    CONFIG.PCW_EN_ENET0 {1} \
    CONFIG.PCW_EN_GPIO {1} \
    CONFIG.PCW_EN_QSPI {1} \
    CONFIG.PCW_EN_RST1_PORT {1} \
    CONFIG.PCW_EN_SDIO0 {1} \
    CONFIG.PCW_EN_SPI0 {1} \
    CONFIG.PCW_EN_UART0 {1} \
    CONFIG.PCW_EN_USB0 {1} \
    CONFIG.PCW_FCLK_CLK1_BUF {TRUE} \
    CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} \
    CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.0} \
    CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
    CONFIG.PCW_FPGA_FCLK1_ENABLE {1} \
    CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
    CONFIG.PCW_GPIO_EMIO_GPIO_IO {20} \
    CONFIG.PCW_GPIO_EMIO_GPIO_WIDTH {20} \
    CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
    CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
    CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_I2C_RESET_ENABLE {1} \
    CONFIG.PCW_IRQ_F2P_INTR {1} \
    CONFIG.PCW_IRQ_F2P_MODE {REVERSE} \
    CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_0_PULLUP {enabled} \
    CONFIG.PCW_MIO_0_SLEW {slow} \
    CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_10_PULLUP {enabled} \
    CONFIG.PCW_MIO_10_SLEW {slow} \
    CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_11_PULLUP {enabled} \
    CONFIG.PCW_MIO_11_SLEW {slow} \
    CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_12_PULLUP {enabled} \
    CONFIG.PCW_MIO_12_SLEW {slow} \
    CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_13_PULLUP {enabled} \
    CONFIG.PCW_MIO_13_SLEW {slow} \
    CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_14_PULLUP {enabled} \
    CONFIG.PCW_MIO_14_SLEW {slow} \
    CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_15_PULLUP {enabled} \
    CONFIG.PCW_MIO_15_SLEW {slow} \
    CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_16_PULLUP {enabled} \
    CONFIG.PCW_MIO_16_SLEW {slow} \
    CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_17_PULLUP {enabled} \
    CONFIG.PCW_MIO_17_SLEW {slow} \
    CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_18_PULLUP {enabled} \
    CONFIG.PCW_MIO_18_SLEW {slow} \
    CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_19_PULLUP {enabled} \
    CONFIG.PCW_MIO_19_SLEW {slow} \
    CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_1_PULLUP {enabled} \
    CONFIG.PCW_MIO_1_SLEW {slow} \
    CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_20_PULLUP {enabled} \
    CONFIG.PCW_MIO_20_SLEW {slow} \
    CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_21_PULLUP {enabled} \
    CONFIG.PCW_MIO_21_SLEW {slow} \
    CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_22_PULLUP {enabled} \
    CONFIG.PCW_MIO_22_SLEW {slow} \
    CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_23_PULLUP {enabled} \
    CONFIG.PCW_MIO_23_SLEW {slow} \
    CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_24_PULLUP {enabled} \
    CONFIG.PCW_MIO_24_SLEW {slow} \
    CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_25_PULLUP {enabled} \
    CONFIG.PCW_MIO_25_SLEW {slow} \
    CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_26_PULLUP {enabled} \
    CONFIG.PCW_MIO_26_SLEW {slow} \
    CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_27_PULLUP {enabled} \
    CONFIG.PCW_MIO_27_SLEW {slow} \
    CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_28_PULLUP {enabled} \
    CONFIG.PCW_MIO_28_SLEW {slow} \
    CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_29_PULLUP {enabled} \
    CONFIG.PCW_MIO_29_SLEW {slow} \
    CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_2_SLEW {slow} \
    CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_30_PULLUP {enabled} \
    CONFIG.PCW_MIO_30_SLEW {slow} \
    CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_31_PULLUP {enabled} \
    CONFIG.PCW_MIO_31_SLEW {slow} \
    CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_32_PULLUP {enabled} \
    CONFIG.PCW_MIO_32_SLEW {slow} \
    CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_33_PULLUP {enabled} \
    CONFIG.PCW_MIO_33_SLEW {slow} \
    CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_34_PULLUP {enabled} \
    CONFIG.PCW_MIO_34_SLEW {slow} \
    CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_35_PULLUP {enabled} \
    CONFIG.PCW_MIO_35_SLEW {slow} \
    CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_36_PULLUP {enabled} \
    CONFIG.PCW_MIO_36_SLEW {slow} \
    CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_37_PULLUP {enabled} \
    CONFIG.PCW_MIO_37_SLEW {slow} \
    CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_38_PULLUP {enabled} \
    CONFIG.PCW_MIO_38_SLEW {slow} \
    CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_39_PULLUP {enabled} \
    CONFIG.PCW_MIO_39_SLEW {slow} \
    CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_3_SLEW {slow} \
    CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_40_PULLUP {enabled} \
    CONFIG.PCW_MIO_40_SLEW {slow} \
    CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_41_PULLUP {enabled} \
    CONFIG.PCW_MIO_41_SLEW {slow} \
    CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_42_PULLUP {enabled} \
    CONFIG.PCW_MIO_42_SLEW {slow} \
    CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_43_PULLUP {enabled} \
    CONFIG.PCW_MIO_43_SLEW {slow} \
    CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_44_PULLUP {enabled} \
    CONFIG.PCW_MIO_44_SLEW {slow} \
    CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_45_PULLUP {enabled} \
    CONFIG.PCW_MIO_45_SLEW {slow} \
    CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_46_PULLUP {enabled} \
    CONFIG.PCW_MIO_46_SLEW {slow} \
    CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_47_PULLUP {enabled} \
    CONFIG.PCW_MIO_47_SLEW {slow} \
    CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_48_PULLUP {enabled} \
    CONFIG.PCW_MIO_48_SLEW {slow} \
    CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_49_PULLUP {disabled} \
    CONFIG.PCW_MIO_49_SLEW {slow} \
    CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_4_SLEW {slow} \
    CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_50_PULLUP {enabled} \
    CONFIG.PCW_MIO_50_SLEW {slow} \
    CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_51_PULLUP {enabled} \
    CONFIG.PCW_MIO_51_SLEW {slow} \
    CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_52_PULLUP {enabled} \
    CONFIG.PCW_MIO_52_SLEW {slow} \
    CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_53_PULLUP {enabled} \
    CONFIG.PCW_MIO_53_SLEW {slow} \
    CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_5_SLEW {slow} \
    CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_6_SLEW {slow} \
    CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_7_SLEW {slow} \
    CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_8_SLEW {slow} \
    CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_9_PULLUP {enabled} \
    CONFIG.PCW_MIO_9_SLEW {slow} \
    CONFIG.PCW_MIO_PRIMITIVE {54} \
    CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO#GPIO#ENET Reset#GPIO#GPIO#GPIO#GPIO#UART 0#UART 0#Enet 0#Enet 0#Enet\
0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#GPIO#USB Reset#GPIO#GPIO#GPIO#GPIO#Enet\
0#Enet 0} \
    CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]/HOLD_B#qspi0_sclk#gpio[7]#gpio[8]#reset#gpio[10]#gpio[11]#gpio[12]#gpio[13]#rx#tx#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#gpio[46]#reset#gpio[48]#gpio[49]#gpio[50]#gpio[51]#mdc#mdio}\
\
    CONFIG.PCW_PACKAGE_NAME {clg400} \
    CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
    CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 2.5V} \
    CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {0} \
    CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
    CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
    CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
    CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
    CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
    CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
    CONFIG.PCW_SD0_GRP_CD_ENABLE {0} \
    CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
    CONFIG.PCW_SD0_GRP_WP_ENABLE {0} \
    CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
    CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
    CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
    CONFIG.PCW_SINGLE_QSPI_DATA_MODE {x4} \
    CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_SPI0_SPI0_IO {EMIO} \
    CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ {166.666666} \
    CONFIG.PCW_SPI_PERIPHERAL_VALID {1} \
    CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_UART0_GRP_FULL_ENABLE {0} \
    CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_UART0_UART0_IO {MIO 14 .. 15} \
    CONFIG.PCW_UART1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {100} \
    CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
    CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {525.000000} \
    CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
    CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.241} \
    CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.240} \
    CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
    CONFIG.PCW_UIPARAM_DDR_CL {9} \
    CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
    CONFIG.PCW_UIPARAM_DDR_CWL {7} \
    CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
    CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.048} \
    CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.050} \
    CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
    CONFIG.PCW_UIPARAM_DDR_PARTNO {Custom} \
    CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
    CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
    CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
    CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
    CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
    CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
    CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
    CONFIG.PCW_UIPARAM_DDR_T_RC {48.91} \
    CONFIG.PCW_UIPARAM_DDR_T_RCD {9} \
    CONFIG.PCW_UIPARAM_DDR_T_RP {9} \
    CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {0} \
    CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_USB0_RESET_ENABLE {1} \
    CONFIG.PCW_USB0_RESET_IO {MIO 47} \
    CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
    CONFIG.PCW_USB_RESET_ENABLE {1} \
    CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
    CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
    CONFIG.PCW_USE_S_AXI_HP1 {1} \
    CONFIG.PCW_USE_S_AXI_HP2 {1} \
    CONFIG.PCW_USE_S_AXI_HP3 {1} \
  ] $sys_ps7


  # Create instance: sys_rstgen, and set properties
  set sys_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.* sys_rstgen ]
  set_property CONFIG.C_EXT_RST_WIDTH {1} $sys_rstgen


  # Create instance: axi_spi, and set properties
  set axi_spi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.* axi_spi ]
  set_property -dict [list \
    CONFIG.C_NUM_SS_BITS {1} \
    CONFIG.C_NUM_TRANSFER_BITS {16} \
    CONFIG.C_SCK_RATIO {8} \
    CONFIG.C_USE_STARTUP {0} \
    CONFIG.FIFO_INCLUDED {1} \
  ] $axi_spi


  # Create instance: GND_1, and set properties
  set GND_1 [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant:1.* GND_1 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {1} \
  ] $GND_1


  # Create instance: axi_iic_exp, and set properties
  set axi_iic_exp [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.* axi_iic_exp ]

  # Create instance: axi_gp0_interconnect, and set properties
  set axi_gp0_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.* axi_gp0_interconnect ]
  set_property CONFIG.NUM_MI {8} $axi_gp0_interconnect


  # Create instance: axi_ad9361, and set properties
  set axi_ad9361 [ create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.* axi_ad9361 ]
  set_property -dict [list \
    CONFIG.ADC_INIT_DELAY {30} \
    CONFIG.CMOS_OR_LVDS_N {0} \
    CONFIG.ID {0} \
    CONFIG.MODE_1R1T {0} \
  ] $axi_ad9361


  # Create instance: axi_ad9361_dac_dma, and set properties
  set axi_ad9361_dac_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.* axi_ad9361_dac_dma ]
  set_property -dict [list \
    CONFIG.AXI_SLICE_DEST {false} \
    CONFIG.AXI_SLICE_SRC {false} \
    CONFIG.CYCLIC {true} \
    CONFIG.DMA_2D_TRANSFER {false} \
    CONFIG.DMA_DATA_WIDTH_DEST {64} \
    CONFIG.DMA_TYPE_DEST {1} \
    CONFIG.DMA_TYPE_SRC {0} \
    CONFIG.SYNC_TRANSFER_START {true} \
  ] $axi_ad9361_dac_dma


  # Create instance: tx_fir_interpolator
ad_add_interpolation_filter "tx_fir_interpolator" 8 2 1 {61.44} {7.68} \
                             "$ad_hdl_dir/library/util_fir_int/coefile_int.coe"

  # GND_x and VCC_x are created by ad_connect_int_get_const through ad_connect

  # Create instance: interp_slice, and set properties
  set interp_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.* interp_slice ]

  # Create instance: tx_upack, and set properties
  set tx_upack [ create_bd_cell -type ip -vlnv analog.com:user:util_upack2:1.* tx_upack ]

  # Create instance: axi_ad9361_adc_dma, and set properties
  set axi_ad9361_adc_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.* axi_ad9361_adc_dma ]
  set_property -dict [list \
    CONFIG.AXI_SLICE_DEST {false} \
    CONFIG.AXI_SLICE_SRC {false} \
    CONFIG.CYCLIC {false} \
    CONFIG.DMA_2D_TRANSFER {false} \
    CONFIG.DMA_DATA_WIDTH_SRC {64} \
    CONFIG.DMA_TYPE_DEST {0} \
    CONFIG.DMA_TYPE_SRC {2} \
    CONFIG.SYNC_TRANSFER_START {true} \
  ] $axi_ad9361_adc_dma


  # Create instance: rx_fir_decimator
ad_add_decimation_filter "rx_fir_decimator" 8 2 1 {61.44} {61.44} \
                         "$ad_hdl_dir/library/util_fir_int/coefile_int.coe"

  # Create instance: decim_slice, and set properties
  set decim_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.* decim_slice ]

  # Create instance: cpack, and set properties
  set cpack [ create_bd_cell -type ip -vlnv analog.com:user:util_cpack2:1.* cpack ]

  # Create instance: logic_or, and set properties
  set logic_or [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.* logic_or ]
  set_property -dict [list \
    CONFIG.C_OPERATION {or} \
    CONFIG.C_SIZE {1} \
  ] $logic_or


# External TDD
set TDD_CHANNEL_CNT 3
set TDD_DEFAULT_POL 0b110
set TDD_REG_WIDTH 32
set TDD_BURST_WIDTH 32
set TDD_SYNC_WIDTH 0
set TDD_SYNC_INT 0
set TDD_SYNC_EXT 1
set TDD_SYNC_EXT_CDC 1
ad_tdd_gen_create axi_tdd_0 $TDD_CHANNEL_CNT \
                            $TDD_DEFAULT_POL \
                            $TDD_REG_WIDTH \
                            $TDD_BURST_WIDTH \
                            $TDD_SYNC_WIDTH \
                            $TDD_SYNC_INT \
                            $TDD_SYNC_EXT \
                            $TDD_SYNC_EXT_CDC

  # Create instance: logic_inv, and set properties
  set logic_inv [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.* logic_inv ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $logic_inv


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.* xlconcat_0 ]
  set_property CONFIG.NUM_PORTS {4} $xlconcat_0


  # Create instance: hier_microblaze_0
  create_hier_cell_hier_microblaze_0 [current_bd_instance .] hier_microblaze_0

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm_riscv:1.* mdm_1 ]

  # Create instance: hier_video
  create_hier_cell_hier_video [current_bd_instance .] hier_video

  # Create instance: app_logic_0, and set properties
  set app_logic_0 [ create_bd_cell -type ip -vlnv user.org:user:app_logic:1.* app_logic_0 ]
  set_property CONFIG.N_CLOCKS {4} $app_logic_0


  # Create instance: sys_concat_intc, and set properties
  set sys_concat_intc [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconcat:1.* sys_concat_intc ]
  set_property CONFIG.NUM_PORTS {16} $sys_concat_intc


  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_gp0_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP0]
  connect_bd_intf_net -intf_net axi_ad9361_adc_dma_m_dest_axi [get_bd_intf_pins axi_ad9361_adc_dma/m_dest_axi] [get_bd_intf_pins sys_ps7/S_AXI_HP1]
  connect_bd_intf_net -intf_net axi_ad9361_dac_dma_m_axis [get_bd_intf_pins tx_upack/s_axis] [get_bd_intf_pins axi_ad9361_dac_dma/m_axis]
  connect_bd_intf_net -intf_net axi_ad9361_dac_dma_m_src_axi [get_bd_intf_pins axi_ad9361_dac_dma/m_src_axi] [get_bd_intf_pins sys_ps7/S_AXI_HP2]
  connect_bd_intf_net -intf_net axi_gp0_interconnect_M00_AXI [get_bd_intf_pins axi_gp0_interconnect/M00_AXI] [get_bd_intf_pins axi_iic_exp/S_AXI]
  connect_bd_intf_net -intf_net axi_gp0_interconnect_M01_AXI [get_bd_intf_pins axi_gp0_interconnect/M01_AXI] [get_bd_intf_pins axi_ad9361/s_axi]
  connect_bd_intf_net -intf_net axi_gp0_interconnect_M02_AXI [get_bd_intf_pins axi_gp0_interconnect/M02_AXI] [get_bd_intf_pins axi_ad9361_adc_dma/s_axi]
  connect_bd_intf_net -intf_net axi_gp0_interconnect_M03_AXI [get_bd_intf_pins axi_gp0_interconnect/M03_AXI] [get_bd_intf_pins axi_ad9361_dac_dma/s_axi]
  connect_bd_intf_net -intf_net axi_gp0_interconnect_M04_AXI [get_bd_intf_pins axi_gp0_interconnect/M04_AXI] [get_bd_intf_pins axi_spi/AXI_LITE]
  connect_bd_intf_net -intf_net axi_gp0_interconnect_M05_AXI [get_bd_intf_pins axi_gp0_interconnect/M05_AXI] [get_bd_intf_pins axi_tdd_0/s_axi]
  connect_bd_intf_net -intf_net axi_gp0_interconnect_M06_AXI [get_bd_intf_pins app_logic_0/s_axil] [get_bd_intf_pins axi_gp0_interconnect/M06_AXI]
  connect_bd_intf_net -intf_net axi_gp0_interconnect_M07_AXI [get_bd_intf_pins axi_gp0_interconnect/M07_AXI] [get_bd_intf_pins hier_video/S00_AXI]
  connect_bd_intf_net -intf_net axi_iic_exp_IIC [get_bd_intf_ports exp_iic] [get_bd_intf_pins axi_iic_exp/IIC]
  connect_bd_intf_net -intf_net cpack_packed_fifo_wr [get_bd_intf_pins axi_ad9361_adc_dma/fifo_wr] [get_bd_intf_pins cpack/packed_fifo_wr]
  connect_bd_intf_net -intf_net hier_video_M_AXI [get_bd_intf_pins sys_ps7/S_AXI_HP3] [get_bd_intf_pins hier_video/M_AXI]
  connect_bd_intf_net -intf_net mdm_1_MBDEBUG_0 [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins hier_microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net sys_ps7_DDR [get_bd_intf_ports ddr] [get_bd_intf_pins sys_ps7/DDR]
  connect_bd_intf_net -intf_net sys_ps7_FIXED_IO [get_bd_intf_ports fixed_io] [get_bd_intf_pins sys_ps7/FIXED_IO]

  # Create port connections
  connect_bd_net -net GND_1_dout  [get_bd_pins GND_1/dout] \
  [get_bd_pins tx_fir_interpolator/load_config] \
  [get_bd_pins axi_ad9361/tdd_sync] \
  [get_bd_pins sys_concat_intc/In7] \
  [get_bd_pins sys_concat_intc/In14] \
  [get_bd_pins sys_concat_intc/In13] \
  [get_bd_pins sys_concat_intc/In12] \
  [get_bd_pins sys_concat_intc/In11] \
  [get_bd_pins sys_concat_intc/In10] \
  [get_bd_pins sys_concat_intc/In9] \
  [get_bd_pins sys_concat_intc/In8] \
  [get_bd_pins sys_concat_intc/In15] \
  [get_bd_pins sys_concat_intc/In6]
  # connections to GND_x and VCC_x have already have been made by ad_connect calls
  connect_bd_net -net active_1  [get_bd_pins decim_slice/Dout] \
  [get_bd_pins rx_fir_decimator/active]
  connect_bd_net -net active_2  [get_bd_pins interp_slice/Dout] \
  [get_bd_pins tx_fir_interpolator/active]
  connect_bd_net -net app_logic_0_video_clk  [get_bd_pins app_logic_0/video_clk] \
  [get_bd_pins hier_video/video_clk] \
  [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net app_logic_0_video_rst  [get_bd_pins app_logic_0/video_rstn] \
  [get_bd_pins hier_video/ext_reset_in]
  connect_bd_net -net axi_ad9361_adc_data_i0  [get_bd_pins axi_ad9361/adc_data_i0] \
  [get_bd_pins rx_fir_decimator/data_in_0]
  connect_bd_net -net axi_ad9361_adc_data_i1  [get_bd_pins axi_ad9361/adc_data_i1] \
  [get_bd_pins cpack/fifo_wr_data_2]
  connect_bd_net -net axi_ad9361_adc_data_q0  [get_bd_pins axi_ad9361/adc_data_q0] \
  [get_bd_pins rx_fir_decimator/data_in_1]
  connect_bd_net -net axi_ad9361_adc_data_q1  [get_bd_pins axi_ad9361/adc_data_q1] \
  [get_bd_pins cpack/fifo_wr_data_3]
  connect_bd_net -net axi_ad9361_adc_dma_irq  [get_bd_pins axi_ad9361_adc_dma/irq] \
  [get_bd_pins sys_concat_intc/In2]
  connect_bd_net -net axi_ad9361_adc_enable_i0  [get_bd_pins axi_ad9361/adc_enable_i0] \
  [get_bd_pins rx_fir_decimator/enable_in_0]
  connect_bd_net -net axi_ad9361_adc_enable_i1  [get_bd_pins axi_ad9361/adc_enable_i1] \
  [get_bd_pins cpack/enable_2]
  connect_bd_net -net axi_ad9361_adc_enable_q0  [get_bd_pins axi_ad9361/adc_enable_q0] \
  [get_bd_pins rx_fir_decimator/enable_in_1]
  connect_bd_net -net axi_ad9361_adc_enable_q1  [get_bd_pins axi_ad9361/adc_enable_q1] \
  [get_bd_pins cpack/enable_3]
  connect_bd_net -net axi_ad9361_adc_valid_i0  [get_bd_pins axi_ad9361/adc_valid_i0] \
  [get_bd_pins rx_fir_decimator/valid_in_0]
  connect_bd_net -net axi_ad9361_adc_valid_q0  [get_bd_pins axi_ad9361/adc_valid_q0] \
  [get_bd_pins rx_fir_decimator/valid_in_1]
  connect_bd_net -net axi_ad9361_dac_dma_irq  [get_bd_pins axi_ad9361_dac_dma/irq] \
  [get_bd_pins sys_concat_intc/In3]
  connect_bd_net -net axi_ad9361_dac_enable_i0  [get_bd_pins axi_ad9361/dac_enable_i0] \
  [get_bd_pins tx_fir_interpolator/dac_enable_0]
  connect_bd_net -net axi_ad9361_dac_enable_i1  [get_bd_pins axi_ad9361/dac_enable_i1] \
  [get_bd_pins tx_upack/enable_2]
  connect_bd_net -net axi_ad9361_dac_enable_q0  [get_bd_pins axi_ad9361/dac_enable_q0] \
  [get_bd_pins tx_fir_interpolator/dac_enable_1]
  connect_bd_net -net axi_ad9361_dac_enable_q1  [get_bd_pins axi_ad9361/dac_enable_q1] \
  [get_bd_pins tx_upack/enable_3]
  connect_bd_net -net axi_ad9361_dac_valid_i0  [get_bd_pins axi_ad9361/dac_valid_i0] \
  [get_bd_pins tx_fir_interpolator/dac_valid_0]
  connect_bd_net -net axi_ad9361_dac_valid_i1  [get_bd_pins axi_ad9361/dac_valid_i1] \
  [get_bd_pins logic_or/Op2]
  connect_bd_net -net axi_ad9361_dac_valid_q0  [get_bd_pins axi_ad9361/dac_valid_q0] \
  [get_bd_pins tx_fir_interpolator/dac_valid_1]
  connect_bd_net -net axi_ad9361_enable  [get_bd_pins axi_ad9361/enable] \
  [get_bd_ports enable]
  connect_bd_net -net axi_ad9361_l_clk  [get_bd_pins axi_ad9361/l_clk] \
  [get_bd_pins axi_ad9361/clk] \
  [get_bd_pins rx_fir_decimator/aclk] \
  [get_bd_pins cpack/clk] \
  [get_bd_pins tx_fir_interpolator/aclk] \
  [get_bd_pins tx_upack/clk] \
  [get_bd_pins axi_ad9361_adc_dma/fifo_wr_clk] \
  [get_bd_pins axi_ad9361_dac_dma/m_axis_aclk] \
  [get_bd_pins axi_tdd_0/clk] \
  [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net axi_ad9361_rst  [get_bd_pins axi_ad9361/rst] \
  [get_bd_pins cpack/reset] \
  [get_bd_pins tx_upack/reset] \
  [get_bd_pins logic_inv/Op1]
  connect_bd_net -net axi_ad9361_tx_clk_out_n  [get_bd_pins axi_ad9361/tx_clk_out_n] \
  [get_bd_ports tx_clk_out_n]
  connect_bd_net -net axi_ad9361_tx_clk_out_p  [get_bd_pins axi_ad9361/tx_clk_out_p] \
  [get_bd_ports tx_clk_out_p]
  connect_bd_net -net axi_ad9361_tx_data_out_n  [get_bd_pins axi_ad9361/tx_data_out_n] \
  [get_bd_ports tx_data_out_n]
  connect_bd_net -net axi_ad9361_tx_data_out_p  [get_bd_pins axi_ad9361/tx_data_out_p] \
  [get_bd_ports tx_data_out_p]
  connect_bd_net -net axi_ad9361_tx_frame_out_n  [get_bd_pins axi_ad9361/tx_frame_out_n] \
  [get_bd_ports tx_frame_out_n]
  connect_bd_net -net axi_ad9361_tx_frame_out_p  [get_bd_pins axi_ad9361/tx_frame_out_p] \
  [get_bd_ports tx_frame_out_p]
  connect_bd_net -net axi_ad9361_txnrx  [get_bd_pins axi_ad9361/txnrx] \
  [get_bd_ports txnrx]
  connect_bd_net -net axi_ad9361_up_adc_gpio_out  [get_bd_pins axi_ad9361/up_adc_gpio_out] \
  [get_bd_pins decim_slice/Din]
  connect_bd_net -net axi_ad9361_up_dac_gpio_out  [get_bd_pins axi_ad9361/up_dac_gpio_out] \
  [get_bd_pins interp_slice/Din]
  connect_bd_net -net axi_iic_exp_iic2intc_irpt  [get_bd_pins axi_iic_exp/iic2intc_irpt] \
  [get_bd_pins sys_concat_intc/In0]
  connect_bd_net -net axi_spi_io0_o  [get_bd_pins axi_spi/io0_o] \
  [get_bd_ports clk_dac_spi_io0_o]
  connect_bd_net -net axi_spi_io0_t  [get_bd_pins axi_spi/io0_t] \
  [get_bd_ports clk_dac_spi_io0_t]
  connect_bd_net -net axi_spi_ip2intc_irpt  [get_bd_pins axi_spi/ip2intc_irpt] \
  [get_bd_pins sys_concat_intc/In1]
  connect_bd_net -net axi_spi_sck_o  [get_bd_pins axi_spi/sck_o] \
  [get_bd_ports clk_dac_spi_sck_o]
  connect_bd_net -net axi_spi_sck_t  [get_bd_pins axi_spi/sck_t] \
  [get_bd_ports clk_dac_spi_sck_t]
  connect_bd_net -net axi_spi_ss_o  [get_bd_pins axi_spi/ss_o] \
  [get_bd_ports clk_dac_spi_ss_o]
  connect_bd_net -net axi_spi_ss_t  [get_bd_pins axi_spi/ss_t] \
  [get_bd_ports clk_dac_spi_ss_t]
  connect_bd_net -net axi_tdd_0_tdd_channel_0  [get_bd_pins axi_tdd_0/tdd_channel_0] \
  [get_bd_ports txdata_o]
  connect_bd_net -net axi_tdd_0_tdd_channel_1  [get_bd_pins axi_tdd_0/tdd_channel_1] \
  [get_bd_pins axi_ad9361_adc_dma/sync]
  connect_bd_net -net axi_tdd_0_tdd_channel_2  [get_bd_pins axi_tdd_0/tdd_channel_2] \
  [get_bd_pins axi_ad9361_dac_dma/sync]
  connect_bd_net -net clk_40m_fpga_1  [get_bd_ports clk_40m_fpga] \
  [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net clk_dac_spi_io0_i_1  [get_bd_ports clk_dac_spi_io0_i] \
  [get_bd_pins axi_spi/io0_i]
  connect_bd_net -net clk_dac_spi_sck_i_1  [get_bd_ports clk_dac_spi_sck_i] \
  [get_bd_pins axi_spi/sck_i]
  connect_bd_net -net clk_dac_spi_ss_i_1  [get_bd_ports clk_dac_spi_ss_i] \
  [get_bd_pins axi_spi/ss_i]
  connect_bd_net -net clkin_10mhz_1  [get_bd_ports clkin_10mhz] \
  [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net cpack_fifo_wr_overflow  [get_bd_pins cpack/fifo_wr_overflow] \
  [get_bd_pins axi_ad9361/adc_dovf]
  connect_bd_net -net gpio_i_1  [get_bd_ports gpio_i] \
  [get_bd_pins sys_ps7/GPIO_I]
  connect_bd_net -net hier_video_interrupt  [get_bd_pins hier_video/dma_irq] \
  [get_bd_pins sys_concat_intc/In5]
  connect_bd_net -net hier_video_irq  [get_bd_pins hier_video/vtc_irq] \
  [get_bd_pins sys_concat_intc/In4]
  connect_bd_net -net logic_inv_Res  [get_bd_pins logic_inv/Res] \
  [get_bd_pins axi_tdd_0/resetn]
  connect_bd_net -net logic_or_Res  [get_bd_pins logic_or/Res] \
  [get_bd_pins tx_upack/fifo_rd_en]
  connect_bd_net -net mdm_1_Debug_SYS_Rst  [get_bd_pins mdm_1/Debug_SYS_Rst] \
  [get_bd_pins sys_rstgen/mb_debug_sys_rst]
  connect_bd_net -net rx_clk_in_n_1  [get_bd_ports rx_clk_in_n] \
  [get_bd_pins axi_ad9361/rx_clk_in_n]
  connect_bd_net -net rx_clk_in_p_1  [get_bd_ports rx_clk_in_p] \
  [get_bd_pins axi_ad9361/rx_clk_in_p]
  connect_bd_net -net rx_data_in_n_1  [get_bd_ports rx_data_in_n] \
  [get_bd_pins axi_ad9361/rx_data_in_n]
  connect_bd_net -net rx_data_in_p_1  [get_bd_ports rx_data_in_p] \
  [get_bd_pins axi_ad9361/rx_data_in_p]
  connect_bd_net -net rx_fir_decimator_data_out_0  [get_bd_pins rx_fir_decimator/data_out_0] \
  [get_bd_pins cpack/fifo_wr_data_0]
  connect_bd_net -net rx_fir_decimator_data_out_1  [get_bd_pins rx_fir_decimator/data_out_1] \
  [get_bd_pins cpack/fifo_wr_data_1]
  connect_bd_net -net rx_fir_decimator_enable_out_0  [get_bd_pins rx_fir_decimator/enable_out_0] \
  [get_bd_pins cpack/enable_0]
  connect_bd_net -net rx_fir_decimator_enable_out_1  [get_bd_pins rx_fir_decimator/enable_out_1] \
  [get_bd_pins cpack/enable_1]
  connect_bd_net -net rx_fir_decimator_valid_out_0  [get_bd_pins rx_fir_decimator/valid_out_0] \
  [get_bd_pins cpack/fifo_wr_en]
  connect_bd_net -net rx_frame_in_n_1  [get_bd_ports rx_frame_in_n] \
  [get_bd_pins axi_ad9361/rx_frame_in_n]
  connect_bd_net -net rx_frame_in_p_1  [get_bd_ports rx_frame_in_p] \
  [get_bd_pins axi_ad9361/rx_frame_in_p]
  connect_bd_net -net spi0_clk_i_1  [get_bd_ports spi0_clk_i] \
  [get_bd_pins sys_ps7/SPI0_SCLK_I]
  connect_bd_net -net spi0_csn_i_1  [get_bd_ports spi0_csn_i] \
  [get_bd_pins sys_ps7/SPI0_SS_I]
  connect_bd_net -net spi0_sdi_i_1  [get_bd_ports spi0_sdi_i] \
  [get_bd_pins sys_ps7/SPI0_MISO_I]
  connect_bd_net -net spi0_sdo_i_1  [get_bd_ports spi0_sdo_i] \
  [get_bd_pins sys_ps7/SPI0_MOSI_I]
  connect_bd_net -net sync_in_1  [get_bd_ports tdd_ext_sync] \
  [get_bd_pins axi_tdd_0/sync_in]
  connect_bd_net -net sys_200m_clk  [get_bd_pins sys_ps7/FCLK_CLK1] \
  [get_bd_pins axi_ad9361/delay_clk]
  connect_bd_net -net sys_concat_intc_dout  [get_bd_pins sys_concat_intc/dout] \
  [get_bd_pins sys_ps7/IRQ_F2P]
  connect_bd_net -net sys_cpu_clk  [get_bd_pins sys_ps7/FCLK_CLK0] \
  [get_bd_pins sys_rstgen/slowest_sync_clk] \
  [get_bd_pins axi_spi/ext_spi_clk] \
  [get_bd_pins axi_gp0_interconnect/ACLK] \
  [get_bd_pins axi_gp0_interconnect/S00_ACLK] \
  [get_bd_pins sys_ps7/M_AXI_GP0_ACLK] \
  [get_bd_pins axi_gp0_interconnect/M00_ACLK] \
  [get_bd_pins axi_iic_exp/s_axi_aclk] \
  [get_bd_pins hier_microblaze_0/Clk] \
  [get_bd_pins axi_gp0_interconnect/M01_ACLK] \
  [get_bd_pins axi_ad9361/s_axi_aclk] \
  [get_bd_pins axi_gp0_interconnect/M02_ACLK] \
  [get_bd_pins axi_ad9361_adc_dma/s_axi_aclk] \
  [get_bd_pins axi_gp0_interconnect/M03_ACLK] \
  [get_bd_pins axi_ad9361_dac_dma/s_axi_aclk] \
  [get_bd_pins axi_gp0_interconnect/M04_ACLK] \
  [get_bd_pins axi_spi/s_axi_aclk] \
  [get_bd_pins axi_gp0_interconnect/M05_ACLK] \
  [get_bd_pins axi_tdd_0/s_axi_aclk] \
  [get_bd_pins axi_gp0_interconnect/M06_ACLK] \
  [get_bd_pins sys_ps7/S_AXI_HP1_ACLK] \
  [get_bd_pins sys_ps7/S_AXI_HP2_ACLK] \
  [get_bd_pins axi_ad9361_dac_dma/m_src_axi_aclk] \
  [get_bd_pins axi_ad9361_adc_dma/m_dest_axi_aclk] \
  [get_bd_pins hier_video/ACLK] \
  [get_bd_pins axi_gp0_interconnect/M07_ACLK] \
  [get_bd_pins sys_ps7/S_AXI_HP3_ACLK] \
  [get_bd_pins app_logic_0/clk]
  connect_bd_net -net sys_cpu_reset  [get_bd_pins sys_rstgen/peripheral_reset]
  connect_bd_net -net sys_cpu_resetn  [get_bd_pins sys_rstgen/peripheral_aresetn] \
  [get_bd_pins axi_gp0_interconnect/ARESETN] \
  [get_bd_pins axi_gp0_interconnect/S00_ARESETN] \
  [get_bd_pins axi_gp0_interconnect/M00_ARESETN] \
  [get_bd_pins axi_iic_exp/s_axi_aresetn] \
  [get_bd_pins hier_microblaze_0/aresetn] \
  [get_bd_pins axi_gp0_interconnect/M01_ARESETN] \
  [get_bd_pins axi_ad9361/s_axi_aresetn] \
  [get_bd_pins axi_gp0_interconnect/M02_ARESETN] \
  [get_bd_pins axi_ad9361_adc_dma/s_axi_aresetn] \
  [get_bd_pins axi_gp0_interconnect/M03_ARESETN] \
  [get_bd_pins axi_ad9361_dac_dma/s_axi_aresetn] \
  [get_bd_pins axi_gp0_interconnect/M04_ARESETN] \
  [get_bd_pins axi_spi/s_axi_aresetn] \
  [get_bd_pins axi_gp0_interconnect/M05_ARESETN] \
  [get_bd_pins axi_tdd_0/s_axi_aresetn] \
  [get_bd_pins axi_gp0_interconnect/M06_ARESETN] \
  [get_bd_pins axi_ad9361_adc_dma/m_dest_axi_aresetn] \
  [get_bd_pins axi_ad9361_dac_dma/m_src_axi_aresetn] \
  [get_bd_pins axi_gp0_interconnect/M07_ARESETN] \
  [get_bd_pins hier_video/ARESETN] \
  [get_bd_pins app_logic_0/rstn]
  connect_bd_net -net sys_ps7_FCLK_RESET0_N  [get_bd_pins sys_ps7/FCLK_RESET0_N] \
  [get_bd_pins sys_rstgen/ext_reset_in]
  connect_bd_net -net sys_ps7_GPIO_O  [get_bd_pins sys_ps7/GPIO_O] \
  [get_bd_ports gpio_o]
  connect_bd_net -net sys_ps7_GPIO_T  [get_bd_pins sys_ps7/GPIO_T] \
  [get_bd_ports gpio_t]
  connect_bd_net -net sys_ps7_SPI0_MOSI_O  [get_bd_pins sys_ps7/SPI0_MOSI_O] \
  [get_bd_ports spi0_sdo_o]
  connect_bd_net -net sys_ps7_SPI0_SCLK_O  [get_bd_pins sys_ps7/SPI0_SCLK_O] \
  [get_bd_ports spi0_clk_o]
  connect_bd_net -net sys_ps7_SPI0_SS1_O  [get_bd_pins sys_ps7/SPI0_SS1_O] \
  [get_bd_ports spi0_csn_1_o]
  connect_bd_net -net sys_ps7_SPI0_SS2_O  [get_bd_pins sys_ps7/SPI0_SS2_O] \
  [get_bd_ports spi0_csn_2_o]
  connect_bd_net -net sys_ps7_SPI0_SS_O  [get_bd_pins sys_ps7/SPI0_SS_O] \
  [get_bd_ports spi0_csn_0_o]
  connect_bd_net -net sys_rstgen_bus_struct_reset  [get_bd_pins sys_rstgen/bus_struct_reset] \
  [get_bd_pins hier_microblaze_0/SYS_Rst]
  connect_bd_net -net sys_rstgen_mb_reset  [get_bd_pins sys_rstgen/mb_reset] \
  [get_bd_pins hier_microblaze_0/Reset]
  connect_bd_net -net tx_fir_interpolator_data_out_0  [get_bd_pins tx_fir_interpolator/data_out_0] \
  [get_bd_pins axi_ad9361/dac_data_i0]
  connect_bd_net -net tx_fir_interpolator_data_out_1  [get_bd_pins tx_fir_interpolator/data_out_1] \
  [get_bd_pins axi_ad9361/dac_data_q0]
  connect_bd_net -net tx_fir_interpolator_enable_out_0  [get_bd_pins tx_fir_interpolator/enable_out_0] \
  [get_bd_pins tx_upack/enable_0]
  connect_bd_net -net tx_fir_interpolator_enable_out_1  [get_bd_pins tx_fir_interpolator/enable_out_1] \
  [get_bd_pins tx_upack/enable_1]
  connect_bd_net -net tx_fir_interpolator_valid_out_0  [get_bd_pins tx_fir_interpolator/valid_out_0] \
  [get_bd_pins logic_or/Op1]
  connect_bd_net -net tx_upack_fifo_rd_data_0  [get_bd_pins tx_upack/fifo_rd_data_0] \
  [get_bd_pins tx_fir_interpolator/data_in_0]
  connect_bd_net -net tx_upack_fifo_rd_data_1  [get_bd_pins tx_upack/fifo_rd_data_1] \
  [get_bd_pins tx_fir_interpolator/data_in_1]
  connect_bd_net -net tx_upack_fifo_rd_data_2  [get_bd_pins tx_upack/fifo_rd_data_2] \
  [get_bd_pins axi_ad9361/dac_data_i1]
  connect_bd_net -net tx_upack_fifo_rd_data_3  [get_bd_pins tx_upack/fifo_rd_data_3] \
  [get_bd_pins axi_ad9361/dac_data_q1]
  connect_bd_net -net tx_upack_fifo_rd_underflow  [get_bd_pins tx_upack/fifo_rd_underflow] \
  [get_bd_pins axi_ad9361/dac_dunf]
  connect_bd_net -net up_enable_1  [get_bd_ports up_enable] \
  [get_bd_pins axi_ad9361/up_enable]
  connect_bd_net -net up_txnrx_1  [get_bd_ports up_txnrx] \
  [get_bd_pins axi_ad9361/up_txnrx]
  connect_bd_net -net xlconcat_0_dout  [get_bd_pins xlconcat_0/dout] \
  [get_bd_pins app_logic_0/board_clocks]

  # Create address segments
  assign_bd_address -offset 0x40000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs app_logic_0/s_axil/reg0] -force
  assign_bd_address -offset 0x79020000 -range 0x00010000 -with_name SEG_data_axi_ad9361 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361/s_axi/axi_lite] -force
  assign_bd_address -offset 0x7C400000 -range 0x00001000 -with_name SEG_data_axi_ad9361_adc_dma -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_adc_dma/s_axi/axi_lite] -force
  assign_bd_address -offset 0x7C420000 -range 0x00001000 -with_name SEG_data_axi_ad9361_dac_dma -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_dac_dma/s_axi/axi_lite] -force
  assign_bd_address -offset 0x41600000 -range 0x00001000 -with_name SEG_data_axi_iic_exp -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_iic_exp/S_AXI/Reg] -force
  assign_bd_address -offset 0x7C430000 -range 0x00001000 -with_name SEG_data_axi_spi -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_spi/AXI_LITE/Reg] -force
  assign_bd_address -offset 0x7C440000 -range 0x00001000 -with_name SEG_data_axi_tdd_0 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_tdd_0/tdd_core/s_axi/axi_lite] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs hier_video/hls_ip_reset/S_AXI/Reg] -force
  assign_bd_address -offset 0x43C10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs hier_video/v_frmbuf_rd_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_ad9361_dac_dma/m_src_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_ad9361_adc_dma/m_dest_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x00004000 -target_address_space [get_bd_addr_spaces hier_microblaze_0/microblaze_riscv_0/Data] [get_bd_addr_segs hier_microblaze_0/microblaze_riscv_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces hier_microblaze_0/microblaze_riscv_0/Data] [get_bd_addr_segs hier_microblaze_0/microblaze_riscv_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00004000 -target_address_space [get_bd_addr_spaces hier_microblaze_0/microblaze_riscv_0/Instruction] [get_bd_addr_segs hier_microblaze_0/microblaze_riscv_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces hier_video/v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] -force
# end of Vivado-generated code
