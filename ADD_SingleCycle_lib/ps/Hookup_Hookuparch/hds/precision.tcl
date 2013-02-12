## SETUP
puts "Info: HDL Designer Synthesis run started"

## Set current project and folder
if {[string length [info commands new_project]]} {
   new_project -name Hookup_Hookuparch -folder "C:/Users/Vincent/Documents/GitHub/ADD_SingleCycle/ADD_SingleCycle_lib/ps/Hookup_Hookuparch"
} else {
   set_working_dir "C:/Users/Vincent/Documents/GitHub/ADD_SingleCycle/ADD_SingleCycle_lib/ps/Hookup_Hookuparch"
}

## Implementation settings
MGS_Gui::notify_gui lock
setup_design -manufacturer "Altera" -family "Cyclone II" -part "EP2C35F672C" -speed "6" 

## Design Settings
setup_design -addio=true
setup_design -safe_fsm_type=none
setup_design -retiming=false
if {[catch {setup_design -2004c_compile_mode=false}]} {
catch {setup_design -frontend_2004=false}
}

setup_design -vhdl=false
setup_design -verilog=false
setup_design -edif=true

## Read in source files
catch {source "C:/Users/Vincent/Documents/GitHub/ADD_SingleCycle/ADD_SingleCycle_lib/ps/Hookup_Hookuparch/hds/add_files.tcl"}
MGS_Gui::notify_gui unlock

## Compile & Synthesize
MGS_Gui::notify_gui lock
if {[catch compile]} {
   MGS_Gui::notify_gui unlock
} elseif {[catch synthesize]} {
   MGS_Gui::notify_gui unlock
} else {
   MGS_Gui::notify_gui unlock
}

puts "Info: HDL Designer Synthesis run finished"


