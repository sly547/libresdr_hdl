  
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

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.* v_tc_0 ]
  set_property -dict [list \
    CONFIG.GEN_FIELDID_EN {true} \
    CONFIG.HAS_INTC_IF {false} \
    CONFIG.INTERLACE_EN {true} \
    CONFIG.active_chroma_generation {false} \
    CONFIG.enable_detection {false} \
    CONFIG.max_clocks_per_line {1024} \
    CONFIG.max_lines_per_frame {1024} \
  ] $v_tc_0


  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.* v_axi4s_vid_out_0 ]
  set_property CONFIG.C_HAS_ASYNC_CLK {0} $v_axi4s_vid_out_0


  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.* ila_0 ]
  set_property -dict [list \
    CONFIG.C_MONITOR_TYPE {Native} \
    CONFIG.C_NUM_OF_PROBES {14} \
    CONFIG.C_PROBE10_WIDTH {2} \
    CONFIG.C_PROBE12_WIDTH {1} \
    CONFIG.C_PROBE1_TYPE {1} \
    CONFIG.C_PROBE1_WIDTH {24} \
    CONFIG.C_PROBE7_TYPE {1} \
    CONFIG.C_PROBE8_TYPE {0} \
    CONFIG.C_PROBE9_TYPE {0} \
  ] $ila_0


  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.* system_ila_0 ]
  set_property -dict [list \
    CONFIG.C_DATA_DEPTH {1024} \
    CONFIG.C_NUM_MONITOR_SLOTS {3} \
    CONFIG.C_SLOT {1} \
    CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
    CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:video_timing_rtl:2.0} \
    CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:video_timing_rtl:2.0} \
  ] $system_ila_0


  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.* axi_interconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {3} \
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


  # Create instance: ilconcat_0, and set properties
  set ilconcat_0 [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconcat:1.* ilconcat_0 ]
  set_property CONFIG.NUM_PORTS {2} $ilconcat_0


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins S00_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins axi_protocol_convert_0/M_AXI] [get_bd_intf_pins M_AXI]
  connect_bd_intf_net -intf_net axi_clock_converter_0_M_AXI [get_bd_intf_pins axi_clock_converter_0/M_AXI] [get_bd_intf_pins axi_protocol_convert_0/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins v_frmbuf_rd_0/s_axi_CTRL] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins v_tc_0/ctrl] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axi_interconnect_0_M01_AXI] [get_bd_intf_pins v_tc_0/ctrl] [get_bd_intf_pins system_ila_0/SLOT_2_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins hls_ip_reset/S_AXI]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axi_mm_video [get_bd_intf_pins axi_clock_converter_0/S_AXI] [get_bd_intf_pins v_frmbuf_rd_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axis_video [get_bd_intf_pins v_frmbuf_rd_0/m_axis_video] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
  connect_bd_intf_net -intf_net [get_bd_intf_nets v_frmbuf_rd_0_m_axis_video] [get_bd_intf_pins v_frmbuf_rd_0/m_axis_video] [get_bd_intf_pins system_ila_0/SLOT_0_AXIS]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_tc_0/vtiming_out] [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in]
  connect_bd_intf_net -intf_net [get_bd_intf_nets v_tc_0_vtiming_out] [get_bd_intf_pins v_tc_0/vtiming_out] [get_bd_intf_pins system_ila_0/SLOT_1_VIDEO_TIMING]

  # Create port connections
  connect_bd_net -net Net  [get_bd_pins proc_sys_reset_0/peripheral_aresetn] \
  [get_bd_pins system_ila_0/resetn] \
  [get_bd_pins v_tc_0/s_axi_aresetn] \
  [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net clk_in1_1  [get_bd_pins ACLK] \
  [get_bd_pins axi_interconnect_0/S00_ACLK] \
  [get_bd_pins axi_interconnect_0/ACLK] \
  [get_bd_pins axi_clock_converter_0/m_axi_aclk] \
  [get_bd_pins axi_protocol_convert_0/aclk]
  connect_bd_net -net clk_wiz_0_clk_out1  [get_bd_pins video_clk] \
  [get_bd_pins axi_interconnect_0/M00_ACLK] \
  [get_bd_pins axi_interconnect_0/M01_ACLK] \
  [get_bd_pins v_tc_0/clk] \
  [get_bd_pins v_tc_0/s_axi_aclk] \
  [get_bd_pins v_axi4s_vid_out_0/aclk] \
  [get_bd_pins ila_0/clk] \
  [get_bd_pins proc_sys_reset_0/slowest_sync_clk] \
  [get_bd_pins system_ila_0/clk] \
  [get_bd_pins hls_ip_reset/s_axi_aclk] \
  [get_bd_pins axi_interconnect_0/M02_ACLK] \
  [get_bd_pins v_frmbuf_rd_0/ap_clk] \
  [get_bd_pins axi_clock_converter_0/s_axi_aclk]
  connect_bd_net -net ext_reset_in_1  [get_bd_pins ARESETN] \
  [get_bd_pins axi_interconnect_0/S00_ARESETN] \
  [get_bd_pins axi_interconnect_0/ARESETN] \
  [get_bd_pins axi_clock_converter_0/m_axi_aresetn] \
  [get_bd_pins axi_protocol_convert_0/aresetn]
  connect_bd_net -net ext_reset_in_2  [get_bd_pins ext_reset_in] \
  [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net hls_ip_reset_gpio_io_o  [get_bd_pins ilslice_0/Dout] \
  [get_bd_pins v_axi4s_vid_out_0/aresetn] \
  [get_bd_pins v_frmbuf_rd_0/ap_rst_n]
  connect_bd_net -net hls_ip_reset_gpio_io_o1  [get_bd_pins hls_ip_reset/gpio_io_o] \
  [get_bd_pins ilslice_0/Din]
  connect_bd_net -net ilconcat_0_dout  [get_bd_pins ilconcat_0/dout] \
  [get_bd_pins ila_0/probe10]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn  [get_bd_pins proc_sys_reset_0/interconnect_aresetn] \
  [get_bd_pins axi_interconnect_0/M00_ARESETN] \
  [get_bd_pins axi_interconnect_0/M01_ARESETN] \
  [get_bd_pins hls_ip_reset/s_axi_aresetn] \
  [get_bd_pins axi_interconnect_0/M02_ARESETN] \
  [get_bd_pins axi_clock_converter_0/s_axi_aresetn]
  connect_bd_net -net v_axi4s_vid_out_0_locked  [get_bd_pins v_axi4s_vid_out_0/locked] \
  [get_bd_pins ila_0/probe7]
  connect_bd_net -net v_axi4s_vid_out_0_overflow  [get_bd_pins v_axi4s_vid_out_0/overflow] \
  [get_bd_pins ila_0/probe8]
  connect_bd_net -net v_axi4s_vid_out_0_underflow  [get_bd_pins v_axi4s_vid_out_0/underflow] \
  [get_bd_pins ila_0/probe9]
  connect_bd_net -net v_axi4s_vid_out_0_vid_active_video  [get_bd_pins v_axi4s_vid_out_0/vid_active_video] \
  [get_bd_pins ila_0/probe0]
  connect_bd_net -net v_axi4s_vid_out_0_vid_data  [get_bd_pins v_axi4s_vid_out_0/vid_data] \
  [get_bd_pins ila_0/probe1]
  connect_bd_net -net v_axi4s_vid_out_0_vid_field_id  [get_bd_pins v_axi4s_vid_out_0/vid_field_id] \
  [get_bd_pins ila_0/probe2]
  connect_bd_net -net v_axi4s_vid_out_0_vid_hblank  [get_bd_pins v_axi4s_vid_out_0/vid_hblank] \
  [get_bd_pins ila_0/probe3]
  connect_bd_net -net v_axi4s_vid_out_0_vid_hsync  [get_bd_pins v_axi4s_vid_out_0/vid_hsync] \
  [get_bd_pins ila_0/probe4]
  connect_bd_net -net v_axi4s_vid_out_0_vid_vblank  [get_bd_pins v_axi4s_vid_out_0/vid_vblank] \
  [get_bd_pins ila_0/probe5]
  connect_bd_net -net v_axi4s_vid_out_0_vid_vsync  [get_bd_pins v_axi4s_vid_out_0/vid_vsync] \
  [get_bd_pins ila_0/probe6]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce  [get_bd_pins v_axi4s_vid_out_0/vtg_ce] \
  [get_bd_pins v_tc_0/gen_clken] \
  [get_bd_pins ila_0/probe13]
  connect_bd_net -net v_frmbuf_rd_0_field_id  [get_bd_pins v_frmbuf_rd_0/field_id] \
  [get_bd_pins v_axi4s_vid_out_0/fid] \
  [get_bd_pins ila_0/probe11]
  connect_bd_net -net v_frmbuf_rd_0_interrupt  [get_bd_pins v_frmbuf_rd_0/interrupt] \
  [get_bd_pins dma_irq] \
  [get_bd_pins ilconcat_0/In1]
  connect_bd_net -net v_tc_0_fsync_out  [get_bd_pins v_tc_0/fsync_out] \
  [get_bd_pins ila_0/probe12]
  connect_bd_net -net v_tc_0_irq  [get_bd_pins v_tc_0/irq] \
  [get_bd_pins vtc_irq] \
  [get_bd_pins ilconcat_0/In0]

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
