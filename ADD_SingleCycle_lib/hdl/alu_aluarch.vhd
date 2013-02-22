--
-- VHDL Architecture ADD_SingleCycle_lib.alu.aluarch
--
-- Created:
--          by - jwarchal.UNKNOWN (GURREN)
--          at - 13:12:46 02/ 4/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY alu IS
      PORT( x,y: in std_logic_vector(15 DOWNTO 0);
      op: in std_logic_vector(5 DOWNTO 0);
      cin: in std_logic;
      z: out std_logic_vector(15 DOWNTO 0);
      ccvector: out std_logic_vector(3 DOWNTO 0));
END ENTITY alu;

--
ARCHITECTURE aluarch OF alu IS
BEGIN
    PROCESS(x,y,op,cin)
    VARIABLE localx, localy: unsigned(16 DOWNTO 0);
    VARIABLE localz: unsigned(16 DOWNTO 0);
    VARIABLE localc: std_logic;
  BEGIN
    localx := unsigned(SXT(x,17));
    localy := unsigned(SXT(y,17));
    CASE op IS
    --Add 
    WHEN "101000" =>
      localz := localx + localy;
      localc := std_logic(localz(16));
      z <= std_logic_vector(localz(15 DOWNTO 0));
    --ADC
    WHEN "101001" =>
      localz := localx + localy + cin;
      localc := std_logic(localz(16));
      z <= std_logic_vector(localz(15 DOWNTO 0));
    --SUB
    WHEN "101010" =>
      localz := localy - localx;
      localc := std_logic(localz(16));
      z <= std_logic_vector(localz(15 DOWNTO 0));
    --SUBC
    WHEN "101011" =>
      localz := localy - localx + cin;
      localc := std_logic(localz(16));
      z <= std_logic_vector(localz(15 DOWNTO 0));
    --AND
    WHEN "101100" =>
      z <= x AND y;
      localc := '0';
    --OR
    WHEN "101101" =>
      z <= x OR y;
      localc := '0';
    --XOR
    WHEN "101110" =>
      z <= x XOR y;
      localc := '0';
    --NOT
    WHEN "101111" =>
      z <= NOT x;
      localc := '0';
    --SL
    WHEN "110000" =>
      z(15 DOWNTO 1) <= x(14 DOWNTO 0);
      z(0) <= '0';
      localc := '0';
    --SRL
    WHEN "110001" =>
      z(14 DOWNTO 0) <= x(15 DOWNTO 1);
      z(15) <= '0';
      localc := '0';
    --SRA
    WHEN "110010" =>
      z(14 DOWNTO 0) <= x(15 DOWNTO 1);
      z(15) <= x(15);
      localc := '0';
    --RRA
    WHEN "110110" =>
      localc := std_logic(localx(0));
      z(14 DOWNTO 0) <= x(15 DOWNTO 1);
      z(15) <= x(15);
    --RR
    WHEN "110101" =>
      localc := std_logic(localx(0));
      z(14 DOWNTO 0) <= x(15 DOWNTO 1);
      z(15) <= cin;
    --RL
    WHEN "110100" =>
      localc := std_logic(localx(15));
      z(15 DOWNTO 1) <= x(14 DOWNTO 0);
      z(0) <= cin;
    
    WHEN OTHERS =>
      IF op(5 DOWNTO 3) = "011" THEN
      --MOV
        localz := localx;
      ELSE
        localz := localx + localy;
      END IF;
      localc := '0';
      z <= std_logic_vector(localz(15 DOWNTO 0));
    END CASE;
    ccvector(3 DOWNTO 2) <= localc & localc;
    ccvector(1) <= std_logic(localz(15));
    ccvector(0) <= '0';
    IF std_logic_vector(localz(15 DOWNTO 0)) = "0000000000000000" THEN
      ccvector(0) <= '1';
    END IF;
  END PROCESS;
END ARCHITECTURE aluarch;

