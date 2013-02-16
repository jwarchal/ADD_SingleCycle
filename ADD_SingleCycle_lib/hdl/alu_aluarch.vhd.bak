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
      op: in std_logic_vector(4 DOWNTO 0);
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
    WHEN "01000" =>
      localz := localx + localy;
      localc := std_logic(localz(16));
      z <= std_logic_vector(localz(15 DOWNTO 0));
    WHEN "01001" =>
      localz := localx + localy + cin;
      localc := std_logic(localz(16));
      z <= std_logic_vector(localz(15 DOWNTO 0));
    WHEN "01010" =>
      localz := localx - localy;
      localc := std_logic(localz(16));
      z <= std_logic_vector(localz(15 DOWNTO 0));
    WHEN "01011" =>
      localz := localx - localy + cin;
      localc := std_logic(localz(16));
      z <= std_logic_vector(localz(15 DOWNTO 0));
    WHEN "01100" =>
      z <= x AND y;
      localc := '0';
    WHEN "01101" =>
      z <= x OR y;
      localc := '0';
    WHEN "01110" =>
      z <= x XOR y;
      localc := '0';
    WHEN "01111" =>
      z <= NOT x;
      localc := '0';
    WHEN "10000" =>
      z(15 DOWNTO 1) <= x(14 DOWNTO 0);
      z(0) <= '0';
      localc := '0';
    WHEN "10001" =>
      z(14 DOWNTO 0) <= x(15 DOWNTO 1);
      z(15) <= '0';
      localc := '0';
    WHEN "10010" =>
      z(14 DOWNTO 0) <= x(15 DOWNTO 1);
      z(15) <= x(15);
      localc := '0';
    WHEN "10110" =>
      localc := std_logic(localx(0));
      z(14 DOWNTO 0) <= x(15 DOWNTO 1);
      z(15) <= x(15);
    WHEN "10101" =>
      localc := std_logic(localx(0));
      z(14 DOWNTO 0) <= x(15 DOWNTO 1);
      z(15) <= cin;
    WHEN "10100" =>
      localc := std_logic(localx(15));
      z(15 DOWNTO 1) <= x(14 DOWNTO 0);
      z(0) <= cin;
    WHEN OTHERS =>
      localz := localx + localy;
      localc := '0';
      z <= std_logic_vector(localz(15 DOWNTO 0));
    END CASE;
    ccvector(3 DOWNTO 2) <= localc & localc;
    ccvector(1) <= std_logic(localz(15));
    ccvector(0) <= '0';
    IF z = "0000000000000000" THEN
      ccvector(0) <= '1';
    END IF;
  END PROCESS;
END ARCHITECTURE aluarch;

