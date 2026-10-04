  
# Hierarchical cell: hier_video
proc create_hier_cell_hier_video { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_video() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI


  # Create pins
  create_bd_pin -dir O -type intr vtc_irq
  create_bd_pin -dir O -type intr dma_irq
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir I -type clk video_clk
  create_bd_pin -dir I clk_out
  create_bd_pin -dir O -from 15 -to 0 data_out_i
  create_bd_pin -dir O -from 15 -to 0 data_out_q

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.* ila_0 ]
  set_property -dict [list \
    CONFIG.C_MONITOR_TYPE {Native} \
    CONFIG.C_NUM_OF_PROBES {6} \
    CONFIG.C_PROBE10_WIDTH {1} \
    CONFIG.C_PROBE12_WIDTH {1} \
    CONFIG.C_PROBE1_TYPE {1} \
    CONFIG.C_PROBE1_WIDTH {12} \
    CONFIG.C_PROBE7_TYPE {1} \
    CONFIG.C_PROBE8_TYPE {0} \
    CONFIG.C_PROBE9_TYPE {0} \
  ] $ila_0


  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.* system_ila_0 ]
  set_property -dict [list \
    CONFIG.C_DATA_DEPTH {1024} \
    CONFIG.C_NUM_MONITOR_SLOTS {1} \
    CONFIG.C_SLOT {0} \
    CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
    CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:video_timing_rtl:2.0} \
    CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:video_timing_rtl:2.0} \
  ] $system_ila_0


  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.* axi_interconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {2} \
    CONFIG.NUM_SI {1} \
  ] $axi_interconnect_0


  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.* proc_sys_reset_0 ]

  # Create instance: hls_ip_reset, and set properties
  set hls_ip_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.* hls_ip_reset ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {2} \
  ] $hls_ip_reset


  # Create instance: axi_protocol_convert_0, and set properties
  set axi_protocol_convert_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.* axi_protocol_convert_0 ]

  # Create instance: v_frmbuf_rd_0, and set properties
  set v_frmbuf_rd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_rd:3.* v_frmbuf_rd_0 ]
  set_property -dict [list \
    CONFIG.HAS_BGR8 {1} \
    CONFIG.HAS_BGRX8 {1} \
    CONFIG.HAS_INTERLACED {1} \
    CONFIG.HAS_RGB8 {1} \
    CONFIG.HAS_RGBX8 {1} \
    CONFIG.MAX_COLS {1024} \
    CONFIG.MAX_ROWS {1024} \
    CONFIG.SAMPLES_PER_CLOCK {1} \
  ] $v_frmbuf_rd_0


  # Create instance: axi_clock_converter_0, and set properties
  set axi_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.* axi_clock_converter_0 ]

  # Create instance: ilslice_0, and set properties
  set ilslice_0 [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilslice:1.* ilslice_0 ]
  set_property CONFIG.DIN_WIDTH {2} $ilslice_0


  # Create instance: my_cvbs_encoder_0, and set properties
  set my_cvbs_encoder_0 [ create_bd_cell -type ip -vlnv user.org:user:my_cvbs_encoder:1.* my_cvbs_encoder_0 ]

  # Create instance: cvbs_to_sdr_0, and set properties
  set cvbs_to_sdr_0 [ create_bd_cell -type ip -vlnv user.org:user:cvbs_to_sdr:1.* cvbs_to_sdr_0 ]

  # Create instance: ilconstant_0, and set properties
  set ilconstant_0 [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant:1.* ilconstant_0 ]

  # Create instance: ila_1, and set properties
  set ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.* ila_1 ]
  set_property -dict [list \
    CONFIG.C_DATA_DEPTH {4096} \
    CONFIG.C_MONITOR_TYPE {Native} \
    CONFIG.C_NUM_OF_PROBES {2} \
    CONFIG.C_PROBE1_TYPE {1} \
    CONFIG.C_PROBE1_WIDTH {16} \
  ] $ila_1


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins S00_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins axi_protocol_convert_0/M_AXI] [get_bd_intf_pins M_AXI]
  connect_bd_intf_net -intf_net axi_clock_converter_0_M_AXI [get_bd_intf_pins axi_clock_converter_0/M_AXI] [get_bd_intf_pins axi_protocol_convert_0/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins v_frmbuf_rd_0/s_axi_CTRL] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins hls_ip_reset/S_AXI]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axi_mm_video [get_bd_intf_pins axi_clock_converter_0/S_AXI] [get_bd_intf_pins v_frmbuf_rd_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axis_video [get_bd_intf_pins v_frmbuf_rd_0/m_axis_video] [get_bd_intf_pins my_cvbs_encoder_0/s_axis]
  connect_bd_intf_net -intf_net [get_bd_intf_nets v_frmbuf_rd_0_m_axis_video] [get_bd_intf_pins v_frmbuf_rd_0/m_axis_video] [get_bd_intf_pins system_ila_0/SLOT_0_AXIS]

  # Create port connections
  connect_bd_net -net Net  [get_bd_pins proc_sys_reset_0/peripheral_aresetn] \
  [get_bd_pins system_ila_0/resetn]
  connect_bd_net -net clk_in1_1  [get_bd_pins ACLK] \
  [get_bd_pins axi_interconnect_0/S00_ACLK] \
  [get_bd_pins axi_interconnect_0/ACLK] \
  [get_bd_pins axi_clock_converter_0/m_axi_aclk] \
  [get_bd_pins axi_protocol_convert_0/aclk]
  connect_bd_net -net clk_out_1  [get_bd_pins clk_out] \
  [get_bd_pins ila_1/clk] \
  [get_bd_pins cvbs_to_sdr_0/clk_out]
  connect_bd_net -net clk_wiz_0_clk_out1  [get_bd_pins video_clk] \
  [get_bd_pins axi_interconnect_0/M00_ACLK] \
  [get_bd_pins axi_interconnect_0/M01_ACLK] \
  [get_bd_pins ila_0/clk] \
  [get_bd_pins proc_sys_reset_0/slowest_sync_clk] \
  [get_bd_pins system_ila_0/clk] \
  [get_bd_pins hls_ip_reset/s_axi_aclk] \
  [get_bd_pins v_frmbuf_rd_0/ap_clk] \
  [get_bd_pins axi_clock_converter_0/s_axi_aclk] \
  [get_bd_pins my_cvbs_encoder_0/aclk] \
  [get_bd_pins cvbs_to_sdr_0/clk_in]
  connect_bd_net -net cvbs_to_sdr_0_data_out_i  [get_bd_pins cvbs_to_sdr_0/data_out_i] \
  [get_bd_pins ila_1/probe1] \
  [get_bd_pins data_out_i]
  connect_bd_net -net cvbs_to_sdr_0_data_out_q  [get_bd_pins cvbs_to_sdr_0/data_out_q] \
  [get_bd_pins data_out_q]
  connect_bd_net -net cvbs_to_sdr_0_data_valid  [get_bd_pins cvbs_to_sdr_0/data_valid] \
  [get_bd_pins ila_1/probe0]
  connect_bd_net -net ext_reset_in_1  [get_bd_pins ARESETN] \
  [get_bd_pins axi_interconnect_0/S00_ARESETN] \
  [get_bd_pins axi_interconnect_0/ARESETN] \
  [get_bd_pins axi_clock_converter_0/m_axi_aresetn] \
  [get_bd_pins axi_protocol_convert_0/aresetn]
  connect_bd_net -net ext_reset_in_2  [get_bd_pins ext_reset_in] \
  [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net hls_ip_reset_gpio_io_o  [get_bd_pins ilslice_0/Dout] \
  [get_bd_pins v_frmbuf_rd_0/ap_rst_n]
  connect_bd_net -net hls_ip_reset_gpio_io_o1  [get_bd_pins hls_ip_reset/gpio_io_o] \
  [get_bd_pins ilslice_0/Din]
  connect_bd_net -net ilconstant_0_dout  [get_bd_pins ilconstant_0/dout] \
  [get_bd_pins cvbs_to_sdr_0/rst_out_n]
  connect_bd_net -net my_cvbs_encoder_0_po_cvbs  [get_bd_pins my_cvbs_encoder_0/po_cvbs] \
  [get_bd_pins ila_0/probe1] \
  [get_bd_pins cvbs_to_sdr_0/cvbs]
  connect_bd_net -net my_cvbs_encoder_0_po_hblank  [get_bd_pins my_cvbs_encoder_0/po_hblank] \
  [get_bd_pins ila_0/probe5] \
  [get_bd_pins cvbs_to_sdr_0/hblank]
  connect_bd_net -net my_cvbs_encoder_0_po_hsync  [get_bd_pins my_cvbs_encoder_0/po_hsync] \
  [get_bd_pins ila_0/probe4] \
  [get_bd_pins cvbs_to_sdr_0/hsync]
  connect_bd_net -net my_cvbs_encoder_0_po_vblank  [get_bd_pins my_cvbs_encoder_0/po_vblank] \
  [get_bd_pins ila_0/probe3] \
  [get_bd_pins cvbs_to_sdr_0/vblank]
  connect_bd_net -net my_cvbs_encoder_0_po_vsync  [get_bd_pins my_cvbs_encoder_0/po_vsync] \
  [get_bd_pins ila_0/probe2] \
  [get_bd_pins cvbs_to_sdr_0/vsync]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn  [get_bd_pins proc_sys_reset_0/interconnect_aresetn] \
  [get_bd_pins axi_interconnect_0/M00_ARESETN] \
  [get_bd_pins axi_interconnect_0/M01_ARESETN] \
  [get_bd_pins hls_ip_reset/s_axi_aresetn] \
  [get_bd_pins axi_clock_converter_0/s_axi_aresetn] \
  [get_bd_pins my_cvbs_encoder_0/aresetn]
  connect_bd_net -net v_frmbuf_rd_0_field_id  [get_bd_pins v_frmbuf_rd_0/field_id] \
  [get_bd_pins ila_0/probe0]
  connect_bd_net -net v_frmbuf_rd_0_interrupt  [get_bd_pins v_frmbuf_rd_0/interrupt] \
  [get_bd_pins dma_irq]

  # Restore current instance
  current_bd_instance $oldCurInst
}


proc available_tcl_procs { } {
   puts "##################################################################"
   puts "# Available Tcl procedures to recreate hierarchical blocks:"
   puts "#"
   puts "#    create_hier_cell_hier_video parentCell nameHier"
   puts "#"
   puts "##################################################################"
}

available_tcl_procs
