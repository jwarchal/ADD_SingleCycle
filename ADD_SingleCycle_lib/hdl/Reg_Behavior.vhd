--
-- VHDL Architecture ADD_SingleCycle_lib.Reg.Behavior
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 16:46:05 04/18/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Reg IS
  PORT ( a: IN std_logic_vector (63 DOWNTO 0);
         c: IN std_logic;
         b: OUT std_logic_vector (63 DOWNTO 0));
         
END ENTITY Reg;

--
ARCHITECTURE Behavior OF Reg IS
BEGIN
  PROCESS (c)
  BEGIN
    IF (rising_edge(c) ) THEN
      b <= a;
    END IF;
  END PROCESS;
END ARCHITECTURE Behavior;

