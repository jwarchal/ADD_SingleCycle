-- Generation properties:
--   Format              : hierarchical
--   Generic mappings    : exclude
--   Leaf-level entities : direct binding
--   Regular libraries   : use library name
--   View name           : include
--   
LIBRARY ADD_SingleCycle_lib;
CONFIGURATION Hookup2_struct_config OF Hookup2 IS
   FOR struct
      FOR ALL : ControlUnit
         USE ENTITY ADD_SingleCycle_lib.ControlUnit(Behavior);
      END FOR;
      FOR ALL : Extendblock
         USE ENTITY ADD_SingleCycle_lib.Extendblock(Extendblockarch);
      END FOR;
      FOR ALL : Increment
         USE ENTITY ADD_SingleCycle_lib.Increment(Incrementarch);
      END FOR;
      FOR ALL : PC
         USE ENTITY ADD_SingleCycle_lib.PC(PCarch);
      END FOR;
      FOR ALL : RegisterFile
         USE ENTITY ADD_SingleCycle_lib.RegisterFile(Behavior);
      END FOR;
      FOR ALL : alu
         USE ENTITY ADD_SingleCycle_lib.alu(aluarch);
      END FOR;
      FOR ALL : easy_RAM_simu
         USE ENTITY ADD_SingleCycle_lib.easy_RAM_simu(behavior);
      END FOR;
      FOR ALL : mux2to1
         USE ENTITY ADD_SingleCycle_lib.mux2to1(mux2to1arch);
      END FOR;
      FOR ALL : mux4to1
         USE ENTITY ADD_SingleCycle_lib.mux4to1(mux4to1arch);
      END FOR;
   END FOR;
END Hookup2_struct_config;
