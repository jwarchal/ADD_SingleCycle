--
-- VHDL Architecture ADD_SingleCycle_lib.Extendblock.Extendblockarch
--
-- Created:
--          by - Vincent.UNKNOWN (VINCENT-LAPTOP)
--          at - 14:17:08 02/12/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Extendblock IS
  PORT(inst: IN std_logic_vector(15 DOWNTO 0);
    ZEXT_L, ZEXT_R, SEXT: OUT std_logic_vector(15 DOWNTO 0));
END ENTITY Extendblock;

--
ARCHITECTURE Extendblockarch OF Extendblock IS
BEGIN
  PROCESS(inst)
  BEGIN
    ZEXT_L <= "00000000000" & inst(4 DOWNTO 0);
    ZEXT_R <= inst(7 DOWNTO 0) & "00000000";
    SEXT <= (15 DOWNTO 8 => inst(7)) & inst(7 DOWNTO 0);
  END PROCESS;
END ARCHITECTURE Extendblockarch;

