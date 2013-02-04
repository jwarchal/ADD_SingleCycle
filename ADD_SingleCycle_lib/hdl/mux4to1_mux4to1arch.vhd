--
-- VHDL Architecture ADD_SingleCycle_lib.mux4to1.mux4to1arch
--
-- Created:
--          by - jwarchal.UNKNOWN (GURREN)
--          at - 13:17:51 02/ 4/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux4to1 IS
  GENERIC(size: POSITIVE := 16);
  PORT(a, b, c, d: IN std_logic_vector(size - 1 DOWNTO 0);
       o: OUT std_logic_vector(size - 1 DOWNTO 0);
       sel: IN std_logic_vector(1 DOWNTO 0));
END ENTITY mux4to1;

--
ARCHITECTURE mux4to1arch OF mux4to1 IS
BEGIN
        PROCESS(a,b,c,d,sel)
        BEGIN
                CASE sel IS
                  WHEN "00" => 
                        o <= a;
                  WHEN "01" => 
                        o <= b;
                  WHEN "10" => 
                        o <= c;
                  WHEN "11" => 
                        o <= d;
                  WHEN OTHERS =>
                        null;
                END CASE;
        END PROCESS;
END ARCHITECTURE mux4to1arch;

