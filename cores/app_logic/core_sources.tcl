# Copyright (c) 2026 Michael Büchler
# SPDX-License-Identifier: MIT

# TODO make this pretty, like creating a list and then looping for each design library
add_files -norecurse {../../desy_vhdl/hdl/misc/clock/clock_freq.vhd ../../desy_vhdl/hdl/common/pkg_common_types.vhd}
set_property library desy [get_files  {../../desy_vhdl/hdl/misc/clock/clock_freq.vhd ../../desy_vhdl/hdl/common/pkg_common_types.vhd}]
add_files -norecurse {./regblock/app_logic_reg_pkg.sv ./src/app_logic.sv ./regblock/app_logic_reg.sv ../common/src/axi4lite_intf.sv}


