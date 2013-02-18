--
-- VHDL Architecture ADD_SingleCycle_lib.ControlUnit.Behavior
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 16:40:35 02/ 5/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ControlUnit IS
  
  PORT (InstMem : IN std_logic_vector (15 DOWNTO 0);
        ConditionCode: IN std_logic_vector (3 DOWNTO 0);
        ALU_R_mux, ALU_L_mux : OUT std_logic_vector (1 DOWNTO 0);
        PC_mux, RF_mux, Mem_en, RF_en : OUT std_logic);
        
END ENTITY ControlUnit;

--
ARCHITECTURE Behavior OF ControlUnit IS
  
BEGIN
  PROCESS (InstMem)
    VARIABLE topBits : std_logic_vector (2 DOWNTO 0);
    VARIABLE eightBit: std_logic;
    VARIABLE bottomBit: std_logic_vector (2 DOWNTO 0);
    VARIABLE twelveToNine: std_logic_vector (3 DOWNTO 0);
  BEGIN
    
    topBits := InstMem(15 DOWNTO 13); 
    eightBit := InstMem (8);
    bottomBit := InstMem(2 DOWNTO 0);
    twelveToNine := InstMem(12 DOWNTO 9); 
    
    PC_mux <=  '0';
    RF_mux <= '0';
    ALU_L_mux <= "00";
    ALU_R_mux <= "00";
    Mem_en <= '0';
    RF_en <= '0';
    
    --NOP
    IF (topBits = "000") THEN
      PC_mux <=  '0';
      RF_mux <= '0';
      ALU_L_mux <= "00";
      ALU_R_mux <= "00";
      Mem_en <= '0';
      RF_en <= '0';
    --LD
    ELSIF(topBits = "001") THEN
      PC_mux <= '0'; 
      RF_mux <= '1';
      ALU_L_mux <= "11";
      ALU_R_mux <= "10";
      Mem_en <= '0';
      RF_en <= '1';
    --ST     
    ELSIF(topBits = "010") THEN
      PC_mux <=  '0';
      RF_mux <= '0';
      ALU_L_mux <= "11";
      ALU_R_mux <= "10";
      Mem_en <= '1';
      RF_en <= '0';
    --MOV
    ELSIF(topBits = "011") THEN 
      PC_mux <=  '0';
      RF_mux <= '0';
      ALU_L_mux <= "00";
      ALU_R_mux <= "10";
      Mem_en <= '0';
      RF_en <= '1';
    --LIL
    ELSIF(topBits = "100" AND eightBit = '0') THEN
      PC_mux <=  '0';
      RF_mux <= '0';
      ALU_L_mux <= "01";
      ALU_R_mux <= "01";
      Mem_en <= '0';
      RF_en <='1';
    --LIH
    ELSIF (topBits = "100" AND eightBit = '1') THEN
      PC_mux <=  '0';
      RF_mux <= '0';
      ALU_L_mux <= "10";
      ALU_R_mux <= "11";
      Mem_en <= '0';
      RF_en <= '1';  
    --ADD, ADC, SUB, ABC, AND, OR, XOR, NOT
    ELSIF(topBits = "101") THEN
      PC_mux <=  '0';
      RF_mux <= '0';
      ALU_L_mux <= "00";
      ALU_R_mux <= "10";
      Mem_en <= '0';
      RF_en <= '1';
    --SL, SRL, SRA, RRA, RR, RL
    ELSIF(topBits = "110" ) THEN
      PC_mux <=  '0';
      RF_mux <= '0';
      ALU_L_mux <= "00";
      ALU_R_mux <= "10";
      Mem_en <= '0';
      RF_en <= '1';
      --JMP
    ELSIF(topBits = "111"  AND eightBit = '0') THEN
      PC_mux <=  '1';
      RF_mux <= '0';
      ALU_L_mux <= "01";
      ALU_R_mux <= "11";
      Mem_en <= '0';
      RF_en <= '0';   
    --BR
    ELSIF (topBits = "111"  AND twelveToNine = "0000" AND eightBit = '1') THEN
      PC_mux <=  '1';
      RF_mux <= '0';
      ALU_L_mux <= "01";
      ALU_R_mux <= "00";
      Mem_en <= '0';
      RF_en <= '0';
    --BC
    ELSIF (topBits = "111"  AND ((twelveToNine(3)= '1' AND ConditionCode(3) = '1')OR(twelveToNine(2)= '1' AND ConditionCode(2) = '1')OR(twelveToNine(1)= '1' AND ConditionCode(1) = '1')OR(twelveToNine(0)= '1' AND ConditionCode(0) = '1')) AND eightBit = '1') THEN
      PC_mux <=  '1';
      RF_mux <= '0';
      ALU_L_mux <= "01";
      ALU_R_mux <= "00";
      Mem_en <= '0';
      RF_en <= '0';
    END IF;
    
  END PROCESS;
END ARCHITECTURE Behavior;

