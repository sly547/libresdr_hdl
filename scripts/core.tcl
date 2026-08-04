# based on https://github.com/pavel-demin/red-pitaya-notes/blob/20220322/scripts/core.tcl

set core_name [lindex $argv 0]
#set part_name [lindex $argv 1]
set part_name "xc7z020clg400-2"

puts "core_name: $core_name"
#create_project -part $part_name $core_name hdl/projects/cores
create_project -force -part $part_name $core_name ../../projects/cores/$core_name

source core_sources.tcl

ipx::package_project -root_dir ../../ip_repo/$core_name -vendor user.org -library user -taxonomy /UserIP -import_files

set core [ipx::current_core]

#set_property VERSION $version $core
set_property NAME $core_name $core
set_property LIBRARY {user} $core
set_property VENDOR {user.org} $core
#set_property VENDOR_DISPLAY_NAME {} $core
#set_property COMPANY_URL {} $core
#set_property SUPPORTED_FAMILIES {zynq Production} $core

source core_config.tcl

ipx::update_source_project_archive -component $core
ipx::create_xgui_files $core
ipx::update_checksums $core
ipx::check_integrity $core
ipx::save_core $core

close_project
