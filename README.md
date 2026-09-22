## what's this

It seemed like a good idea to collect the programmable logic stuff for the LibreSDR in its own repo. It is part of my personal repo for this device, to serve as a platform for experimentation and implementing ideas.

## Folder structure

Rough overview:

- adi-hdl/ is a submodule from Analog Devices. It provides IP for the AD9361 and PlutoSDR ecosystem as well as the Vivado build scripts.
- cores/ is where additional HDL can be placed and developed
- desy_vhdl/ is a submodule with useful VHDL code from the MSK firmware group at DESY
- ip_repo/ is where generated IP for Vivado block designs is placed (not checked into Git!)
- projects/ contains Vivado projects
    - libre/ is the LibreSDR project. It has project-specific HDL, constraints and Tcl scripts. The Vivado project is also created in here (but not checked into Git). 
    - cores/ is where temporary IP creation projects are created. They can be reopened for manually repackaging the IP after changes.
- scripts/ is for code that supports the build flow

## How to build

There is a Makefile in projects/libre/.

1. source the Vivado environment (tested: 2025.2)
2. `cd projects/libre`
3. `make`

## Issues

- missing .gitignore
- missing separation of Vivado project files and the source code and scripts

## TODO

- Remove `axi_iic_exp` from the PL design. Use a PS-internal I2C controller (`CONFIG.PCW_I2C0_PERIPHERAL_ENABLE`) through EMIO for the PL-attached "exp_iic" interface and use this for the AT24C02D. It could store a custom MAC address, for example.
