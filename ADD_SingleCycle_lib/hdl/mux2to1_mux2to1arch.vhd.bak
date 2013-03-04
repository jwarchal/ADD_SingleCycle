--
-- VHDL Architecture ADD_SingleCycle_lib.mux2to1.mux2to1arch
--
-- Created:
--          by - jwarchal.UNKNOWN (GURREN)
--          at - 13:17:06 02/ 4/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux2to1 IS
  GENERIC(size: POSITIVE := 16);
  PORT(a, b: IN std_logic_vector(size - 1 DOWNTO 0);
       o: OUT std_logic_vector(size - 1 DOWNTO 0);
       sel: IN std_logic);
END ENTITY mux2to1;

--
ARCHITECTURE mux2to1arch OF mux2to1 IS
BEGIN
        PROCESS(a,b,sel)
        BEGIN
                CASE sel IS
                  WHEN '0' => 
                        o <= a;
                  WHEN '1' => 
                        o <= b;
                  WHEN OTHERS =>
                        null;
                END CASE;
        END PROCESS;
END ARCHITECTURE mux2to1arch;

