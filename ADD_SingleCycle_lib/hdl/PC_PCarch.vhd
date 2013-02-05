--
-- VHDL Architecture ADD_SingleCycle_lib.PC.PCarch
--
-- Created:
--          by - Vincent.UNKNOWN (VINCENT-LAPTOP)
--          at - 15:34:46 02/ 5/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY PC IS
  PORT(a: IN std_logic_vector(15 DOWNTO 0);
    b: OUT std_logic_vector(15 DOWNTO 0);
    c,e: IN std_logic);
END ENTITY PC;

--
ARCHITECTURE PCarch OF PC IS
BEGIN
  PROCESS(c)
  BEGIN
    IF(rising_edge(c) AND (e = '1'))THEN
      b <= a;
    END IF;
  END PROCESS;
END ARCHITECTURE PCarch;

