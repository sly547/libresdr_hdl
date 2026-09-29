# Copyright (c) 2026 Michael Büchler
# SPDX-License-Identifier: MIT

# Vivado auto-infers this. Keep it anyway because it shows how to configure a core.
ipx::add_bus_parameter POLARITY [ipx::get_bus_interfaces rstn -of_objects $core]
set_property value ACTIVE_LOW [ipx::get_bus_parameters POLARITY -of_objects [ipx::get_bus_interfaces rstn -of_objects $core]]
ipx::add_bus_parameter POLARITY [ipx::get_bus_interfaces video_rstn -of_objects $core]
set_property value ACTIVE_LOW [ipx::get_bus_parameters POLARITY -of_objects [ipx::get_bus_interfaces video_rstn -of_objects $core]]

# video_clk depends on the input clock, but the intended value is 13.5 MHz
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces video_clk -of_objects $core]
set_property value 13500000 [ipx::get_bus_parameters FREQ_HZ -of_objects [ipx::get_bus_interfaces video_clk -of_objects $core]]
