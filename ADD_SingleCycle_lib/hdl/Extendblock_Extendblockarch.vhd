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
    VARIABLE unsignedoffset: std_logic_vector(4 DOWNTO 0);
    VARIABLE signedoffset: std_logic_vector(7 DOWNTO 0);
    VARIABLE check: std_logic_vector(2 DOWNTO 0);
    VARIABLE temp_L, temp_R, temp_S: std_logic_vector(15 DOWNTO 0);
  BEGIN
    unsignedoffset := inst(4 DOWNTO 0);
    signedoffset := inst(7 DOWNTO 0);
    check := inst(15 DOWNTO 13);
    if (check = "010" or check = "011") then
      temp_L(4 DOWNTO 0) := unsignedoffset;
      temp_L(15 DOWNTO 5) := "00000000000";
      temp_R(15 DOWNTO 11) := signedoffset;
      temp_R(10 DOWNTO 0) := "00000000000";
      if (unsignedoffset(4) = '0') then
        temp_S(15 DOWNTO 5) := "00000000000";
        temp_S(4 DOWNTO 0) := unsignedoffset;
      else
        temp_S(15 DOWNTO 5) := "11111111111";
        temp_S(4 DOWNTO 0) := unsignedoffset;
      end if;
    else
      temp_L(7 DOWNTO 0) := unsignedoffset;
      temp_L(15 DOWNTO 8) := "00000000";
      temp_R(15 DOWNTO 8) := signedoffset;
      temp_R(7 DOWNTO 0) := "00000000";
      if (unsignedoffset(7) = '0') then
        temp_S(15 DOWNTO 8) := "00000000";
        temp_S(7 DOWNTO 0) := signedoffset;
      else
        temp_S(15 DOWNTO 8) := "11111111";
        temp_S(7 DOWNTO 0) := signedoffset;
      end if;
    end if;
    ZEXT_L <= temp_L;
    ZEXT_R <= temp_R;
    SEXT <= temp_S;
  END PROCESS;
END ARCHITECTURE Extendblockarch;

