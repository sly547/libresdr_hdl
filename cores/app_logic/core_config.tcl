# Vivado auto-infers this. Keep it anyway because it shows how to configure a core.
ipx::add_bus_parameter POLARITY [ipx::get_bus_interfaces rstn -of_objects $core]
set_property value ACTIVE_LOW [ipx::get_bus_parameters POLARITY -of_objects [ipx::get_bus_interfaces rstn -of_objects $core]]
ipx::add_bus_parameter POLARITY [ipx::get_bus_interfaces video_rstn -of_objects $core]
set_property value ACTIVE_LOW [ipx::get_bus_parameters POLARITY -of_objects [ipx::get_bus_interfaces video_rstn -of_objects $core]]

