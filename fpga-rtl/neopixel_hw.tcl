# TCL File Generated by Component Editor 17.0
# Tue May 30 21:54:37 CEST 2017
# DO NOT MODIFY


# 
# neopixel "neopixel" v1.0
#  2017.05.30.21:54:37
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module neopixel
# 
set_module_property DESCRIPTION ""
set_module_property NAME neopixel
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME neopixel
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL neopixel
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file neopixel.v VERILOG PATH neopixel.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter NUMBER_OF_NEOPIXEL INTEGER 7
set_parameter_property NUMBER_OF_NEOPIXEL DEFAULT_VALUE 7
set_parameter_property NUMBER_OF_NEOPIXEL DISPLAY_NAME NUMBER_OF_NEOPIXEL
set_parameter_property NUMBER_OF_NEOPIXEL TYPE INTEGER
set_parameter_property NUMBER_OF_NEOPIXEL UNITS None
set_parameter_property NUMBER_OF_NEOPIXEL HDL_PARAMETER true
add_parameter SIZE INTEGER 4
set_parameter_property SIZE DEFAULT_VALUE 4
set_parameter_property SIZE DISPLAY_NAME SIZE
set_parameter_property SIZE TYPE INTEGER
set_parameter_property SIZE UNITS None
set_parameter_property SIZE HDL_PARAMETER true
add_parameter SEND_0 INTEGER 0
set_parameter_property SEND_0 DEFAULT_VALUE 0
set_parameter_property SEND_0 DISPLAY_NAME SEND_0
set_parameter_property SEND_0 TYPE INTEGER
set_parameter_property SEND_0 UNITS None
set_parameter_property SEND_0 HDL_PARAMETER true
add_parameter SEND_1 INTEGER 1
set_parameter_property SEND_1 DEFAULT_VALUE 1
set_parameter_property SEND_1 DISPLAY_NAME SEND_1
set_parameter_property SEND_1 TYPE INTEGER
set_parameter_property SEND_1 UNITS None
set_parameter_property SEND_1 HDL_PARAMETER true
add_parameter LATCH INTEGER 2
set_parameter_property LATCH DEFAULT_VALUE 2
set_parameter_property LATCH DISPLAY_NAME LATCH
set_parameter_property LATCH TYPE INTEGER
set_parameter_property LATCH UNITS None
set_parameter_property LATCH HDL_PARAMETER true
add_parameter IDLE INTEGER 3
set_parameter_property IDLE DEFAULT_VALUE 3
set_parameter_property IDLE DISPLAY_NAME IDLE
set_parameter_property IDLE TYPE INTEGER
set_parameter_property IDLE UNITS None
set_parameter_property IDLE HDL_PARAMETER true


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock_sink
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock_sink
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 address address Input 6
add_interface_port avalon_slave_0 write write Input 1
add_interface_port avalon_slave_0 writedata writedata Input 32
add_interface_port avalon_slave_0 read read Input 1
add_interface_port avalon_slave_0 readdata readdata Output 32
add_interface_port avalon_slave_0 waitrequest waitrequest Output 1
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock_sink
set_interface_property conduit_end associatedReset reset
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end one_wire one_wire Output 1


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink clock clk Input 1
